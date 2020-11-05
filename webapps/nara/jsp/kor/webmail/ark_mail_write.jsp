<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.RecentAddressService"%>
<%@page import="com.nara.util.aria.SimpleNaraARIAUtil"%>



<%@page import="java.io.*"%>

<%@page import="com.nara.util.aria.NaraARIAUtil"%>
<%@page import="com.nara.jdf.db.entity.AnaUserEntity"%>
<%@page import="com.nara.springframework.service.AnacondaService"%>

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
<jsp:useBean id="uuid" class="java.lang.String" scope="request" />
<jsp:useBean id="fname" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="fsize" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="flid" class="java.util.ArrayList" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/css/portal.css" />
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />


<script type="text/javascript" charset="utf-8" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/WebUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/src/locale/ext-lang-ko.js"></script>

<script type="text/javascript" charset="utf-8" src="/js/kor/util/ExtUtil.js"></script>

<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
int maxsize = conf.getInt("com.nara.kebimail.maxsize");
String strHost = "http://"+conf.getString("com.nara.kebimail.host"); // 웹도메인
String USERS_SENDBOX = (String) session.getAttribute("USERS_SENDBOX");
String USERS_SIGNATURE = (String) session.getAttribute("USERS_SIGNATURE");
String strUrl = DomainService.getHttpUrl();
String USERS_ID = (String) session.getAttribute("USERS_ID");
UserEntity userEntity = UserSession.getUserInfo(request);
double NormalFreeDiskSpace = (userEntity.USERS_MAX_VOLUME - userEntity.USERS_CUR_VOLUME)*1024*1024;
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();

AnaUserEntity anaUserEntity = new AnaUserEntity();
anaUserEntity.USERS_IDX = userEntity.USERS_IDX;

AnacondaService anacondaService = new AnacondaService(); 
anaUserEntity = anacondaService.getUserByPolicy(anaUserEntity);

String nowDate = "0";
String expireDate = "0";
String downCnt = "0";

java.util.Calendar calendar = new java.util.GregorianCalendar();
java.util.Date trialTime = new java.util.Date();
calendar.setTime(trialTime);

calendar.add(Calendar.DATE, (int)anaUserEntity.USERS_PERIOD);

java.util.Date now    = new java.util.Date();
java.util.Date expire = calendar.getTime();

java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");

nowDate = sdf.format(now);
expireDate = sdf.format(expire);
downCnt = Integer.toString((int)anaUserEntity.DOWN_CNT);
%>


<script language='javascript'>	

</script>	
<script type="text/javascript" charset="utf-8" src="/js/kor/util/anaconda_append_file_webhard.js"></script>


<script LANGUAGE="JavaScript">
var focusObj=null;
function sendMail<%=uniqStr%>(){
	var objForm = document.form_ark_mail_write;
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
		isSaveTempMail = false;
	    objForm.method.value="aj_mail_send";
	    objForm.mailSendMode.value = 0;

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
				M_SECURE_YN:objForm.M_SECURE_YN.value
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
}

function mailSendAction<%=uniqStr%>() {
	var objForm = document.form_ark_mail_write;
	objForm.m_content.value += makeArkMailString();
   	
   	Ext.Ajax.request({
		scope :this,
		url: 'anaconda.public.do?method=anaFileInsertWebhard',
		method : 'POST',
		form: document.anaForm<%=uniqStr%>,
		success : function(response, options) {
    		var reader = new Ext.data.XmlReader({
    		   	record: 'RESPONSE'
    			}, 
    			['RESULT','MESSAGE']);
    		var resultXML = reader.read(response);
    		if (resultXML.records[0].data.RESULT == "success") {
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
			    			document.form_webhard.target ="webhard";
			    			document.form_webhard.submit();
			    			alert("대용량 메일이 전송 되었습니다.");
			    			window.close();

			    		}else{
			    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
			    			
			    		}
			   		},
					failure : function(response, options) {
						callAjaxFailure(response, options);
					}
				});
	
    		}else{
    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
    			
    		}
   		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
		}
	});
	
   	
}		

function clearAddress<%=uniqStr%>(m_to, m_cc, m_bcc) {
	var objForm = document.form_ark_mail_write;
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

function staticMessanger<%=uniqStr%>(){
	var objForm = document.form_ark_mail_write;
	
  if( objForm.isUseMsg.checked == false){
	  objForm.MailToName.value= objForm.M_TO.value.replaceAll("\"","");
    var val = f.MailToName.value;
    if(val.length == val.lastIndexOf(",")+1){
    	objForm.MailToName.value = val.substring(0, val.lastIndexOf(","));
    }
  }
}

function saveTempMail<%=uniqStr%>(){
	var objForm = document.form_ark_mail_write;
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
	objForm = document.form_ark_mail_write;
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
	var link = 'webmail.auth.do?method=preview&uniqStr=<%=uniqStr%>';
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
	var objForm = document.form_ark_mail_write;
	if(objForm.letterPaper.value.length > 0){
	    var strTempContent;
	    strTempContent = "<table width=700 height=350 border=0 cellpadding=0 cellspacing=1 bgcolor=#999999 align=center ><tr valign=top><td bgcolor=#ffffff background='"+objForm.letterPaper.value+"'>";
	    strTempContent += contentValue;
	    strTempContent += "</td></tr></table>";
	    objForm.m_content.value=strTempContent;
    }
}

function setCheckbox<%=uniqStr%>(obj){
	var objFormObj = eval("document.form_ark_mail_write."+obj);
	if(objFormObj.checked)
		objFormObj.checked = false;
	else
		objFormObj.checked = true;
}

function AnaFileListView<%=uniqStr%>(mailContentStr){
	var objForm = document.form_ark_mail_write;
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
	var objForm = document.form_ark_mail_write;

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
			        params: {strAddress:resultXML.records[0].data.strAddress , rcpt:resultXML.records[0].data.rcpt ,M_TITLE:resultXML.records[0].data.M_TITLE},
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
	var objForm = document.form_ark_mail_write;
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
	var objForm = document.form_ark_mail_write;
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
	var objFormObj = eval("document.form_ark_mail_write."+obj);
	
	if(objFormObj.checked){
		eval(showObj).style.display = "inline";
	}else{
		eval(showObj).style.display = "none";
	}
}

function makeArkMailString() {
	var anaFileInfo = "";
<%
	if (fname.size() > 0) {
		for(int i=0; i<fname.size(); i++) {
	
%>	
	anaFileInfo += "<%=(String)fname.get(i)%>|0|<%=(String)fsize.get(i)%>|1|";
<%
		}
	}
%>
	var fileAppendList = "";
	fileAppendList = "" +anaFrontList()  + anaList(anaFileInfo) +"";
	document.form_ark_mail_write.fileAppendList.value= fileAppendList;
	return fileAppendList;
}
</script>
<style type="text/css" id="mypage">
.x-html-editor-tb .x-edit-table .x-btn-text {background: transparent url(/images/kor/ico/ico_editSprite.gif)no-repeat 0 0;}
.x-html-editor-tb .x-edit-imageappend .x-btn-text {	background: transparent url(/images/kor/ico/ico_editSprite.gif)no-repeat -16px 0;}
.x-html-editor-tb .x-edit-letter .x-btn-text {background: transparent url(/images/kor/ico/ico_editSprite.gif)no-repeat -32px 0;}
.x-html-editor-tb .x-edit-formletter .x-btn-text {background: transparent url(/images/kor/ico/ico_editSprite.gif)no-repeat -48px 0;}
</style>

<%
String ftp_ip = conf.getString("c2i.if.sftp.ip");
String ftp_id = conf.getString("c2i.if.sftp.id");
String ftp_passwd = conf.getString("c2i.if.sftp.passwd");
String c2i_url = conf.getString("c2i.if.callback.url");
String ftp_key = SimpleNaraARIAUtil.ariaEncrypt(ftp_id + "||" + ftp_passwd);
%>

<form name="form_webhard" method="post" action="<%=c2i_url%>">
<input type=hidden name="ftp_key" value="<%=ftp_key%>">
<input type=hidden name="uploadDir" value="<%= NaraARIAUtil.ariaDecrypt(anaUserEntity.FILE_HOMEDIR,userEntity.USERS_IDX) %>">
<input type=hidden name="ftp_ip" value="<%=ftp_ip%>">
<input type=hidden name="uuid" value="<%=uuid%>">
<% for( int k=0; k<flid.size(); k++){%>
	<input type=hidden name="flid" value="<%=flid.get(k)%>">
<%}%>
</form>
<%
com.nara.util.UniqueStringGenerator usg = new com.nara.util.UniqueStringGenerator();		// mailseq
String mail_seq = usg.getUniqueString();
%>

<form name="form_ark_mail_write" method="post">
<input type=hidden name='method' value='aj_mail_send'>
<input type=hidden name='mail_type' value='ark_mail'>
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
<input type=hidden name='uuid' value='<%=uuid%>'>
<input type=hidden name='fname' value='<%=fname%>'>
<input type=hidden name='fsize' value='<%=fsize%>'>
<input type=hidden name='flid' value='<%=flid%>'>
<input type=hidden name='mail_seq' value='<%=mail_seq%>'>
<input type=hidden name='fileAppendList'>

<div id=imageFileDiv></div>
<div class="k_content">
<div class="k_gridA5">
<p><a href="javascript:sendMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_send.gif" /></a>
</p>
</div>
<table class="k_mailHead" style="min-width: 680px">
	<tr>
		<th width="156" scope="row">보내는사람</th>
		<td><select name="M_SENDER" class="select" style="width:300px">
			<%=strReAddr%>
		</select></td>
	</tr>
	<tr>
		<th scope="row">받는사람 <em> 
		<input type="checkbox" name="send_me" id="mb_writeMe" onClick="javascript:Send_Me<%=uniqStr%>();" />
		<div id="d_b1<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		<label for="me">내게쓰기</label> </em></th>
		<td>
		<div style="float: left; margin: 1px 3px 0 0; vertical-align: middle;">
		<%  if (!ccBcc.equals("03")) { %>
				<textarea name="M_TO" id="M_TO<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="width: 430px; height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"><%=com.nara.util.ChkValueUtil.translate(entity.M_TO).trim()%></textarea>
		<%  } else { %>
				<textarea name="M_TO" id="M_TO<%=uniqStr%>"	onfocus="javascript:focusObj=this;"	onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');"	onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="width: 430px; height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"></textarea><%  } %>
		</div>
		<a href="javascript:selAddress<%=uniqStr%>('form_ark_mail_write','addr')"><img src="/images/kor/btn/btnB_address.gif" /></a>
		<a href="javascript:selAddress<%=uniqStr%>('form_ark_mail_write','grp')"><img src="/images/kor/btn/btnB_inuser.gif" /></a> 
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
		<textarea name="M_CC" id="B_M_CC" TABINDEX="1" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" autocomplete="off" style="height: 12px; width: 430px; overflow: hidden; word-break: break-all; vertical-align: middle; ime-mode:inactive;" class="k_inpColor"><%= com.nara.util.ChkValueUtil.translate(entity.M_CC).trim()%></textarea>
		<%  } else { %>
		<textarea name="M_CC" id="B_M_CC" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" autocomplete="off" style="height: 12px; width: 430px; overflow: hidden; word-break: break-all; vertical-align: middle; ime-mode:inactive;" class="k_inpColor"></textarea> <%  } %>
		<div id="ADDRESS_BOX_M_CC" style="position: absolute"></div>
		<%  if (ccBcc.equals("02") || ccBcc.equals("05")) { %> <script>scrollFix<%=uniqStr%>(document.form_ark_mail_write.M_CC,'d_b2<%=uniqStr%>');</script>
		<%  } %>
		</td>
	</tr>
	<tr id="divCc<%=uniqStr%>" style='display: none'>
		<th scope="row">숨겨받는사람
		<div id="d_b3<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		</th>
		<td>
		<%  if (ccBcc.equals("05")) { %>
		<textarea name="M_BCC" id="B_M_BCC" TABINDEX="1" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" autocomplete="off" style="height: 12px; line-height: 12px; width: 430px; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"><%= com.nara.util.ChkValueUtil.translate(entity.M_BCC).trim()%></textarea>
		<%  } else { %> <textarea name="M_BCC" id="B_M_BCC" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" autocomplete="off" style="height: 12px; line-height: 12px; width: 430px; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"></textarea> <%  } %>
		<div id="ADDRESS_BOX_M_BCC" style="position: absolute"></div>
		</td>
	</tr>
	<tr>
		<th scope="row">제목</th>
		<td><input type="text" name="M_TITLE" value="<%=com.nara.util.ChkValueUtil.translate(entity.M_TITLE).replaceAll("\t", "")%>" style="width: 430px" class="k_inpColor" />
		<input type="checkbox"	name='individual' value='1' id="oneBone" class="inchek2" /> <label for="oneBone">한사람씩보내기</label></td>
	</tr>
</table>

<div id="k_txWrite<%=uniqStr%>" style="border-top: 2px solid #6d6d6d;height:380px">
<textarea name="htmleditor" id="htmleditor"	style="font: 12px 굴림, Gulim, Gulim Che; position: absolute; width: 95%; height: 380px"></textarea>
<textarea name="temp_content" id="temp_content"	style="display: none;"><%=m_content.trim()%></textarea>
</div>


<div ID=fileattache<%=uniqStr%>></div>

	<table style='border-collapse:collapse;width:100%; border:1px solid #cacaca; border-width:0px 1px 1px 1px;'>
  	<caption style='background:#cacaca url(/images/kor/bullet/arrow_right2.gif) no-repeat 9px 7px; text-align:left;color:#2d2c2c;font-weight:bold;line-height:18px;padding:2px 0 0 17px;display:block;position:relative'>
  	대용량첨부파일<span style='position:absolute;right:5px;top:2px'></span>
  	</caption>
  	<tr>
  	<th style='background:#ececec url(/images/kor/line/2tonG_14px.gif) no-repeat left 2px; border-top:1px solid #fff; border-bottom:1px solid #cacaca; text-align:left:	line-height:19px ;font-weight:normal;padding-left:8px'>파일명</th>
  	<th width='74' style='background:#ececec url(/images/kor/line/2tonG_14px.gif) no-repeat left 2px; border-top:1px solid #fff; border-bottom:1px solid #cacaca; text-align: center; line-height: 19px; font-weight: normal;'>용량</th>
  	</tr>
  	<%
        for (int i = 0; i < fname.size(); i++) {            
%>
	<tr>
		<td style="line-height:20px; border-bottom:1px solid #ccc;padding-left:8px;border-right:1px solid #ccc"><%=fname.get(i)%></td>
		<td style="text-align:center;line-height:20px; border-bottom:1px solid #ccc"><%=Long.parseLong((String)fsize.get(i))/1024%> KB</td>
	</tr>
	<%           
        }
%>
  	</table>
 <%
      DaoManager daoManager = DaoConfig.getDaoManager();
		String signStr = WebMailService.getSignStmt(daoManager, userEntity.USERS_IDX);
      %>
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
	<dd><label><input type=checkbox name=M_PRIORITY value=1 class="inchek" id="impt" /> <img src="/images/kor/ico/ico_star2.gif" />중요편지</label>&nbsp;</dd>
	<input type=hidden name=M_SECURE_YN value=N class="inchek" id="impt">
</dl>

</div>
</div>
<div ID="imageattache<%=uniqStr%>"></div>
<input type="hidden" name="m_content_tmp" value="" />
</form>
<iframe name="mailsend" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
<iframe name="webhard" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
<% java.util.Calendar cal = java.util.Calendar.getInstance(); %>

<script LANGUAGE="JavaScript">
var uniqStr = "<%=uniqStr%>";

<%  if (attache_image != null && attache_image.length() > 0) { %>
eval("imageattache<%=uniqStr%>").innerHTML += "<%=attache_image%>";
<% } %>

isSaveTempMail = true;
var imgTool=false, letterTool=false, formletterTool=false;
</script>
<script type="text/javascript" charset="utf-8" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/editor/htmleditorExtend_pop.js"></script>

<script type="text/javascript" charset="utf-8" src="/js/kor/webmail/ark_webmail_write.js"></script>

<form name="anaForm<%=uniqStr%>">
<input type="hidden" name="returnStr" id="returnStr" value=""> 
<input type="hidden" name="users_idx" id="users_idx" value="<%=userEntity.USERS_IDX%>"> 
<input type="hidden" name="anaMailContent" id="anaMailContent" value="">
<input type="hidden" name="sendURL" value="<%=strHost%>">
<input type="hidden" name="mailServletURL" value="/mail/">
<input type="hidden" name="mail_seq"  id="mail_seq" value="<%=mail_seq%>">
<input type="hidden" name="down_cnt" id="down_cnt" value="<%=downCnt%>"> 
<input type="hidden" name="file_create" id="file_create" value="<%=nowDate%>">
<input type="hidden" name="file_expire" id="file_expire" value="<%=expireDate%>">
<%
//폴더 및 파일 이름 | 파일(0)/폴더(1) 구분 | 파일사이즈 | 메일유(1)/무(0) | 날짜 | 업데이트(1)/추가(0)

StringBuffer fileInfo = new StringBuffer();
int curTime= (int)(System.currentTimeMillis()/1000);
fileInfo.append(userEntity.USERS_IDX).append("|");;
for (int i = 0; i < fname.size(); i++) {
	fileInfo.append("/").append(fname.get(i)).append("|0|");
	fileInfo.append(fsize.get(i)).append("|1|");
	fileInfo.append(Integer.toString(curTime)).append("|0|");
}
%>
<textarea name="fileInfo" rows=0 cols=0 style="display: none;"><%= fileInfo.toString() %></textarea>
</form>
