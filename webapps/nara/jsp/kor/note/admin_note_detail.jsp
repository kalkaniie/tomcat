<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.NoteAttacheEntity"%>
<jsp:useBean id="noteEntity" scope="request"
	class="com.nara.jdf.db.entity.NoteEntity" />
<jsp:useBean id="attache_list" scope="request"
	class="java.util.ArrayList" />


<form name="f_noto_detail" method="post"><input type="hidden"
	name="method" value=""> <input type="hidden"
	name="NOTE_ATTACHE_IDX" value=""></form>
<div class="k_puLayout">
<div class="k_puLayHead">쪽지정보 보기</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<table class="k_puTableB">
	<%
	if (noteEntity.NOTE_BOX_TYPE == 1) {
%>
	<tr>
		<th width="20%" scope="row">보낸사람</th>
		<td width="80%"><%=noteEntity.NOTE_FROM%></td>
	</tr>
	<%
	} else {
%>
	<tr>
		<th scope="row">받는사람</th>
		<td><%=noteEntity.NOTE_TO%></td>
	</tr>
	<%
	}
%>
	<tr>
		<th scope="row">보낸시간</th>
		<td><%=noteEntity.NOTE_TIME%></td>
	</tr>
	<tr>
		<th scope="row">내용</th>
		<td>
		<div style="height: 100px; overflow: auto;"><%=noteEntity.NOTE_CONTENT%></div>
		</td>
	</tr>
</table>
</div>
</div>
<div class="k_puLayBott">
<%
	if (noteEntity.NOTE_BOX_TYPE == 1) {
%> <a href="javascript:self.close();"><img
	src="/images/kor/btn/btnA_confirm.gif" /></a> <%
	}else{
%> <a href="javascript:self.close();"><img
	src="/images/kor/btn/btnA_confirm.gif" /></a> <%
}
%>
</div>
</div>

