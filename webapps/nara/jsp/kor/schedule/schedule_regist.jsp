<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserGroupEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="userGroupList" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="userGroupEntity" scope="request" class="com.nara.jdf.db.entity.UserGroupEntity" />
<jsp:useBean id="_type" scope="request" class="java.lang.String" />
<jsp:useBean id="_date" scope="request" class="java.lang.String" />
<jsp:useBean id="_stime" scope="request" class="java.lang.String" />
<jsp:useBean id="_etime" scope="request" class="java.lang.String" />
<jsp:useBean id="scheduleEntity" scope="request" class="com.nara.jdf.db.entity.ScheduleEntity" />

<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
	String _title = "일정 등록";
	if (scheduleEntity.SCHEDULE_IDX != 0) {
		_title = "일정 보기/수정";
	}
	
	boolean isAdmin = UsersService.isAdmin(request);
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
<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />
<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/ExtUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/calender/calendar.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/schedule/schedule.js"></script>
<script language="javascript">
function ReloadScheduleMain() {
	window.returnValue = true;
    window.close();
}

</script>
<form name="detail_schedule_regist" method="post">
<input type="hidden" name="method" value="aj_schedule_regist">
<input type="hidden" name="SCHEDULE_IDX" value="<%=scheduleEntity.SCHEDULE_IDX%>">
<input type="hidden" name="USERS_IDX" value="<%=userEntity.USERS_IDX%>">
 
<!-- 일정 등록 -->
<div id="div_pop_sched" class="pop_sched" style="display: block;position: absolute; width: 600px; height: 370px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pop_sched">
		<tr>
			<th colspan="2"><span id="span_pop_sched_title" class="tt"><%=_title%></span><span class="btn"><img src="/images/kor/btn/x.gif" width="12" height="12" onclick="javascript:self.close();" style="cursor: hand;"/></span></th>
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
			<input type="text" name="SCHEDULE_TITLE" id="SCHEDULE_TITLE" value="<%=scheduleEntity.SCHEDULE_TITLE%>"/>
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
			  <div id="div_repead_cond" style="display:inline;">
			    <div id="div_schedule_edate" style="float:left; width:90px;"></div>
			    <div id="div_schedule_etime" style="float:left; width:75px;"></div>
			    <div id="cond1_text" style="float:left;">까지&nbsp;</div><div id="cond2_text" style="float:left;display: none;">까지 반복</div>
			  </div>
			</td>
		</tr>
		<tr>
			<td class="tt">내　　용 |</td>
			<td><textarea name="SCHEDULE_STMT" id="SCHEDULE_STMT" style="width:100%; height:70px;"><%=scheduleEntity.SCHEDULE_STMT%></textarea></td>
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
<%
		if (scheduleEntity.SCHEDULE_IDX == 0 || (scheduleEntity.SCHEDULE_IDX != 0) && (isAdmin == true || userEntity.USERS_IDX.equals(scheduleEntity.USERS_IDX))) {
%>			
			  	<span><a id="a_pop_sched_save" href="#"><img src="/images/kor/btn/btnA_save.gif" alt="저장" onclick="javascript:schedule_space.schedule.regist(document.detail_schedule_regist, 'd');" style="cursor: hand;"/></a></span>
<%
		}
		if (isAdmin == true || userEntity.USERS_IDX.equals(scheduleEntity.USERS_IDX) && scheduleEntity.SCHEDULE_IDX != 0) {
%>			  	
			  	<span><a id="a_pop_sched_del" href="#"><img src="/images/kor/btn/btnA_delete2.gif" alt="삭제" onclick="javascript:schedule_space.schedule.remove(document.detail_schedule_regist.SCHEDULE_IDX.value);" style="cursor: hand;"/></a></span>
<%
		}
%>			  	
			 	<span><img src="/images/kor/btn/btnA_close.gif" alt="닫기" onclick="javascript:self.close();" style="cursor: hand;"/></span>
			</div>
			</td>
		</tr>
	</table>
</div>
<!--일정 등록 /-->
</form>

<%
	if (scheduleEntity.SCHEDULE_IDX == 0) {
%>
<script language="javascript">
schedule_space.schedule.randDateField('<%=_type%>', '<%=_date%>', '<%=_stime%>', '<%=_etime%>');
</script>
<%

	} else {		
		String sdate = scheduleEntity.SCHEDULE_SDATE.substring(0, 10);
		String edate = scheduleEntity.SCHEDULE_EDATE.substring(0, 10);
		String stime = scheduleEntity.SCHEDULE_SDATE.substring(11, 16);
		String etime = scheduleEntity.SCHEDULE_EDATE.substring(11, 16);
%>
<script language="javascript">
var objForm = document.detail_schedule_regist;

renderPairDateField('div_schedule_sdate', 'div_schedule_edate', 'SCHEDULE_SDATE', 'SCHEDULE_EDATE', '<%=sdate%>', '<%=edate%>');
renderTimeField('div_schedule_stime', 'SCHEDULE_STIME', '<%=stime%>');
renderTimeField('div_schedule_etime', 'SCHEDULE_ETIME', '<%=etime%>');
	
setCheckedRadioByValue( 	objForm.SCHEDULE_SHARE, 	'<%=scheduleEntity.SCHEDULE_SHARE%>' ); 	//일정구분
setSelectedIndexByValue( 	objForm.SCHEDULE_TYPE, 		'<%=scheduleEntity.SCHEDULE_TYPE%>' );   	//일정종류
setCheckedRadioByValue( 	objForm.SCHEDULE_REPEAT, 	'<%=scheduleEntity.SCHEDULE_REPEAT%>' );   	//일정반복
setCheckBoxByValue( 		objForm.SCHEDULE_DAYLY, 	'<%=scheduleEntity.SCHEDULE_DAYLY%>' );	  	//종일일정
setSelectedIndexByValue( 	objForm.SCHEDULE_ALAM, 		'<%=scheduleEntity.SCHEDULE_ALAM%>' );		//일정알림
setSelectedIndexByValue( 	objForm.SHARE_GROUP_IDX, 	'<%=scheduleEntity.SHARE_GROUP_IDX%>' );	//그룹
setCheckBoxByValue( 		objForm.SCHEDULE_DDAY, 		'<%=scheduleEntity.SCHEDULE_DDAY%>' );			//D-DAY
<%	
		if (scheduleEntity.SCHEDULE_ALAM_WAY == 1) {
%>		
		objForm.SCHEDULE_ALARM_WAY_MAIL.checked = true;
<%
		} else if (scheduleEntity.SCHEDULE_ALAM_WAY == 2) {
%>		
		objForm.SCHEDULE_ALARM_WAY_MAIL.checked = false;
<%		
		} else if (scheduleEntity.SCHEDULE_ALAM_WAY == 3) {
%>		
		objForm.SCHEDULE_ALARM_WAY_MAIL.checked = true;
<%		
		}
%>

schedule_space.schedule.setRepeatCond(objForm, '<%=scheduleEntity.SCHEDULE_REPEAT%>')
</script>
<%
	}
%>