<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.nara.springframework.service.BbsAuthService"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%@page import="com.nara.jdf.servlet.HttpUtility"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.springframework.service.BbsService"%>
<%@page import="com.nara.util.UtilFileApp"%>

<%@page import="com.nara.jdf.db.entity.ScheduleEntity"%>
<%@page import="com.nara.springframework.service.ScheduleConf"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.ScheduleService"%>
<jsp:useBean id="sch_gubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="view_type" class="java.lang.String" scope="request"/>
<jsp:useBean id="nYear" class="java.lang.String" scope="request"/>
<jsp:useBean id="nMonth" class="java.lang.String" scope="request"/>
<jsp:useBean id="nDay" class="java.lang.String" scope="request"/>
<jsp:useBean id="nWeek" class="java.lang.String" scope="request"/>
<jsp:useBean id="schedule_list" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="nPage" class="java.lang.String" scope="request"/>
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request"/>
<jsp:useBean id="strIndex" scope="request" class="java.lang.Object" />
<jsp:useBean id="strKeyword" scope="request" class="java.lang.String" />
<%
String CHK_SCHEDULE_TITLE = "";
String CHK_USERS_NAME = "";
String CHK_SCHEDULE_STMT = "";
if (strIndex != null) {
	for(int i=0; i<((String[])strIndex).length; i++) {
		if (((String[])strIndex)[i].equals("SCHEDULE_TITLE")) {
			CHK_SCHEDULE_TITLE = "checked";
		} else if (((String[])strIndex)[i].equals("USERS_NAME")) {
			CHK_USERS_NAME = "checked";
		} else if (((String[])strIndex)[i].equals("SCHEDULE_STMT")) {
			CHK_SCHEDULE_STMT = "checked";
		}
	}
}
%>
<script language="javascript">
var isAdmin = "<%=UsersService.isAdmin(request)%>";

function scheduleSearchPaging(nPage) {
	var objForm = document.f_schedule_search;
	objForm.nPage.value = nPage;
	schedule_space.schedule.scheduleSearch(objForm);
}

function ReloadScheduleMain() {
 	left_schedule_space.left_schedule.leftScheduleReload();
}
</script>

<form name="f_schedule_search" method="post" action="schedule.auth.do">
<input type=hidden name='method' value='schedule_search'>
<input type="hidden" name="sch_gubun" value="<%=sch_gubun%>"/>
<input type="hidden" name="view_type" value="<%=view_type%>"/>
<input type="hidden" name="nYear" value="<%=nYear%>"/>  
<input type="hidden" name="nMonth" value="<%=nMonth%>"/> 
<input type="hidden" name="nDay" value="<%=nDay%>"/> 
<input type="hidden" name="nWeek" value="<%=nWeek%>"/>
<input type="hidden" name='nPage' value='<%=pagingInfo.nPage %>'>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td colspan="2" class="btn_bgtd" style="padding-right:10px; text-align:right;">
  	  <b>일정찾기</b> |　<input name="strIndex" type="checkbox" value="SCHEDULE_TITLE" <%=CHK_SCHEDULE_TITLE %>/>제목 <input name="strIndex" type="checkbox" value="USERS_NAME" <%=CHK_USERS_NAME %>/>작성자 <input name="strIndex" type="checkbox" value="SCHEDULE_STMT" <%=CHK_SCHEDULE_STMT %>/>내용 <input name="strKeyword" type="text" value="<%=strKeyword%>" onkeydown="javascript:if(event.keyCode == 13) {scheduleSearchPaging(1); return false;}"/> <a href="javascript:scheduleSearchPaging(1);"><img src="/images_std/kor/btn/btn_search03.gif" align="top" /></a>
  	</td>
  </tr>
</table>
		
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100" nowrap="nowrap" class="board_title" style="text-align:center;">일정구분</td>
		<td height="30" nowrap="nowrap" class="board_title" style="text-align:center;">제목</td>
		<td width="100" nowrap="nowrap" class="board_title" style="text-align:center;">작성자</td>
		<td width="150" nowrap="nowrap" class="board_title" style="text-align:center;">기간</td>
	</tr>
	<tr>
		<td colspan="4" class="board_line_tt"></td>
	</tr>
<%
	Iterator iterator = schedule_list.iterator();
	if (iterator.hasNext()) {
		ScheduleEntity entity = new ScheduleEntity();
		while(iterator.hasNext()) {
			entity = (ScheduleEntity)iterator.next();
%>	
	<tr onmouseover="this.style.backgroundColor='#f9fdf1'" onmouseout="this.style.backgroundColor='#ffffff'" style="cursor:hand">
		<td style="text-align:center; height:30px;">[<%=ScheduleConf.SCHEDULE_SHARE_TEXT[entity.SCHEDULE_SHARE] %>]</td>
		<td class="t_left10"><a href="javascript:schedule_space.schedule.scheduleView(<%=entity.SCHEDULE_IDX%>);" title="<%=ScheduleService.getToolTip(entity)%>"><%=entity.SCHEDULE_TITLE%></a></td>
		<td style="text-align:center;" nowrap="nowrap"><a href="javascript:goLeftAndRightDivRender('webmail.auth.do?method=mail_write&M_TO=<%=entity.USERS_IDX%>','편지쓰기')" class="board_id"><%=entity.USERS_NAME%>(<%=entity.USERS_IDX.substring(0,entity.USERS_IDX.indexOf("@"))%>)</a></td>
		<td class="board_txt" style="text-align:center;" nowrap="nowrap"><%=entity.SCHEDULE_SDATE.substring(0,10)%>&nbsp;~&nbsp;<%=entity.SCHEDULE_EDATE.substring(0,10)%></td>
	</tr>
	<tr>
		<td colspan="4" class="board_line_cont"></td>
	</tr>
<%
		}
	} else {
%>	
	<tr onmouseover="this.style.backgroundColor='#f9fdf1'" onmouseout="this.style.backgroundColor='#ffffff'" style="cursor:hand">
		<td style="text-align:center;" colspan="4" class="board_txt"><img src="/images_std//kor/ico/ico_listError.gif" align="absmiddle" />&nbsp;검색된 일정이 없습니다.</td>
	</tr>
	<tr>
		<td colspan="4" class="board_line_cont"></td>
	</tr>
<%
	}
%>	
	<tr>
		<td height="35" colspan="4" style="text-align:center;" valign="bottom" ><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></td>
	</tr>
	<!---------------------  페이지표시 끝 --------------------->
</table>
</form>
<jsp:include page="/jsp/kor/schedule/schedule_div.jsp" flush="true"></jsp:include>