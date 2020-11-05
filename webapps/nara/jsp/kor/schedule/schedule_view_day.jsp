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
<%@page import="com.nara.util.UtilLunal"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="java.text.ParseException"%>
<%@page import="com.nara.springframework.service.ScheduleConf"%>
<jsp:useBean id="sch_gubun" scope="request" class="java.lang.String" />
<jsp:useBean id="view_type" scope="request" class="java.lang.String" />
<jsp:useBean id="nYear" scope="request" class="java.lang.String" />
<jsp:useBean id="nMonth" scope="request" class="java.lang.String" />
<jsp:useBean id="nDay" scope="request" class="java.lang.String" />
<jsp:useBean id="nWeek" scope="request" class="java.lang.String" />
<jsp:useBean id="schedule_list" scope="request" class="java.util.ArrayList" />
<%
	UserEntity userEntity = UserSession.getUserInfo(request);
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
	SimpleDateFormat dfTime = new SimpleDateFormat("HH:mm", java.util.Locale.KOREA);
	Calendar cal = Calendar.getInstance();
	String toDay = df.format(cal.getTime()); 
	cal.set(Integer.parseInt(nYear), Integer.parseInt(nMonth)-1, Integer.parseInt(nDay), 0, 0, 0);
	
	Calendar tmpCal = Calendar.getInstance();
	String curTime = dfTime.format(tmpCal.getTime());
	tmpCal = (Calendar)cal.clone();
	tmpCal.add(Calendar.DATE, -1);
	String prevDay = df.format(tmpCal.getTime());
	tmpCal.add(Calendar.DATE, 2);
	String nextDay = df.format(tmpCal.getTime());
%>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css" />
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

  <table width="97%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td colspan="2" class="btn_bgtd" style="padding-right:10px; text-align:right;">
  	  <b>일정찾기</b> |　<input name="strIndex" type="checkbox" value="SCHEDULE_TITLE" checked="checked"/>제목 <input name="strIndex" type="checkbox" value="USERS_NAME" />작성자 <input name="strIndex" type="checkbox" value="SCHEDULE_STMT" />내용 <input name="strKeyword" type="text" onkeydown="javascript:if(event.keyCode == 13) {schedule_space.schedule.scheduleSearch(document.f_schedule_view); return false};"/> <a href="javascript:schedule_space.schedule.scheduleSearch(document.f_schedule_view);"><img src="/images_std/kor/btn/btn_search03.gif" align="top" /></a>
  	</td>
  </tr>
  <tr>
    <td style="height:32px; padding-left:10px;">
      <a href="javascript:ReloadScheduleBySchGubun('TOTAL');"><img src="/images_std/kor/btn/btn_wholeSchedule.gif" align="top" /></a>
      <a href="javascript:ReloadScheduleBySchGubun('PRIVATE');"><img src="/images_std/kor/btn/btn_mySchedule.gif" align="top" /></a>
      <a href="javascript:ReloadScheduleBySchGubun('GROUP');"><img src="/images_std/kor/btn/btn_groupSchedule.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '<%=curTime%>');"><img src="/images_std/kor/btn/btn_detailSchedule.gif" align="top" /></a>
      <a href="javascript:schedule_space.schedule.schedulePrint();"><img src="/images_std/kor/btn/btn_printSchedule.gif" align="top" /></a>
      <a href="javascript:scheculeUp();"><img src="/images_std/kor/btn/btn_schePrint.GIF" align="top" /></a>
      <a href="javascript:scheduleDownload();"><img src="/images_std/kor/btn/btn_scheDownload.gif" align="top" /></a>
      <a href="javascript:scheduleDownloadForm();"><img src="/images_std/kor/btn/btn_formDownload.gif" align="top" /></a>
    </td>
    <td style="padding-right:5px; text-align:right;">
    <a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=prevDay%>');" ><img src="/images_std/kor/bullet/daily_left.gif" align="top" style="margin-top:3px;" /></a>
    <span id="span_dislay_month"><%=df.format(cal.getTime())%></span>
	<a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=nextDay%>');" ><img src="/images_std/kor/bullet/daily_right.gif" align="top" style="margin-top:3px;" /></a> 
	<a href="javascript:schedule_space.schedule.ReloadDailySchedule('<%=toDay%>');" name="btn_sch_next" value="오늘" ><img src="/images_std/kor/ico/ico_schedule.gif" align="top" style="margin-left:2px;" />오늘날짜가기</a>
    </td>    
  </tr>
  </table>

<div id="div_schedule">  
<table width="97%" border="0" cellspacing="0" cellpadding="0" class="sche">
	<tr>
		<th class="day" colspan="2"><%=nYear%>월 <%=nMonth%>일 <%=nDay%>일 <%=ScheduleService.getDayName(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), "K")%></th>
	</tr>
	<tr>
		<th class="tt" onclick="javascript:schedule_space.schedule.regist_form('d', document.simple_schedule_regist, '<%=df.format(cal.getTime()) %>');" style="cursor: hand;">오늘의 주요일정<br>[ 음 <%=UtilLunal.getLunal(Integer.parseInt(nYear), Integer.parseInt(nMonth)+1, Integer.parseInt(nDay))%> ]<br><%=ScheduleService.getHolidayStr(cal)%></th>
		<td class="today">
			<%=ScheduleService.getScheduleInCal(cal, schedule_list, ScheduleConf.SCHEDULE_IN_DAYLY)%>
	    </td>
	</tr>
	<tr>
		<th class="time_am"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '00:00', '08:00');">AM 00:00 ~ 08:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 0, 8, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '08:00', '09:00');">08:00 ~ 09:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 8, 9, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '09:00', '10:00');">09:00 ~ 10:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 9, 10, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '10:00', '11:00');">10:00 ~ 11:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 10, 11, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '11:00', '12:00');">11:00 ~ 12:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 11, 12, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time_pm"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '12:00', '13:00');">PM 12:00 ~ 13:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 12, 13, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '13:00', '14:00');">13:00 ~ 14:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 13, 14, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '14:00', '15:00');">14:00 ~ 15:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 14, 15, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '15:00', '16:00');">15:00 ~ 16:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 15, 16, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '16:00', '17:00');">16:00 ~ 17:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 16, 17, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '17:00', '18:00');">17:00 ~ 18:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 17, 18, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '18:00', '19:00');">18:00 ~ 19:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 18, 19, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '19:00', '20:00');">19:00 ~ 20:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 19, 20, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '20:00', '21:00');">20:00 ~ 21:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 20, 21, schedule_list, userEntity)%></td>
	</tr>
	<tr>
		<th class="time"><a href="javascript:schedule_space.schedule.regist_form('d', document.detail_schedule_regist, '<%=df.format(cal.getTime())%>', '21:00', '24:00');">21:00 ~ 00:00</a></th>
		<td><%=ScheduleService.getScheduleInDate(Integer.parseInt(nYear), Integer.parseInt(nMonth), Integer.parseInt(nDay), 21, 24, schedule_list, userEntity)%></td>
	</tr>
</table>
</div>
</form>
<jsp:include page="/jsp/kor/schedule/schedule_div.jsp" flush="true"></jsp:include>