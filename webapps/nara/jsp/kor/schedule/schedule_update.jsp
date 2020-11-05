<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.UserGroupEntity;"%>

<jsp:useBean id="scheduleEntity" scope="request" class="com.nara.jdf.db.entity.ScheduleEntity" />
<jsp:useBean id="userGroupEntity" scope="request" class="com.nara.jdf.db.entity.UserGroupEntity" />
<jsp:useBean id="userGroupList" scope="request" class="java.util.ArrayList" />

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

<%
	String startdt_date = scheduleEntity.SCHEDULE_SDATE.substring(0, 10);
	String enddt_date = scheduleEntity.SCHEDULE_EDATE.substring(0, 10);
	String startdt_time = scheduleEntity.SCHEDULE_SDATE.substring(11, 16);
	String enddt_time = scheduleEntity.SCHEDULE_EDATE.substring(11, 16);
%>

<style type="text/css">
.ext-ie .x-form-text{margin:0;}
</style>

<form name="f_sr" id="f_sr" method="post">
<input type="hidden" name="SCHEDULE_IDX" value="<%=scheduleEntity.SCHEDULE_IDX %>">
<table class="k_puTableB">
  <tr>
    <th width="130" scope="row">일정구분</th>
    <td>
    <label>
      <input name="SCHEDULE_SHARE" id="SCHEDULE_SHARE" type="radio" value="0" onclick="schedule_space.schedule_regist.onClickShareOpt('0');" checked="checked">
      개인
    </label>&nbsp;&nbsp;
    <% if(UsersService.isAdmin(request)){ %>
    <label>
    <input name="SCHEDULE_SHARE" id="SCHEDULE_SHARE" type="radio" value="2" onclick="schedule_space.schedule_regist.onClickShareOpt('2');">
      전체
      </label>
      <%}%>     
<%
	if (userGroupEntity != null && userGroupEntity.USER_GROUP_IDX != 0) {
%>    
    <label>
      <input name="SCHEDULE_SHARE" id="SCHEDULE_SHARE" type="radio" value="1" onclick="javascript:schedule_space.schedule_regist.onClickShareOpt('1');">
      그룹
      <select name="SHARE_GROUP_IDX" id="SHARE_GROUP_IDX">
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
    </label>
<%
	}
%>       
          <div id="dv_share_group" style="display:none; padding:5px 0 0">
            <input name="SHARE_GROUP_NAME" id="SHARE_GROUP_NAME" type="text" class="gray_box_01" size="70" readonly="readonly">
            &nbsp;
            <a href="javascript:;" onClick="openUserGroupTree();">
            <img src="/images/btn/b_search.gif" border="0" align="absmiddle">
            </a>
          </div>
    </td>
  </tr>
  <tr>
    <th scope="row">제목</th>
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
          <input name="SCHEDULE_TITLE" id="SCHEDULE_TITLE" type="text" value="<%=scheduleEntity.SCHEDULE_TITLE %>" style="width:300px">
    </td>
  </tr>
  <tr>
    <th scope="row">일정반복</th>
    <td>
      <label><input type="radio" name="SCHEDULE_REPEAT" id="SCHEDULE_REPEAT" value="0" onclick="schedule_space.schedule_regist.CheckScheduleRepeat('0');" checked="checked"/>
      반복안함</label>&nbsp;&nbsp;
      <label><input type="radio" name="SCHEDULE_REPEAT" id="SCHEDULE_REPEAT" value="1" onclick="schedule_space.schedule_regist.CheckScheduleRepeat('1');"/>
      매일반복</label>&nbsp;&nbsp;
      <label><input type="radio" name="SCHEDULE_REPEAT" id="SCHEDULE_REPEAT" value="2" onclick="schedule_space.schedule_regist.CheckScheduleRepeat('1');"/>
      매주반복</label>&nbsp;&nbsp;
      <label><input type="radio" name="SCHEDULE_REPEAT" id="SCHEDULE_REPEAT" value="3" onclick="schedule_space.schedule_regist.CheckScheduleRepeat('1');"/>
      매월반복</label>&nbsp;&nbsp;
      <label><input type="radio" name="SCHEDULE_REPEAT" id="SCHEDULE_REPEAT" value="4" onclick="schedule_space.schedule_regist.CheckScheduleRepeat('1');"/>
      매년반복</label>
    </td>
  </tr>
  <tr>
    <th scope="row">일정시작</th>
    <td>
       <div id="div_sch_norepeat" style="display:<%if(scheduleEntity.SCHEDULE_REPEAT == 0) {out.println("block");} else {out.println("none");} %>;">
       	<table class="k_bodNoB2">
       		<tr>
       			<td><div id="norepeat_stdate"></div></td>
       			<td><div id="norepeat_sttime"></div></td>
       			<td>분 부터&nbsp;</td>
       			<td><label><input type="checkbox" name="SCHEDULE_DAYLY" id="SCHEDULE_DAYLY_NO" value="1"/>하루종일</label></td>
       		</tr>
       		<tr>
       			<td><div id="norepeat_eddate"></div></td>
       			<td><div id="norepeat_edtime"></div></td>
       			<td>분 까지</td>
       			<td>&nbsp;</td>
       		</tr>
       	</table>
       </div>
       <div id="div_sch_repeat" style="display:<%if(scheduleEntity.SCHEDULE_REPEAT == 0) {out.println("none");} else {out.println("block");} %>;">
       	 <table class="k_bodNoB2">
       	   <tr>
       	     <td style="width:91px"><div id="repeat_stdate"></div></td>
       	     <td><div id="repeat_sttime"></div></td>
       	     <td>&nbsp;~&nbsp;</td>
       	     <td><div id="repeat_edtime"></div></td>
       	     <td><label><input type="checkbox" name="SCHEDULE_DAYLY" id="SCHEDULE_DAYLY_RE" />하루종일</label></td>
       	   </tr>
       	   <tr>
       	     <td><div id="repeat_eddate"></div></td>
             <td colspan="4">&nbsp;일까지 반복</td>
       	   </tr>
       	 </table>   
       </div>
    </td>
  </tr>
  <tr>
    <th scope="row">내용</th>
    <td><textarea name="SCHEDULE_STMT" id="SCHEDULE_STMT" style="width:390px;height:100px; overflow:auto"><%=scheduleEntity.SCHEDULE_STMT %></textarea></td>
  </tr>
  <tr>
    <th scope="row">일정알림</th>
    <td>
      <select name="SCHEDULE_ALAM" id="SCHEDULE_ALAM">
       <option value="0">알리지않음</option>
       <option value="1">시작시간</option>
       <option value="2">1시간전</option>
       <option value="3">1일전</option>
       <option value="4">2일전</option>
       <option value="5">3일전</option>
       <option value="6">1주일전</option>
      </select>&nbsp;
      <label><input name="SCHEDULE_ALARM_WAY_MAIL" id="SCHEDULE_ALARM_WAY_MAIL" type="checkbox" value="1" >
      편지로 알림</label>&nbsp;  
      <!--<label><input name="SCHEDULE_ALARM_WAY_SMS" id= "SCHEDULE_ALARM_WAY_SMS" type="checkbox" value="2">
      SMS 알림</label>-->
    </td>
  </tr>
  <tr>
    <th scope="row">D-day</th>
    <td>
    <label><input name="SCHEDULE_DDAY" id="SCHEDULE_DDAY" type="checkbox" value="1">
    D-Day 적용</label>
    </td>
  </tr>
</table>

<div class="k_puBtn">
  <a href="javascript:schedule_space.schedule_update.scheduleUpdate();"><img src="/images/kor/btn/btnA_save.gif" /></a>
  <a href="javascript:schedule_space.schedule_update.closeScheduleUpdateWindow();"><img src="/images/kor/btn/btnA_cancel.gif" /></a>
</div>
</form>
<script language="javascript">
schedule_space.schedule_regist.setRepeatDiv('<%=startdt_date%>','<%=enddt_date%>','<%=startdt_time%>','<%=enddt_time%>');

setCheckedRadioByValue( document.f_sr.SCHEDULE_SHARE, "<%=scheduleEntity.SCHEDULE_SHARE%>" ); 	//일정구분
setSelectedIndexByValue( document.f_sr.SCHEDULE_TYPE, "<%=scheduleEntity.SCHEDULE_TYPE%>" );   	//일정종류
setCheckedRadioByValue( document.f_sr.SCHEDULE_REPEAT, "<%=scheduleEntity.SCHEDULE_REPEAT%>" );   	//일정반복
setCheckBoxByValue( document.f_sr.SCHEDULE_DAYLY_NO, "<%=scheduleEntity.SCHEDULE_DAYLY%>" );	  	//종일일정
setCheckBoxByValue( document.f_sr.SCHEDULE_DAYLY_RE, "<%=scheduleEntity.SCHEDULE_DAYLY%>" );	  	//종일일정
setSelectedIndexByValue( document.f_sr.SCHEDULE_ALAM, "<%=scheduleEntity.SCHEDULE_ALAM%>" );		//일정알림
setSelectedIndexByValue( document.f_sr.SHARE_GROUP_IDX, "<%=scheduleEntity.SHARE_GROUP_IDX%>" );	//그룹

<%
	if (scheduleEntity.SCHEDULE_ALAM_WAY == 1) {
%>
	document.f_sr.SCHEDULE_ALARM_WAY_MAIL.checked = true;
	//document.f_sr.SCHEDULE_ALARM_WAY_SMS.checked = false;
<%
	} else if (scheduleEntity.SCHEDULE_ALAM_WAY == 2) {
%>
	document.f_sr.SCHEDULE_ALARM_WAY_MAIL.checked = false;
	//document.f_sr.SCHEDULE_ALARM_WAY_SMS.checked = true;
<%
	} else if (scheduleEntity.SCHEDULE_ALAM_WAY == 3) {
%>
	document.f_sr.SCHEDULE_ALARM_WAY_MAIL.checked = true;
//	document.f_sr.SCHEDULE_ALARM_WAY_SMS.checked = true;
<%
	}
%>
setCheckBoxByValue( document.f_sr.SCHEDULE_DDAY, "<%=scheduleEntity.SCHEDULE_DDAY%>" );			//D-DAY
</script>
