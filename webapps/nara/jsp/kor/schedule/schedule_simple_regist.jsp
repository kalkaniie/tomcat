<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserGroupEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.ScheduleEntity"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="userGroupList" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="userGroupEntity" scope="request" class="com.nara.jdf.db.entity.UserGroupEntity" />
<jsp:useBean id="_type" scope="request" class="java.lang.String" />
<jsp:useBean id="_date" scope="request" class="java.lang.String" />
<jsp:useBean id="_stime" scope="request" class="java.lang.String" />
<jsp:useBean id="_etime" scope="request" class="java.lang.String" />
<jsp:useBean id="scheduleEntity" scope="request" class="com.nara.jdf.db.entity.ScheduleEntity" />

<%
	String _schedule_date_title = "날짜";
	if (_type.equals("dd")) {
		_schedule_date_title = "D-Day";
	} else if (_type.equals("m")) {
		_schedule_date_title = "기념일";
	}
	
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

<div id="div_pop_sche" class="pop_sche" style="display: block;position: absolute; width: 400px; height: 300px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pop_sche">
		<tr>
			<th colspan="2"><span class="tt">간단한 일정 입력</span><span class="btn"><img src="/images/kor/btn/x.gif" width="12" height="12" onclick="javascript:self.close();" style="cursor: hand;"/></span></th>
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
			<td class="tt"><span id="schedule_date_title"><%=_schedule_date_title%> |</span></td>
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
			<td><textarea name="SCHEDULE_STMT" id="SCHEDULE_STMT" style="width:100%; height:120px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" class="btn">
				<img src="/images/kor/btn/btnA_save.gif" width="32" height="18" alt="저장" onclick="javascript:schedule_space.schedule.regist(document.simple_schedule_regist, 's');" style="cursor: hand;"/>
				<img src="/images/kor/btn/btnA_close.gif" width="32" height="18" alt="닫기" onclick="javascript:self.close();" style="cursor: hand;"/>
			</td>
		</tr>
	</table>
</div>
<!--간단한 일정 입력 /-->
</form>

<script language="javascript">
schedule_space.schedule.randDateField('<%=_type%>', '<%=_date%>', '<%=_stime%>', '<%=_etime%>');
function init() {
	var objForm = document.simple_schedule_regist;
	
	if ("<%=_type%>" == "m") {
		setSelectedIndexByValue(objForm.SCHEDULE_TYPE, '1' );
	} else if ("<%=_type%>" == "dd") {
		objForm.SCHEDULE_DDAY.value = "1";
	}
};

init();
</script>