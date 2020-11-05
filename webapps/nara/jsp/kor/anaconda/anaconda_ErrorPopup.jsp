<%@ page contentType="text/html;charset=EUC-KR"%>
<!-- JSP import or useBean tags here. -->
<%
  String jdf_user_msg = request.getParameter("jdf_user_msg");
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width=100% height=100%>
	<tr>
		<td align=center valign=middle><%=jdf_user_msg%></td>
	</tr>
</table>
</body>
</html>