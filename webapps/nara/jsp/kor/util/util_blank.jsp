<%@ page contentType="text/html;charset=utf-8"%>
<%
String strBgcolor = "bgcolor=#FFFFFF";
if(request.getParameter("bgcolor")!= null)
  strBgcolor = "bgcolor="+request.getParameter("bgcolor");
%>
<html>
<head><title></title><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body <%=strBgcolor%>></body>
</html>