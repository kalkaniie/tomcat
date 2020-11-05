<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="TYPE" class="java.lang.String" scope="request" />
<html>
<head>
<title>renewal</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<script language=javascript>
if("<%=TYPE%>" !=""){
	opener.document.reloadUrl = "";
   	opener.document.reloadUrl ="<%=TYPE%>" ;
   	//alert("type=============><%=TYPE%>" );
   	if(opener.document.reloadUrl != null) {
   		if("<%=TYPE%>" == "user_list") {
   			window.opener.location.reload();
   		} else {	
   			opener.window.pagereloadurl("<%=TYPE%>");
   		}
	}
}	
	self.close();
</script>
</head>
<body>
</body>
</html>