<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_debug_msg" class="java.lang.String" scope="request" />
<html>
<head>
<title></title>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table>
	<tr>
		<td><%=jdf_user_msg%></td>
	</tr>
	<tr>
		<td><%=jdf_debug_msg%></td>
	</tr>
</table>
</body>
</html>