<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%
//out.println(request.getParameter("aaa")); 
String aaa[] = request.getParameterValues("aaa");
//out.println(aaa.length);
String key ="";

Enumeration<?> ee = request.getParameterNames();
while(ee.hasMoreElements()){
	key = (String)ee.nextElement();
	out.println(key +":" +  request.getParameterValues(key));
}


for(Enumeration e = request.getParameterNames(); e.hasMoreElements();) {
	key = (String)e.nextElement();
	out.println(request.getParameter(key) + ":" + request.getParameterValues(key));
}
%>