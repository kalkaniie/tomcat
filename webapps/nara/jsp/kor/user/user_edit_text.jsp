<%@page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="m_content" class="java.lang.String" scope="request" />
<jsp:useBean id="mode" class="java.lang.String" scope="request" />
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

<SCRIPT LANGUAGE=JavaScript>
var imgTool=false, letterTool=false, formletterTool= false;
function editText() {
	objForm = document.f;
	objForm.action = "/mail/userenv.auth.do";
	objForm.method.value = "editText";
	
	objForm.m_content.value =iframe_editor<%=uniqStr%>.Editor.getContent();
	
	if(objForm.m_content.value.length > 2000){
		alert("내용은 2000자 보다 작아야 합니다.");
		return;
	}
	objForm.submit();
}

function previewText() {
	var link = "/mail/userenv.auth.do?method=editTextPreview";
  	MM_openBrWindow(link,'editPreview','scrollbars=yes,width=570,height=400');
}
</SCRIPT>

<form name="f" method="post">
<input type=hidden name='method' value='editText'> 
<input type=hidden name='mode' value='<%=mode%>'> 
<input type="hidden" name="m_content">
<TEXTAREA id=temp_content style="display:none;"><%=m_content.trim()%></TEXTAREA>
<table width="100%" height="431" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td align="left" valign="top" style="height:431px;">
  <div style="border-top:1px solid #CCC;border-bottom:1px solid #CCC;"><iframe  TABINDEX="4"  src="/jsp_std/kor/editor/htmlarea.jsp?uniqStr=<%=uniqStr%>&SIGN_YN=Y" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
  </td>
</tr>
</table>
<div style="display: block; padding: 10px 5px 10px; text-align: right">
<img src="/images/kor/btn/popup_save2.gif" onClick="javascript:editText();" style="padding: 0 0 1px" /> 
<img src="/images/kor/btn/popup_cancel.gif" onclick="window.close()" style="padding: 0 0 1px" />
</div>
</form>