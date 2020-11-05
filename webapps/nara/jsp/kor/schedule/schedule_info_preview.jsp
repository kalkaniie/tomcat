<%@ page language="java"%> 
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="scheduleEntity" scope="request" class="com.nara.jdf.db.entity.ScheduleEntity" />
<jsp:useBean id="scheduleConf" scope="request" class="com.nara.springframework.service.ScheduleConf" />
<jsp:useBean id="userEntity" scope="request" class="com.nara.jdf.db.entity.UserEntity" />
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_tt" width="70">일정분류</td>
		<td class="pop_form_td">[<%=scheduleConf.SCHEDULE_SHARE_TEXT[scheduleEntity.SCHEDULE_SHARE]%>]</td>
	</tr>
	<tr>
		<td class="pop_form_tt">작성자</td>
		<td class="pop_form_td"><%=scheduleEntity.USERS_NAME%>(<%=scheduleEntity.USERS_IDX%>)</td>
	</tr>
	<tr>
		<td class="pop_form_tt">일정제목</td>
		<td class="pop_form_td">[<%=scheduleConf.SCHEDULE_TYPE_TEXT[scheduleEntity.SCHEDULE_TYPE]%>]<%=scheduleEntity.SCHEDULE_TITLE%></td>
	</tr>
	<tr>
		<td class="pop_form_tt">일정기간</td>
		<td class="pop_form_td"><%=scheduleEntity.SCHEDULE_SDATE%> ~ <%=scheduleEntity.SCHEDULE_EDATE%></td>
	</tr>
	<tr>
		<td class="pop_form_tt">내용</td>
		<td class="pop_form_td" style="line-height:14px; word-break:break-all"><%=scheduleEntity.SCHEDULE_STMT%></td>
	</tr>
	<tr>
		<td class="pop_form_tt">일정반복</td>
		<td class="pop_form_td"><%=scheduleConf.SCHEDULE_REPEAT_TEXT[scheduleEntity.SCHEDULE_REPEAT]%></td>
	</tr>
	<tr>
		<td class="pop_form_tt">일정알림</td>
		<td class="pop_form_td"><%=scheduleConf.SCHEDULE_ALAM_TEXT[scheduleEntity.SCHEDULE_ALAM]%></td>
  </tr>
</table>

