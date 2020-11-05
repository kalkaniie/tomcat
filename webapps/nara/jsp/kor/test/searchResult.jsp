<%@ page contentType="text/html;charset=EUC-KR"%><jsp:useBean id="list"
	class="java.util.ArrayList" scope="request" />
<%	
	StringBuffer sb = new StringBuffer();		
	for(int idx=0; idx<list.size(); idx++)
	{
		String str = (String)list.get(idx);
		sb.append(str);
		if(idx != list.size() -1)
      sb.append("=||=");
	}
	out.println(com.nara.jdf.jsp.HtmlUtility.translateTag(sb.toString()));
%>