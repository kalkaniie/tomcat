<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<SCRIPT LANGUAGE=JavaScript src="/js/kor/util/ecard.js"></SCRIPT>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table class="h2">
<tr>
	<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />편지쓰기 미리보기</td>
</tr>
</table>
<div class="k_puLayCont"><script language=JavaScript>
var formName = "form_mail_write<%=uniqStr%>";
//if(opener.entOrStd() =="std"){
	var objForms = opener.mainPanel.getEl().dom.getElementsByTagName('form');
//}else{
//	var objForms = opener.mainPanel.getActiveTab().getEl().dom.getElementsByTagName('form');
//}
for(var ii=0; ii<objForms.length; ii++) {
	if(objForms[ii].name.indexOf(formName) ==0){
		objForm = objForms[ii];
 		break;
	}
}

//var strContent = opener.Ext.getCmp("editor_m_content<%=uniqStr%>").getValue();
var objForm = opener.form_mail_write<%=uniqStr%>;
var strContent = opener.iframe_editor<%=uniqStr%>.Editor.getContent();
objForm.m_content.value = strContent;
if(objForm.ECARD_IDX != null && objForm.ECARD_IDX.value.length>0)
  strContent = getCardMail(objForm);

document.write(strContent);
</script></div>
<div class="k_puLayBott"><a href="javascript:onClick=self.close()"><img src="/images/kor/btn/btnA_close.gif" /></a></div>

