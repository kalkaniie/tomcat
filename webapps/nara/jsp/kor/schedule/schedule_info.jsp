<%@ page language="java"%> 
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="scheduleEntity" scope="request" class="com.nara.jdf.db.entity.ScheduleEntity" />
<jsp:useBean id="scheduleConf" scope="request" class="com.nara.springframework.service.ScheduleConf" />
<jsp:useBean id="userEntity" scope="request" class="com.nara.jdf.db.entity.UserEntity" />
<table class="k_puTableB">
  <tr>
    <th width="130" scope="row">일정분류</th>
    <td>[<%=scheduleConf.SCHEDULE_SHARE_TEXT[scheduleEntity.SCHEDULE_SHARE]%>]</td>
  </tr>
  <tr>
    <th scope="row">작성자</th>
    <td><a href="#" class="k_ftColor"><%=scheduleEntity.USERS_NAME%>(<%=scheduleEntity.USERS_IDX%>)</a>
    </td>
  </tr>
  <tr>
    <th scope="row">일정제목</th>
    <td>[<%=scheduleConf.SCHEDULE_TYPE_TEXT[scheduleEntity.SCHEDULE_TYPE]%>]<%=scheduleEntity.SCHEDULE_TITLE%>
    </td>
  </tr>
  <tr>
    <th scope="row">일정기간</th>
    <td>
       <%=scheduleEntity.SCHEDULE_SDATE%> ~ <%=scheduleEntity.SCHEDULE_EDATE%>
    </td>
  </tr>
  <tr>
    <th scope="row">내용</th>
    <td style="line-height:14px; word-break:break-all"><%=scheduleEntity.SCHEDULE_STMT%></td>
  </tr>
  <tr>
    <th scope="row">일정반복</th>
    <td>
     <%=scheduleConf.SCHEDULE_REPEAT_TEXT[scheduleEntity.SCHEDULE_REPEAT]%>
    </td>
  </tr>
  <tr>
    <th scope="row">일정알림</th>
    <td>
    <%=scheduleConf.SCHEDULE_ALAM_TEXT[scheduleEntity.SCHEDULE_ALAM]%>
    </td>
  </tr>
</table>

<div class="k_puBtn">
<%
	if (userEntity.USERS_IDX.equals(scheduleEntity.USERS_IDX)) {
%>
  <a href="javascript:schedule_space.schedule_update.openScheduleUpdateWindow('<%=scheduleEntity.SCHEDULE_IDX %>');"><img src="/images/kor/btn/btnA_modify.gif"></a>
  <a href="javascript:schedule_space.schedule_detail.ScheduleDelete('<%=scheduleEntity.SCHEDULE_IDX %>');"><img src="/images/kor/btn/btnA_delete2.gif"></a>
<%
	}
%>
</div>