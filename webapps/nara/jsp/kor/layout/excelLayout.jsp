<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld" prefix="tiles"%>
<%@ page import="java.util.Date"%>
<jsp:useBean id="pageUrl" class="java.lang.String" scope="request" />
<jsp:useBean id="fileName" class="java.lang.String" scope="request" />
<% 
response.setHeader("Content-Disposition", "attachment; filename="+new String(fileName.getBytes("KSC5601"), "8859_1")+".xls");  
response.setHeader("Content-Description", "JSP Generated Data");  
response.setContentType("application/vnd.ms-excel; charset=utf-8");

/*  파일다운로드
    response.setContentType("application/x-force-download;");   
	response.setHeader("Content-Disposition", "attachment; filename=" + new String(("조직별 Summary.xls").getBytes(charset), "8859_1")  + ";");   
	response.setHeader("Content-Transfer-Encoding","binary;");
*/
%>
<HTML>

<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
<tiles:insert page="<%=pageUrl %>" flush="true" />
</body>
</html>
