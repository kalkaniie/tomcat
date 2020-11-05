<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.ArchiveMailLogEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="fileName" class="java.lang.String" scope="request" />

<table cellspacing="1" bordercolor="#000000" border="1"> 
	<tr>
		<td align="center" colspan=9 bgcolor="#C0FFFF"><b><%=fileName%></b></td>
	</tr>
	<tr >
		<td bgcolor="#E8F5FF">사용자 이름</td>
		<td bgcolor="#E8F5FF">사용자 이메일</td>
		<td bgcolor="#E8F5FF">소속</td>
		<td bgcolor="#E8F5FF">직책</td>
		<td bgcolor="#E8F5FF">직위</td>
		<td bgcolor="#E8F5FF">일반수신</td>
		<td bgcolor="#E8F5FF">보안수신</td>
		<td bgcolor="#E8F5FF">일반송신</td>
		<td bgcolor="#E8F5FF">보안송신</td>
		</tr>
<%
		ArchiveMailLogEntity entity = new ArchiveMailLogEntity();
		
		Iterator iterator2 = list.iterator();		
		for(int j=0; j<list.size(); j++) {
			entity = (ArchiveMailLogEntity)iterator2.next();
			
%>		
	<tr>
		<td><%=entity.USERS_NAME ==null ? "" : entity.USERS_NAME %></td>
		<td><%=entity.USERS_IDX%></td>
		<td><%=entity.USERS_DEPARTMENT ==null ? "" : entity.USERS_DEPARTMENT%></td>
		<td><%=entity.USERS_JOBCODE ==null ? "" : entity.USERS_JOBCODE%></td>
		<td><%=entity.USERS_COMPNAME ==null ? "" : entity.USERS_COMPNAME%></td>
		<td><%=entity.RECV_NOMAL%></td>
		<td><%=entity.RECV_SECURITY%></td>
		<td><%=entity.SEND_NOMAL%></td>
		<td><%=entity.SEND_SECURITY%></td>
	</tr>
<% } %>	
</table>