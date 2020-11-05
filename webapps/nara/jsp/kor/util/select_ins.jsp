<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="strIdx" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyWord" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyWord_eng" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strFormName" class="java.lang.String" scope="request" />
<jsp:useBean id="objSelect" class="java.lang.String" scope="request" />
<jsp:useBean id="objText" class="java.lang.String" scope="request" />
<jsp:useBean id="objText_E" class="java.lang.String" scope="request" />
<%
String tmp = "";
if(strKeyWord_eng!= null && !strKeyWord_eng.equals(""))
	tmp =  "[" + strKeyWord_eng +"]";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<SCRIPT LANGUAGE=JavaScript>
function init(){
  var objOrg  = eval("parent.window.document.<%=strFormName%>.<%=objSelect%>");  
  var objDes  = eval("parent.window.document.<%=strFormName%>.<%=objText%>");
  //var objDes_E  = eval("parent.window.document.<%=strFormName%>.<%=objText_E%>");  
  insertOption( objOrg, "<%=strKeyWord + tmp%>","<%=strIdx%>");
  objDes.value="";
}
</SCRIPT>
</head>
<body onload="javascript:init()">
</body>
</html>
