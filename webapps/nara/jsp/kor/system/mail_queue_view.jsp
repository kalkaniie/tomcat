<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="strValue" class="java.lang.String" scope="request" />
<HTML>
<HEAD>
<META HTTP-EQUIV='refresh' CONTENT='5;URL="maillog.system.do?method=mail_queue_view'>
<BODY>
<XMP></XMP>
</BODY>
</HTML>
<%=strValue%>