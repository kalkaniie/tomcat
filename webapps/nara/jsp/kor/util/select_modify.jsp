<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="strFormName" class="java.lang.String" scope="request" />
<jsp:useBean id="objSelect" class="java.lang.String" scope="request" />
<jsp:useBean id="strValue" class="java.lang.String" scope="request" />
<jsp:useBean id="strText" class="java.lang.String" scope="request" />
<jsp:useBean id="strText_eng" class="java.lang.String" scope="request" />
<%
String tmp = "";
if(strText_eng!= null && !strText_eng.equals(""))
	tmp =  "[" + strText_eng +"]";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<SCRIPT LANGUAGE=JavaScript>
var strFormName = "f";
function init()
{
  var objOrg  = eval("parent.window.document.<%=strFormName%>.<%=objSelect%>");
  modifySelectTextByValue(objOrg, <%=strValue%>, "<%=strText+ tmp%>");
}
</SCRIPT>
</head>
<body onload="javascript:init()">
</body>
</html>