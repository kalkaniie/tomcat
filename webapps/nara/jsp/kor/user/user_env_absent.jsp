<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>
<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>
<script type="text/javascript" src="/js/kor/util/language.js"></script>
<script type="text/javascript" src="/js/common/SimpleAjax.js"></script>



<script languate="javascript">
var imgTool=false, letterTool=false, formletterTool= false;
	
function registAbsent() {
	var objForm = document.env_absent;
	
	for(var i=objForm.USERS_AUTORE_LIST.length-1; i>=0; i--) {
		if(objForm.USERS_IDX.value == objForm.USERS_AUTORE_LIST.options[i].value) {
			alert("자기 자신에 대한 자동응답 대리수신 설정은 제외 합니다.");
			objForm.USERS_AUTORE_LIST.options[i] = null;	
		}
	}
	
	if(objForm.USERS_OPT_AUTORE_CHECK.checked && objForm.USERS_AUTORE_LIST.length == 0) {
		alert("대리 수신자를 설정하세요.");
		objForm.USERS_AUTORE_LIST.focus();
		return;
	}
	if( !objForm.USERS_OPT_AUTORE_CHECK.checked){
		objForm.USERS_OPT_AUTORE.value="N";
	}else{
		objForm.USERS_OPT_AUTORE.value="Y";
	}
	objForm.m_content.value =iframe_editor<%=uniqStr%>.Editor.getContent();
	
	objForm.m_content.value = objForm.m_content.value.replace(/[\r|\n]/g, '');
	if (objForm.USERS_ABSENT.checked) {			
	  if (objForm.m_content.value == "<P>&nbsp;</P>") {
		alert("부재시 알림 메시지를 설정하세요.");
		return;
	  }
	}
		
	if(confirm("부재중 설정을 저장하시겠습니까?")) {
		for(var i=0; i<objForm.USERS_AUTORE_LIST.length; i++) {
			objForm.USERS_AUTORE_LIST.options[i].selected = true
		}
			
		objForm.method.value = "env_absent_save";
		objForm.action = "userenv.auth.do"; 
		objForm.submit();	
	}
}
	
//Ext.onReady(function(){
//	Ext.QuickTips.init();
//	var userenv_editor = new Ext.ux.HTMLEditor({
//      	id : 'editor_m_content',
//      	width:726,
//      	height:175,
//      	plugins: new Ext.ux.HTMLEditorImage(),
//      	el:'userenv_htmleditor'
//	});
//  	userenv_editor.render();
//});
  
function popAutoReUserList() {
	var link = "address.auth.do?method=address_userAll_list_pop&objForm=env_absent";
	MM_openBrWindow(link,'address_pop_type1','status=yes,toolbar=no,scrollbars=yes,width=721,height=430')
}

function delAutoReUser() {
	var objForm = document.env_absent;
	var objSel = objForm.USERS_AUTORE_LIST;
	
	for( var i=0; i< objSel.length; i++) {
		if( true == objSel.options[i].selected ) {
			objSel.options[i] = null;
			i--;
		}
	}
}	  

function addAutoReUser(str) {
	if(str ==""){
		alert("주소를 입력하여 주십시요");
		return;
	}else if(!isValidEmail(str)){
      	alert('잘못된 이메일 형식입니다. 다시 확인해 주십시오.');	
		return;
	}	
	var objForm = document.env_absent;
	var oOption = document.createElement("OPTION");
	var isExist = false;
	for(var i=0; i<objForm.USERS_AUTORE_LIST.length; i++) {
		if (objForm.USERS_AUTORE_LIST.options[i].value == str) {
			isExist = true;
			break;	
		}
	}
	if (!isExist) {
		oOption.text = str;
		oOption.value = str;
		oOption.innerText = str;	
		objForm.USERS_AUTORE_LIST.appendChild(oOption);
	}
}

function showAbsentForm(obj){
  var objForm = document.env_absent;
  if(obj.checked){
  	objForm.USERS_ABSENT.checked = true;
  }
}

function showAbsentForm2(obj){
  var objForm = document.env_absent;
  if(!obj.checked){
  	objForm.USERS_OPT_AUTORE_CHECK.checked = false;
  }
}
</script>

<form method=post name="env_absent">
<input type=hidden name='method' value=''>
<input type=hidden name='USERS_IDX' value='<%=userEntity.USERS_IDX %>'>
<input type=hidden name='USERS_OPT_AUTORE'>
<TEXTAREA id=temp_content style="display:none;"><%=userEntity.USERS_ABSENT_RESTMT%></TEXTAREA>
<input type="hidden" name="m_content">
<div class="k_puTit">
  <h2>부재중 자동응답<span>메일확인을 못하는 경우 자동으로 답장을 보내드립니다.</span></h2>
</div>
<table class="k_tb_other" style="border-bottom: none">
  <tr>
	<th>부재중 설정</th>
    <td>
	  <input type="checkbox" name="USERS_ABSENT" id="checkbox2" value="Y" onClick=showAbsentForm2(this); /> 부재중 자동응답 설정을 사용합니다.
      </td>
  </tr>
  <tr>
	<th>부재중 설정날짜</th>
	<td style="clear:both; padding:0;">	  
    <table cellpadding="0" cellspacing="0" border="0">
	    <tr>
	      <td><div id="STARTDT_DIV"></div></td>
	      <td>&nbsp;&nbsp;&nbsp;~&nbsp;</td>
	      <td><div id="ENDDT_DIV"></div></td>
	    </tr>
      </table>
	</td>
  </tr>
  <tr>
	<th>대리수신자 설정</th>
	<td style="clear:both; padding:0;">	  
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr>
        <td style="width: 260px;"><input type="checkbox" name="USERS_OPT_AUTORE_CHECK" id="checkbox2" value="Y" onClick=showAbsentForm(this); /> 대리수신자  설정을 사용합니다.</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td> <select name="USERS_AUTORE_LIST" multiple="multiple" style="width: 254px; height: 60px;" class="k_fltL" id="USERS_AUTORE_LIST">
<%
	if (userEntity.USERS_AUTORE_LIST != null && !userEntity.USERS_AUTORE_LIST.equals("")) {
		String[] tempArr =  userEntity.USERS_AUTORE_LIST.split(",");
		if (tempArr != null && tempArr.length > 0) {
			for(int i=0; i<tempArr.length; i++) {
				out.println("<OPTION VALUE='" + tempArr[i] + "'>" + tempArr[i] + "</OPTION>");
			}
		}
	}
%>        
	    </select></td>
        <td> <a href="javascript:popAutoReUserList();"><img src="/images/kor/btn/popupin_add3.gif" /></a>
	    <a href="javascript:delAutoReUser();"><img src="/images/kor/btn/popupin_delete2.gif" /></a></td>
      </tr>
      <tr>
        <td><input type="text" name="user_input" style="width: 250px; height: 15px; ime-mode:disabled" class="k_fltL"></td>
        <td><a href="javascript:addAutoReUser(document.env_absent.user_input.value)"><img src="/images/kor/btn/popupin_add4.gif" /></a></td>
      </tr>
    </table>
	 </td>
  </tr>  
</table>
<table width="100%" height="431" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td align="left" valign="top" style="height:431px;">
  <div style="border-top:1px solid #CCC;border-bottom:1px solid #CCC;"><iframe  TABINDEX="4"  src="/jsp_std/kor/editor/htmlarea.jsp?uniqStr=<%=uniqStr%>&SIGN_YN=Y" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
  </td>
</tr>
</table>
<p class="k_fltR" style="padding: 10px 5px 10px">
  <a href="javascript:registAbsent();"><img	src="/images/kor/btn/popup_confirm.gif" /></a>
</p>
</form>
<script language=javascript>
setCheckBoxByValue( document.env_absent.USERS_ABSENT, "<%=userEntity.USERS_ABSENT%>" );
setCheckBoxByValue( document.env_absent.USERS_OPT_AUTORE_CHECK, "<%=userEntity.USERS_OPT_AUTORE%>" );
</script>
<script>
var _date = new Date();
var toDate = _date.format('Y-m-d');
var sDate ="", eDate="";

if("<%=userEntity.USERS_ABSENT_SDATE%>" =="" || "<%=userEntity.USERS_ABSENT_SDATE%>" == "null"){
	sDate = toDate;
}else{
	sDate = "<%=userEntity.USERS_ABSENT_SDATE%>";
}
if("<%=userEntity.USERS_ABSENT_EDATE%>" =="" || "<%=userEntity.USERS_ABSENT_EDATE%>" =="null"){
	eDate = toDate;
}else{
	eDate = "<%=userEntity.USERS_ABSENT_EDATE%>";
}				
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "USERS_ABSENT_SDATE", "USERS_ABSENT_EDATE", sDate, eDate);
</script>
