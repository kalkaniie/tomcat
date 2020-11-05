<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.RecentAddressService"%>
<%@page import="com.nara.web.narasession.DomainSession"%>

<jsp:useBean id="entity" class="com.nara.jdf.db.entity.WebMailEntity"scope="request" />
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
int maxsize = Integer.parseInt(DomainSession.getString(request,"DOMAIN_LIMIT_UPLOAD"));//conf.getInt("com.nara.kebimail.maxsize");
String USERS_SENDBOX = (String) session.getAttribute("USERS_SENDBOX");
String USERS_SIGNATURE = (String) session.getAttribute("USERS_SIGNATURE");
String strUrl = DomainService.getHttpUrl();
String USERS_ID = (String) session.getAttribute("USERS_ID");
UserEntity userEntity = UserSession.getUserInfo(request);
double NormalFreeDiskSpace = (userEntity.USERS_MAX_VOLUME - userEntity.USERS_CUR_VOLUME)*1024*1024;
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
int maxattachesize = conf.getInt("com.nara.kebimail.attache.max");
%>


<script LANGUAGE="JavaScript">
//FF
var nMaxAttache = <%=maxattachesize%>; //첨부파일 갯수
var strHiddenFrame = "fileattach"; //Hidden Frame Name
var strFormName = "fileForm<%=uniqStr%>";  // Form Name

function insFile(strNameOfOrg, strNameOfDest)
{
  var objOrg  = eval("document."+strFormName+"." + strNameOfOrg);
  var objDest = eval("document."+strFormName+"." + strNameOfDest);
  var objForm = eval("document."+strFormName);
  var strFile  = objOrg.value;
  var strValue = objOrg.value;
  if(objForm.isAttache.value == "U"){
    alert("파일업로드중입니다.");
    return;
  }else if(objForm.isAttache.value == "D"){
    alert("파일삭제중입니다.");
    return;
  }

  if(objOrg.value == "") {
    alert("파일을 선택해 주십시오");
    objOrg.focus();
    return;
  }

  //파일명에 :를 사용할 수 없음
  strValue = strValue.substr(strValue.lastIndexOf("\\") + 1);
  if(strValue.indexOf(":") != -1){
    alert("첨부파일명에 콜론(:)을 사용할 수 없습니다.");
    objOrg.focus();
    return;
  }

  if(!chkValue(objDest)){
    alert("파일은 "+nMaxAttache+"개까지 첨부할수 있습니다.");
    objOrg.focus();
    return;
  }

  objForm.action="utilfile.auth.do?method=attache_ins";
  objForm.isAttache.value="U";
  objForm.strFileName.value=strValue;
  
  for(i=1; i < objDest.length ; i++){
    if(objDest.options[i].value == ""){
      objDest.options[i].text="..파일업로드중입니다.";
      objDest.options[i].value="";
      objForm.submit();
      return;
    }
  }
}


function removeFile(strNameOfDest)
{
  var objForm = eval("document."+strFormName);
  var objDest = eval("document."+strFormName+"." + strNameOfDest);
  nDestSelectedIndex  = objDest.selectedIndex;
  if(nDestSelectedIndex <=0 || objDest.options[nDestSelectedIndex].text == ""){
    alert("삭제할 파일을 선택해 주십시오.");
    return;
  }
  if(objForm.isAttache.value == "U"){
    alert("파일업로드중입니다.");
    return;
  }else if(objForm.isAttache.value == "D"){
    alert("파일삭제중입니다.");
    return;
  }
  if(nDestSelectedIndex > 0 && objDest.options[nDestSelectedIndex].selected) {
    objForm.target = strHiddenFrame;
    var strValue = objDest.options[nDestSelectedIndex].value;
    strValue = strValue.substr(strValue.lastIndexOf("\\") + 1);
    
    objForm.action="utilfile.auth.do?method=attache_del&display=true&strFileName="+strValue+"&uniqStr=<%=uniqStr%>";
    objDest.options[nDestSelectedIndex].text = "..파일삭제중입니다.";
    objForm.isAttache.value="D";
    objForm.submit();
  }
}

function chkValue(objDest){
  var isValid = false;
  for(i=1; i < nMaxAttache+1 ; i++){
    if(objDest.options[i].value == ""){
      isValid= true;
      break;
    }
  }
  return isValid;
}

function setFileNM(){
  var objDest = document.fileForm<%=uniqStr%>.CatMenu_1;
  var strFileName = "";
  for(i=1; i < nMaxAttache+1 ; i++){
    if(objDest.options[i].value != "")
      strFileName=strFileName+objDest.options[i].text+",";
    }
  if(strFileName.length > 0)
    document.f.M_ISATTACH.value="Y";
  document.f.M_ATTACHE.value=strFileName;
}

function chkExist(objDest, strValue){
  var isValid = true;
  for(i=1; i < nMaxAttache+1 ; i++){
    if(objDest.options[i].value == strValue){
      isValid= false;
      break;
    }
  }
  return isValid;
}  
function setReserv(){
	  objForm = document.f;
	  if(objForm.isReserve.value == "N"){
	    reservmenu.style.backgroundColor = "#cccccc";
	    ReserveMode.style.display = "inline";
	    objForm.isReserve.value="Y";
	  } else {
	    reservmenu.style.backgroundColor = "#ececec";
	    ReserveMode.style.display = "none";
	    objForm.isReserve.value="N";
	  }
	}  

function setFileName(strFile){
	  var objDest = eval("document.fileForm<%=uniqStr%>.CatMenu_1");
	  for(i=1; i < objDest.length ; i++){
	    if(objDest.options[i].value == ""){
	      insertValue(objDest, strFile , i);
	      return;
	    }
	  }
	}

	function insertValue(objDest, strFile , i){
	  objDest.options[i].value=strFile;
	  objDest.options[i].text=getByteLength(strFile.substr(strFile.lastIndexOf("/") + 1));
	}

	function getByteLength(s){
	   var len = 0;
	   var str = "";
	   if ( s == null ) return 0;
	   for(var i=0;i<s.length;i++){
	      str += s.charAt(i);
	      var c = escape(s.charAt(i));
	      if ( c.length == 1 ) len ++;
	      else if ( c.indexOf("%u") != -1 ) len += 2;
	      else if ( c.indexOf("%") != -1 ) len += c.length/3;
	      if(len > 19){
	        str += "..";
	        break;
	      }
	   }
	   return str;
	}
//FF
var focusObj=null;
function sendMail<%=uniqStr%>(){
	var objForm , fileForm, appendForm;
	objForm = searchFormByActiveTab("form_mail_write");
	fileForm = searchFormByActiveTab("fileForm");
	appendForm = searchFormByActiveTab("send_append");
	
	if(objForm.M_TO.value.length <= 0 ){
		alert("받는사람 메일주소를 입력 하십시오.");
	    objForm.M_TO.focus();
	    return;
	}
	  
	var isValid = true;
	objForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue();
	
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
	var objForm, fileForm, appendForm;
	objForm = searchFormByActiveTab("form_mail_write");
	fileForm = searchFormByActiveTab("fileForm");
	appendForm = searchFormByActiveTab("send_append");
	
	isSaveTempMail = false;
	   objForm.method.value="aj_mail_send";
	    
	if(appendForm.isReservMail.checked== true){ //예약발송인 경우
	   	objForm.mailSendMode.value = 2;
	}else{ //메일임시보관 혹은 메일 발송
	   	objForm.mailSendMode.value = 0;
	}
	    
    var freeDisk = <%= new java.math.BigDecimal(NormalFreeDiskSpace).setScale(2,java.math.BigDecimal.ROUND_HALF_UP) %>- ( objForm.m_content.value.length*2 + 2000) ;        // 사용가능한용량
    var uploadFileSize =0;
    setLetterPaper<%=uniqStr%>(objForm.m_content.value);  //편지지 사용  수정필
    
    if(freeDisk<=0){
    	alert("메일 사용량을 초과하여 송신할 수 없습니다.\n관리자에게 문의 하여 주십시요");
    	return;
    }
    
    objForm.USERS_SENDBOX.value   = appendForm.USERS_SENDBOX.checked ? "Y":"";
    objForm.USERS_SIGNATURE.value = appendForm.USERS_SIGNATURE.checked ? "Y":"";
    objForm.individual.value      = appendForm.individual.checked ? "1":"";
    objForm.M_PRIORITY.value      = appendForm.M_PRIORITY.checked ? "1":"";
    objForm.unicode.value         = "1";
    objForm.isReservMail.value    = appendForm.isReservMail.checked ? "Y":"";
    objForm.dateReserv_year.value = appendForm.dateReserv_year.value;
    objForm.dateReserv_month.value= appendForm.dateReserv_month.value;
    objForm.dateReserv_date.value = appendForm.dateReserv_date.value;
    objForm.dateReserv_hour.value = appendForm.dateReserv_hour.value;
    
    for(i=0; i < nMaxAttache+1 ; i++){
        if(fileForm.CatMenu_1.options[i].value == "") {
            objForm.attache_file[i].disabled = true;
        } else {
            objForm.attache_file[i].value = fileForm.CatMenu_1.options[i].value;
        }
    }
	    
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
					params: {strAddress:resultXML.records[0].data.strAddress , rcpt:resultXML.records[0].data.rcpt ,M_TITLE:resultXML.records[0].data.M_TITLE},
					scripts: true
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

function staticMessanger<%=uniqStr%>(){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write<%=uniqStr%>"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	
  if( objForm.isUseMsg.checked == false){
	  objForm.MailToName.value= objForm.M_TO.value.replaceAll("\"","");
    var val = f.MailToName.value;
    if(val.length == val.lastIndexOf(",")+1){
    	objForm.MailToName.value = val.substring(0, val.lastIndexOf(","));
    }
  }
}

function saveTempMail<%=uniqStr%>(){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write<%=uniqStr%>"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	isSaveTempMail = false;
	objForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue();
	
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
	window.open( link,"preview","status=yes,toolbar=no,scrollbars=yes,width=750,height=429");
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
	  document.getElementById('selectDate<%=uniqStr%>').style.display = "inline";
  }else{
    document.getElementById('selectDate<%=uniqStr%>').style.display = "none";
  }
}

function showTextForm<%=uniqStr%>(obj){
  if(obj.checked){
	  document.getElementById('selectText').style.display = "";
	  f.MailToName.value="수신인 이름을 입력하세요";
  }else{
	  document.getElementById('selectText').style.display = "none";
    f.MailToName.value="";
  }
}

function showCCForm<%=uniqStr%>(){
  if(divCc<%=uniqStr%>.style.display == "inline"){
	  document.getElementById('divCc<%=uniqStr%>').style.display = "none";
  }else{
	  document.getElementById('divCc<%=uniqStr%>').style.display = "inline";
  }
}

function formletter<%=uniqStr%>() {
   var link = "formletter.auth.do?method=formletter_list";
   var openwin = window.open( link ,"formLetter","status=yes,toolbar=no,scrollbars=yes,resizable=yes,width=700,height=400");
}


function setLetterPaper<%=uniqStr%>(contentValue){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write<%=uniqStr%>"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
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
  window.open(strurl,'env','status=no,toolbar=no,scrollbars=no,resizable=yes,width=490,height=185');
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
			focusObj.value = focusObj.value + obj.options[obj.selectedIndex].value;
		} else {
			focusObj.value = focusObj.value + "," + obj.options[obj.selectedIndex].value;
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

function mail_write_active<%=uniqStr%>() {
 	mainPanel.getActiveTab().body.load( {
		url: "webmail.auth.do?method=mail_write",
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
</script>

<form name="form_mail_write<%=uniqStr%>" method="post">
<input type="hidden" name="method">
<input type="hidden" name="mailSendMode" value="0">
<input type="hidden" name="M_ATTACHE">
<input type="hidden" name="m_content">
<input type="hidden" name="history" value="<%=history%>">
<input type="hidden" name="H_M_IDX" value="<%=M_IDX%>">
<input type="hidden" name="letterPaper">
<input type="hidden" name="processiong">
<input type="hidden" name="content_add">
<input type="hidden" name="tmpStr" id="tmpStr">
<input type="hidden" name="uniqStr" value="<%=uniqStr%>">
<input type="hidden" name="wiswigEditId" value="editor_m_content<%=uniqStr%>">
<input type="hidden" name="USERS_SENDBOX">
<input type="hidden" name="USERS_SIGNATURE">
<input type="hidden" name="individual">
<input type="hidden" name="M_PRIORITY">
<input type="hidden" name="unicode">
<input type="hidden" name="isReservMail">
<input type="hidden" name="dateReserv_year">
<input type="hidden" name="dateReserv_month">
<input type="hidden" name="dateReserv_date">
<input type="hidden" name="dateReserv_hour">
<%for(int i=0; i < maxattachesize+1; i++) {
    out.println("<input type=hidden name='attache_file' value=''>");
}%>
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

<div class="k_content">
<div class="k_gridA5" style="position:relative">
<p>
<a href="javascript:sendMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_send.gif" /></a>
<a href="javascript:previewMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_preview.gif" /></a>
<a href="javascript:saveTempMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_temp.gif" /></a>
<a href="javascript:mail_write_active<%=uniqStr%>();"><img src="/images/kor/btn/btnA_modeAct.gif" /></a>
<a href="javascript:mail_write_flex<%=uniqStr%>();">flex 모드사용</a>
</p>

</div>
<table class="k_mailHead">
	<tr>
		<th width="156" scope="row">보내는사람</th>
		<td><select name="M_SENDER" class="select" style="width:590px">
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
		<%  if (!ccBcc.equals("03")) { %><textarea name="M_TO" id="M_TO<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="width: 60%; height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"><%=com.nara.util.ChkValueUtil.translate(entity.M_TO).trim()%></textarea>
		<%  } else { %> <textarea name="M_TO" id="M_TO<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="width: 60%; height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"></textarea><%  } %>
		</div>
		<a href="javascript:selAddress<%=uniqStr%>('form_mail_write<%=uniqStr%>','addr')"><img src="/images/kor/btn/btnB_address.gif" /></a>
		<a href="javascript:selAddress<%=uniqStr%>('form_mail_write<%=uniqStr%>','grp')"><img src="/images/kor/btn/btnB_inuser.gif" /></a> 
		<select name='selFrequentAddr' id='sel3' onchange="javascript:setSendAddress<%=uniqStr%>(this);" style="width: 155px">
			<option>최근에 사용한 주소</option>
			<%= RecentAddressService.getRecentAddressBySelect(userEntity.USERS_IDX) %>
		</select></td>
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
		<%  if (ccBcc.equals("02") || ccBcc.equals("05")) { %><textarea name="M_CC" id="M_CC<%=uniqStr%>" TABINDEX="1" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" autocomplete="off" style="height: 17px; line-height: 12px; width: 85%; overflow: hidden; word-break: break-all; vertical-align: middle; ime-mode:inactive;" class="k_inpColor"><%= com.nara.util.ChkValueUtil.translate(entity.M_CC).trim()%></textarea>
		<%  } else { %> <textarea name="M_CC" id="M_CC<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b2<%=uniqStr%>');" autocomplete="off" style="height: 17px; line-height: 12px; width: 85%; overflow: hidden; word-break: break-all; vertical-align: middle; ime-mode:inactive;" class="k_inpColor"></textarea> <%  } %>
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
		<%  if (ccBcc.equals("05")) { %><textarea name="M_BCC" id="M_BCC<%=uniqStr%>" TABINDEX="1" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" autocomplete="off" style="height: 17px; line-height: 12px; width: 85%; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"><%= com.nara.util.ChkValueUtil.translate(entity.M_BCC).trim()%></textarea>
		<%  } else { %> <textarea name="M_BCC" id="M_BCC<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b3<%=uniqStr%>');" autocomplete="off" style="height: 17px; line-height: 12px; width: 85%; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"></textarea> <%  } %>
		<div id="ADDRESS_BOX_M_BCC" style="position: absolute"></div>
		</td>
	</tr>
	<tr>
		<th scope="row">제목</th>
		<td><input type="text" name="M_TITLE" value="<%=com.nara.util.ChkValueUtil.translate(entity.M_TITLE).replaceAll("\t", "")%>"
			style="width: 465px" class="k_inpColor" /><input type="checkbox" name='individual' value='1' id="oneBone" class="inchek2" /><label for="oneBone">한사람씩보내기</label></td>
	</tr>
</table>
<div class="k_txWrite" id="k_txWrite<%=uniqStr%>"><textarea name="htmleditor<%=uniqStr%>" id="htmleditor<%=uniqStr%>" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"></textarea>
<textarea name="temp_content<%=uniqStr%>" id="temp_content" style="display: none;"><%=m_content.trim()%></textarea></div>

<%  if (vecTitleList.size() > 0) { %>
<ul class="k_mailFb">
	<%      for (int i = 0; i < vecTitleList.size(); i++) { %>
	<li><b>전달메일:</b> <%=com.nara.jdf.jsp.HtmlUtility.translate((String)vecTitleList.elementAt(i))%></li>
	<%      } %>
</ul>


<%  } %>
<div ID=fileattache <%=uniqStr%>>
<%
    if(nlist.size() > 0) {
      for (int i = 0; i < nlist.size(); i++) {
        out.println(com.nara.util.UtilFileApp.getAttacheFileByHtmlEucKr((String)nlist.elementAt(i), "kor"));
      }
    }
	%>
</div>
</form>

<form name="fileForm<%=uniqStr%>" enctype=multipart/form-data method=post target="fileattach">
<input type=hidden name=strFileName value="">
<input type=hidden name=uniqStr value="<%=uniqStr%>">
<input type=hidden name=cmd value="">
<input type=hidden name='isAttache' value='N'>
<SCRIPT LANGUAGE=JavaScript>
function AttacheList()
{
  parent.window.document.file<%=uniqStr%>.isAttache.value="";
  var objDest = eval("document.fileForm<%=uniqStr%>.CatMenu_1");
  var AttacheName = '';
  for(i=0 ; i < objDest.length-1 ; i++){
     if(objDest.options[i].value.substring(14, objDest.options[i].value.length).length != 0)
       AttacheName = AttacheName + "\n" + objDest.options[i].value;
  }
  if(AttacheName.length == 0)
      alert("Not find Attache file.");
  else
      alert(AttacheName);
}
</SCRIPT>
<div class="k_attach<%=uniqStr%>" id="k_attach<%=uniqStr%>">
<div class="k_axffBox">
<div class="k_axffBox_file">
<select name="CatMenu_1" size="8" style="width: 100%">
	<option value='' selected="selected">= = = = = = = 최대 <%=maxsize%>MB까지 가능합니다. = = = = = = = 
	<% 
      for( int i=0; i< maxattachesize ; i++){
    	  out.println("<option> </option>");
      }
      %>
	
</select></div>
<div class="k_axffBox_funt">
<p class="k_fltL">파일 : <input type=file size=25 name=CatMenu_0 value="">
<a href="javascript:onClick=insFile('CatMenu_0', 'CatMenu_1')"><img src="/images/kor/btn/btnB_add.gif" /></a>
<a href="javascript:onClick=removeFile('CatMenu_1')"><img src="/images/kor/btn/btnB_delete.gif" /></a>
</p>
<p class="k_fltR">파일 용량 : <b><input type=text name=filesize value='0' onFocus=blur(); style="width: 40px"> Byte</b></p>
</div>
</div>
</div>
</form>

<div class="k_mailFun">	
<form name="send_append<%=uniqStr%>" method=post>

<dl class="k_maFun1">
	<dt>편지기능</dt>
	<dd><input type=checkbox name=USERS_SENDBOX value='Y' <%=(USERS_SENDBOX != null && USERS_SENDBOX.equals("Y"))? "checked" : ""%>
		class="inchek" id="save" /> <label for="save"><img src="/images/kor/ico/ico_file2.gif" />보낸편지함 저장</label> &nbsp;
		<img src="/images/kor/line/blu_13px.gif" /></dd>
	
	<dd><label><input type=checkbox name=USERS_SIGNATURE value='Y' <%=(USERS_SIGNATURE != null && USERS_SIGNATURE.equals("Y"))? "checked" : ""%> class="inchek" id="att" /> <img src="/images/kor/ico/ico_sign.gif" />서명첨부</label>
	<span id='signnature<%=uniqStr%>'>
      &nbsp;<select name="SIGN_STMT" style="width:80px"><%= signStr %></select>&nbsp;
      </span>&nbsp;<img src="/images/kor/line/blu_13px.gif" />
	</dd>
	<dd><input type='checkbox' name='individual' value='1' class="inchek" id="send" /><label for="send"><img src="/images/kor/ico/ico_indiSend.gif" />받는주소 개별전송</label> &nbsp;
	<img src="/images/kor/line/blu_13px.gif" /></dd>
	<dd><input type=checkbox name=M_PRIORITY value=1 class="inchek" id="impt" /><label for="impt"><img src="/images/kor/ico/ico_star2.gif" />중요편지</label> &nbsp;
	<img src="/images/kor/line/blu_13px.gif" /></dd>
</dl>	
<dl class="k_maFun2">	
	<dd style="padding-left: 62px; _padding-left: 84px"><input type=checkbox name=isReservMail value=Y onClick="javascript:showDateForm<%=uniqStr%>(this);" class="inchek" id="appo" /><label for="appo"><img src="/images/kor/ico/ico_appo.gif" />예약발송</label>
	<span id='selectDate<%=uniqStr%>' style='display: none'>
	<script language="JavaScript">
		Ext.DomHelper.append(("selectDate<%=uniqStr%>"),printDateTimeSelect2("dateReserv"));
    </script></span>
	</dd>
</dl>
</form>
</div>
<div class="k_gridA5">
<p><a href="javascript:sendMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_send.gif" /></a>
<a href="javascript:previewMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_preview.gif" /></a>
<a href="javascript:saveTempMail<%=uniqStr%>();"><img src="/images/kor/btn/btnA_temp.gif" /></a>
</p>
</div>

<div ID="imageattache<%=uniqStr%>"></div>
<iframe name="mailsend" src="../jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
<iframe name="fileattach" src="../jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
<% 
if ( nlist != null ) {
  java.util.Enumeration enumer = nlist.elements();
  if(enumer.hasMoreElements() == true){
    String strFileName = null;
    while(enumer.hasMoreElements()) {
      strFileName = enumer.nextElement().toString();
      out.println("<script language=javascript>");
      out.println("setFileName('"+strFileName+"')");
      out.println("</script>");
    }
  }
}
java.util.Calendar cal = java.util.Calendar.getInstance(); 
%>

<script LANGUAGE="JavaScript">
function getUniqStr<%=uniqStr%>(){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write<%=uniqStr%>"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	return objForm.uniqStr.value;
}
var uniqStr = getUniqStr<%=uniqStr%>();

<%  if (attache_image != null && attache_image.length() > 0) { %>
eval("imageattache<%=uniqStr%>").innerHTML += "<%=attache_image%>";
<% } %>

setSelectedIndexByValue(document.send_append<%=uniqStr%>.dateReserv_year, "<%=cal.get(cal.YEAR)%>");
setSelectedIndexByValue(document.send_append<%=uniqStr%>.dateReserv_month, "<%=cal.get(cal.MONTH)+1%>");
setSelectedIndexByValue(document.send_append<%=uniqStr%>.dateReserv_date, "<%=cal.get(cal.DATE)%>");
setSelectedIndexByValue(document.send_append<%=uniqStr%>.dateReserv_hour, "<%=cal.get(cal.HOUR_OF_DAY)%>");
isSaveTempMail = true;

var imgTool=false, letterTool=true, formletterTool= true;
</script>
<script type="text/javascript" charset="utf-8" src="/js/kor/webmail/webmail_write.js?<%=uniqStr %>"></script>