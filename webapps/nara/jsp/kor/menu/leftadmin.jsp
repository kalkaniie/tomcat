<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.io.*"%>
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
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.OrganizeEntity"%>
<%@page import="com.nara.web.narasession.OrganizeSession"%>

<%
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	UserEntity userEntity = UserSession.getUserInfo(request);
	String methodPath = request.getQueryString() != null ? request.getQueryString():"";
	
	List oragnList = (ArrayList)OrganizeSession.getObject(request, "orgainzeList");
	
	int ORGANIZE_IDX = -1;
	if (oragnList != null && oragnList.size() >0) {
		try {
			OrganizeEntity organizeEntity =  (OrganizeEntity)oragnList.get(0);
			ORGANIZE_IDX = organizeEntity.ORGANIZE_IDX;
		} catch(Exception e) {}
	} else {
		if (UsersService.isAdmin(userEntity)) {
			ORGANIZE_IDX = 0;
		}
	}
%>

<div class="k_puLeftM">
<div class="k_puLeftM_in">
<h2><span>관리자기능</span></h2>
<% 
	if(
		methodPath.indexOf("join_opt") != -1 ||
		methodPath.indexOf("user_list") != -1 ||
		methodPath.indexOf("usergroup_main") != -1 ||
		methodPath.indexOf("organize_main") != -1 ||
		methodPath.indexOf("organize_detail") != -1 ||
		methodPath.indexOf("authority_main") != -1 ||
		methodPath.indexOf("userList") != -1 ||
		methodPath.indexOf("registUser") != -1 ||
		methodPath.indexOf("user_single_regist_form") != -1 ||
		methodPath.indexOf("user_multi_regist_form") != -1 ||
		methodPath.indexOf("user_multi_pause_form") != -1 ||
		methodPath.indexOf("user_multi_delete_form") != -1 ||
		methodPath.indexOf("reservation_list") != -1 ||
		methodPath.indexOf("forword_info_list") != -1 ||		
		methodPath.indexOf("agreement_opt") != -1 ||
		methodPath.indexOf("greetings_opt") != -1 ||
		methodPath.indexOf("certify_list") != -1 ||
		methodPath.indexOf("standby_user_list") != -1 ||
		methodPath.indexOf("alias_info_list") != -1 ||
		methodPath.indexOf("alias_detail_list") != -1 ||
		methodPath.indexOf("regist_sk_user_pop") != -1 ||
		methodPath.indexOf("batch_main") != -1 
	) { 
%>
<h3 style="border: none">사용자 관리</h3>
<ul class="k_puLeftM_li">
	<!-- <li><a href="user.admin.do?method=join_opt">가입 옵션</a></li> -->
	<li><a href="user.admin.do?method=user_list">사용자 관리</a></li>	
	<li><a href="usergroup.admin.do?method=batch_main">배치 관리</a></li>
	<!-- <li><a href="usergroup.admin.do?method=usergroup_main">조직도 관리</a></li> -->
<%-- 	<% if(ORGANIZE_IDX != -1 && UsersService.isValidModule(request,"intranet")) { %>
	<li><a href="organize.admin.do?method=organize_main">인트라넷 관리</a></li>
	<% } %> --%>
</ul>
<% } %>
<% 
	if(
		methodPath.indexOf("system_users_list") != -1 ||
		methodPath.indexOf("agreement_view") != -1 ||
		methodPath.indexOf("bad_mail_list") != -1 ||
		methodPath.indexOf("filter_list") != -1 ||
		methodPath.indexOf("domain_list") != -1 ||
		methodPath.indexOf("domain_detail") != -1 ||
		methodPath.indexOf("domain_regist_form") != -1 ||
		methodPath.indexOf("admin_regist_form") != -1 ||
		methodPath.indexOf("info_main") != -1 ||
		methodPath.indexOf("grantIp_list") != -1 ||
		methodPath.indexOf("linkageIp_list") != -1 
		
	) { 
%>
<h3 style="border: none">시스템 관리</h3>
<ul class="k_puLeftM_li">
	<% if(conf.getBoolean("com.nara.jdf.domain.multi")) { %>
	<li><a href="user.system.do?method=system_users_list">전체 사용자 관리</a></li>
	<li><a href="agreement.system.do?method=agreement_view">등록 약관</a></li>
	<% } %>
	<!--<li><a href="ipblocking.system.do?method=list">IP Blocking</a></li>-->
	<!--<li><a href="maillogtrace.system.do?method=main">메일로그추적</a></li>-->
	<li><a href="domain.system.do?method=domain_list">도메인 관리</a></li>
	<li><a href="serverinfo.system.do?method=info_main">서버 관리</a></li>
	<!-- <li><a href="grantip.system.do?method=grantIp_list">관리자 접근제어 관리</a></li>
	<li><a href="grantip.system.do?method=linkageIp_list">외부시스템 접근제어 관리</a></li>-->
	<li><a href="mailreport.system.do?method=bad_mail_list">불량 메일 차단</a></li>
</ul>
<% } %>
<% 
	if(
		methodPath.indexOf("mailLog_main") != -1 ||
		methodPath.indexOf("login_log_list") != -1 ||
		methodPath.indexOf("archive_list") != -1 ||
		methodPath.indexOf("mail_queue") != -1 
		
	) { 
%>
<h3 style="border: none">통계 및 로그관리</h3>
<ul class="k_puLeftM_li">
	<li><a href="maillog.system.do?method=mailLog_main">메일 송수신 현황</a></li>
	<!--<li><a href="archive.system.do?method=securemail_statistic_main">보안메일 송수신 현황</a></li>-->
	<li><a href="loginlog.system.do?method=login_log_list">로그인 로그 현황</a></li>
	<% if(conf.getBoolean("com.nara.kebimail.archive")) { %>
	<!--<li><a href="archive.system.do?method=archive_list">메일 로그 정보</a></li>-->
	<% } %>
	<li><a href="maillog.system.do?method=mail_queue">메일 큐 정보</a></li>
</ul>
<%} %>
<% 
	if(
		methodPath.indexOf("skin_base_form") != -1 ||
		methodPath.indexOf("popup_list") != -1 ||
		methodPath.indexOf("popup_regist_form") != -1 ||
		methodPath.indexOf("popup_detail") != -1 ||
		methodPath.indexOf("card_list") != -1 ||
		methodPath.indexOf("letter_main") != -1 ||
		methodPath.indexOf("bbs_list") != -1 ||
		methodPath.indexOf("bbs_regist_form") != -1 ||
		methodPath.indexOf("bbs_detail") != -1 ||
		methodPath.indexOf("bbs_group_main") != -1 ||
		methodPath.indexOf("formletter_list") != -1 ||
		methodPath.indexOf("formletter_detail") != -1 ||
		methodPath.indexOf("formletter_regist_form") != -1 ||
		methodPath.indexOf("publicgroup_main") != -1||
		methodPath.indexOf("poll_main") != -1|| 
		methodPath.indexOf("sharegroup_list") != -1||
		methodPath.indexOf("sharegrouplist_list") != -1|| 
		methodPath.indexOf("sys_03_010") != -1 ||
		methodPath.indexOf("sys_03_020") != -1 ||
		methodPath.indexOf("sys_03_060") != -1 ||
		methodPath.indexOf("sys_03_040") != -1 ||
		methodPath.indexOf("sys_03_050") != -1 ||
		methodPath.indexOf("tag_filterList") != -1 ||
		methodPath.indexOf("domain_modify_form") != -1
		
	) { 
%>
<h3 style="border: none">기타 관리</h3>
<ul class="k_puLeftM_li">
    <!-- <li><a href="config.admin.do?method=domain_modify_form">기본 환경 설정</a></li> -->
	<!-- <li><a href="skinbase.admin.do?method=skin_base_form">디자인 설정 관리</a></li> -->
	<!-- <li><a href="popup.admin.do?method=popup_list">팝업 관리</a></li> -->
	<%-- <% if(conf.getBoolean("com.nara.kebimail.cardmail")) { %>
	<li><a href="ecard.system.do?method=card_list">E-CARD 관리</a></li>
	<% } %> --%>
	<!-- <li><a href="letter.system.do?method=letter_main">편지지 관리</a></li> -->
	<li><a href="bbs.admin.do?method=bbs_list">게시판 관리</a></li>
	<li><a href="formletter.admin.do?method=formletter_list">템플릿 관리</a></li>
	<!-- <li><a href="publicgroup.admin.do?method=publicgroup_main">공용주소록 관리</a></li> -->
	<!-- <li><a href="poll.admin.do?method=poll_main">가상투표</a></li>-->
<%-- 	<% if(UsersService.isValidModule(request,"sms")) { %>
	<li><a href="sms.system.do?method=sys_03_010">SMS 관리</a></li>
	<% } %> --%>
	<li><a href="domain.system.do?method=tag_filterList">메일태그필터링</a></li>
	<!--<li><a href="admin207.html">국경일관리</a></li>-->
</ul>
<% } %>
<% 
	if(
		methodPath.indexOf("basicSetup") != -1 ||
		methodPath.indexOf("publicDisk") != -1 ||
		methodPath.indexOf("individualDisk") != -1 ||
		methodPath.indexOf("logIndividual") != -1 ||
		methodPath.indexOf("logPublic") != -1 ||
		methodPath.indexOf("logBigmail") != -1 ||
		methodPath.indexOf("logGuest") != -1 ||
		methodPath.indexOf("ipConstraint") != -1 ||
		methodPath.indexOf("statistic") != -1
		
		
	) { 
%>
	<% if(conf.getInt("com.nara.bigmail.diskManager") == 0) {%>
	<h3 style="border: none">웹하드 관리</h3>
	<ul class="k_puLeftM_li">
		<li><a href="webhard.admin.do?method=basicSetup">기본설정</a></li>
		<li><a href="webhard.admin.do?method=individualDisk">디스크 관리</a></li>
		<li><a href="webhard.admin.do?method=logIndividual">로그관리</a></li>
		<li><a href="webhard.admin.do?method=ipConstraint">접속 IP 제한</a></li>
		<li><a href="webhard.admin.do?method=statistic">통계</a></li>
	</ul>
	<% } else { %>
	<h3 style="border: none">대용량 관리</h3>
	<ul class="k_puLeftM_li">
		<li><a href="webhard.admin.do?method=basicSetup">기본설정</a></li>
	</ul>
	<% } %>
<% } %>
</div>
</div>
<script>
var reloadUrl = "";
function pagereloadurl(reloadUrl){
	if(reloadUrl != null && reloadUrl != "") {		
	 	if(reloadUrl == "user_list")
	 		link ="user.admin.do?method=user_list" ;
	 	else if(reloadUrl == "system_users_list")
	 		link ="user.system.do?method=system_users_list" ;
	 	else if(reloadUrl == "usergroup_main")
	 		link ="usergroup.admin.do?method=usergroup_main" ;			 	
	 	else if(reloadUrl == "sharegroup_list")
	 		link ="sharegroup.admin.do?method=sharegroup_list" ;		 			
		else if(reloadUrl == "publicgroup_main")
	 		link ="publicgroup.admin.do?method=publicgroup_main" ;
		else if(reloadUrl == "grantIp_list")
	 		link ="grantip.system.do?method=grantIp_list" ;		 		
	 	else if(reloadUrl == "bad_mail_list")
	 		link ="mailreport.system.do?method=bad_mail_list" ;
		else if(reloadUrl == "domain_detail")
	 		link ="domain.system.do?method=domain_detail" ;	
	 	else if(reloadUrl == "basicSetup")
		 	link = "webhard.admin.do?method=basicSetup";
	 	else 
	 		link = reloadUrl;	 			 					 			
	}
	
	window.open(link ,"_self","");
}
</script>