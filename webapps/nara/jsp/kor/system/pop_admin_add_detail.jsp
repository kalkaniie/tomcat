<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@page import="com.nara.jdf.db.entity.AdminLogTrackEntity"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<jsp:useBean id="entity"
	class="com.nara.jdf.db.entity.AdminLogTrackEntity" scope="request" />
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">

<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />관리자 로그 상세보기</td>
	</tr>
</table>
      <table width="100%" class="k_tb_other">
	  	<caption>기본내용</caption>
	<%
String USER_ACTION ="";
String ACTION_MENU = "";

	if(entity == null) {
%>
	<tr>
		<td colspan="2" align="center">검색된 결과가 없습니다.</td>
	</tr>
	<%
}
	else{

%>
	<tr>
		<th width="100" scope="row">로그시간</th>
		<td><%=entity.CONNECT_TIME %></td>
	</tr>
	<tr>
		<th scope="row">아이디</th>
		<td><%=entity.USERS_ID %></td>
	</tr>
	<tr>
		<th scope="row">대상아이디</th>
		<td><%=entity.TARGET_USERS_IDS %></td>
	</tr>

	<%
		if(entity.ACTION_MENU.equals("01")){
		if(entity.USER_ACTION.equals("01")){
		 USER_ACTION = "사용자 생성";   %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("02")){
		USER_ACTION = "사용자 수정";  %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("03")){
		USER_ACTION = "사용자 삭제"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("04")){
		USER_ACTION = "인증서 입력"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("05")){
		USER_ACTION = "인증서 삭제"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("06")){
		USER_ACTION = "아이디 변경"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("07")){
		USER_ACTION = "사용자 자동전달"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("08")){
		USER_ACTION = "사용자  권한 변경"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("09")){
		USER_ACTION = "사용자 비밀번호 변경"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("10")){
		USER_ACTION = "사용자 용량 변경"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("11")){
		USER_ACTION = "[전체]사용자용량변경 "; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("12")){
		USER_ACTION = "[전체]사용자자동포워드잠김"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else{ USER_ACTION = entity.USER_ACTION;%>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} }%>


	<%
		if(entity.ACTION_MENU.equals("02")){
		if(entity.USER_ACTION.equals("01")){
		 USER_ACTION = "사용자수정";   %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else{ USER_ACTION = entity.USER_ACTION;%>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} }%>

	<%
		if(entity.ACTION_MENU.equals("03")){
		if(entity.USER_ACTION.equals("01")){
		 USER_ACTION = "아카이브목록저장";   %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("02")){
		USER_ACTION = "아카이브복구";  %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("03")){
		USER_ACTION = "아카이브삭제"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else if(entity.USER_ACTION.equals("04")){
		USER_ACTION = "아카이브보기"; %>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} else{ USER_ACTION = entity.USER_ACTION;%>
	<tr>
		<th>작업</th>
		<td><%=USER_ACTION%></td>
	</tr>
	<%} }%>


	<%if(entity.ACTION_MENU.equals("01")){
		ACTION_MENU = "사용자관리";   %>
	<tr>
		<th>메뉴</th>
		<td><%=ACTION_MENU%></td>
	</tr>
	<%} else if(entity.ACTION_MENU.equals("02")){
		ACTION_MENU = "도메인관리";  %>
	<tr>
		<th>메뉴</th>
		<td><%=ACTION_MENU%></td>
	</tr>
	<%} else if(entity.ACTION_MENU.equals("03")){
		ACTION_MENU = "아카이브관리"; %>
	<tr>
		<th>메뉴</th>
		<td><%=ACTION_MENU%></td>
	</tr>
	<%} else{ ACTION_MENU = entity.ACTION_MENU;%>
	<tr>
		<th>메뉴</th>
		<td><%=ACTION_MENU%></td>
	</tr>
	<%} %>
	<%} %>
</table>

<table width="100%" class="k_tb_other">
	  	<caption>상세보기</caption>
		<tr>
			<td><div style="height: 244px; overflow: scroll;"><%=entity.USERS_CONTENT %></div></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="javascript:window.close();"><img src="/images_std/kor/pop/btn_enter.gif" /></a><a href="javascript:self.print()"><img src="/images_std/kor/pop/btn_print.gif" /></a></td>
		</tr>
</table>