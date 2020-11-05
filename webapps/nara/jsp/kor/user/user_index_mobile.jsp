<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="strUri" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<HTML lang=ko xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>:: Mobile Mail ::</TITLE>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<META name=viewport content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">

<style type="text/css">

* {padding:0; margin:0}
body { font-family:Dotum, "돋움", Gulim, "굴림", sans-serif; font-size:87.5%; color:#333; background-color:#fff;}
img {border:0;}
ul li { margin:0; padding:0; list-style:none;}
ul { text-align:center;}

#contentWrap { position:relative; min-width:320px; width:100%; min-height:460px;}
#header { z-index:1; background:url(/images_text/kor/login/bg_topBg.gif) repeat-x; min-width:320px; width:100%; height:128px; clear:both;}
#header .leftBg { position:absolute; float:left; width:120px;}
#header .rightBg { position:absolute; top:0; right:0; float:right; width:135px;}
#logIn {position:absolute; top:40px; width:100%; }
#logIn .logo { height:138px; vertical-align:top;}
#logIn .lineHeight { height:20px;}
#logIn .ldInput{ border-top: 2px solid #9b9b9b;border-left: 2px solid #cbcbcb; border-right: 2px solid #b6b5b6; border-bottom: 2px solid #dcdddd;0px 68px 7px 12px; background:url(/images_text/kor/login/img_id.gif) no-repeat; HEIGHT: 28px; line-height:28px; width:70%; -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px;}
#logIn .PwInput{border-top: 2px solid #9b9b9b;border-left: 2px solid #cbcbcb; border-right: 2px solid #b6b5b6; border-bottom: 2px solid #dcdddd;0px 68px 7px 12px; background:url(/images_text/kor/login/img_pw.gif) no-repeat; HEIGHT: 28px; line-height:28px; width:70%; -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px;}
#logIn .ldInput2{ border-top: 2px solid #9b9b9b;border-left: 2px solid #cbcbcb; border-right: 2px solid #b6b5b6; border-bottom: 2px solid #dcdddd;0px 68px 7px 12px; HEIGHT: 28px; line-height:28px; width:70%; -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px;}
#logIn .PwInput2{border-top: 2px solid #9b9b9b;border-left: 2px solid #cbcbcb; border-right: 2px solid #b6b5b6; border-bottom: 2px solid #dcdddd;0px 68px 7px 12px; HEIGHT: 28px; line-height:28px; width:70%; -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px;}
#logIn .txtIdPw { color:#333; font-size:14px; font-weight:bold;}

</style>

<script type="text/javascript" charset="utf-8" src=/js/kor/util/ControlUtils.js></script>
<script type="text/javascript" src="/js_text/kor/common/common.js"></script>
<script language="JavaScript">
var _ua = window.navigator.userAgent.toLowerCase();

var mobileB = {
	model: _ua.match(/(sch-m490|sonyericssonx1i|ipod|ipad|iphone)/) ? _ua.match(/(sch-m490|sonyericssonx1i|ipod|ipad|iphone)/)[0] : "",
	skt : /msie/.test( _ua ) && /nate/.test( _ua ),
	lgt : /msie/.test( _ua ) && /([010|011|016|017|018|019]{3}\d{3,4}\d{4}$)/.test( _ua ),
	opera : (/opera/.test( _ua ) && /(ppc|skt)/.test(_ua)) || /opera mobi/.test( _ua ),
	ipod : /webkit/.test( _ua ) && /\(ipod/.test( _ua ) ,
	iphone : /webkit/.test( _ua ) && /\(iphone/.test( _ua ),
	ipad : /webkit/.test( _ua ) && /\(ipad/.test( _ua ),
	lgtwv : /wv/.test( _ua ) && /lgtelecom/.test( _ua ),
	android : /android/.test( _ua )
};

try {
	if (mobileB.opera){
		document.write("<link href='/css_text/css_mobile_onaOp.css' rel='stylesheet' type='text/css' />");
	}else{
	 	document.write("<link href='/css_text/css_mobile.css' rel='stylesheet' type='text/css' />");
	}
	if (mobileB.android) {
        document.write("<link rel='shortcut icon' href='/images_text/kor/ico/mobile_ico.ico' />");
	} else if(mobileB.iphone || mobileB.ipod || mobileB.ipad){
	    document.write("<link rel='apple-touch-icon' href='/images_text/kor/ico/mobile_ico.png' />");
	}
} catch (e) {}

if(window.addEventListener) window.addEventListener("load", function() {setTimeout(scrollTo, 0,0,1);} , false );
else if(window.attachEvent)window.attachEvent("onload", function() {setTimeout(scrollTo, 0,0,1);} , false );

</script>

<script language=javascript>
<!--
function setCookie(name, value, expiredays, domain) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	                  + (domain ? "domain="+domain : "" ) + ";"
}
function getCookie(name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;

    while(i< clen){
    	
            var j = i + alen;
            if(document.cookie.substring(i,j)==arg){
                    var end = document.cookie.indexOf(";",j);
                    if(end == -1)
                            end = document.cookie.length;
                    return unescape(document.cookie.substring(j,end));
            }
            i=document.cookie.indexOf(" ",i)+1;
            if (i==0) break;
    }
    return null;
}

function userLogin(){
	var objForm = document.login;
	if(objForm.USERS_ID.value.length < 1){
      alert("아이디를 입력해 주십시오");
	  objForm.USERS_ID.focus();
	  return;
	}else if(objForm.USERS_PASSWD.value.length < 1){
	  alert("비밀번호를 입력해 주십시오");
	  objForm.USERS_PASSWD.focus();
	  return;
	}
	
	 if(objForm.keepid.checked == false) {
		 setCookie('keepid',"0",0,"<%=DOMAIN%>");
		 setCookie('USERS_ID',"0",0,"<%=DOMAIN%>");
     } else {
		setCookie('keepid',"1",7,"<%=DOMAIN%>");
		setCookie('USERS_ID',objForm.USERS_ID.value,7,"<%=DOMAIN%>");
	 }
	 if(objForm.keeppw.checked == false) {
		 setCookie('keeppw',"0",0,"<%=DOMAIN%>");
		 setCookie('USERS_PASSWD',"0",0,"<%=DOMAIN%>");
     } else {
		setCookie('keeppw',"1",7,"<%=DOMAIN%>");
		setCookie('USERS_PASSWD',objForm.USERS_PASSWD.value,7,"<%=DOMAIN%>");
	 }
	objForm.action="/mail/user.public.do";
  	objForm.method.value="login";
  	objForm.submit();
}
if(window.addEventListener) window.addEventListener("load", function() {MM_preloadImages('/images_text/kor/btn/btnLog_loginOvr.gif');init();} , false );
else if(window.attachEvent)window.attachEvent("onload", function() {MM_preloadImages('/images_text/kor/btn/btnLog_loginOvr.gif');init();} , false );
-->
</script>
</HEAD>

<body>
<form method=post name="login" onsubmit="return userLogin();">
<input type='hidden' name='method' value='login'> 
<input type='hidden' name='strUri' value='<%=strUri%>'> 
<input type='hidden' name='ssl'> 
<input type='hidden' name='DOMAIN' value='<%=DOMAIN%>'>
<input type='hidden' name='users_login_mode' value='text'>
<input type='hidden' name='mobile' value='y'>		
  <div id="contentWrap">
    <div id="header">
      <div class="leftBg"><img src="/images_text/kor/login/img_topLeft.jpg" /></div>
      <div class="rightBg"><img src="/images_text/kor/login/img_rightImg.gif" /></div>
    </div>
    <div id="logIn">
     <ul>
       <li class="logo"><img src="/images_text/kor/login/img_logo.gif" /></li>
       <li><input name="USERS_ID" id="USERS_ID" type="text" class="ldInput" style="margin-bottom:10px;" onkeydown="this.className='ldInput2'" /></li>
       <li><input name="USERS_PASSWD" id="USERS_PASSWD" type="password" class="PwInput" onkeydown="this.className='PwInput2'" /></li>
       <li class="lineHeight"></li>
       <li>
         <label>
       	   <input name="keepid" type="checkbox" id="keepid" value="1" /> <span class="txtIdPw">아이디저장</span>&nbsp;&nbsp;
           <input name="keeppw" type="checkbox" id="keeppw" value="1" /> <span class="txtIdPw">비밀번호저장</span>
         </label>
       </li>
       <li class="lineHeight"></li>
       <li><input type="image" src="/images_text/kor/login/btn_login.gif" width="251" height="46" style="margin-bottom:8px;" /></li>
     </ul>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
if(conf.getBoolean("com.nara.textmode.kpns.use")) {
	String strHost = conf.getString("com.nara.mail.host");
	String strPort = conf.getString("com.nara.kebimail.port");
	String strUrl = strHost + ":" + strPort;
%>	    
<script language="JavaScript">
var _ua = window.navigator.userAgent.toLowerCase();

var mobileB = {
	model: _ua.match(/(sch-m490|sonyericssonx1i|ipod|iphone|ipad|android)/) ? _ua.match(/(sch-m490|sonyericssonx1i|ipod|iphone|ipad|android)/)[0] : "",
	skt : /msie/.test( _ua ) && /nate/.test( _ua ),
	lgt : /msie/.test( _ua ) && /([010|011|016|017|018|019]{3}\d{3,4}\d{4}$)/.test( _ua ),
	opera : (/opera/.test( _ua ) && /(ppc|skt)/.test(_ua)) || /opera mobi/.test( _ua ),
	android : /webkit/.test( _ua ) && /android/.test( _ua ),
	ipod : /webkit/.test( _ua ) && /\(ipod/.test( _ua ),
	ipad : /webkit/.test( _ua ) && /\(ipad/.test( _ua ),
	iphone : /webkit/.test( _ua ) && /\(iphone/.test( _ua ),
	lgtwv : /wv/.test( _ua ) && /lgtelecom/.test( _ua )	
};

	if(mobileB.iphone || mobileB.ipod || mobileB.ipad){
		document.write("<ul>");
		document.write("<li colspan='2' align='center'>");

        document.write("<a href='itms-services://?action=download-manifest&url=http://m.kebi.com/kpns/iphone/<%=strHost%>/<%=strHost%>.plist'><img src='/images_text/kor/login/btn_iphoneAlimi.gif' /></a>&nbsp;");
        
		//메신저 사용시 (안할경우 주석처리 해주세요)
        document.write("<a href='itms-services://?action=download-manifest&url=http://m.kebi.com/messenger/iphone/<%=strHost%>/<%=strHost%>.plist'><img src='/images_text/kor/login/btn_iphoneMsg.gif' /></a></li>");
        document.write("</ul>");
} else if(mobileB.android){
        document.write("<ul>");
        document.write("<li colspan='2' align='center'>");
        
        document.write("<a href='http://m.kebi.com/kpns/android/<%=strHost%>/<%=strHost%>.Notification.apk'><img src='/images_text/kor/login/btn_androidAlimi.gif' /></a>&nbsp;");
        
      	//메신저 사용시 (안할경우 주석처리 해주세요)
        document.write("<a href='http://m.kebi.com/messenger/android/<%=strHost%>/<%=strHost%>.Messenger.apk'><img src='/images_text/kor/login/btn_androidMsg.gif' /></a></li>");
		document.write("</ul>");
	}
</script>	
<% } %>       
    </div>
  </div>
</form>  
<script language=javascript>
<!--

var is_sid=getCookie("keepid")? true:false;
var is_spw=getCookie("keeppw")? true:false;

function init(){
    if(is_sid){
        var userid = document.getElementById('USERS_ID');
        if(userid.value == "")
	      	userid.value = getCookie('USERS_ID');	
        document.getElementById('USERS_PASSWD').focus();
        document.getElementById('keepid').checked = true;
        document.getElementById('USERS_ID').className='ldInput2';
    } 

    if(is_spw){
    	document.getElementById('USERS_PASSWD').value = getCookie("USERS_PASSWD");
        document.getElementById('keeppw').checked  = true;
        document.getElementById('USERS_PASSWD').className='PwInput2';
    }		
}
-->
</script>
</body>
</html>
