<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.nara.util.UniqueStringGenerator"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<%@ page import="com.nara.jdf.db.entity.UserGroupEntity"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.nara.springframework.service.ScheduleService"%>
<%@page import="com.nara.jdf.db.entity.ScheduleEntity"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>

<%@page import="com.nara.springframework.service.ScheduleConf"%>
<jsp:useBean id="sch_gubun" scope="request" class="java.lang.String" />
<jsp:useBean id="view_type" scope="request" class="java.lang.String" />
<jsp:useBean id="nYear" scope="request" class="java.lang.String" />
<jsp:useBean id="nMonth" scope="request" class="java.lang.String" />
<jsp:useBean id="nDay" scope="request" class="java.lang.String" />
<jsp:useBean id="nWeek" scope="request" class="java.lang.String" />
<jsp:useBean id="schedule_list" scope="request" class="java.util.ArrayList" />
<%
	SimpleDateFormat df = new SimpleDateFormat("d", java.util.Locale.KOREA);
	SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
	SimpleDateFormat dfTime = new SimpleDateFormat("HH:mm", java.util.Locale.KOREA);
	SimpleDateFormat dfMonth = new SimpleDateFormat("yyyy-MM", java.util.Locale.KOREA);
	Calendar today = Calendar.getInstance();
	Calendar tmpCal = Calendar.getInstance();

	//시간, 이전달, 다음달 계산
	String curTime = dfTime.format(tmpCal.getTime());
	tmpCal.set(Calendar.YEAR, Integer.parseInt(nYear));
	tmpCal.set(Calendar.MONTH, Integer.parseInt(nMonth)-1);
	tmpCal.add(Calendar.MONTH, -1);
	String curMonth = dfMonth.format(tmpCal.getTime());
	int prev_year = tmpCal.get(Calendar.YEAR);
	int prev_month = tmpCal.get(Calendar.MONTH)+1;
	tmpCal.add(Calendar.MONTH, 2);
	int next_year = tmpCal.get(Calendar.YEAR);
	int next_month = tmpCal.get(Calendar.MONTH)+1;
%>
<script type="text/javascript" charset="utf-8" src="/js/kor/schedule/schedule.js"></script>

<script language="javascript">
var isAdmin = "<%=UsersService.isAdmin(request)%>";

function ReloadScheduleMain() {
 	var objForm = document.f_schedule_view;
	var tabObj = schedule_space.schedule.getScheduleTabObj();
	
	try {
		tabObj.load({
			url: 'schedule.auth.do', 
			scripts:true, 
			scope: this,
			params:{
				method: 'main',
				sch_gubun: objForm.sch_gubun.value,
	        	view_type: objForm.view_type.value,
	        	nYear: objForm.nYear.value,
	        	nMonth: objForm.nMonth.value,
	        	nDay: objForm.nDay.value,
	        	nWeek: objForm.nWeek.value
			}
		});
	
		left_schedule_space.left_schedule.leftScheduleReload();
	} catch(e) {}
}

function ReloadScheduleBySchGubun(_sch_gubun) {
 	var objForm = document.f_schedule_view;
 	var tabObj = schedule_space.schedule.getScheduleTabObj();
	
	try {
		tabObj.load({
			url: 'schedule.auth.do', 
			scripts:true, 
			scope: this,
			params:{
				method: 'main',
				sch_gubun: _sch_gubun,
	        	view_type: objForm.view_type.value,
	        	nYear: objForm.nYear.value,
	        	nMonth: objForm.nMonth.value,
	        	nDay: objForm.nDay.value,
	        	nWeek: objForm.nWeek.value
			}
		});
	} catch(e) {}
};

function MoveScheduleMain(_nYear, _nMonth) {
 	var objForm = document.f_schedule_view;
 	var tabObj = schedule_space.schedule.getScheduleTabObj();
	
	try {
		tabObj.load({
			url: 'schedule.auth.do', 
			scripts:true, 
			scope: this,
			params:{
				method: 'main',
				sch_gubun: objForm.sch_gubun.value,
	        	view_type: objForm.view_type.value,
	        	nYear: _nYear,
	        	nMonth: _nMonth,
	        	nDay: objForm.nDay.value,
	        	nWeek: objForm.nWeek.value
			}
		});
	} catch(e) {}
};

function showPreviewDiv(_idx) {
	var nameDiv = document.getElementById("div_over_name");
	var titleDiv = document.getElementById("div_over_title");
	var stmtDiv = document.getElementById("div_over_stmt");
	 
	if (schedule_array != null) {
		for(var i=0; i<schedule_array.length; i++) {
			if (schedule_array[i][0] == _idx) {
				nameDiv.innerHTML = schedule_array[i][1];
				titleDiv.innerHTML = schedule_array[i][2];
				if (schedule_array[i][3] != "") {
					stmtDiv.innerHTML = schedule_array[i][3];
				} else {
					stmtDiv.innerHTML = "없음";
				}
				
				setPreviewDivPosition();
				showHideDiv('div_over_sche', 'block');
				break;
			}
		}
	}
}

function setPreviewDivPosition() {
	var objDiv = document.getElementById("div_over_sche");
	objDiv.style.top = event.y;
	objDiv.style.left = event.x;
}

function showHideDiv(_div, _display) {
	var objDiv = document.getElementById(_div);
	objDiv.style.display = _display;
}

function scheduleView(_idx) {
	schedule_space.schedule.scheduleView(_idx);
}
</script>
<form name="f_schedule_view" mehtod="post">
<input type=hidden name='method' value=''>
<input type="hidden" name="sch_gubun" value="<%=sch_gubun%>"/>
<input type="hidden" name="view_type" value="<%=view_type%>"/>
<input type="hidden" name="nYear" value="<%=nYear%>"/>  
<input type="hidden" name="nMonth" value="<%=nMonth%>"/> 
<input type="hidden" name="nDay" value="<%=nDay%>"/> 
<input type="hidden" name="nWeek" value="<%=nWeek%>"/>
<input type="hidden" name="nPage" value="1"/>
<input type="hidden" name="curMonth" value="<%=curMonth %>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td style="padding-right:20px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td colspan="2" style="padding-right:10px; text-align:right; border-bottom:2px solid #A8A8A8; height:30px;">
  	  <b>일정찾기</b> |　<input name="strIndex" type="checkbox" value="SCHEDULE_TITLE" checked="checked"/>제목 <input name="strIndex" type="checkbox" value="USERS_NAME" />작성자 <input name="strIndex" type="checkbox" value="SCHEDULE_STMT" />내용 <input name="strKeyword" type="text" onkeydown="javascript:if(event.keyCode == 13) {schedule_space.schedule.scheduleSearch(document.f_schedule_view); return false};"/> <a href="javascript:schedule_space.schedule.scheduleSearch(document.f_schedule_view);"><img src="/images/kor/btn/btnB_search.gif" align="top" /></a>
  	</td>
  </tr>
  <tr>
    <td style="height:32px; padding-left:10px;">
      <a href="javascript:ReloadScheduleBySchGubun('TOTAL');"><img src="/images/kor/btn/btnA_scheduleAll.gif" align="top" /></a>
      <a href="javascript:ReloadScheduleBySchGubun('PRIVATE');"><img src="/images/kor/btn/btnA_scheduleMy.gif" align="top" /></a>
      <a href="javascript:ReloadScheduleBySchGubun('GROUP');"><img src="/images/kor/btn/btnA_scheduleGr.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df2.format(today.getTime()) %>', '<%=curTime%>');"><img src="/images/kor/btn/btnA_scheduleAdd.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.schedulePrint();"><img src="/images/kor/btn/btnA_schedulePrint.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.scheculeUpload();"><img src="/images/kor/btn/btnA_uploadSched.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.scheduleDownload(document.f_schedule_view, '<%=curMonth%>');"><img src="/images/kor/btn/btnA_downLoadSched.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.scheduleDownloadForm(document.f_schedule_view);"><img src="/images/kor/btn/btnA_downLoadForm.gif" align="top" /></a>
    </td>
    <td style="padding-right:5px; text-align:right;">
    <a href="javascript:MoveScheduleMain('<%=prev_year%>', '<%=prev_month%>');" ><img src="/images_std/kor/bullet/daily_left.gif" align="top" style="margin-top:3px;" /></a>
    <span id="span_dislay_month"><%=nMonth%></span>
	<a href="javascript:MoveScheduleMain('<%=next_year%>', '<%=next_month%>');" ><img src="/images_std/kor/bullet/daily_right.gif" align="top" style="margin-top:3px;" /></a> 
	<a href="javascript:MoveScheduleMain('<%=today.get(Calendar.YEAR)%>', '<%=today.get(Calendar.MONTH)+1%>');" name="btn_sch_next" value="오늘" ><img src="/images_std/kor/ico/ico_schedule.gif" align="top" style="margin-left:2px;" />오늘날짜가기</a>
    </td>    
  </tr>
  </table>
</form>

<!-- 달력 -->
<div id="div_schedule">
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="calend" style="background-color:#E4E4E4;">
	<tr bgcolor="#FFFFFF">
		<th colspan="7" class="calend_month"><%=nYear%>년 <%=nMonth%>월</th>
	</tr>
	<tr>
		<th class="calend_day_s">일요일</th>
		<th class="calend_day">월요일</th>
		<th class="calend_day">화요일</th>
		<th class="calend_day">수요일</th>
		<th class="calend_day">목요일</th>
		<th class="calend_day">금요일</th>
		<th class="calend_day_st">토요일</th>
	</tr>
<%
	int START_WEEK_OF_YEAR = 0;
	int END_WEEK_OF_YEAR = 0;
	int END_DAY = 0;
	boolean isToDay = false;
	
	Calendar cal = Calendar.getInstance();
	Calendar days = Calendar.getInstance();
	cal.set(Calendar.YEAR, Integer.parseInt(nYear));
	cal.set(Calendar.MONTH, Integer.parseInt(nMonth)-1);

	cal.set(Calendar.DAY_OF_MONTH , cal.getActualMinimum(Calendar.DAY_OF_MONTH));
	START_WEEK_OF_YEAR = cal.get(Calendar.WEEK_OF_YEAR);

	cal.set(Calendar.DAY_OF_MONTH , cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	END_WEEK_OF_YEAR = cal.get(Calendar.WEEK_OF_YEAR);
	if (END_WEEK_OF_YEAR == 1) {
		END_WEEK_OF_YEAR = cal.getActualMaximum(Calendar.WEEK_OF_YEAR)+1;
	}

	days.set(Calendar.YEAR, cal.get(Calendar.YEAR));	
	for(int i=START_WEEK_OF_YEAR; i<=END_WEEK_OF_YEAR; i++){
		days.set(Calendar.WEEK_OF_YEAR, i);
%>
	<tr bgcolor="#FFFFFF">
<%		
		for(int j=1; j<=7; j++){
			days.set(Calendar.DAY_OF_WEEK, j);
			isToDay = ScheduleService.isToday(today, days);
			if (cal.get(Calendar.MONTH) != days.get(Calendar.MONTH)) {
%>
		<td width="14%" class='<%=isToDay ? "calend_today" : "not"%>' style="height:70px;">
		  	<table width="99%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td nowrap="nowrap" style="border:none;"><a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=df2.format(days.getTime())%>');"><strong><%=df.format(days.getTime())%></strong></a></td>
					<td width="60%" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"></td>
					<td width="27%" nowrap="nowrap" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"><span class="holi"><%=ScheduleService.getHolidayStr(days) %></span></td>
				</tr>
			</table>
<%
			} else {
				if (j==1) {
%>
		<td width="14%" class='<%=isToDay ? "calend_today" : ""%>' style="height:70px;">
		  	<table width="99%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td nowrap="nowrap" style="border:none;"><a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=df2.format(days.getTime())%>');"><strong class="day_s"><%=df.format(days.getTime())%></strong><span class="um">(음 <%=ScheduleService.getLunarDay(days)%>)</span></a></td>
					<td width="37%" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"></td>
					<td width="27%" nowrap="nowrap" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"><span class="holi"><%=ScheduleService.getHolidayStr(days) %></span></td>
				</tr>
			</table>
<%
				} else if (j==7) {
%>
		<td width="14%" class='<%=isToDay ? "calend_today" : ""%>' style="height:70px;">
		  	<table width="99%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td nowrap="nowrap" style="border:none;"><a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=df2.format(days.getTime())%>');"><strong class="day_st"><%=df.format(days.getTime())%></strong></a></td>
					<td width="60%" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"></td>
					<td width="27%" nowrap="nowrap" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"><span class="holi"><%=ScheduleService.getHolidayStr(days) %></span></td>
				</tr>
			</table>
<%
				} else {
%>
		<td width="14%" class='<%=isToDay ? "calend_today" : ""%>' style="height:70px;">
		  	<table width="99%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td nowrap="nowrap" style="border:none;"><a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=df2.format(days.getTime())%>');"><strong><%=df.format(days.getTime())%></strong></a></td>
					<td width="60%" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"></td>
					<td width="27%" nowrap="nowrap" onclick="javascript:schedule_space.schedule.regist_form('s', document.simple_schedule_regist, '<%=df2.format(days.getTime()) %>');" style="cursor: hand; border:none;"><span class="holi"><%=ScheduleService.getHolidayStr(days) %></span></td>
				</tr>
			</table>
<%
				}
			}
%>
		<%=ScheduleService.getScheduleInCal(days, schedule_list, ScheduleConf.SCHEDULE_IN_ALL) %>
		</td>
		
<%
		}
%>
	</tr>
<%
	}
%>
</table>
<!--달력 /-->
</div>
</td>
</tr>
</table>
<jsp:include page="/jsp/kor/schedule/schedule_div.jsp" flush="true"></jsp:include>