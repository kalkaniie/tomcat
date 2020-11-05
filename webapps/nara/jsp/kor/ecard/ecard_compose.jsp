<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.springframework.service.RecentAddressService"%>
<%@page
	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<jsp:useBean id="ECARD_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="strReAddr" class="java.lang.String" scope="request" />
<jsp:useBean id="strUrl" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />

<%
UserEntity userEntity = UserSession.getUserInfo(request);
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
int maxsize = conf.getInt("com.nara.kebimail.maxsize");
double NormalFreeDiskSpace = (userEntity.USERS_MAX_VOLUME - userEntity.USERS_CUR_VOLUME)*1024*1024;
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript" src="/js/kor/util/ecard.js"></script>
<SCRIPT LANGUAGE=JavaScript>

var focusObj=null;
function sendMail<%=uniqStr%>(){
  objForm = document.f;
  objForm = searchFormByActiveTab("form_mail_write");
  if(objForm.M_TO.value.length <= 0){
    alert("받는사람 이메일을 입력 하십시오");
    objForm.M_TO.focus();
    return;
  }else if(objForm.CARD_TO.value.length <= 0){
    alert("받는사람 이름을 입력 하십시오");
    objForm.CARD_TO.focus();
    return;
  }else if(objForm.M_TITLE.value.length <= 0){
    alert("제목을 입력 하십시오");
    objForm.M_TITLE.focus();
    return;
   }else if(objForm.CARD_FROM.value.length <= 0){
    alert("보내는 사람 이름을 입력 하십시오");
    objForm.CARD_FROM.focus();
    return;
  }
  
  isSaveTempMail = false;
  objForm.action="webmail.auth.do";
  objForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue();
  objForm.m_content.value=getCardMail(objForm);
  
  
  var freeDisk = <%= new java.math.BigDecimal(NormalFreeDiskSpace).setScale(2,java.math.BigDecimal.ROUND_HALF_UP) %>- ( objForm.m_content.value.length*2 + 2000) ;        // 사용가능한용량
  var uploadFileSize =0;
  if(freeDisk<=0){
  	alert("메일 사용량을 초과하여 송신할 수 없습니다.\n관리자에게 문의 하여 주십시요");
  	return;
  }
  	objForm.method.value="aj_mail_send";
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
//function selAddress<%=uniqStr%>(objForm) { //v2.0
//    var link = "address.auth.do?method=address_list_pop&view_type=ecard&objForm="+objForm;
//    MM_openBrWindow( link ,"address_pop","status=yes,toolbar=no,scrollbars=no,width=921,height=459");
//}
function selAddress<%=uniqStr%>(objForm,pName) {
	var link="";
	if(pName =="addr")
    	link = "address.auth.do?method=address_list_pop&view_type=ecard&objForm="+objForm;
    else
    	link = "usergroup.auth.do?method=usergroup_list_pop&view_type=ecard&objForm="+objForm;
    MM_openBrWindow( link ,"address_pop","status=yes,toolbar=no,scrollbars=no,width=921,height=459");
}
function previewMail<%=uniqStr%>() { 
  var link = 'ecard.auth.do?method=preview_card&uniqStr=<%=uniqStr%>';
  MM_openBrWindow( link,"ecard_preview","status=yes,toolbar=no,scroll=no,width=428,height=611");
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
	
function goEcardMain<%=uniqStr%>() {
	mainPanel.getActiveTab().body.load( {
		url: "ecard.auth.do?method=card_list",
		scripts: true,
		autoDestory: true
    });
}
getHtmlEditorInit();
</SCRIPT>
<form name="form_mail_write<%=uniqStr%>" method="post">
<input type=hidden name='method' value=''>
<input type=hidden name='m_content' value=''>
<input type=hidden name='mailSendMode' value='0'>
<input type=hidden name='ECARD_IDX' value='<%=ECARD_IDX%>'>
<input type=hidden name='strUrl' value='<%=strUrl%>'>
<input type=hidden name='USERS_NAME' value='<%=USERS_NAME%>'>
<input type=hidden name='USERS_SENDBOX' value='<%=(String)session.getAttribute("USERS_SENDBOX")%>'>
<input type=hidden name="M_CC" />
<input type=hidden name="M_BCC" />
<input type=hidden name='uniqStr' value='<%=uniqStr%>'>
<input type=hidden name='wiswigEditId' value='editor_m_content<%=uniqStr%>'>
<input type="hidden" name="individual" value="1">
<input type=hidden name='letterPaper' value=''>
<div class="k_gridA3">
<a href=javascript:onClick=sendMail<%=uniqStr%>();><img src="/images/kor/btn/btnA_sendletter.gif" /></a>
<a href=javascript:onClick=previewMail<%=uniqStr%>();><img src="/images/kor/btn/btnA_preview.gif" /></a>
<a href="javascript:goEcardMain<%=uniqStr%>();"><img src="/images/kor/btn/btnA_cardMain.gif" /></a>
</div>
<table class="k_mailHead">
	<tr>
		<th width="156" scope="row">보내시는 분 이메일</th>
		<td><select name="M_SENDER" style="width: 60%">
			<%=strReAddr%>
		</select></td>
	</tr>
	<tr>
		<th scope="row">받으시는 분 이메일</th>
		<td>
		<div id="d_b1<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		<div style="float: left; margin: 1px 3px 0 0; vertical-align: middle;">
		<textarea name="M_TO" id="M_TO<%=uniqStr%>" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" style="width: 50%; height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;" class="k_inpColor"></textarea></div>
		<a href="javascript:selAddress<%=uniqStr%>('form_mail_write<%=uniqStr%>','addr')"><img src="/images/kor/btn/btnB_address.gif" /></a>
		<a href="javascript:selAddress<%=uniqStr%>('form_mail_write<%=uniqStr%>','grp')"><img src="/images/kor/btn/btnB_inuser.gif" /></a> 
		<select name='selFrequentAddr' id='sel3' onchange="javascript:setSendAddress<%=uniqStr%>(this);" style="width: 155px">
			<option>최근에 사용한 주소</option>
			<%= RecentAddressService.getRecentAddressBySelect(userEntity.USERS_IDX) %>
		</select>		
	</td>
	</tr>
</table>
<div class="k_cardWrite">
<table>
	<tr>
		<td height="276" class="k_cardFlash">
		<div id="flashView" style="width: 400px; height: 271px"></div>
		<script language="javascript">FlashLoadScript("flashView","<%=ECARD_IDX%>");</script>
		</td>
		<td class="k_cardEntry">
		<div class="k_cardPlugin">
		<p class="k_cardP1">카드가 안 보이거나 소리가 안들릴경우</p>
		<p class="k_cardP2">- 스피커를 켜고 볼륨을 높이세요.<br />
		- 최신 버전의 플래쉬 플러그인을 다운로드/설치하세요</p>
		<p class="k_cardP3" style="margin-right:20px"><a
			href='http://www.macromedia.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash&P5_Language=English'
			target=_new><img src="/images/kor/btn/btnFlash_down.gif" /></a></p>
		</div>
		<div class="k_cardInfo">
		<div class="k_cardInfoT">TO<input name="CARD_TO" type="text"
			tabindex=1></div>
		<div class="k_cardInfoTt">제목<input name="M_TITLE" type="text"
			tabindex=1></div>
		<div class="k_cardLine"></div>
		<div class="k_cardInfoF">FROM<input name="CARD_FROM" type="text"
			value='<%=(String)session.getAttribute("USERS_NAME")%>' tabindex=1></div>
		</div>
		</td>
	</tr>
</table>
</div>

<textarea name="htmleditor<%=uniqStr%>" id="htmleditor<%=uniqStr%>" style="font: 12px 굴림, Gulim, Gulim Che; width: 99%; height: 200px"></textarea>

</form>
<iframe name="mailsend" src="../jsp/kor/util/util_blank.jsp"
	frameborder="NO" border="0" marginwidth="0" marginheight="0"
	scrolling="NO" width="0" height="0"></iframe>
<script LANGUAGE="JavaScript">
var imgTool=false, letterTool=true, formletterTool= true;
function getUniqStr<%=uniqStr%>(){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write<%=uniqStr%>"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	return objForm.uniqStr.value;
}
var uniqStr = getUniqStr<%=uniqStr%>();
</script>
<script type="text/javascript" src="/js/kor/webmail/ecard_write.js"></script>