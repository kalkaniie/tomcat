<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.dao.SignstmtDao"%>
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />
<jsp:useBean id="stmt_idx" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_SIGNATURESTMT" class="java.lang.String" scope="request" />
<style type="text/css">
strong {font-weight: bold;}
em {font-style: italic;}
</style>

<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />편지쓰기 미리보기</td>
	</tr>
</table>
<div class="k_puLayCont" style="margin-top:-5px;">
<div class="k_puLayContIn">
<div class="k_puTxView" style="height:345px; overflow-y: auto">
<textarea id="signstmt" name="signstmt" style="display:none;"><%=USERS_SIGNATURESTMT%></textarea>
<script language=JavaScript>
  var objForm;
  //if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write"){
		objForm = opener.form_mail_write<%=uniqStr%>;
  //}
  var strContent = opener.editor.getHTML();//opener.editor_getHTML("m_content");
  strContent = strContent + document.getElementById("signstmt").value;
    
  var strContentType = "text/html";
  if(objForm.contentType != null)
    strContentType=objForm.contentType.value;
  if(strContentType == "mix"){
    strContent = strContent.replace( /\n/g, "\n<br>");
    strContent = strContent.replace( / /g, "&nbsp;");
  }else if(strContentType == "text/plain"){
    strContent = strContent.replace( /</g, "&lt");
    strContent = strContent.replace( />/g, "&gt;");
    strContent = strContent.replace( /\"/g, "&quot;");
    strContent = strContent.replace( /\'/g, "&#039;");
    strContent = strContent.replace( /\n/g, "\n<br>");
    strContent = strContent.replace( / /g, "&nbsp;");
    strContent = strContent.replace( /\t/g, "	");
  }

  if(objForm.ECARD_IDX != null && objForm.ECARD_IDX.value.length>0)
    strContent = getCardMail(objForm);

  if(objForm.letterPaper != null && objForm.letterPaper.value.length>0)
    strContent = setLetterPaper(strContent);
  document.write(strContent);

  function setLetterPaper(strContent){
    var strTempContent;
    strTempContent = "<table width=680 height=345 border=0 cellpadding=0 cellspacing=0><tr><td valign=top background='"+objForm.letterPaper.value+"'>";
    strTempContent += strContent;
    strTempContent += "</td></tr></table>";
    return strTempContent;
  }
</script>
</div>
</div>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_close.gif" onclick="javascript:window.close()" /></a></td>
	</tr>
</table>
