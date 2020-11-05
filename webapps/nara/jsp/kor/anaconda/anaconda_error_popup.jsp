<%@ page contentType="text/html;charset=EUC-KR"%>
<!-- JSP import or useBean tags here. -->
<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_debug_msg" class="java.lang.String" scope="request" />
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name="f" action=""><input type="hidden"
	name="jdf_user_msg" value='<%=jdf_user_msg%>'> <input
	type="hidden" name="jdf_debug_msg" value='<%=jdf_debug_msg%>'>
</FORM>
<div id='jdf_user_msg'>
<%//=jdf_user_msg%>
</div>
</body>
<script language=javascript>
<!--
  var link = "anaconda.AnaAdminServ?cmd=showAnacondaMessage";
  var objPopup = showModalDialog(link ,document.f.jdf_user_msg.value, "resizable: yes; help: no; status: no; scroll: yes; ");
-->
</script>
</html>