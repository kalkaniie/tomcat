<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserGroupEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="userGroupList" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="userGroupEntity" scope="request" class="com.nara.jdf.db.entity.UserGroupEntity" />
<%
UserEntity userEntity  = UserSession.getUserInfo(request);
%>
<%!
private String lpad(String str, int len, String addStr) {
    String result = str;
    int templen   = len;

    for (int i = 0; i < templen; i++){
          result = addStr + result;
    }

    return result;
}
%>

<!-- 간단한 일정 입력 -->
<%@page import="com.nara.springframework.service.UsersService"%>

<form name="simple_schedule_regist" method="post">
<input type="hidden" name="method" value="aj_schedule_regist">
<input type="hidden" name="SCHEDULE_IDX" value="0">
<input type="hidden" name="SCHEDULE_SDATE" value="">
<input type="hidden" name="SCHEDULE_EDATE" value="">
<input type="hidden" name="SCHEDULE_REPEAT" value="0">
<input type="hidden" name="SCHEDULE_DAYLY" value="">
<input type="hidden" name="SCHEDULE_ALAM" value="0">
<input type="hidden" name="SCHEDULE_ALAM_DATE" value="">
<input type="hidden" name="SCHEDULE_ALAM_WAY_MAIL" value="0">
<input type="hidden" name="SCHEDULE_ALAM_WAY_SMS" value="0">
<input type="hidden" name="SCHEDULE_DDAY" value="0">
<input type="hidden" name="SCHEDULE_STIME" value="00:00:00">
<input type="hidden" name="SCHEDULE_ETIME" value="00:00:00">

<div id="div_pop_sche" class="pop_sche" style="display: none;position: absolute; width: 400px; height: 240px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pop_sche">
		<tr>
			<th colspan="2"><span class="tt">간단한 일정 입력</span><span class="btn"><a href="javascript:showHideDiv('div_pop_sche', 'none');"><img src="/images/kor/btn/x.gif" width="12" height="12" /></a></span></th>
		</tr>
		<tr>
			<td class="tt">구분 |</td>
			<td>
			  <input name="SCHEDULE_SHARE" type="radio" value="0" checked="checked" />개인일정
<%
	if (UsersService.isAuthOfGroupSchedule(request)) {
%>			   
			  <input name="SCHEDULE_SHARE" type="radio" value="2" />전체일정
<%
	}
	
	if (userGroupEntity != null && userGroupEntity.USER_GROUP_IDX != 0) {
%>			  
			  <input name="SCHEDULE_SHARE" type="radio" value="1" />그룹일정
              <select name="SHARE_GROUP_IDX">
<%
		if (userGroupList != null && userGroupList.size() >0) {
			for(int i=userGroupList.size()-1; i>-1; i--) {
				UserGroupEntity entity = (UserGroupEntity)userGroupList.get(i);
				
				String value = Integer.toString(entity.USER_GROUP_IDX);
				String text = lpad(entity.USER_GROUP_NAME, 5*(userGroupList.size()-entity.USER_GROUP_LEVEL), "&nbsp;");
%>
	  	         <option value="<%=value %>" selected="selected"><%=text %></option>
<%
			}
		}
%>      
              </select>			  
<%
	}
%>			  
			</td>
		</tr>
		<tr>
			<td class="tt"><span id="schedule_date_title">날짜 |</span></td>
			<td><div id="div_schedule_date"></div></td>
		</tr>
		<tr>
			<td class="tt">제목 |</td>
			<td>
			<select name="SCHEDULE_TYPE" id="SCHEDULE_TYPE">
				<option value="0">개인일정</option>
		        <option value="1">기념일</option>
		        <option value="2">업무</option>
		        <option value="3">휴가</option>
		        <option value="4">행사</option>
		        <option value="5">출장</option>
		        <option value="6">공지</option>
		        <option value="7">국경일</option>
		        <option value="9">공휴일</option>
      		</select>
			<input type="text" name="SCHEDULE_TITLE" id="SCHEDULE_TITLE" />
			</td>
		</tr>
		<tr>
			<td class="tt">내용 |</td>
			<td><textarea name="SCHEDULE_STMT" id="SCHEDULE_STMT" style="width:100%; height:70px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" class="btn"><a href="javascript:schedule_space.schedule.regist(document.simple_schedule_regist, 's');"><img src="/images/kor/btn/btnA_save.gif" width="32" height="18" alt="저장" /></a>
			<a href="javascript:showHideDiv('div_pop_sche', 'none');"><img src="/images/kor/btn/btnA_close.gif" width="32" height="18" alt="닫기" /></a></td>
		</tr>
	</table>
</div>
<!--간단한 일정 입력 /-->
</form>

<form name="detail_schedule_regist" method="post">
<input type="hidden" name="method" value="aj_schedule_regist">
<input type="hidden" name="SCHEDULE_IDX" value="0">
<input type="hidden" name="USERS_IDX" value="<%=userEntity.USERS_IDX%>">
 
<!-- 일정 등록 -->
<div id="div_pop_sched" class="pop_sched" style="display: none;position: absolute; width: 600px; height: 370px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pop_sched">
		<tr>
			<th colspan="2"><span id="span_pop_sched_title" class="tt">일정 등록</span><span class="btn"><a href="javascript:showHideDiv('div_pop_sched', 'none');"><img src="/images/kor/btn/x.gif" width="12" height="12" /></a></span></th>
		</tr>
		<tr>
			<td class="tt">일정공유 |</td>
			<td>
			  <input name="SCHEDULE_SHARE" type="radio" value="" checked="checked" />개인일정
<%
	if (UsersService.isAuthOfGroupSchedule(request)) {
%>			   
			  <input name="SCHEDULE_SHARE" type="radio" value="2" />전체일정
<%
	}
	
	if (userGroupEntity != null && userGroupEntity.USER_GROUP_IDX != 0) {
%>			  
			  <input name="SCHEDULE_SHARE" type="radio" value="1" />그룹일정
              <select name="SHARE_GROUP_IDX">
<%
		if (userGroupList != null && userGroupList.size() >0) {
			for(int i=userGroupList.size()-1; i>-1; i--) {
				UserGroupEntity entity = (UserGroupEntity)userGroupList.get(i);
				
				String value = Integer.toString(entity.USER_GROUP_IDX);
				String text = lpad(entity.USER_GROUP_NAME, 5*(userGroupList.size()-entity.USER_GROUP_LEVEL), "&nbsp;");
%>
	  	         <option value="<%=value %>" selected="selected"><%=text %></option>
<%
			}
		}
%>      
              </select>			  
<%
	}
%>
			</td>
		</tr>
		<tr>
			<td class="tt">제　　목 |</td>
			<td>
			<select name="SCHEDULE_TYPE" id="SCHEDULE_TYPE">
				<option value="0">개인일정</option>
		        <option value="1">기념일</option>
		        <option value="2">업무</option>
		        <option value="3">휴가</option>
		        <option value="4">행사</option>
		        <option value="5">출장</option>
		        <option value="6">공지</option>
		        <option value="7">국경일</option>
		        <option value="9">공휴일</option>
      		</select>
			<input type="text" name="SCHEDULE_TITLE" id="SCHEDULE_TITLE" />
			</td>
		</tr>
		<tr>
			<td class="tt">일정반복 |</td>
			<td>
			  <input name="SCHEDULE_REPEAT" type="radio" value="0" onclick="javascript:schedule_space.schedule.setRepeatCond(document.div_pop_sched, '0');" checked="checked" />반복안함 
			  <input name="SCHEDULE_REPEAT" type="radio" value="1" onclick="javascript:schedule_space.schedule.setRepeatCond(document.div_pop_sched, '1');" />매일반복 
			  <input name="SCHEDULE_REPEAT" type="radio" value="2" onclick="javascript:schedule_space.schedule.setRepeatCond(document.div_pop_sched, '2');" />매주반복 
			  <input name="SCHEDULE_REPEAT" type="radio" value="3" onclick="javascript:schedule_space.schedule.setRepeatCond(document.div_pop_sched, '3');" />매월반복 
			  <input name="SCHEDULE_REPEAT" type="radio" value="4" onclick="javascript:schedule_space.schedule.setRepeatCond(document.div_pop_sched, '4');" />매년반복
			</td>
		</tr>
		<tr>
			<td class="tt">일정시작 |</td>
			<td>
			  <div id="div_schedule_sdate" style="float:left; width:90px;"></div><div id="div_schedule_stime" style="float:left; width:75px;"></div><div style="float:left;">&nbsp;부터 
			  <input name="SCHEDULE_DAYLY" type="checkbox" value="1" />하루종일</div>
			</td>
		</tr>
		<tr>
			<td class="tt">일정종료 |</td>
			<td>
			  <div id="div_repead_cond" style="display:inline;"><div id="div_schedule_edate" style="float:left; width:90px;"></div><div id="div_schedule_etime" style="float:left; width:75px;"></div><div style="float:left;">&nbsp;까지</div></div>
			</td>
		</tr>
		<tr>
			<td class="tt">내　　용 |</td>
			<td><textarea name="SCHEDULE_STMT" id="SCHEDULE_STMT" style="width:100%; height:70px;"></textarea></td>
		</tr>
		<tr>
			<td class="tt">일정알림 |</td>
			<td>
			<select name="SCHEDULE_ALAM" id="SCHEDULE_ALAM">
				<option value="0">알리지않음</option>
				<option value="1">시작시간</option>
				<option value="2">1시간전</option>
				<option value="3">1일전</option>
				<option value="4">2일전</option>
				<option value="5">3일전</option>
				<option value="6">1주일전</option>
			</select>
			<input name="SCHEDULE_ALAM_WAY_MAIL" type="checkbox" value="1" />편지로 알림 
			<input name="SCHEDULE_ALAM_WAY_SMS" type="hidden" value="0" />
			</td>
		</tr>
		<tr>
			<td class="tt">D-day　|</td>
			<td><input name="SCHEDULE_DDAY" type="checkbox" value="1" /> D-day 적용</td>
		</tr>
		<tr>
			<td colspan="2" class="btn">
			<div>
			  	<span><a id="a_pop_sched_save" href="javascript:schedule_space.schedule.regist(document.detail_schedule_regist, 'd');"><img src="/images/kor/btn/btnA_save.gif" alt="저장" /></a></span>
			  	<span><a id="a_pop_sched_del" href="javascript:schedule_space.schedule.remove(document.detail_schedule_regist.SCHEDULE_IDX.value);"><img src="/images/kor/btn/btnA_delete2.gif" alt="삭제" /></a></span>
			 	<span><a href="javascript:showHideDiv('div_pop_sched', 'none');"><img src="/images/kor/btn/btnA_close.gif" alt="닫기" /></a></span>
			</div>
			</td>
		</tr>
	</table>
</div>
<!--일정 등록 /-->
</form>

<!--알림오버 div-->
<div id="div_over_sche" class="over_sche" style="display: none;position: absolute;">
	<ul>
		<li>·작성자 : <div id="div_over_name"></div></li>
		<li>·제　목 : <div id="div_over_title"></div></li>
		<li>·내　용 : <div id="div_over_stmt"></div></li>
	</ul>
</div>