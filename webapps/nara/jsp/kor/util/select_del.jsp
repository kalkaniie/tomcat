<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="strFormName" class="java.lang.String" scope="request" />
<jsp:useBean id="objSelect" class="java.lang.String" scope="request" />
<jsp:useBean id="strIdx" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.Vector" scope="request" />
<html>
<head>

<SCRIPT LANGUAGE=JavaScript>
var strFormName = "f";
var objOrg  = eval("parent.window.document.<%=strFormName%>.<%=objSelect%>");

function removeOption(strIdx)
{
  removeOptionByValue( objOrg, strIdx);
}
</SCRIPT>
</head>
<body>
<SCRIPT LANGUAGE=JavaScript>
<%
if(strIdx.length() > 0){
%>
  removeOption('<%=strIdx%>');
<%
}

for (int i = 0; i < list.size(); i++) {
  int FILTER_IDX = Integer.parseInt((String) list.elementAt(i));
  if (FILTER_IDX != -1) {
%>
    removeOption('<%=FILTER_IDX%>');
<%
  }
}
%>
</SCRIPT>
</body>
</html>