<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.dao.WebMailBoxDao"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.MBoxService"%>
<%@page import="com.nara.jdf.db.entity.WebMailEntity"%>
<%@page import="com.nara.springframework.service.DomainService"%>

<% UserEntity userEntity = UserSession.getUserInfo(request); %>

<div class="k_puLeftM">
<div class="k_puLeftM_in">
<h2><span>환경설정</span></h2>
<h3 style="border: none">기본기능 설정</h3>
<ul class="k_puLeftM_li">
	<li><a href="userenv.auth.do?method=my_info" >기본정보수정</a></li>
	<!-- <li><a href="userenv.auth.do?method=change_password_form" >비밀번호변경</a></li> -->
	<!-- <li><a href="userenv.auth.do?method=user_secede_form" >회원탈퇴</a></li> -->
	<!-- <li><a href="userenv.auth.do?method=env_account_form" >멀티계정관리</a></li> -->
	<li><a href="userenv.auth.do?method=env_mail_form" >리스트/편지함설정</a></li>
	<li><a href="userenv.auth.do?method=env_mailwrite_form"	>쓰기설정</a></li>
	<li><a href="autodivision.auth.do?method=env_autodivision_form"	>메일 자동분류</a></li>
	<!-- <li><a href="userenv.auth.do?method=env_absent_form" >부재중 자동응답</a></li> -->
	<!-- <li><a href="signstmt.auth.do?method=sign_list" >서명작성</a></li> -->
	<!--<li><a href="userenv.auth.do?method=env_account_change_form" >계정변경신청</a></li>-->
	<li><a href="filter.auth.do?method=env_filter_form"	>스팸메일 걸러내기</a></li>
</ul>
</div>
</div>