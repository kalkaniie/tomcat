<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.dao.NoteDomainDao"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.dao.NoteDomainDao"%>
<% UserEntity userEntity = UserSession.getUserInfo(request); %>

<div class="k_sideBox"> 
	<div class="k_sideTopBox">
	  <div class="k_sideTop">
	  <a href="javascript:goRightDivRender('webmail.auth.do?method=mail_write','편지쓰기')"><img src="/images/kor/side/menu_write.gif" /></a>
	  <a href="javascript:goRightDivRender('webmailReConfirm.auth.do?method=confirm_list','수신확인')" ><img src="/images/kor/side/menu_receive.gif" /></a>
	  <a href="javascript:goLeftAndRightDivRender('address.auth.do?method=address_list','주소록','address')"><img src="/images/kor/side/menu_addr.gif" /></a>
	  </div>
	</div>
	<div id="leftCalenderPanel" style="padding:0 0 5px 0;" align="center"></div>
	<div class="k_sideMailMu">
		<ul class="k_menuBox">
		<li>기념일<em><a href="javascript:schedule_space.schedule.regist_form('m', document.simple_schedule_regist);">추가</a></em>
		  <div id="leftMemorialPanel"></div>
		</li>
		<li>D-Day<em><a href="javascript:schedule_space.schedule.regist_form('dd', document.simple_schedule_regist);">추가</a></em>
		<div id="leftDDayPanel"></div>
		</li>
		</ul>
	<div class="k_muListBoxBott"></div>
	</div>
</div>
<script type="text/javascript" src="/js/kor/schedule/leftschedule.js"></script>