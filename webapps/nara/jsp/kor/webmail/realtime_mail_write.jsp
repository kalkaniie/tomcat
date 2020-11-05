<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.service.WebMailService"%>

<%@page	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.RecentAddressService"%>
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.WebMailEntity" scope="request" />
<jsp:useBean id="strReAddr" class="java.lang.String" scope="request" />
<jsp:useBean id="history" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="nlist" class="java.util.Vector" scope="request" />
<jsp:useBean id="vecIdxList" class="java.util.Vector" scope="request" />
<jsp:useBean id="vecTitleList" class="java.util.Vector" scope="request" />
<jsp:useBean id="ccBcc" class="java.lang.String" scope="request" />
<jsp:useBean id="attache_image" class="java.lang.String" scope="request" />
<jsp:useBean id="m_content" class="java.lang.String" scope="request" />
<jsp:useBean id="signStr" class="java.lang.String" scope="request" />

<%
if (session.getAttribute("USERS_IDX") != null) {
	
    StringBuffer sb = new StringBuffer();
    sb.append(request.getServerName()).append(':');
    sb.append(request.getServerPort());
    sb.append(request.getContextPath());
    
    String serverAddr = sb.toString();
    
    String webhardParameter = com.nara.springframework.bigmail.BigMailUtil.getWebHardParameter(request);
    
    out.println("<script language='JavaScript' src='../js/kor/ActiveX.js'></script>");
    out.println("<script language='JavaScript'>loadActiveXInstaller('" + serverAddr + "');</script>");
    out.println("<script language='JavaScript'>loadKebiLauncherAX('" + serverAddr + "', '" + webhardParameter + "');</script>");
}
%>

<%
m_content = m_content.replaceAll("<STYLE", "<div style='display:none'").replaceAll("</STYLE>", "</div>")
.replaceAll("<style", "<div style='display:none'").replaceAll("</style>", "</div>")
.replaceAll("<SCRIPT", "<X-SCRIPT").replaceAll("<script", "<X-SCRIPT")
.replaceAll("<JAVASCRIPT", "<X-JAVASCRIPT").replaceAll("<javascript", "<X-JAVASCRIPT")
.replaceAll("<head", "<X-head").replaceAll("</head", "<X-head")
.replaceAll("<html", "<X-html").replaceAll("</html", "<X-html")
.replaceAll("iframe", "X-IFRAME").replaceAll("IFRAME", "X-IFRAME")
.replaceAll("script", "X-SCRIPT").replaceAll("SCRIPT", "X-SCRIPT")
.replaceAll("link rel", "X-LINK REL").replaceAll("LINK REL", "X-LINK REL")
.replaceAll("http-equiv", "X-HTTP-EQUIV").replaceAll("HTTP-EQUIV", "X-HTTP-EQUIV")
.replaceAll("implementation", "X-IMPLEMENTATION").replaceAll("IMPLEMENTATION", "X-IMPLEMENTATION")
.replaceAll("xml", "X-XML").replaceAll("XML", "X-XML");

com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
int maxsize = conf.getInt("com.nara.kebimail.maxsize");
String USERS_SENDBOX = (String) session.getAttribute("USERS_SENDBOX");
String USERS_SIGNATURE = (String) session.getAttribute("USERS_SIGNATURE");
String strUrl = DomainService.getHttpUrl();
String USERS_ID = (String) session.getAttribute("USERS_ID");
UserEntity userEntity = UserSession.getUserInfo(request);
double NormalFreeDiskSpace = (userEntity.USERS_MAX_VOLUME - userEntity.USERS_CUR_VOLUME)*1024*1024;
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
String webmail_host = conf.getString("com.nara.kebimail.host");
%>
<%if(conf.getBoolean("com.nara.kebimail.anaconda")){%>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/anaconda_append_file.js"></script>
<%}%>
<script type="text/javascript" charset="utf-8" src="/js/kor/webmail/webmail_write_realtime.js?<%=uniqStr %>"></script>
<script LANGUAGE="JavaScript">
var activexOrFlex ="flex";
if( kebiGetCookie("kebimail_filecontrol") == "activex"){
	activexOrFlex ="activex";
}	


function changeAttacheMode<%=uniqStr%>(str){
	var anacondaFm = document.getElementById("anacondaFm<%=uniqStr%>");
	if(str=="flex"){
		anacondaFm.src = "/flex/jsp/fileupload_flex.jsp?uniqStr=<%=uniqStr%>&attechMode=mail";
		anacondaFm.height = "150";
		document.getElementById("attacheButton").style.display = "none";
	}else{
		anacondaFm.src = "anaconda.public.do?method=show_ana_upload&uniqStr=<%=uniqStr%>";
		anacondaFm.height = "120";
		document.getElementById("attacheButton").style.display = "block";
	}
}
getHtmlEditorInit();
logoAppend =false;
var focusObj=null;

function getChannel(){
	return document.anacondaFm<%=uniqStr%>.getChannel();
}

function sendMail<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("form_mail_write");
	
	if(objForm.M_TO.value.length <= 0 ){
		alert("받는사람 메일주소를 입력 하십시오.");
	    objForm.M_TO.focus();
	    return;
	}
	  
	var isValid = true;
	objForm.m_content.value = Ext.getCmp("editor_m_content"+objForm.uniqStr.value).getValue();
	
	if(objForm.M_TITLE.value.length <= 0)
		isValid = confirm("메일 제목이 작성되지 않았습니다.\n제목없는 메일을 발송/저장 하시겠습니까?");    
	    
	if(isValid && objForm.m_content.value.indexOf("mail.auth.do?method=outputImage") != -1){
	    isValid = confirm("이미지가 첨부된 메일은 수신자에게 이미지가 출력되지 않을 수 있습니다.\n이미지를 포함한 메세지를 발송하시려면 메일전달 기능을 사용하십시오.\n메일을 발송 하시겠습니까?");
	}
	  
	if(!isValid){
		objForm.M_TITLE.focus();
	}else{	
		chkValidName();	
	}
}

function sendMailStep2<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("form_mail_write");
	var isSaveTempMail = false;
    objForm.method.value="aj_mail_send";
    
    if(objForm.isReservMail.checked== true){ //예약발송인 경우
    	if(!isReservMail_check()) return ;
    	objForm.mailSendMode.value = 2;
    }else{ //메일임시보관 혹은 메일 발송
    	objForm.mailSendMode.value = 0;
    }

    var uploadObj = anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>;
    var freeDisk = <%= new java.math.BigDecimal(NormalFreeDiskSpace).setScale(2,java.math.BigDecimal.ROUND_HALF_UP) %>- ( objForm.m_content.value.length*2 + 2000) ;        // 사용가능한용량
    var uploadFileSize =0;
    setLetterPaper<%=uniqStr%>(objForm.m_content.value);  //편지지 사용  수정필
   
    if(freeDisk<=0){
    	alert("메일 사용량을 초과하여 송신할 수 없습니다.\n관리자에게 문의 하여 주십시요");
    	return;
    }

	Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do',
		method : 'POST',
		params: {
			method:'aj_emailAddressValidCheck',
			M_TO:objForm.M_TO.value,
			M_CC:objForm.M_CC.value,
			M_BCC:objForm.M_BCC.value,
			M_SECURE_YN:objForm.M_SECURE_YN.checked
		},
		success : function(response, options) {
			try {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE','ERR_M_TO','ERR_M_CC','ERR_M_BCC']);
		  		var resultXML = reader.read(response);

		  		if (resultXML.records[0].data.RESULT == "success") {
					mailSendAction<%=uniqStr%>();
		  		}  else {
		  			if (resultXML.records[0].data.RESULT == "AbnormalError") {
		  				alert(resultXML.records[0].data.MESSAGE);
		  				return ;
		  			} else if (resultXML.records[0].data.RESULT == "NumOfRcptToOver") {
		  				alert(resultXML.records[0].data.MESSAGE);
		  				return ;
		  			} else if (resultXML.records[0].data.RESULT == "badMailAddress") {
		  				var rtn = confirm(resultXML.records[0].data.MESSAGE);
		  				if(rtn) {
		  					clearAddress<%=uniqStr%>(
		  						resultXML.records[0].data.ERR_M_TO,
		  						resultXML.records[0].data.ERR_M_CC,
		  						resultXML.records[0].data.ERR_M_BCC
		  					);
		  					mailSendAction<%=uniqStr%>(
		  						resultXML.records[0].data.ERR_M_TO,
		  						resultXML.records[0].data.ERR_M_CC,
		  						resultXML.records[0].data.ERR_M_BCC
		  					);
		  				} else {
		  					return ;
		  				}
		  			} else if (resultXML.records[0].data.RESULT == "notSendSecureMail") {
		  				var rtn = confirm(resultXML.records[0].data.MESSAGE);
		  				if(rtn) {
		  					clearAddress<%=uniqStr%>(
		  						resultXML.records[0].data.ERR_M_TO,
		  						resultXML.records[0].data.ERR_M_CC,
		  						resultXML.records[0].data.ERR_M_BCC
		  					);
		  					mailSendAction<%=uniqStr%>(
		  						resultXML.records[0].data.ERR_M_TO,
		  						resultXML.records[0].data.ERR_M_CC,
		  						resultXML.records[0].data.ERR_M_BCC
		  					);
		  				} else {
		  					return ;
		  				}
		  			}		  		
		  		}
			} catch(e) {
				return ;
			}	    		
   		},
		failure : function(response, options) {
		}
	});	
}

function clearAddress<%=uniqStr%>(m_to, m_cc, m_bcc) {
	var objForm = searchFormByActiveTab("form_mail_write");
	var arrList = new Array();
	var tmpValue = "";
	
	if (m_to != "") {
		tmpValue = objForm.M_TO.value;
		arrList = m_to.split(",");
		if (arrList != null || arrList.length > 0) {
			for(var i=0; i<arrList.length; i++) {
				tmpValue = tmpValue.replaceAll(arrList[i], "");
			}
			objForm.M_TO.value = tmpValue;
		}
	}
	
	if (m_cc != "" ) {
		tmpValue = objForm.M_CC.value;
		arrList = m_cc.split(",");
		if (arrList != null || arrList.length >0 ) {
			for(var i=0; i<arrList.length; i++) {
				tmpValue = tmpValue.replaceAll(arrList[i], "");
			}
			objForm.M_CC.value = tmpValue;
		}	
	}
	
	if (m_bcc != "") {
		tmpValue = objForm.M_BCC.value;
		arrList = m_bcc.split(",");
		if (arrList != null || arrList.length > 0) {
			for(var i=0; i<arrList.length; i++) {
				tmpValue = tmpValue.replaceAll(arrList[i], "");
			}
			objForm.M_BCC.value = tmpValue;
		}	
	}
}

function mailSendAction<%=uniqStr%>() {
	var objForm = searchFormByActiveTab("form_mail_write");
	if(objForm.M_TO.value.length <= 0 ){
		alert("받는사람 메일주소를 입력 하십시오.");
	    objForm.M_TO.focus();
	    return;
	}
		
	var uploadObj = anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>;
    var freeDisk = <%= new java.math.BigDecimal(NormalFreeDiskSpace).setScale(2,java.math.BigDecimal.ROUND_HALF_UP) %>- ( objForm.m_content.value.length*2 + 2000) ;        // 사용가능한용량
    var uploadFileSize =0;
    
    if( objForm.M_SECURE_YN != null && objForm.M_SECURE_YN.checked== true){ //security mail
    	var encEmailStr = "<%=userEntity.USERS_IDX%>," + objForm.M_TO.value+","+objForm.M_CC.value+","+objForm.M_BCC.value;
    	if( encEmailStr.indexOf("!") !=-1 || encEmailStr.indexOf("#") !=-1 || encEmailStr.indexOf("$") !=-1){
    		alert("그룹전송으로 보안메일을 전송할 수 없습니다");
    		return;
    	}	
		
		uploadObj.SetNormalFreeDiskSpace(freeDisk);	
	   	uploadObj.SetMailInfo(objForm.M_TITLE.value ,"<%=userEntity.USERS_NAME%> <%=userEntity.USERS_IDX%>" , objForm.M_TO.value, objForm.M_CC.value);
	   	uploadObj.DoEncrypt(objForm.m_content.value, "", encEmailStr,1);   	
	   	return;	   	
    }

    if(uploadObj && !uploadObj.IsFileListEmpty()) {
    	uploadFileSize = uploadObj.GetBase64EncodeFileLength();    // 첨부하고자 하는용량 (activX base64 encoding size)
    	if( freeDisk < uploadObj.GetBase64EncodeFileLength()){
    		alert("메일 사용량을 초과하여 송신할 수 없습니다.\n관리자에게 문의 하여 주십시요");
    		return;
    	}  
    	fileUpload<%=uniqStr%>();       	
    }else if(activexOrFlex == "flex"){
        flexUpload<%=uniqStr%>();
    }else{
    	mailSendComplete();
    }
}		
function mailSendComplete(){
	var objForm = searchFormByActiveTab("form_mail_write");
		showLoadingMessage("메일을 전송 중입니다");
		Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({
			   	record: 'RESPONSE'
				}, 
				['RESULT','MESSAGE','strAddress','rcpt','M_TITLE']);
			var resultXML = reader.read(response);
			if (resultXML.records[0].data.RESULT == "success") {
				unLoadingMessage();
				document.getElementById("anacondaFm<%=uniqStr%>").style.visibility="hidden";	// activex or flash iframe hidden
				mainPanel.getActiveTab().body.load(
							{url: "webmail.auth.do?method=show_message",
							params: {strAddress:resultXML.records[0].data.strAddress,
									 rcpt:resultXML.records[0].data.rcpt,
									 M_TITLE:resultXML.records[0].data.M_TITLE
									},
							scripts: true
					        }	
					);
					uploadObj = null;
			}else{
				unLoadingMessage();
				Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
				
			}
			},
		failure : function(response, options) {
			unLoadingMessage();
			callAjaxFailure(response, options);
		}
	});
}

function staticMessanger<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("form_mail_write");
	
  if( objForm.isUseMsg.checked == false){
	  objForm.MailToName.value= objForm.M_TO.value.replaceAll("\"","");
    var val = f.MailToName.value;
    if(val.length == val.lastIndexOf(",")+1){
    	objForm.MailToName.value = val.substring(0, val.lastIndexOf(","));
    }
  }
}

function saveTempMail<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("form_mail_write");
	isSaveTempMail = false;
	objForm.m_content.value = Ext.getCmp("editor_m_content<%=uniqStr%>").getValue();
	
	if(objForm.m_content.value.length == 0){
  		alert("임시저장함에 저장할 본문 내용이 없습니다. ");
  	  	return;
  	}
	objForm.method.value="aj_mail_send";
	setLetterPaper<%=uniqStr%>();
	objForm.mailSendMode.value = 1;
	showLoadingMessage("메일을 임시 보관 중입니다");
	Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			getExtAjaxMessage(response,'임시보관 되었습니다.',true);
			unLoadingMessage();
		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
			unLoadingMessage();
		}
	});
}
function saveTempMail(){
	var objForm ;
	objForm = searchFormByActiveTab("form_mail_write");
	isSaveTempMail = false;
	objForm.m_content.value = Ext.getCmp("editor_m_content"+objForm.uniqStr.value).getValue();
	if(objForm.m_content.value.length == 0){
  		alert("임시저장함에 저장할 본문 내용이 없습니다. ");
  	  	return;
  	}
	objForm.method.value="aj_mail_send";
	setLetterPaper<%=uniqStr%>();
	objForm.mailSendMode.value = 1;
	showLoadingMessage("메일을 임시 보관 중입니다");
	Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			getExtAjaxMessage(response,'임시보관 되었습니다.',true);
			unLoadingMessage();
		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
			unLoadingMessage();
		}
	});
}

function previewMail<%=uniqStr%>() { //v2.0
	var objForm = searchFormByActiveTab("form_mail_write");
	var link = 'webmail.auth.do?method=preview&uniqStr=<%=uniqStr%>&stmt_idx='+objForm.SIGN_STMT.value;
	MM_openBrWindow( link,"preview","status=yes,toolbar=no,scrollbars=yes,width=750,height=429");
}

function selAddress<%=uniqStr%>(objForm,pName) {
	var link="";
	if(pName =="addr")
    	link = "address.auth.do?method=address_list_pop&objForm="+objForm;
    else
    	link = "usergroup.auth.do?method=usergroup_list_pop&objForm="+objForm;
    MM_openBrWindow( link ,"address_pop","status=yes,toolbar=no,scrollbars=no,width=921,height=467");
}

function showDateForm<%=uniqStr%>(obj){
  if(obj.checked){
    selectDate<%=uniqStr%>.style.display = "inline";
  }else{
    selectDate<%=uniqStr%>.style.display = "none";
  }
}

function showSecureForm<%=uniqStr%>(obj){
  if(obj.checked){
    secureLayer<%=uniqStr%>.style.display = "inline";
  }else{
    secureLayer<%=uniqStr%>.style.display = "none";
  }
}

function showTextForm<%=uniqStr%>(obj){
  if(obj.checked){
    selectText.style.display = "";
    f.MailToName.value="수신인 이름을 입력하세요";
  }else{
    selectText.style.display = "none";
    f.MailToName.value="";
  }
}

function showCCForm<%=uniqStr%>(){
  if(divCc<%=uniqStr%>.style.display == "inline"){
    divCc<%=uniqStr%>.style.display = "none";
  }else{
    divCc<%=uniqStr%>.style.display = "inline";
  }
}

function formletter<%=uniqStr%>() {
   var link = "formletter.auth.do?method=formletter_list";
   var openwin = window.open( link ,"formLetter","status=yes,toolbar=no,scrollbars=yes,resizable=yes,width=700,height=400");
}

function setLetterPaper<%=uniqStr%>(contentValue){
	var objForm = searchFormByActiveTab("form_mail_write");
	if(objForm.letterPaper.value.length > 0){
	    var strTempContent;
	    strTempContent = "<table width=700 height=350 border=0 cellpadding=0 cellspacing=1 bgcolor=#999999 align=center ><tr valign=top><td bgcolor=#ffffff background='"+objForm.letterPaper.value+"'>";
	    strTempContent += contentValue;
	    strTempContent += "</td></tr></table>";
	    objForm.m_content.value=strTempContent;
    }
}

function setCheckbox<%=uniqStr%>(obj){
	var objFormObj = eval("document.form_mail_write<%=uniqStr%>."+obj);
	if(objFormObj.checked)
		objFormObj.checked = false;
	else
		objFormObj.checked = true;
}

function AnaFileListView<%=uniqStr%>(mailContentStr){
	var objForm = document.form_mail_write<%=uniqStr%>;
	objForm.sendURL.value = anacondaFm<%=uniqStr%>.anaForm<%=uniqStr%>.sendURL.value;
	var fileAppendList = "";
	if( mailContentStr.length > 0 ) {
		fileAppendList = "" +anaFrontList()  + anaList(mailContentStr) +"";
	}
  
	objForm.users_idx.value   = anacondaFm<%=uniqStr%>.anaForm<%=uniqStr%>.users_idx.value  ;
	objForm.mail_seq.value    = anacondaFm<%=uniqStr%>.anaForm<%=uniqStr%>.mail_seq.value   ;
	objForm.down_cnt.value    = anacondaFm<%=uniqStr%>.anaForm<%=uniqStr%>.down_cnt.value   ;
	objForm.mail_expire.value = anacondaFm<%=uniqStr%>.anaForm<%=uniqStr%>.file_expire.value;
	objForm.mail_create.value = anacondaFm<%=uniqStr%>.anaForm<%=uniqStr%>.file_create.value;
	objForm.fileAppendList.value = fileAppendList;
}

function sendMailAppend<%=uniqStr%>() {
	var objForm = document.form_mail_write<%=uniqStr%>;
    if(objForm.isReservMail.checked == true && objForm.fileAppendList.value !=""){
		alert("대용량첨부파일이 첨부된 메일은 예약발송을 할 수 없습니다.");
		return;
	}
  
	objForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue()+objForm.fileAppendList.value;
	showLoadingMessage("메일을 전송 중입니다");

	Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
    		var reader = new Ext.data.XmlReader({
    		   	record: 'RESPONSE'
    			}, 
    			['RESULT','MESSAGE','strAddress','rcpt','M_TITLE']);
    		var resultXML = reader.read(response);
    		// alert(resultXML.records[0].data.M_TITLE);
    		if (resultXML.records[0].data.RESULT == "success") {
    			unLoadingMessage();
    			mainPanel.getActiveTab().body.load(
					{url: "webmail.auth.do?method=show_message",
					scripts: true,
			        params: {strAddress:resultXML.records[0].data.strAddress, 
			        		 rcpt:resultXML.records[0].data.rcpt,
			        		 M_TITLE:resultXML.records[0].data.M_TITLE,
			        		 M_SECURE_YN:objForm.M_SECURE_YN.checked, 
							 M_SECURE_PW:objForm.secureMailKey.value
			        		},
			        autoDestroy :true
			        }	
				);
    		}else{
    			unLoadingMessage();
    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
    		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

function Send_Me<%=uniqStr%>(){
	var objForm = document.form_mail_write<%=uniqStr%>;
	if(objForm.send_me.checked){
		objForm.M_TO.value='<%=(String)session.getAttribute("USERS_IDX")%>';
	}else{
		objForm.M_TO.value='';
	}
}

function scrollFix<%=uniqStr%>(obj, bufId){
	  if(!IsIE<%=uniqStr%>()){
	    flexInput<%=uniqStr%>(obj, bufId);
	  }
	}

	function flexInput<%=uniqStr%>(obj, bufId){
	  var valu = obj.value;
	  var curWidth = obj.offsetWidth;
	  var curHeight = obj.offsetHeight;

	  var buffer = document.getElementById(bufId);
	  buffer.style.width = curWidth + "px";

	  var tmpText = document.createTextNode(valu);
	  buffer.innerHTML = "";
	  buffer.appendChild(tmpText);
	  if(buffer.offsetHeight >= 80){
	    obj.style.height = "80px";
	    obj.style.overflowY = "auto";
	  }else if(buffer.offsetHeight <= 12){
	    obj.style.height = "12px";
	    obj.style.overflowY = "hidden";      
	  }else{
	    obj.style.height = buffer.offsetHeight;
	    obj.style.overflowY = "hidden";      
	  }
	}
	 
	function IsIE<%=uniqStr%>() { 
	  if(navigator.userAgent.indexOf("MSIE") == -1) {
	    return false;
	  } 
	  return true;
	} 

function diskManager(){
  anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>.ExcuteDiskManager();
}

function envManager(){
	  // var strurl = "/mail/anaconda.public.do?method=anaUserEnvForm&USERS_IDX=<%=(String)session.getAttribute("USERS_IDX")%>"
	  // MM_openBrWindow(strurl,'env','status=no,toolbar=no,scrollbars=no,resizable=yes,width=490,height=205');

	  var strurl = "/mail/webhard.auth.do?method=userEnvForm&USERS_IDX=<%=(String)session.getAttribute("USERS_IDX")%>";
	  MM_openBrWindow(strurl,'env','status=no,toolbar=no,scrollbars=no,resizable=yes,width=600,height=265');
}

function ActiveXDownLoad() {
  location.href = "/activeX/KBinstaller.exe";
}

function setSendAddress<%=uniqStr%>(obj) {
	var objForm = document.form_mail_write<%=uniqStr%>;
	if (obj.value != -1) {
		if (focusObj == null) {
			focusObj = objForm.M_TO;
		}
		
		if (focusObj.value.trim().length == 0) {
			focusObj.value = focusObj.value.trim() + obj.options[obj.selectedIndex].value;
		} else {
			if (focusObj.value.trim().substring(focusObj.value.trim().length-1) != ",") {
				focusObj.value = focusObj.value.trim() + "," + obj.options[obj.selectedIndex].value;
			} else {
				focusObj.value = focusObj.value.trim() + obj.options[obj.selectedIndex].value;
			}
		} 
	}
}

function FindFile<%=uniqStr%>() {
	var uploadObj = anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>;
	if( !uploadObj ) {
		alert("파일 업로드 activeX가 로드되지 못했습니다.");
		return;
	}
	uploadObj.FindFileDialog();
} 

function DeleteFile<%=uniqStr%>() {
	var uploadObj = anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>;
	if( !uploadObj ) {
		alert("파일 업로드 activeX가 로드되지 못했습니다.");
		return;
	}

	uploadObj.DeleteFile();
}

function fileUpload<%=uniqStr%>() {
	var uploadObj = anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>;
	if( !uploadObj ) {
		alert("파일 업로드 activeX 로드되지 못했습니다.");
		return;
	}

	uploadObj.SetCmd("webmailAttacheFile");
	uploadObj.filetype = "ALL";
	uploadObj.UploadFile();  
	return;
} 

function flexUpload<%=uniqStr%>() {
	anacondaFm<%=uniqStr%>.setAttechMode("mail", "parent.mailSendComplete");
	anacondaFm<%=uniqStr%>.upload();
}

function showLayer<%=uniqStr%>(obj,showObj){
	var objFormObj = eval("document.form_mail_write<%=uniqStr%>."+obj);
	
	if(objFormObj.checked){
		eval(showObj).style.display = "inline";
	}else{
		eval(showObj).style.display = "none";
	}
}

function chkValidName(){
	var objForm = searchFormByActiveTab("form_mail_write");
	var sReceive = "";
	var sReceive2 = "";

	var ajaxBoolean = Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do',
		method : 'POST',
		params: {
			method:'aj_NameValidCheck',
			M_TO:objForm.M_TO.value,
			M_CC:objForm.M_CC.value,
			M_BCC:objForm.M_BCC.value
		},			
		success : function(response, options) {
			try {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE','VALID_M_TO','VALID_M_CC','VALID_M_BCC','DUPL_ADDR_LIST','GUBUN']);
		  		var resultXML = reader.read(response);
		  	
		  		var vailResult = new Ext.data.XmlReader({record: 'DUPL_ADDR'},['TARGET','USERS_IDX','USERS_NAME','USERS_DEPARTMENT']);
				var vailResultXML = vailResult.read(response);
				
		  		if (resultXML.records[0].data.RESULT == "success") {
		  			if(resultXML.records[0].data.GUBUN == "validAddr"){
		  				objForm.M_TO.value = resultXML.records[0].data.VALID_M_TO;
		  				objForm.M_CC.value = resultXML.records[0].data.VALID_M_CC;
		  				objForm.M_BCC.value = resultXML.records[0].data.VALID_M_BCC;
		  				sendMailStep2<%=uniqStr%>()	
		  			}else if(resultXML.records[0].data.GUBUN == "duplAddr"){
		  				var VALID_M_TO = "", VALID_M_CC = "", VALID_M_BCC = ""; 
						var TARGET = new Array(), USERS_IDX = new Array(), USERS_NAME = new Array(), USERS_DEPARTMENT = new Array();
		  				arrSize = vailResultXML.records.length;
		  				
		  				VALID_M_TO = resultXML.records[0].data.VALID_M_TO;
		  				VALID_M_CC = resultXML.records[0].data.VALID_M_CC;
		  				VALID_M_BCC = resultXML.records[0].data.VALID_M_BCC;
		  				
		  				for(i =0; i<arrSize; i++){
		  					TARGET.push(vailResultXML.records[i].data.TARGET);
		  					USERS_IDX.push(vailResultXML.records[i].data.USERS_IDX + " ");
		  					USERS_NAME.push(vailResultXML.records[i].data.USERS_NAME + " ");
		  					USERS_DEPARTMENT.push(vailResultXML.records[i].data.USERS_DEPARTMENT + " ");
		  				}
		  				
		  				var link_str = "webmail.auth.do?method=getLocalUser";
		  				var params = Ext.urlDecode(
		  								"USERS_IDX="+USERS_IDX+
		  								"&USERS_NAME="+USERS_NAME+
		  								"&USERS_DEPARTMENT="+USERS_DEPARTMENT+
		  								"&TARGET="+TARGET+
		  								"&VALID_M_TO="+VALID_M_TO+
		  								"&VALID_M_CC="+VALID_M_CC+
		  								"&VALID_M_BCC="+VALID_M_BCC+
		  								"&key_uniqStr=<%=uniqStr%>");
		  				newWindowOpen('조직도선택',360,150,link_str,params);		
		  			}
		  		}  else {
		  			alert(resultXML.records[0].data.MESSAGE);
		  			return;
		  		}
			} catch(e) {
				return;
			}	    		
   		},
		failure : function(response, options) {
		}
	});
}

function mail_write_non_active<%=uniqStr%>() {
 	mainPanel.getActiveTab().body.load( {
		url: "webmail.auth.do?method=mail_write_non_active",
		scripts: true,
		autoDestory: true
    });
}

function mail_write_flex<%=uniqStr%>(){
	mainPanel.getActiveTab().body.load( {
		url: "webmail.auth.do?method=mail_write_flex",
		scripts: true,
		autoDestory: true
    });
}

function secureMail_show<%=uniqStr%>(){
	var obj = anacondaFm<%=uniqStr%>.KBbig<%=uniqStr%>;
	if (obj == null) {
		changeAttacheMode<%=uniqStr%>('activex', "secure");
	} else {
		secureMail_show<%=uniqStr%>Step2();
	}
}
function secureMail_show<%=uniqStr%>Step2(){
	document.form_mail_write<%=uniqStr%>.M_SECURE_YN.value="Y";
	document.getElementById("secure_mail_div").style.display = "inline";
}
function secureMail_cancel<%=uniqStr%>(){
	document.form_mail_write<%=uniqStr%>.M_SECURE_YN.value="";
	document.form_mail_write<%=uniqStr%>.secureMailKey.value="";
	document.form_mail_write<%=uniqStr%>.secureMailHint.value="";
	document.form_mail_write<%=uniqStr%>.secureMailPhone.value="";
	document.getElementById("secure_mail_div").style.display = "none";
}
function selctUser<%=uniqStr%>(objForm,obj) {
	link = "usergroup.auth.do?method=usergroup_list_pop_userselect&objForm="+objForm+"&obj="+obj;
    MM_openBrWindow( link ,"usersearch_pop","status=yes,toolbar=no,scrollbars=no,width=600,height=463");
}
</script>
<table width="95%" border="0" cellspacing="0" cellpadding="0"><tr><td>
<form name="form_mail_write<%=uniqStr%>" method="post">
<input type=hidden name='method' value=''>
<input type=hidden name='mailSendMode' value='0'>
<input type=hidden name='M_ATTACHE' value=''>
<input type=hidden name='m_content'	value=''>
<input type=hidden name='history' value='<%=history%>'>
<input type=hidden name='H_M_IDX' value='<%=M_IDX%>'>
<input type=hidden name='letterPaper' value=''>
<input type=hidden name='processiong' value=''>
<input type=hidden name='content_add'>
<input type=hidden name='tmpStr' value='' id='tmpStr'>
<input type=hidden name='uniqStr' value='<%=uniqStr%>'>
<input type=hidden name='wiswigEditId' value='editor_m_content<%=uniqStr%>'>
<input type='hidden' name='M_SECURE_YN'>
<input type='hidden' name='M_CC'>
<input type='hidden' name='M_BCC'>
<input type='hidden' name='REALTIME' value="Y">
<div id=imageFileDiv></div>
<%
  if (history.equals("forward")) {
    java.util.Enumeration _enum = vecIdxList.elements();
    if (_enum.hasMoreElements() == true) {
      while (_enum.hasMoreElements()) {
%> <input type=hidden name='F_M_IDX'
	value='<%=_enum.nextElement().toString()%>'> <%    
      }
    }
  }
%>

<div class="btn_bgtd" style="border-bottom:2px solid #A8A8A8; position:relative; margin:0;">
<br>
<a href="javascript:sendMail<%=uniqStr%>()"><img src="/images/kor/btn/btn_send_mail.gif" align="top"></a>
&nbsp;<a href="javascript:saveTempMail<%=uniqStr%>();"><img src="/images/kor/btn/btn_temporary.gif" align="top"></a>
&nbsp;<a href="javascript:previewMail<%=uniqStr%>();"><img src="/images/kor/btn/btn_view.gif" align="top"></a>
<% if(conf.getBoolean("com.nara.securitymail")){ %>
&nbsp;<a href="javascript:secureMail_show<%=uniqStr%>();"><img src="/images/kor/btn/btn_securityMail.gif" align="top"></a>
<%}%>
</div>
<table class="k_mailHead" style="background:#F5F5F5;">
<% if(strReAddr.indexOf("</option><option") != -1) { %>
	<tr>
		<th width="156" scope="row">보내는사람</th>
		<td><select name="M_SENDER" class="select" style="width:95%">
			<%=strReAddr%>
		</select></td>
	</tr>
<% } else { %>	
	<input type=hidden name='M_SENDER'	value='<%=(String) session.getAttribute("USERS_IDX")%>'>
<% } %>
	<tr>
		<th width="156" scope="row">받는사람 <em> 
		<input type="checkbox" name="send_me" id="mb_writeMe" onClick="javascript:Send_Me<%=uniqStr%>();"/>
		<div id="d_b1<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		<label for="me">내게쓰기</label> </em></th>
		<td>
		<table><tr>
		<td>
			<div style="float:left;margin:1px 3px 0 0;vertical-align:buttom;align:left;">
			<% if (!ccBcc.equals("03")) { %>
					<textarea name="M_TO" id="M_TO<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="height: 10px;width: 330px; overflow: hidden; word-break: break-all; ime-mode:inactive;"><%=com.nara.util.ChkValueUtil.translate(entity.M_TO).trim()%></textarea>
			<% } else { %>
					<textarea name="M_TO" id="M_TO<%=uniqStr%>"	onfocus="javascript:focusObj=this;"	onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');"	onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="height: 10px;width: 330px; overflow: hidden; word-break: break-all; ime-mode:inactive;"></textarea><%  } %>
			
			</div>
		</td>
		<td>
			<a href="javascript:selAddress<%=uniqStr%>('form_mail_write<%=uniqStr%>','addr')"><img src="/images/kor/btn/btnB_address.gif" align="middle"/></a>
		</td>
		<td style="padding-left:3px;">
			<select name='selFrequentAddr' id='sel3' onchange="javascript:setSendAddress<%=uniqStr%>(this);" style="width: 155px">
				<option>최근에 사용한 주소</option>
				<%= RecentAddressService.getRecentAddressBySelect(userEntity.USERS_IDX) %>
			</select>
		</td>
		</tr></table>
	 </td>
	</tr>
	<tr>
		<th scope="row">제목</th>
		<td><input type="text" name="M_TITLE" value="<%=com.nara.util.ChkValueUtil.translate(entity.M_TITLE).replaceAll("\t", "")%>" style="width:96%; height:15px" class="k_inpColor" />
		</td>
	</tr>
	
	<tr> 
	  <th scope="row" class="t_dgray01" style="">1순위 대리인</td>
	  <td align="left" style="">
	  <table border="0" cellspacing="0" cellpadding="0">
	  	<tr>
			<td><input type="text" name="RT_RECEIVER1" id="RT_RECEIVER1"  style="width:200px;" class="gray_box_02"></td>
			<td><a href="javascript:selctUser<%=uniqStr%>('form_mail_write<%=uniqStr%>','RT_RECEIVER1')"><img src="/images_std/kor/ico/btn_searchRealtime.gif" border="0" align="top" style="margin:0 0 0 5px;"></a></td>
			<td width="30" style="text-align:center;">|</td>
			<td style="padding-right:5px;"><b>2순위 대리인</b></td>
			<td><input type="text" name="RT_RECEIVER2" id="RT_RECEIVER2" style="width:200px;" class="gray_box_02"></td>
			<td><a href="javascript:selctUser<%=uniqStr%>('form_mail_write<%=uniqStr%>','RT_RECEIVER2')"><img src="/images_std/kor/ico/btn_searchRealtime.gif" border="0" align="top" style="margin:0 0 0 5px;"></a></td>
		</tr>
	</table>
	</td>
	</tr>
	<tr> 
	  <th height="28" class="t_dgray01" >상대방대화명</td>
	  <td align="left" >
	  <input type="text" name="MailToName" value=""  style="width:100px" class="gray_box_02">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
	  <b>대화요청 유효기간 </b> 
	  <select name="RT_VALID_DAY">
	  	<option value="0">제한없음</option>	
	  	<option value="1">1일간</option>
	  	<option value="2">2일간</option>
	  	<option value="3">3일간</option>
	  	<option value="4">4일간</option>
	  	<option value="5">5일간</option>
	  	<option value="6">6일간</option>
	  	<option value="7">7일간</option>
	  </select>	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
	  <b>대화요청 시간</b>
	  <select name="RT_VALID_TIME_START">
	  	<option value="0">0</option>
	  	<option value="1">1</option>
	  	<option value="2">2</option>
	  	<option value="3">3</option>
	  	<option value="4">4</option>
	  	<option value="5">5</option>
	  	<option value="6">6</option>
	  	<option value="7">7</option>
	  	<option value="8">8</option>
	  	<option value="9" selected>9</option>
	  	<option value="10">10</option>
	  	<option value="11">11</option>
	  	<option value="12">12</option>
	  	<option value="13">13</option>
	  	<option value="14">14</option>
	  	<option value="15">15</option>
	  	<option value="16">16</option>
	  	<option value="17">17</option>
	  	<option value="18">18</option>
	  	<option value="19">19</option>
	  	<option value="20">20</option>
	  	<option value="21">21</option>
	  	<option value="22">22</option>
	  	<option value="23">23</option>
	  	<option value="24">24</option>
	  </select>시 ~
	  <select name="RT_VALID_TIME_END">
	  	<option value="0">0</option>
	  	<option value="1">1</option>
	  	<option value="2">2</option>
	  	<option value="3">3</option>
	  	<option value="4">4</option>
	  	<option value="5">5</option>
	  	<option value="6">6</option>
	  	<option value="7">7</option>
	  	<option value="8">8</option>
	  	<option value="9">9</option>
	  	<option value="10">10</option>
	  	<option value="11">11</option>
	  	<option value="12">12</option>
	  	<option value="13">13</option>
	  	<option value="14">14</option>
	  	<option value="15">15</option>
	  	<option value="16">16</option>
	  	<option value="17">17</option>
	  	<option value="18" selected>18</option>
	  	<option value="19">19</option>
	  	<option value="20">20</option>
	  	<option value="21">21</option>
	  	<option value="22">22</option>
	  	<option value="23">23</option>
	  	<option value="24">24</option>
	  </select>시 까지
	  </td>
	</tr>
</table>

<div id="k_txWrite<%=uniqStr%>" style="border-top: 2px solid #6d6d6d;height:300px">
<textarea name="htmleditor<%=uniqStr%>" tabIndex="4" id="htmleditor<%=uniqStr%>" style="font:12px 굴림, Gulim, Gulim Che; position:absolute; width:95%;height: 300px"></textarea>
<textarea name="temp_content" id="temp_content"	style="display: none;"><%=m_content.trim()%></textarea>
</div>

<%	if (vecTitleList.size() > 0) { %>
<ul class="k_mailFb">
	<%      for (int i = 0; i < vecTitleList.size(); i++) { %>
	<li><b>전달메일:</b> <%=com.nara.jdf.jsp.HtmlUtility.translate((String)vecTitleList.elementAt(i))%></li>
	<%      } %>
</ul>
<%  } %>


<div ID=fileattache<%=uniqStr%>>
<%
    if(nlist.size() > 0) {
      for (int i = 0; i < nlist.size(); i++) {
        out.println(com.nara.util.UtilFileApp.getAttacheFileByHtmlEucKr((String)nlist.elementAt(i), "kor"));
      }
    }
	%>
</div>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
   <td colspan="2" bgcolor="ffffff">
  <div id="k_attach" style="width:100%">
       <jsp:include page="/jsp/kor/util/util_fileupload_mail.jsp" flush="true">
			<jsp:param name="uniqStr" value="<%=uniqStr%>" />	
			<jsp:param name="attechMode" value="mail" />					
	   </jsp:include>
  </div>
  </td>
</tr>
<tr id="attacheButton" style="display:none">
  <td height="30" width="50%" align="left" bgcolor="f4f4f4" style="padding-left:10px">
  	<a href="javascript:FindFile<%=uniqStr%>()"><img src="../images_std/kor/btn/btn_file_search.gif" align="top"></a>
  	&nbsp;<a href="javascript:DeleteFile<%=uniqStr%>()"><img src="../images_std/kor/btn/btn_file_delete.gif" align="top"></a>
  	&nbsp;<a href="javascript:changeAttacheMode<%=uniqStr%>('flex')"><img src="../images_std/kor/btn/btn_addFlex.gif" align="top"></a>
  </td>
  <td width="50%" align="right" bgcolor="f4f4f4" style="padding-right:10px">	                  
  	<a href="javascript:ExecuteKebiExplorer()"><img src="../images_std/kor/btn/btn_file_big.gif" align="top"></a>
    <a href="javascript:envManager()"><img src="../images_std/kor/btn/btn_file_setup.gif" align="top"></a>
    &nbsp;<a href="javascript:ActiveXDownLoad()"><img src="../images_std/kor/btn/btn_activeX.gif" align="top"></a>
  </td>
</tr>
</table>

<div class="k_mailFun">
<dl class="k_maFun1">
	<dt>편지기능</dt>
	<dd><label>
		<input type=checkbox name=USERS_SENDBOX value='Y' <%=(USERS_SENDBOX != null && USERS_SENDBOX.equals("Y"))? "checked" : ""%>	class="inchek" id="save" /> <img src="/images/kor/ico/ico_file2.gif" />보낸편지함	저장</label> &nbsp;<img src="/images/kor/line/blu_13px.gif" /></dd>
	<dd><label><input type=checkbox name=USERS_SIGNATURE value='Y' <%=(USERS_SIGNATURE != null && USERS_SIGNATURE.equals("Y"))? "checked" : ""%> class="inchek" id="att" /> <img src="/images/kor/ico/ico_sign.gif" />서명첨부</label>
	<span id='signnature<%=uniqStr%>'>
      &nbsp;<select name="SIGN_STMT" style="width:80px"><%= signStr %></select>&nbsp;
      </span>&nbsp;<img src="/images/kor/line/blu_13px.gif" />
	</dd>
	<dd><label><input type='checkbox' name='individual'	value='1' class="inchek" id="send" /> <img src="/images/kor/ico/ico_indiSend.gif" />한사람씩보내기</label> &nbsp;<img src="/images/kor/line/blu_13px.gif" /></dd>
	<dd><label><input type=checkbox name=M_PRIORITY value=1 class="inchek" id="impt" /> <img src="/images/kor/ico/ico_star2.gif" />중요편지</label>&nbsp;<img src="/images/kor/line/blu_13px.gif" /></dd>
	
</dl>
<dl class="k_maFun2">
	<dd style="padding-left: 66px; _padding-left: 84px"> 
	<label><input type=checkbox name=isReservMail value=Y onClick=showDateForm<%=uniqStr%>(this); class="inchek" id="appo" /> <img src="/images/kor/ico/ico_appo.gif" />예약발송</label>
	<span id='selectDate<%=uniqStr%>' style='display: none'>
		<script language="JavaScript">
           Ext.DomHelper.append(("selectDate<%=uniqStr%>"),printDateTimeSelect2("dateReserv"));
         </script> </span></dd>
</dl>
</div>
<div class="btn_bgtd" style="border-bottom:2px solid #A8A8A8; position:relative; margin:0;">
<br>
<a href="javascript:sendMail<%=uniqStr%>()"><img src="/images/kor/btn/btn_send_mail.gif" align="top"></a>
&nbsp;<a href="javascript:saveTempMail<%=uniqStr%>();"><img src="/images/kor/btn/btn_temporary.gif" align="top"></a>
&nbsp;<a href="javascript:previewMail<%=uniqStr%>();"><img src="/images/kor/btn/btn_view.gif" align="top"></a>
<% if(conf.getBoolean("com.nara.securitymail")){ %>
&nbsp;<a href="javascript:secureMail_show<%=uniqStr%>();"><img src="/images/kor/btn/btn_securityMail.gif" align="top"></a>
<%}%>
</div>
<div ID="imageattache<%=uniqStr%>"></div>
<div ID="secure_div<%=uniqStr%>"></div>
<input type="hidden" name="m_content_tmp" value="" />
<div id="secure_mail_div" style="position:absolute; width:330px; display:none; z-index:100000; margin:0 auto; left:320px; top:30%;">
<table width="330" border="0" cellpadding="0" cellspacing="2" bgcolor="#a4a4a4">
<tr>
	<td align="left" valign="top" bgcolor="#ffffff" style="padding:10px" class="t_Gblue_line">
		<table width="310" border="0" cellspacing="0" cellpadding="0">
			<tr><td colspan="2" class="btn_bgtd">
			<a href="javascript:sendMail<%=uniqStr%>();"><img src="../images_std/kor/btn/btn_sendSecurity.gif" align="top"></a>&nbsp;
			<a href="javascript:secureMail_cancel<%=uniqStr%>();"><img src="../images_std/kor/btn/btn_setup_cancle.gif" align="top"></a></td>
			</tr>
			<tr>
				<td width="120" height="28" class="t_dgray01"><img src="../images_std/kor/bullet/dot.gif" align="absmiddle" >&nbsp; 보안키</td>
				<td width="190"align="left" valign="top" style="padding:5px 0px 7px 0"><input name="secureMailKey" type="password" style="width:180px" class="gray_box_02"></td>
			</tr>
			<tr>
				<td colspan="2" class="board_line_ddd"></td>
			</tr>
			<tr>
				<td width="140" height="28" class="t_dgray01"><img src="../images_std/kor/bullet/dot.gif" align="absmiddle" >&nbsp; 보안키 힌트</td>
				<td align="left" valign="top" style="padding:5px 0px 7px 0"><input name="secureMailHint" type="text" style="width:180px" class="gray_box_02"></td>
			</tr>
			<tr>
				<td colspan="2" class="board_line_ddd"></td>
			</tr>
			<tr>
                <td width="140" height="28" class="t_dgray01"><img src="../images_std/kor/bullet/dot.gif" align="absmiddle" >&nbsp; 발신자 Mobile</td>
				<td align="left" valign="top" style="padding:5px 0px 7px 0"><input name="secureMailPhone" type="text" style="width:180px" class="gray_box_02"></td>
			</tr>
			<tr>
				<td colspan="2" class="board_line_ddd"></td>
			</tr>
	</table>
	</td>
</tr>
</table>
</div>
</form>
</td></tr></table>
<iframe name="mailsend" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>

<% java.util.Calendar cal = java.util.Calendar.getInstance(); %>

<script LANGUAGE="JavaScript">
isSaveTempMail = true;
var imgTool=true, letterTool=true, formletterTool= true;
var uniqStr = getUniqStr<%=uniqStr%>();

function getUniqStr<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("form_mail_write");
	return objForm.uniqStr.value;
}

<%  if (attache_image != null && attache_image.length() > 0) { %>
eval("imageattache<%=uniqStr%>").innerHTML += "<%=attache_image%>";
<% } %>

setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_year, "<%=cal.get(cal.YEAR)%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_month, "<%=cal.get(cal.MONTH)+1%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_date, "<%=cal.get(cal.DATE)%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_hour, "<%=cal.get(cal.HOUR_OF_DAY)%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_minute, "<%=cal.get(cal.MINUTE)%>");

function isReservMail_check(){

	var nowDate = "<%=cal.get(cal.YEAR)%>" +
				  "<%=cal.get(cal.MONTH)+1%>" + 	
				  "<%=cal.get(cal.DATE)%>" + 
				  "<%=cal.get(cal.HOUR_OF_DAY)%>" +
				  "<%=cal.get(cal.MINUTE)%>";
				  
	var reserveDate =isSelectedTextSelectBox(document.form_mail_write<%=uniqStr%>.dateReserv_year) +
				   isSelectedTextSelectBox(document.form_mail_write<%=uniqStr%>.dateReserv_month) +
				   isSelectedTextSelectBox(document.form_mail_write<%=uniqStr%>.dateReserv_date)  + 
				   isSelectedTextSelectBox(document.form_mail_write<%=uniqStr%>.dateReserv_hour) +
				   isSelectedTextSelectBox(document.form_mail_write<%=uniqStr%>.dateReserv_minute) ;
	 
	if(nowDate >  reserveDate){
		alert('예약시간이 오늘 날짜 보다 이전 날짜입니다.');
		return false;
	}
		
	return true;	
}
</script>