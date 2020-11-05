<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="url" class="java.lang.String" scope="request" />
<jsp:useBean id="frame" class="java.lang.String" scope="request" />
<%
  if(!frame.equals(""))
    frame = "."+frame;
%>
<html>
<head>
<title>renewal</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<script language=javascript>
opener.document<%=frame%>.location.replace("<%=url%>");
self.close();
</script>
</head>
<body>
</body>
</html>