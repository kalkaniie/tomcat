function initHttp () {
  var oHttp;

  if (window.ActiveXObject) {
    try  {
      oHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }  catch (e) {
      try  {
        oHttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch (e) {
        return null;
      }
    }
  } else if (window.XMLHttpRequest) {
    oHttp = new XMLHttpRequest;
  } else {
    return null;
  }
  return oHttp;
}

function callSimpleAjax(Uri, Query) {
  oHttp = initHttp();
  if (oHttp) {
    oHttp.open("POST", Uri, false);
    oHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");  
    oHttp.onreadystatechange = function() {
      if (oHttp.readyState == 4 && oHttp.status == 200) {
        var xmlDoc = oHttp.responseXML;
        var result = xmlDoc.getElementsByTagName("result") ;
        var code =result.item(0).getElementsByTagName("code").item(0).firstChild.nodeValue;
        var message =result.item(0).getElementsByTagName("message").item(0).firstChild.nodeValue;
        processResult(code, message);
      }
    }
    //Query = escape(Query);
    oHttp.send(Query);
  }
}

var popIdx = "";
var mboxIdx = "";

function fetchPOP3Message(popIdx, mboxIdx) {
  this.popIdx = popIdx;
  this.mboxIdx = mboxIdx;
  var query = "method=aj_getPopmail";
  callSimpleAjax("pop3.auth.do", query, popIdx, mboxIdx);
}

function processResult(ajax_code, ajax_message) {
  var result = document.getElementById('result_'+popIdx);
  if (ajax_code == 200) {
    var cnt = ajax_message.split("/");
    var pct = Math.round( (eval(cnt[0]) / eval(cnt[1])) * 100);
    if (eval(cnt[0]) < eval(cnt[1])) {
    	result.innerHTML = "<div class=floatL><font size=2>메일을 가져오고 있습니다.</div><div class=bar_small><img src=/images/kor/etc/bar_capacityB.gif width="+pct+"% height=7 /></div><div class=floatR>"+cnt[0]+" / <b>"+cnt[1]+"</b></font></div>";
      setTimeout("fetchPOP3Message("+popIdx+","+mboxIdx+")", 3000); 
    } else {
      result.innerHTML = "<div class=floatL><font size=2>&nbsp;&nbsp;"+cnt[0]+"개의 새로운 메일을 메일함으로 가져왔습니다.</font> </div>";
      location.href = "pop3.auth.do?method=pop3_iframe";
    }
  } else if (ajax_code == 204) {
    setTimeout("fetchPOP3Message("+popIdx+","+mboxIdx+")", 3000); 
  } else if (ajax_code == 404)  {
    result.innerHTML = "<div class=floatL><font size=2>에러 : 서버에 접속할 수 없거나 로그인 정보가 틀립니다.</font>";
    location.href = "pop3.auth.do?method=pop3_iframe";
  } else if (ajax_code == 500) {
    result.innerHTML = "<div class=floatL><font size=2>에러 : " + ajax_message +"</font></div>";
    location.href = "pop3.auth.do?method=pop3_iframe";
  } else if (ajax_code == 503) {
  	var cnt = ajax_message.split("/");
  	result.innerHTML = "<div class=floatL><font size=2>메일작업이 중단되었습니다. ("+ cnt[0] + "/" + cnt[1] + ")</font></div>";
  }
}

function resizeSelfFrame() {
  var body = this.document.getElementsByTagName('BODY');
  body = body[0];
  var pp = parent.document.getElementById('popFrame');
  //parent.document.getElementById('popFrame').height = (body.scrollHeight + 10) +"px";
}