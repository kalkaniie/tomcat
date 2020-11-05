<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Header"%>
<%@page import="com.nara.jdf.db.entity.WebMailEntity"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.UserTagService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.jdf.db.entity.UserTagEntity"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.springframework.service.MBoxService"%>

<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="webMailEntityList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="strIsInjure" class="java.lang.String" scope="request" />
<jsp:useBean id="strOrder" class="java.lang.String" scope="request" />
<jsp:useBean id="strDesc" class="java.lang.String" scope="request" />
<jsp:useBean id="history" class="java.lang.String" scope="request" />
<jsp:useBean id="MBOX_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_year" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_month" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_date" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_year" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_month" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_date" class="java.lang.String" scope="request" />
<jsp:useBean id="strSearch" class="java.lang.String" scope="request" />

<jsp:useBean id="M_IDX_PREV" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX_NEXT" class="java.lang.String" scope="request" />
<jsp:useBean id="nMode" class="java.lang.String" scope="request" />
<jsp:useBean id="strLinkQuery" class="java.lang.String" scope="request" />
<jsp:useBean id="headers" class="java.util.Vector" scope="request" />

<jsp:useBean id="paramEntity" class="com.nara.jdf.db.entity.MailListParamEntity" scope="request" />

<jsp:include page="/jsp/kor/util/util_fileupload.jsp" flush="true" />
<%
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	WebMailEntity webMailEntity = (WebMailEntity) webMailEntityList.get(0);
    UserTagEntity tagEntity = new UserTagEntity();							//태그정보
    tagEntity = UserTagService.getUserTagInfo(userEntity.DOMAIN,userEntity.USERS_IDX, webMailEntity.TAG_TYPE);
    int MBOX_TYPE = MBoxService.getMBoxTypeByMBoxIdx(request, webMailEntity.MBOX_IDX);
    
    String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
    String addressStr = "";
    try{
    	javax.mail.internet.InternetAddress addr1 = new javax.mail.internet.InternetAddress(webMailEntity.M_SENDER);
    	addressStr = ChkValueUtil.translate(addr1.toString().replaceAll("\"","").replaceAll("'",""));
    }catch(Exception e){
    	e.printStackTrace();
    }
    webMailEntity.M_TITLE = webMailEntity.M_TITLE.replaceAll("\r\n", ""); 
    paramEntity.M_TITLE = paramEntity.M_TITLE.replaceAll("\r\n", ""); 
%>

<script language="javascript">
  //자동분류 팝업
  function setAutoDivision<%=uniqStr%>(){
	  var link_str = "autodivision.auth.do?method=pop_env_autodivision_form";
	  var params =Ext.urlDecode("autodivision_M_SENDER=<%=ChkValueUtil.translate(webMailEntity.M_SENDER.replaceAll("\"","").replaceAll("'",""))%>&autodivision_M_TITLE=<%=ChkValueUtil.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>");
	  newWindowOpen("자동분류",410,175,link_str,params);
  }
  
  //주소록에 추가
  function registAddress<%=uniqStr%>() { 
	  
	  objForm = document.mail_view<%=uniqStr%>;
	  var link="address.auth.do?method=address_add_pop_form&nMode=normal&ADDRESS_EMAIL=<%=addressStr%>";
	  MM_openBrWindow(link,'_address','width=500,height=632');
  }
  
  //수신거부
  function showRefuseWin<%=uniqStr%>(M_IDX,MBOX_IDX) { 
    var link = "webmail.auth.do?method=pop_mail_refuse_form&M_IDX="+M_IDX+"&MBOX_IDX="+MBOX_IDX+"&VIEW_TYPE="+document.mail_view<%=uniqStr%>.VIEW_TYPE.value;
    newWindowOpen("수신거부",475,245,link);
  }

  //스펨신고
  function showProsecutionWin<%=uniqStr%>(M_IDX,MBOX_IDX) { 
    var link = "webmail.auth.do?method=pop_mail_prosecution_form&M_IDX="+M_IDX+"&MBOX_IDX="+MBOX_IDX+"&VIEW_TYPE="+document.mail_view<%=uniqStr%>.VIEW_TYPE.value;
    newWindowOpen("스펨신고",450,275,link);
  }
  
  //메일삭제
  function removeMail<%=uniqStr%>() {
    var objForm = document.mail_view<%=uniqStr%>;
    Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do?method=aj_delete_mail',
		method : 'POST',
		params: { M_IDX: <%=paramEntity.M_IDX%>,MBOX_TYPE:mainPanel.getActiveTab().getEl().child("form").dom.MBOX_TYPE.value},
		success : function(response, options) {
			getExtAjaxMessage(response,'삭제되었습니다.',false);
			returnMailList();
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});    
  }
  
  function moveMail<%=uniqStr%>(obj){//편지함이동
  	objForm = document.mail_view<%=uniqStr%>;
  	var move_mbox_idx  = obj.value;
	var move_mbox_name = obj.options[obj.selectedIndex].text;
	if (move_mbox_idx == "") {
  		alert("이동할 편지함을 선택하세요.");
  		objForm.select_mbox[0].value = "";
	    objForm.select_mbox[1].value = "";
  		return ;
  	} else if (move_mbox_idx == objForm.MBOX_IDX) {
  		alert("이동 대상 편지함이 동일합니다.");
  		objForm.select_mbox[0].value = "";
	    objForm.select_mbox[1].value = "";
  		return ;
  	}
	
  	Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do?method=aj_move_mail',
		method : 'POST',
		params: { M_IDX:'<%=paramEntity.M_IDX%>',MBOX_IDX:move_mbox_idx},
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({
    		   	record: 'RESPONSE'
    			}, 
    			['RESULT','MESSAGE']);
    		var resultXML = reader.read(response);
    		if (resultXML.records[0].data.RESULT == "success") {
    			getExtAjaxMessage(response,'메일이 '+move_mbox_name+' 편지함으로 이동 되었습니다.',true);
    			returnMailList();
    		}else{
    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
    			
    		}
    	},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
	leftMailBoxAllReload();
  }
  
  //메일전달
  function mailWriteArg<%=uniqStr%>(str,tabName){
    goRightDivRender("webmail.auth.do?method="+str+"&M_IDX="+mainPanel.getActiveTab().getEl().child("form").dom.M_IDX.value,tabName);
  }
  
  //'보낸사람 메일주소'를 클릭한 경우 
  function sendTo<%=uniqStr%>(str) {
	goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + str, "편지쓰기:주소록-" + getUniqueString());
  }
  
  //인쇄미리보기
  function printPage<%=uniqStr%>() {
    var objForm = document.mail_view<%=uniqStr%>;
    var link = "webmail.auth.do?method=printPage&M_IDX="+mainPanel.getActiveTab().getEl().child("form").dom.M_IDX.value;
    MM_openBrWindow(link,'popMailPrint','scrollbars=yes,width=1000,height=560');
  }
  
  //메일저장
  function downloadMail<%=uniqStr%>() {
    objForm = document.mail_view<%=uniqStr%>;
    objForm.method.value = 'downloadMail';
    objForm.action = "webmail.auth.do";
    objForm.submit();
  }
  
  // 첨부파일다운로드
  function downloadBlocking<%=uniqStr%>(mIdx, fNum, fIdx, fName) {
    var blockingFile = new Array();
    //blockingFile.push("mdb");
    
    var objForm = document.mail_view<%=uniqStr%>;
    var chk = 0;
    for (i=0; i<blockingFile.length; i++) {
      if (fName.substring(fName.lastIndexOf(".") + 1) == blockingFile[i]) {
        alert("다운로드 불가능한 파일이 포함되어 있습니다.");
        chk++;
      }
    }
    if (chk == 0) {
      //objForm.target = "_blank";
      objForm.action = "webmail.auth.do?method=attache&M_IDX="+mIdx+"&nFileNum="+fNum+"&nSubIndex="+fIdx;
      if( isDownloadTaget(fName))
     		objForm.target ="_blank";
      objForm.submit();
    }
  }


	//메일중요도 설정
	function chkPriority<%=uniqStr%>(obj){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
		if (obj == false) {
	      objForm.M_PRIORITY.value = 3;
	      objForm.M_PRIORITY.checked = false;
	    } else {
	      objForm.M_PRIORITY.value = 1;
	      objForm.M_PRIORITY.checked = true;
	    }
	    Ext.Ajax.request({
			scope :this,
			url: 'webmail.auth.do?method=aj_chkPriority',
			method : 'POST',
			params: { M_IDX: mainPanel.getActiveTab().getEl().child("form").dom.M_IDX.value,
					  M_PRIORITY: objForm.M_PRIORITY.value
					 },
			success : function(response, options) {
				if(obj == false){
					alert('중요 편지가 해제되었습니다.');
				}else{
					alert('중요 편지가 설정되었습니다.');
				}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	}
	
    //메일 태그 변경
	function checkTagType<%=uniqStr%>(isTagVal){
		var objForm = searchFormByActiveTab("mail_view<%=uniqStr%>");
	  	if(isTagVal == ""){
	    	alert("적용할 태그를 선택하세요.");
	    	return;
	  	} else {
	  		Ext.Ajax.request({
				scope :this,	
				url:'webmail.auth.do?method=aj_change_tagtype',
		    	method:'POST',
		    	params: { M_IDX: objForm.M_IDX.value, TAG_TYPE:isTagVal},
		    	success : function(response, options) {
					getExtAjaxMessage(response,'적용 되었습니다.',true);
					var tagType = Number(isTagVal) <10 ? "0"+Number(isTagVal)+".gif" : Number(isTagVal)+".gif";
					document.getElementById("tagImg<%=uniqStr%>").src ="/images/kor/ico/ico_tag"+tagType;
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
		    });		  	
	  	}
	};
	
	function goMailViewPreNext(m_idx){
		mainPanel.getActiveTab().body.load({
			url: 'webmail.auth.do',
	  		params: {
				method:'mail_view',
				M_IDX:m_idx,
				MBOX_IDX:'<%=paramEntity.MBOX_IDX%>',
				MBOX_TYPE:'<%=paramEntity.MBOX_TYPE%>',
				TAG_TYPE:'<%=paramEntity.TAG_TYPE%>',
				VIEW_TYPE:'<%=paramEntity.VIEW_TYPE%>', 				
				READ_MODE:'<%=paramEntity.READ_MODE%>',
				M_TITLE:'<%=paramEntity.M_TITLE.replaceAll("\"","").replaceAll("'","")%>',
				M_SENDER:'<%=paramEntity.M_SENDER.replaceAll("\"","").replaceAll("'","")%>',
				M_SENDERNM:'<%=paramEntity.M_SENDERNM.replaceAll("\"","").replaceAll("'","")%>',
				M_TO:'<%=paramEntity.M_TO.replaceAll("\"","").replaceAll("'","")%>',
				M_ATTACH_NAME:'<%=paramEntity.M_ATTACH_NAME.replaceAll("\"","").replaceAll("'","")%>',
				search_strIndex:'<%=paramEntity.search_strIndex%>',
				search_strKeyword:'<%=paramEntity.search_strKeyword%>',
				search_startdt:'<%=paramEntity.search_startdt%>',
				search_enddt:'<%=paramEntity.search_enddt%>',
				nPage:'<%=paramEntity.nPage%>'  		
	  		},
	  		scripts: true,
	  		scope:true,
			renderTo:mainPanel.getActiveTab().body
		});
	};
	
  // mail header view function	
  function getXMLHttpRequest<%=uniqStr%>() {
    if (window.ActiveXObject) {
      try {
        return new ActiveXObject("Msxml2.XMLHTTP");
      } catch (e) {
        try {
          return new ActiveXObject("Microsoft.XMLHTTP");
        } catch (ex) {
          return null;
        }
      }
    } else if (window.XMLHttpRequest) {
      return new XMLHttpRequest();
    } else {
      return null;
    }
  }
  
  var httpRequest = null;
  function sendRequest<%=uniqStr%>(url, params, callback, method) {
    httpRequest = getXMLHttpRequest<%=uniqStr%>();
    var httpMethod = method ? method : 'GET';
    if (httpMethod != 'GET' && httpMethod != 'POST') {
      httpMethod = 'GET';
    }
    var httpParams = (params == null || params == '') ? null : params;
    var httpUrl = url;
    if (httpMethod == 'GET' && httpParams != null) {
      httpUrl = httpUrl + "?" + httpParams;
    }
    httpRequest.open(httpMethod, httpUrl, true);
    httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    httpRequest.onreadystatechange = callback;
    httpRequest.send(httpMethod == 'POST' ? httpParams : null);
  }
  
  var xmlDoc = null;
  var xslDoc = null;
  
  function callbackHeadersXML<%=uniqStr%>() {
    if (httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
        xmlDoc = httpRequest.responseXML;
        sendRequest<%=uniqStr%>('/jsp/kor/webmail/mail_headers.xsl', null, callbackHeadersXSL<%=uniqStr%>, 'GET');
      }
    }        
  }
  
  function callbackHeadersXSL<%=uniqStr%>() {
    if (httpRequest.readyState == 4) {
      if (httpRequest.status == 200) {
        xslDoc = httpRequest.responseXML;
        doXSLT<%=uniqStr%>();
      }
    }
  }
  
  function doXSLT<%=uniqStr%>() {
    if (xmlDoc == null || xslDoc == null)
      return;
    var mailHeaderDiv = document.getElementById('mailHeader<%=uniqStr%>');
    if (window.ActiveXObject) {
      mailHeaderDiv.innerHTML = xmlDoc.transformNode(xslDoc);
    } else {
      var xsltProc = new XSLTProcessor();
      xsltProc.importStylesheet(xslDoc);
      var fragment = xsltProc.transformToFragment(xmlDoc, document);
      mailHeaderDiv.innerHTML='<table>'+fragment.childNodes[0].innerHTML+'</table>';
      //mailHeaderDiv.append(fragment);
    }
  }

  function showHeaders<%=uniqStr%>(elementId) {
	    var mailHeaderDiv = document.getElementById(elementId);
	    
	    if (mailHeaderDiv.style.display == "none") {
	      mailHeaderDiv.innerHTML = '헤더정보를 가져오고 있습니다.';
	      sendRequest<%=uniqStr%>('webmail.auth.do?method=aj_mail_header&M_IDX=' + document.mail_view<%=uniqStr%>.M_IDX.value, null, callbackHeadersXML<%=uniqStr%>, 'GET');
	    }
	    if (mailHeaderDiv.style.display == "block") 
	      mailHeaderDiv.style.display = "none";
	    else
	      mailHeaderDiv.style.display = "block";
 }
  
  function attcheFileCheckAll<%=uniqStr%>(nSubIndex){
	  var objForm = document.mail_view_attache_form<%=uniqStr%>;
	  var len = objForm.elements.length;
	  var objName= "attache_file_"+nSubIndex;
	  for ( var i = 0; i < len; i++ ){
	   if(objForm.elements[i].name == objName){
	     objForm.elements[i].checked = !objForm.elements[i].checked;
	   }
	 }
  }
  function downloadAllFile<%=uniqStr%>(nSubIndex) {
	  callFileUploadDownload("downloadAllFile<%=uniqStr%>('" + nSubIndex + "')");
		var obj = document.getElementById("KBUpDown"); 
		if (obj == null) {
			setTimeout("downloadAllFile<%=uniqStr%>('" + nSubIndex + "')", 1000);
		  	return;
		}
		  
		if (install_action == install_ok) { 
			function File(url,name) {this.url = url;this.name = name;}	
			var objForm = document.mail_view_attache_form<%=uniqStr%>;
			 
			var len = objForm.elements.length;
			var objName= "attache_file_"+nSubIndex;
			var files = new Array();
			var chk =0;
			var blokingFile = new Array();
			
			    
			for ( var i = 0; i < len; i++ ){
				if(objForm.elements[i].name == objName && objForm.elements[i].checked){
					for( j=0; j<blokingFile.length; j++){
			  			if( objForm.elements[i].fileName.substring( objForm.elements[i].fileName.lastIndexOf(".")+1).toLowerCase() == blokingFile[j]){
			  		  		alert("다운로드 불가능한 파일이 포함되어 있습니다.");
			  		  		chk++;
			  		  	}
					}
					files.push(new File("&nFileNum="+objForm.elements[i].value+"&nSubIndex="+nSubIndex, objForm.elements[i].fileName));
			    }
			}
			if(chk ==0){
				if(files.length == 0){
				    alert("다운로드 할 파일을 선택해 주십시오.");
				    return;
				}else{
					var serverName = "<%="http://"+conf.getString("com.nara.kebimail.host")+":"+request.getServerPort()+ (request.getContextPath().length() <=1 ? "" : request.getContextPath()) %>";
					var downServ = "/mail/webmail.auth.do?method=attache&M_IDX="+objForm.M_IDX.value;
			        KBUpDown.SetLoginInfo("<%=conf.getString("com.nara.kebimail.host")%>", "<%=request.getContextPath().length() <= 1 ? "" : request.getContextPath().substring(1)%>", "<%=(String)session.getAttribute("USERS_IDX")%>");
					KBUpDown.ClearURLFileList();
					var url;
					for (var i = 0; i < files.length; i++) {
						url = serverName + downServ + files[i].url;
					  	KBUpDown.AddURLFileList(url, files[i].name);
					}
					KBUpDown.URLDownloadToFile();
				}
			}
		}			 
	}
  
  function downloadToFile<%=uniqStr%>(nSubIndex){
	  var objForm = document.mail_view_attache_form<%=uniqStr%>;
	  var objName= "attache_file_"+nSubIndex;
	  
	  function File(url,name) {this.url = url;this.name = name;}	
	  var len = objForm.elements.length;
	  var files = new Array();
	  
	  var chk =0;
	  var blokingFile = new Array();
	  //blokingFile.push("mdb");
	  
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == objName && objForm.elements[i].checked){
			for( j=0; j<blokingFile.length; j++){
			  	if( objForm.elements[i].fileName.substring( objForm.elements[i].fileName.lastIndexOf(".")+1).toLowerCase() == blokingFile[j]){
			  		alert("다운로드 불가능한 파일이 포함되어 있습니다.");
			  		chk++;
			  	}
		  	}
	    }
	  }  
	  
		if(chk ==0){
		  if(!isCheckedOfBox(objForm, objName)){
		    alert("저장할 파일을 선택해 주십시오.");
		    return;
		  }else{
		    var link = "webfile.auth.do?method=attache&nSubIndex="+nSubIndex+"&uniqStr=<%=uniqStr%>";
		    window.open( link ,"attache","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=380");
		  }
	  }
	}
	
	function arkFileDownLoadAll(_url) {
		MM_openBrWindow(_url,'ark_filedown_all','');
	}
	
	function arkFileDownLoad(_mail_seq, _file_seq, _url) {
		Ext.Ajax.request({
			scope :this,
			url: 'anaconda.public.do',
			method : 'POST',
			params: {
				method:'anaFileDelStatus',
				MAIL_SEQ:_mail_seq,
				FILE_SEQ:_file_seq
			},
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['SUCCESS','FILE_DEL']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.SUCCESS == "true") {
			  			if (resultXML.records[0].data.FILE_DEL == "3" || resultXML.records[0].data.FILE_DEL == "4") {
			  				alert("유효기간이 만료된 파일입니다.");
			  			} else if (resultXML.records[0].data.FILE_DEL == "5" || resultXML.records[0].data.FILE_DEL == "6" || resultXML.records[0].data.FILE_DEL == "7") {
			  				alert("메일 발신자에 의해 삭제된 메일 입니다.");
			  			} else {
			  				location.href = _url;
			  			}
			  		}else{
						alert("잠시후 다운로드를 시도하여 주시기 바랍니다.");
			  		}  
				} catch(e) {}
			},
			failure : function(response, options) {
				alert("잠시후 다운로드를 시도하여 주시기 바랍니다.");
			}
		});	
	}
	
	function arkFolderDownLoad(_url) {
		var newWindow = window.open("about:blank");
		newWindow.location.href = _url;
	}
	
  	if ("<%=webMailEntity.M_ISREAD%>" == "N" || "<%=webMailEntity.M_ISREAD%>" == "P") {
  	  	leftMBoxReload();
	}	
	
  //수신거부 연동
  function refuseMailSniper<%=uniqStr%>(M_IDX) { 
    var isRefuse = confirm("선택한 메일이 수신거부 이메일에 등록됩니다.\n등록 하시겠습니까?");
	if(isRefuse){
		Ext.Ajax.request({
			scope :this,
			url: 'webmail.auth.do?method=aj_refuse_mail_sniper',
			method : 'POST',
			params: { M_IDX: M_IDX},
			success : function(response, options) {
				alert("수신거부되었습니다");
				getExtAjaxMessage(response,'수신거부되었습니다.',true);
				returnMailList();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
    }
  }

function returnMailList(){
	mainPanel.getActiveTab().body.load({
		url: 'webmail.auth.do',
  		params: {
			method:'mail_list',
			MBOX_IDX:'<%=paramEntity.MBOX_IDX%>',
			MBOX_TYPE:'<%=paramEntity.MBOX_TYPE%>',
			TAG_TYPE:'<%=paramEntity.TAG_TYPE%>',
			VIEW_TYPE:'<%=paramEntity.VIEW_TYPE%>', 				
			READ_MODE:'<%=paramEntity.READ_MODE%>',
			M_TITLE:'<%=paramEntity.M_TITLE.replaceAll("\"","").replaceAll("'","")%>',
			M_SENDER:'<%=paramEntity.M_SENDER.replaceAll("\"","").replaceAll("'","")%>',
			M_SENDERNM:'<%=paramEntity.M_SENDERNM.replaceAll("\"","").replaceAll("'","")%>',
			M_TO:'<%=paramEntity.M_TO.replaceAll("\"","").replaceAll("'","")%>',
			M_ATTACH_NAME:'<%=paramEntity.M_ATTACH_NAME.replaceAll("\"","").replaceAll("'","")%>',
			search_strIndex:'<%=paramEntity.search_strIndex%>',
			search_strKeyword:'<%=paramEntity.search_strKeyword%>',
			search_startdt:'<%=paramEntity.search_startdt%>',
			search_enddt:'<%=paramEntity.search_enddt%>',
			nPage:'<%=paramEntity.nPage%>'  		
  		},
  		scripts: true,
  		scope:true,
		renderTo:mainPanel.getActiveTab().body
	});
}      
</script>

<div style="display: block; height: 100%; background: url(/images/kor/line/dot_gray.gif) repeat-y left top;">
<div style="display: block; height: 100%; background: url(/images/kor/line/dot_gray.gif) repeat-y right top;">
<form method=post name="mail_view<%=uniqStr%>">
<input type='hidden' name='method' value=''> 
<input type='hidden' name='M_IDX' value='<%=webMailEntity.M_IDX%>'> 
<input type='hidden' name='MBOX_IDX' value='<%=webMailEntity.MBOX_IDX%>'> 
<input type='hidden' name='MBOX_TYPE' value='<%=MBOX_TYPE%>'> 
<input type='hidden' name='MOVE_MBOX_IDX' value=''> 
<input type='hidden' name='M_TITLE_<%=paramEntity.M_IDX%>' value='<%=ChkValueUtil.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>'> 
<input type='hidden' name='nPage' value='<%=paramEntity.nPage%>'> 
<input type='hidden' name='nMode' value='<%=nMode%>'>  
<input type='hidden' name='VIEW_TYPE' value='<%=paramEntity.VIEW_TYPE%>'> 

<input type='hidden' name='M_TO' value='<%=webMailEntity.M_SENDER.replaceAll("\"","").replaceAll("'","")%>'> 
<textarea name="autodivision_M_SENDER" style="display: none"><%=webMailEntity.M_SENDER%></textarea>
<textarea name="autodivision_M_TITLE" style="display: none"><%=webMailEntity.M_TITLE%></textarea>

<%
java.text.DecimalFormat df = new java.text.DecimalFormat("#,###.##");
try {
    javax.mail.internet.InternetAddress addr = 
        new javax.mail.internet.InternetAddress(webMailEntity.M_SENDER);
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"+ ChkValueUtil.translate(addr.toString().replaceAll("\"","").replaceAll("'","")) + "'>");
} catch (Exception e) {
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"+ ChkValueUtil.translate(webMailEntity.M_SENDER.replaceAll("\"","").replaceAll("'","")) + "'>");
}
String tagImgName = webMailEntity.TAG_TYPE <10 ? "0"+ Integer.toString(webMailEntity.TAG_TYPE) : Integer.toString(webMailEntity.TAG_TYPE);
tagImgName = "ico_tag"+tagImgName+".gif";
%>
<table width=98%><tr><td>
<div class="btn_bgtd" style="border-bottom:2px solid #A8A8A8; position:relative; margin:0;">
<p class="k_posiL">
<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")){ %>
<a href="javascript:removeMail<%=uniqStr%>()"><img src="/images/kor/btn/btnA_delete.gif" /></a>
<%}%>
<% if (MBOX_TYPE != 4 && MBOX_TYPE != 2) { %>
<a href="javascript:mailWriteArg<%=uniqStr%>('reply','답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>')"><img	src="/images/kor/btn/btnA_answer.gif" /></a> 
<a href="javascript:mailWriteArg<%=uniqStr%>('edit_forward','전달:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>');"><img	src="/images/kor/btn/btnA_convey.gif" /></a> 
<a href="javascript:mailWriteArg<%=uniqStr%>('replyall','전체답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>')"><img src="/images/kor/btn/btnA_answerAll.gif" /></a> 
<% } %> <%	if (MBOX_TYPE == 4 || MBOX_TYPE == 2) { %>
<a href="javascript:mailWriteArg<%=uniqStr%>('mail_rewrite','다시쓰기:<%=HtmlUtility.translate(webMailEntity.M_TITLE)%>');"><img src="/images/kor/btn/btnA_reWrite.gif" /></a> 
<% } else { %> 
<a href="javascript:refuseMailSniper<%=uniqStr%>('<%=paramEntity.M_IDX %>')"><img src="/images/kor/btn/btnA_dontRreceipt.gif" /></a> 
<% } %>
</p>
<p class="k_posiR" align="middle">
	<select name="select_mbox" onChange="javascript:moveMail<%=uniqStr%>(this);">
		<option>다른편지함으로이동</option>
		<%=WebMailService.getMboxbySelect(request)%>
	</select>
</p>
</div>
<div class="k_gridB2">
<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")){ %>
<ul class="k_fltL">
  <li><a href="javascript:returnMailList()"><img src="/images/kor/ico/ico_list.gif" />목록<%=userEntity.USERS_MAIL_VIEW_MODE%></a></li>
  <li>
<% if (!history.equals("search") && (Integer.parseInt(M_IDX_NEXT) != 0)) { %>
	<a href="javascript:goMailViewPreNext('<%=M_IDX_NEXT%>');"><img src="/images/kor/ico/ico_listUp.gif" />윗글</a> 
<% } %>
  </li>
  <li>
<% if (!history.equals("search") && (Integer.parseInt(M_IDX_PREV) != 0)) { %>
	<a href="javascript:goMailViewPreNext('<%=M_IDX_PREV%>');"><img src="/images/kor/ico/ico_listDw.gif" />아랫글</a> 
<% } %>
  </li>
</ul>
<%}%>
<ul class="k_fltR">
  <li><a href="javascript:setAutoDivision<%=uniqStr%>();"><img src="/images/kor/ico/ico_mAuto.gif" />자동분류</a></li>
  <li><a href="javascript:showHeaders<%=uniqStr%>('mailHeader<%=uniqStr%>');"><img src="/images/kor/ico/ico_mHead.gif" />헤더보기</a></li>
  <li><a href="javascript:printPage<%=uniqStr%>();"><img src="/images/kor/ico/ico_mPrint.gif" />인쇄</a></li>
  <li><a href="javascript:downloadMail<%=uniqStr%>();"><img	src="/images/kor/ico/ico_mSave.gif" />저장</a></li>
  <!--<li><label for="K_topimpt"><img src="/images/kor/ico/ico_star2.gif" alt="중요한편지 체크" />
    <input type="checkbox" name="M_PRIORITY" value="1" onclick="javascript:chkPriority<%=uniqStr%>(this.checked);" id="K_topimpt" /> 
  </label></li>--> 
</ul>
</div>
<div class="k_txViewHed">
<table>
  <caption><%=HtmlUtility.translate(webMailEntity.M_TITLE)%>         
    <img id="tagImg<%=uniqStr%>" src="/images/kor/ico/<%=tagImgName%>"/>
      <select name="change_tagtype" style="vertical-align:middle;" onChange="checkTagType<%=uniqStr%>(this.value)">
        <option value="">태그적용</option>
        <option value="0">선택해제</option>
        <%=UserTagService.getUseTagbySelectOpt(request, webMailEntity.TAG_TYPE) %>
      </select>
  </caption>
  <tr>
	<th width="155" scope="col">
	  <div class="k_fltL">보낸 사람</div>
	  <div class="k_more">
		<a href="#" class="k_ibtnPlus" onclick="mb_infoDet<%=paramEntity.M_IDX%>.style.display='block';btn_infoOp<%=paramEntity.M_IDX%>.style.display='none';btn_infoCl<%=paramEntity.M_IDX%>.style.display='block'" id="btn_infoOp<%=paramEntity.M_IDX%>"><b>+</b></a> 
		<a href="#" class="k_ibtnMinus" onclick="mb_infoDet<%=paramEntity.M_IDX%>.style.display='none';btn_infoOp<%=paramEntity.M_IDX%>.style.display='block';btn_infoCl<%=paramEntity.M_IDX%>.style.display='none'" id="btn_infoCl<%=paramEntity.M_IDX%>"><b>-</b></a>
	  </div>
	  <em class="K_boxTh_em">세부정보</em>
	</th>
	<td>
	  <div class="k_fltL"><a href="javascript:sendTo<%=uniqStr%>('<%=HtmlUtility.translate(webMailEntity.M_SENDER.replaceAll("\"","").replaceAll("'",""))%>')"><%=HtmlUtility.translate(webMailEntity.M_SENDER)%></a></div>
	  <!--<div class="k_fltR"><a href="javascript:showRefuseWin<%=uniqStr%>('<%=paramEntity.M_IDX%>','<%=webMailEntity.MBOX_IDX%>')">수신거부</a> <a href="javascript:registAddress<%=uniqStr%>();" class="k_fotCol">주소록에 추가</a></div>-->
	  <div class="k_fltR"><a href="javascript:registAddress<%=uniqStr%>();">주소록에 추가</a></div>
	</td>
  </tr>
</table>

<table id="mb_infoDet<%=paramEntity.M_IDX%>" style="display: none">
  <tr>
	<th width="155" scope="row">받는사람</th>
	<td><%=HtmlUtility.translate(webMailEntity.M_TO)%></td>
  </tr>
  <tr>
	<th scope="row">참조</th>
	  <td><%=HtmlUtility.translate(webMailEntity.M_CC)%></td>
  </tr>
  <tr>
	<th scope="row">보낸날짜</th>
	<td><%=HtmlUtility.translate(webMailEntity.M_TIME)%></td>
  </tr>
</table>
</div>
</form>
<div id="mailHeader<%=uniqStr%>" style="width:98%;display:none;"></div>
<% webMailEntity.M_CONTENT = com.nara.util.XmlDocCreate.removeSpecialChar(webMailEntity.M_CONTENT); %>
              <%=webMailEntity.M_CONTENT
              .replaceAll("<body", "<X-BODY'").replaceAll("</body>", "</X-BODY>")
              .replaceAll("<BODY", "<X-BODY'").replaceAll("</BODY>", "</X-BODY>")
              .replaceAll("<iframe", "<X-IFRAME'").replaceAll("</iframe>", "</X-IFRAME>")
              .replaceAll("<IFRAME", "<X-IFRAME'").replaceAll("</IFRAME>", "</X-IFRAME>")
              .replaceAll("<STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</DIV>")
              .replaceAll("<style", "<DIV STYLE='display:none'").replaceAll("</style>", "</DIV>")
              .replaceAll("<Style", "<DIV STYLE='display:none'").replaceAll("</Style>", "</DIV>")
              .replaceAll("<X-STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</X-STYLE>")
              .replaceAll("<SCRIPT", "<X-SCRIPT").replaceAll("<script", "<X-SCRIPT")
              .replaceAll("<JAVASCRIPT", "<X-JAVASCRIPT").replaceAll("<javascript", "<X-JAVASCRIPT")
              .replaceAll("<head", "<X-head").replaceAll("</head", "<X-head")
              .replaceAll("<html", "<X-html").replaceAll("</html", "<X-html")
              .replaceAll("iframe", "X-IFRAME").replaceAll("IFRAME", "X-IFRAME")
              .replaceAll("script", "X-SCRIPT").replaceAll("SCRIPT", "X-SCRIPT")
              .replaceAll("link rel", "X-LINK REL").replaceAll("LINK REL", "X-LINK REL")
              .replaceAll("http-equiv", "X-HTTP-EQUIV").replaceAll("HTTP-EQUIV", "X-HTTP-EQUIV")
              .replaceAll("implementation", "X-IMPLEMENTATION").replaceAll("IMPLEMENTATION", "X-IMPLEMENTATION")
              .replaceAll("xml", "X-XML").replaceAll("XML", "X-XML")
              .replaceAll("APPLET", "X-APPLET").replaceAll("applet", "X-APPLET")
              .replaceAll("<STRONG>", "<B>").replaceAll("</STRONG>", "</B>")
              .replaceAll("<strong>", "<B>").replaceAll("</strong>", "</B>")
              .replaceAll("<LINK", "<X-LINK").replaceAll("</LINK", "</X-LINK")
              .replaceAll("<link", "<X-LINK").replaceAll("</link", "</X-LINK")
              .replaceAll(" href=", " target='_new' href=").replaceAll(" HREF=", " target='_new' href=")
              
%>
<% if (webMailEntityList.size() ==1) {%>
	<form name="mail_view_attache_form<%=uniqStr%>" method="post" action="">
	<input type='hidden' name='M_IDX' value='<%=paramEntity.M_IDX%>'> 
	<input type='hidden' name='nSubIndex' value=''> 
	<input type='hidden' name='strDir' value=''>
<%} %>              
<%
    if (webMailEntityList.size() > 1) {
        webMailEntityList.remove(0);
        for (int i = 0; i < webMailEntityList.size(); i++) {
            WebMailEntity subWebMailEntity = 
                (WebMailEntity) webMailEntityList.get(i);        
%> 
<div class="k_mailFd">
<div class="k_mailFd_tit">
<p class="k_mailFd_titIco"><b>전달된편지 : </b><%=HtmlUtility.translate(subWebMailEntity.M_TITLE)%></p>
</div>
<table class="k_mailFd_head">
	<tr>
		<th width="100" scope="row" class="k_mailFd_headTh">보낸사람</th>
		<td class="k_mailFd_headTd"><a href="#"><%=HtmlUtility.translate(subWebMailEntity.M_SENDER)%></a></td>
	</tr>
	<tr>
		<th scope="row" class="k_mailFd_headTh">받는사람</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subWebMailEntity.M_TO)%></td>
	</tr>
	<tr>
		<th scope="row" class="k_mailFd_headTh">보낸날짜</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subWebMailEntity.M_TIME)%></td>
	</tr>
</table>
<div class="k_mailFd_txt"><% subWebMailEntity.M_CONTENT = com.nara.util.XmlDocCreate.removeSpecialChar(subWebMailEntity.M_CONTENT); %>             
        <%=subWebMailEntity.M_CONTENT
                     .replaceAll("<body", "<X-BODY'").replaceAll("</body>", "</X-BODY>")
                     .replaceAll("<BODY", "<X-BODY'").replaceAll("</BODY>", "</X-BODY>")
                     .replaceAll("<iframe", "<X-IFRAME'").replaceAll("</iframe>", "</X-IFRAME>")
                     .replaceAll("<IFRAME", "<X-IFRAME'").replaceAll("</IFRAME>", "</X-IFRAME>")
                     .replaceAll("<STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</DIV>")
                     .replaceAll("<style", "<DIV STYLE='display:none'").replaceAll("</style>", "</DIV>")
                     .replaceAll("<Style", "<DIV STYLE='display:none'").replaceAll("</Style>", "</DIV>")
                     .replaceAll("<X-STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</X-STYLE>")
                     .replaceAll("<SCRIPT", "<X-SCRIPT").replaceAll("<script", "<X-SCRIPT")
                     .replaceAll("<JAVASCRIPT", "<X-JAVASCRIPT").replaceAll("<javascript", "<X-JAVASCRIPT")
                     .replaceAll("<head", "<X-head").replaceAll("</head", "<X-head")
                     .replaceAll("<html", "<X-html").replaceAll("</html", "<X-html")
                     .replaceAll("iframe", "X-IFRAME").replaceAll("IFRAME", "X-IFRAME")
                     .replaceAll("script", "X-SCRIPT").replaceAll("SCRIPT", "X-SCRIPT")
                     .replaceAll("link rel", "X-LINK REL").replaceAll("LINK REL", "X-LINK REL")
                     .replaceAll("http-equiv", "X-HTTP-EQUIV").replaceAll("HTTP-EQUIV", "X-HTTP-EQUIV")
                     .replaceAll("implementation", "X-IMPLEMENTATION").replaceAll("IMPLEMENTATION", "X-IMPLEMENTATION")
                     .replaceAll("xml", "X-XML").replaceAll("XML", "X-XML")
                     .replaceAll("APPLET", "X-APPLET").replaceAll("applet", "X-APPLET")
                     .replaceAll("<STRONG>", "<B>").replaceAll("</STRONG>", "</B>")
              		 .replaceAll("<strong>", "<B>").replaceAll("</strong>", "</B>")
              		 .replaceAll("<LINK", "<X-LINK").replaceAll("</LINK", "</X-LINK")
              		 .replaceAll("<link", "<X-LINK").replaceAll("</link", "</X-LINK")
              		 .replaceAll(" href=", " target='_new' href=").replaceAll(" HREF=", " target='_new' href=")
              		 
%>
<%
                      if (subWebMailEntity.M_ATTACH_NUM != null
                              && subWebMailEntity.M_ATTACH_NUM.length() > 0) {
                          String[] attachNums = subWebMailEntity.M_ATTACH_NUM.split("[;]");
                          String[] attachNames = subWebMailEntity.M_ATTACH_NAME.split("[;]");
                          String[] attachSize = subWebMailEntity.M_ATTACH_SIZE.split("[;]");
                          String[] attachType = subWebMailEntity.M_ATTACH_TYPE.split("[;]");
%> 
</div>
<% if (i ==0) {%>
<form name="mail_view_attache_form<%=uniqStr%>" method="post" action="">
<input type='hidden' name='M_IDX' value='<%=paramEntity.M_IDX%>'> 
<input type='hidden' name='nSubIndex' value=''> 
<input type='hidden' name='strDir' value=''>
<%} %>
<table class="k_attNma">
	<caption>
	<p>일반 첨부파일</p>
	<span> <a href="javascript:downloadAllFile<%=uniqStr%>(<%=i%>);">
	<img src="/images/kor/btn/btnB_blueSave.gif" /></a>
	</caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><a	href="javascript:attcheFileCheckAll<%=uniqStr%>(<%=i%>)"><img src="/images/kor/grid/pick_butt2.gif" /></a></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
<%                    
                          for (int idx = 0; idx < attachNums.length; idx++) { 
                              try {
                                  String[] fileType = com.nara.util.UtilFileApp.getFileType(
                                          attachNames[idx].substring(attachNames[idx].lastIndexOf('.') + 1));
%>
	<tr>
		<td><input type="checkbox" name="attache_file_<%=i%>" value="<%=attachNums[idx]%>" fileName="<%=attachNames[idx].replaceAll("\"","").replaceAll("'","")%>" /></td>
		<td class="k_txAliL"><img src="../images/kor/ico/<%=fileType[1]%>" /><a href="javascript:downloadBlocking<%=uniqStr%>('<%=webMailEntity.M_IDX%>', '<%=attachNums[idx]%>', '<%=i%>', '<%=attachNames[idx].replaceAll("\"","").replaceAll("'","")%>');"><%=attachNames[idx]%></a>
		</td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[idx])/1024)%>KB</td>
	</tr>
<%                    
                              } catch (ArrayIndexOutOfBoundsException e) {
                                  
                              }
                          }
%>
</table>
<%
                      }
%> 
<%
        }
    }
%>
</div>
</div>
</div>

<%
    if (webMailEntity.M_ATTACH_NUM != null               
        && webMailEntity.M_ATTACH_NUM.length() > 0) {
        String[] attachNums = webMailEntity.M_ATTACH_NUM.split("[;]");
        String[] attachNames = webMailEntity.M_ATTACH_NAME.split("[;]");
        String[] attachSize = webMailEntity.M_ATTACH_SIZE.split("[;]");
        String[] attachType = webMailEntity.M_ATTACH_TYPE.split("[;]");
%>

<table class="k_attNma">
	<caption>
	<p>일반 첨부파일</p>
	<span> <a href="javascript:downloadAllFile<%=uniqStr%>(-1);"><img src="/images/kor/btn/btnB_blueSave.gif" /></a> 
<% if(UsersService.isValidModule(request,"webfile")){ %>
	<!--<a href="javascript:downloadToFile<%=uniqStr%>(-1);"><img src="/images/kor/btn/btnB_blueWebhard.gif" /></a>--> 
<% } %> 
    <!--<a href="#"><img src="/images/kor/btn/btnB_blueVirus.gif" /></a>--> </span></caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><a	href="javascript:attcheFileCheckAll<%=uniqStr%>(-1)"><img src="/images/kor/grid/pick_butt2.gif" /></a></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<%
        for (int i = 0; i < attachNums.length; i++) { 
            try {
                String[] fileType = com.nara.util.UtilFileApp.getFileType(
                        attachNames[i].substring(attachNames[i].lastIndexOf('.') + 1));
%>
	<tr>
		<td><input type="checkbox" name='attache_file_-1' value='<%=attachNums[i]%>' fileName="<%=attachNames[i].replaceAll("\"","").replaceAll("'","")%>" /></td>
		<td class="k_txAliL"><img src="../images/kor/ico/<%=fileType[1]%>" style="vertical-align: middle;" /> 
		<a href="javascript:downloadBlocking<%=uniqStr%>('<%=webMailEntity.M_IDX%>', '<%=attachNums[i]%>', '-1', '<%=attachNames[i].replaceAll("\"","").replaceAll("'","")%>');">
		<%=attachNames[i]%></a></td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[i])/1024)%>KB</td>
	</tr>
	<%
            } catch (ArrayIndexOutOfBoundsException e) {
                
            }
        }
%>
</table>
<%
    }
%>
</div>
</form>
</div>
</div>
<td></tr></table>
<table width="98%">
<tr><td>
<div class="btn_bgtd" style="border-bottom:2px solid #A8A8A8; position:relative; margin:0;">
<p class="k_posiL">
<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")){ %>
<a href="javascript:removeMail<%=uniqStr%>()"><img src="/images/kor/btn/btnA_delete.gif" /></a>
<%}%>
<% if (MBOX_TYPE != 4 && MBOX_TYPE != 2) { %>
<a href="javascript:mailWriteArg<%=uniqStr%>('reply','답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>')"><img	src="/images/kor/btn/btnA_answer.gif" /></a> 
<a href="javascript:mailWriteArg<%=uniqStr%>('edit_forward','전달:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>');"><img	src="/images/kor/btn/btnA_convey.gif" /></a> 
<a href="javascript:mailWriteArg<%=uniqStr%>('replyall','전체답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>')"><img src="/images/kor/btn/btnA_answerAll.gif" /></a> 
<% } %> <%	if (MBOX_TYPE == 4 || MBOX_TYPE == 2) { %>
<a href="javascript:mailWriteArg<%=uniqStr%>('mail_rewrite','다시쓰기:<%=HtmlUtility.translate(webMailEntity.M_TITLE)%>');"><img src="/images/kor/btn/btnA_reWrite.gif" /></a> 
<% } else { %> 
<a href="javascript:refuseMailSniper<%=uniqStr%>('<%=paramEntity.M_IDX %>')"><img src="/images/kor/btn/btnA_dontRreceipt.gif" /></a> 
<% } %>
</p>
<p class="k_posiR">
	<select name="select_mbox" onChange="javascript:moveMail<%=uniqStr%>(this);">
		<option>다른편지함으로이동</option>
		<%=WebMailService.getMboxbySelect(request)%>
	</select>
</p>
</div>
</td></tr></table>