<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="strFormName" class="java.lang.String" scope="request" />
<jsp:useBean id="objSelect" class="java.lang.String" scope="request" />
<jsp:useBean id="strOptionFrom" class="java.lang.String" scope="request" />
<jsp:useBean id="strOptionTo" class="java.lang.String" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<SCRIPT LANGUAGE=JavaScript>
<!--
var strFormName = "f";

function init()
{
  var objOrg  = eval("parent.window.document.<%=strFormName%>.<%=objSelect%>");
  moveSelectOptionByIndex(objOrg, <%=strOptionFrom%>, <%=strOptionTo%>);
}
-->
</SCRIPT>
</head>
<body onload="javascript:init()">
</body>
</html>