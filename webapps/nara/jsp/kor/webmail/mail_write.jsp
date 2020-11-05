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
m_content = m_content.replaceAll("<STYLE", "<div style='display:none'").replaceAll("</STYLE>", "</div>")
.replaceAll("<style", "<div style='display:none'").replaceAll("</style>", "</div>")
.replaceAll("P \\{margin-top:0px;margin-bottom:0px;\\}", "")
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

<script LANGUAGE="JavaScript">
getHtmlEditorInit();
logoAppend =false;
var focusObj=null;
var activexOrFlex="activex"
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
    objForm.method.value="mail_send";
    
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
			method:'emailAddressValidCheck',
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
    }else{    
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
				getExtAjaxMessage(0);
			}
		});
    }	
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
	objForm.method.value="mail_send";
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
			getExtAjaxMessage(0);
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
	objForm.method.value="mail_send";
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
			getExtAjaxMessage(0);
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
    MM_openBrWindow( link ,"address_pop","status=yes,toolbar=no,scrollbars=no,width=921,height=459");
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
		failure : function(response, options) {getExtAjaxMessage(0);}
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
  var strurl = "anaconda.public.do?method=anaUserEnvForm&USERS_IDX=<%=(String)session.getAttribute("USERS_IDX")%>"
  MM_openBrWindow(strurl,'env','status=no,toolbar=no,scrollbars=no,resizable=yes,width=490,height=195');
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
			method:'NameValidCheck',
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
</script>
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


<div class="k_gridA5" style="position:relative">
<p><a href="javascript:sendMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_send.gif" /></a>
<a href="javascript:previewMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_preview.gif" /></a>
<a href="javascript:saveTempMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_temp.gif" /></a>
<a href="javascript:mail_write_non_active<%=uniqStr%>();"><img src="/images/kor/btn/btnA_modeTex.gif" /></a>
</p>
</div>
<table class="k_mailHead" style="min-width: 680px">
<% if(strReAddr.indexOf("</option><option") != -1) { %>
	<tr>
		<th width="156" scope="row">보내는사람</th>
		<td><select name="M_SENDER" class="select" style="width:590px">
			<%=strReAddr%>
		</select></td>
	</tr>
<% } else { %>	
	<input type=hidden name='M_SENDER'	value='<%=(String) session.getAttribute("USERS_IDX")%>'>
<% } %>
	<tr>
		<th scope="row">받는사람 <em> 
		<input type="checkbox" name="send_me" id="mb_writeMe" onClick="javascript:Send_Me<%=uniqStr%>();"/>
		<div id="d_b1<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		<label for="me">내게쓰기</label> </em></th>
		<td>
		<div style="float:left;margin:1px 3px 0 0;vertical-align:buttom;align:left;">
		<% if (!ccBcc.equals("03")) { %>
				<textarea name="M_TO" id="M_TO<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"><%=com.nara.util.ChkValueUtil.translate(entity.M_TO).trim()%></textarea>
		<% } else { %>
				<textarea name="M_TO" id="M_TO<%=uniqStr%>"	onfocus="javascript:focusObj=this;"	onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');"	onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"></textarea><%  } %>
		
		</div>
		<a href="javascript:selAddress<%=uniqStr%>('form_mail_write<%=uniqStr%>','addr')"><img src="/images/kor/btn/btnB_address.gif" /></a>
		<select name='selFrequentAddr' id='sel3' onchange="javascript:setSendAddress<%=uniqStr%>(this);" style="width: 155px">
			<option>최근에 사용한 주소</option>
			<%= RecentAddressService.getRecentAddressBySelect(userEntity.USERS_IDX) %>
		</select>
	 </td>
	</tr>
	<tr>
		<th scope="row">
		<div class="k_fltL">함께받는사람</div>
		<div class="k_more"><a href="#" class="k_ibtnPlus" id="kPlus<%=uniqStr%>" onclick="kPlus<%=uniqStr%>.style.display='none';kMinus<%=uniqStr%>.style.display='block';divCc<%=uniqStr%>.style.display='block'"><b>+</b></a>
		<a href="#" class="k_ibtnMinus" id="kMinus<%=uniqStr%>" onclick="kPlus<%=uniqStr%>.style.display='block';kMinus<%=uniqStr%>.style.display='none';divCc<%=uniqStr%>.style.display='none'"><b>-</b></a>
		</div>
		<div id="d_b2<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		</th>
		<td>
		<%  if (ccBcc.equals("02") || ccBcc.equals("05")) { %>
		<textarea name="M_CC" id="M_CC<%=uniqStr%>" TABINDEX="1" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" autocomplete="off" style="height: 12px; width: 430px; overflow: hidden; word-break: break-all; vertical-align: middle; ime-mode:inactive;" class="k_inpColor"><%= com.nara.util.ChkValueUtil.translate(entity.M_CC).trim()%></textarea>
		<%  } else { %>
		<textarea name="M_CC" id="M_CC<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" autocomplete="off" style="height: 12px; width: 430px; overflow: hidden; word-break: break-all; vertical-align: middle; ime-mode:inactive;" class="k_inpColor"></textarea> <%  } %>
		<div id="ADDRESS_BOX_M_CC" style="position: absolute"></div>
		<%  if (ccBcc.equals("02") || ccBcc.equals("05")) { %> <script>scrollFix<%=uniqStr%>(document.form_mail_write<%=uniqStr%>.M_CC,'d_b2<%=uniqStr%>');</script>
		<%  } %>
		</td>
	</tr>
	<tr id="divCc<%=uniqStr%>" style='display: none'>
		<th scope="row">숨겨받는사람
		<div id="d_b3<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		</th>
		<td>
		<%  if (ccBcc.equals("05")) { %>
		<textarea name="M_BCC" id="M_BCC<%=uniqStr%>" TABINDEX="1" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" autocomplete="off" style="height: 12px; line-height: 12px; width: 430px; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"><%= com.nara.util.ChkValueUtil.translate(entity.M_BCC).trim()%></textarea>
		<%  } else { %><textarea name="M_BCC" id="M_BCC<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" autocomplete="off" style="height: 12px; line-height: 12px; width: 430px; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"></textarea> <%  } %>
		<div id="ADDRESS_BOX_M_BCC" style="position: absolute"></div>
		</td>
	</tr>
	<tr>
		<th scope="row">제목</th>
		<td><input type="text" name="M_TITLE" value="<%=com.nara.util.ChkValueUtil.translate(entity.M_TITLE).replaceAll("\t", "")%>" style="width: 465px" class="k_inpColor" />
		<input type="checkbox"	name='individual' value='1' id="oneBone" class="inchek2" /> <label for="oneBone">한사람씩보내기</label></td>
	</tr>
</table>

<div id="k_txWrite<%=uniqStr%>" style="border-top: 2px solid #6d6d6d;height:300px">
<textarea name="htmleditor<%=uniqStr%>" id="htmleditor<%=uniqStr%>"	style="font: 12px 굴림, Gulim, Gulim Che; position: absolute; width: 95%; height: 300px"></textarea>
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
        out.println(com.nara.util.UtilFileApp.getAttacheFileByHtmlEucKr((String)nlist.elementAt(i), "kor",uniqStr));
      }
    }
	%>
</div>


<div class="k_attach<%=uniqStr%>" id="k_attach<%=uniqStr%>">
<jsp:include page="/jsp/kor/util/util_fileupload_mail.jsp" flush="true">
	<jsp:param name="uniqStr" value="<%=uniqStr%>" />
</jsp:include>
<div class="k_attBtn">
<p class="k_fltL">
 <a href="#"><img src="/images/kor/btn/btnB_findFile.gif" onclick="javascript:FindFile<%=uniqStr%>()" /></a> 
 <a href="#"><img src="/images/kor/btn/btnB_delete.gif" onclick="javascript:DeleteFile<%=uniqStr%>()" /></a>
 &nbsp;&nbsp;<a href="#" onclick="javascript:ActiveXDownLoad()"><b>ActiveX</b> 수동설치</a>
</p>
<p class="k_fltR">
 대용량 첨부는 최대 10일간 저장됩니다.&nbsp;&nbsp; <a href="javascript:;"	onclick="javascript:envManager()"><img src="/images/kor/btn/ext_bigFileSett.gif" /></a> 
<img src="/images/kor/line/gry_14px.gif" style="padding: 0 2px" /> 
<a href="javascript:;" onclick="javascript:callWebhard()"><img src="/images/kor/btn/ext_bigFileAdmin.gif" /></a>
</p>
</div>
</div>

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
	<dd><label><input type='checkbox' name='individual'	value='1' class="inchek" id="send" /> <img src="/images/kor/ico/ico_indiSend.gif" />받는주소 개별전송</label> &nbsp;<img src="/images/kor/line/blu_13px.gif" /></dd>
	<dd><label><input type=checkbox name=M_PRIORITY value=1 class="inchek" id="impt" /> <img src="/images/kor/ico/ico_star2.gif" />중요편지</label>&nbsp;<img src="/images/kor/line/blu_13px.gif" /></dd>
	
</dl>
<dl class="k_maFun2">
	<dd style="padding-left: 62px; _padding-left: 84px">
	<label><input type=checkbox name=isReservMail value=Y onClick=showDateForm<%=uniqStr%>(this); class="inchek" id="appo" /> <img src="/images/kor/ico/ico_appo.gif" />예약발송</label>
	<span id='selectDate<%=uniqStr%>' style='display: none'>
		<script language="JavaScript">
           Ext.DomHelper.append(("selectDate<%=uniqStr%>"),printDateTimeSelect2("dateReserv"));
         </script> </span></dd>
</dl>
<dl class="k_maFun2">
	<dd style="padding-left: 62px; _padding-left: 84px">
	<label><input type=checkbox name=M_SECURE_YN value=Y class="inchek" id="impt" onClick=showSecureForm<%=uniqStr%>(this); class="inchek" id="appo" /> <img src="/images/kor/ico/ico_staffMail.gif" />보안메일</label>
	<span id='secureLayer<%=uniqStr%>' style='display: none'> &nbsp; 
		보안키<input type="password" class="boxline01" name="secureMailKey" maxlength="10" size="10"> 
		힌트<input type="text" class="boxline01" name="secureMailHint" maxlength="20" size="20">&nbsp;
		발신자Mobile<input type="text" class="boxline01" name="secureMailPhone" maxlength="15" size="15">&nbsp;
	</span></dd>
</dl>
</div>
<div class="k_gridA5">
<p><a href="javascript:sendMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_send.gif" /></a>
<a href="javascript:previewMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_preview.gif" /></a>
<a href="javascript:saveTempMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_temp.gif" /></a>
</p>
</div>
<div ID="imageattache<%=uniqStr%>"></div>
<div ID="secure_div<%=uniqStr%>"></div>
<input type="hidden" name="m_content_tmp" value="" />
</form>
<iframe name="mailsend" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
<form name="createmail">
<input type="hidden" name="passwd">
</form>
<% java.util.Calendar cal = java.util.Calendar.getInstance(); %>

<script LANGUAGE="JavaScript">

function getUniqStr<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("form_mail_write");
	return objForm.uniqStr.value;
}
var uniqStr = getUniqStr<%=uniqStr%>();

<%  if (attache_image != null && attache_image.length() > 0) { %>
eval("imageattache<%=uniqStr%>").innerHTML += "<%=attache_image%>";
<% } %>

setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_year, "<%=cal.get(cal.YEAR)%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_month, "<%=cal.get(cal.MONTH)+1%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_date, "<%=cal.get(cal.DATE)%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_hour, "<%=cal.get(cal.HOUR_OF_DAY)%>");
setSelectedIndexByValue(document.form_mail_write<%=uniqStr%>.dateReserv_minute, "<%=cal.get(cal.MINUTE)%>");

isSaveTempMail = true;
var imgTool=true, letterTool=true, formletterTool= true;
</script>
<script type="text/javascript" charset="utf-8" src="/js/kor/webmail/webmail_write.js?<%=uniqStr %>"></script>
<script type="text/javascript">
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