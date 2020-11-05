<%@ page contentType="text/html;charset=EUC-KR"%>
<%
	java.util.List list = new java.util.ArrayList();
	list.add("one");
	list.add("two");
	list.add("three");
	list.add("four");
	
	java.util.List list2 = new java.util.ArrayList();
	list2.add( "five");
	list2.add( "six");
	
	list.addAll(list2);
	
	for(int idx=0; idx<list.size(); idx++)
	{
		out.println((String)list.get(idx)+"<br>");
	}
%>