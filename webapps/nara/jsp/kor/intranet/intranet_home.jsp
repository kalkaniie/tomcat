<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="organizeEntity"
	class="com.nara.jdf.db.entity.OrganizeEntity" scope="request" />
<jsp:useBean id="strImgFile" class="java.lang.String" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="bbsList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="strAdminName" class="java.lang.String" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />

<script type="text/javascript">
var bbs_name_array = new Array();
var bbs_idx_array = new Array();
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	Iterator iterator = bbsList.iterator();
	Map bbsMap = null;
	while(iterator.hasNext()) {
		bbsMap = (Map)iterator.next();
%>
		bbs_name_array.push("<%=bbsMap.get("BBS_NAME")%>");
		bbs_idx_array.push("<%=bbsMap.get("BBS_IDX")%>");
<%
	}
%>
</script>
<script type="text/javascript" src="/js/kor/intranet/intranet_home.js?<%=uniqStr %>"></script>
<form name="f_intranet_home" method=post action="board.auth.do">
<input type=hidden name='method' value='download'> <input
	type="hidden" name="BBS_IDX" value=""> <input type="hidden"
	name="B_IDX" value=""> <input type="hidden" name="strFileName"
	value=""> <input type="hidden" name="nFileNum" value="">
<input type="hidden" name="uniqStr" value="<%=uniqStr %>">

<div class="k_gridA3">
<%
	if (IntranetService.isAdmin(organizeEntity,userEntity)) {
%> <a
	href="javascript:intranet_home_space.intranet_home.groupList('<%=organizeEntity.ORGANIZE_IDX%>');"><img
	src="/images/kor/btn/btnA_memberView.gif" /></a> <a
	href="javascript:intranet_home_space.intranet_home.organize_detail('<%=organizeEntity.ORGANIZE_IDX%>');"><img
	src="/images/kor/btn/btnA_boardSett.gif" /></a> <%
	}
%>
</div>

<div class="k_gridB">
<p class="k_grBlink4"><%=DOMAIN_NAME%> &gt; <%= IntranetService.getOrganizeFullName2(gList,organizeEntity)%>
</p>
<p class="k_grBpage"><%=organizeEntity.ORGANIZE_NAME%> 게시판 <strong
	style="font-weight: bold"><%= bbsList.size()%>개</strong></p>
</div>

<div class="k_boxItr">
<div class="k_boxItrTop"><img
	src="/images/kor/box/popBoxItr_cornersTopL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBoxItr_cornersTopR.gif" class="k_fltR" /></div>
<div class="k_boxItrCont2">
<div class="k_boxItrCont_in2" style="background-color:#FFF;">
<div class="k_intraBox_tit"><span style="color:#000;"><%=organizeEntity.ORGANIZE_NAME%></span>에 오신걸 환영합니다. <a href="#" class="k_hide" id="kHide"
	onclick="kIntrInfo.style.display='none';kShow.style.display='block';kHide.style.display='none'"><img
	src="/images/kor/shared/wid_false.gif" /></a> <a href="#" class="k_show"
	id="kShow"
	onclick="kIntrInfo.style.display='block';kShow.style.display='none';kHide.style.display='block'"><img
	src="/images/kor/shared/wid_true.gif" /></a></div>

<table class="k_intraBox_cont" id="kIntrInfo">
	<tr>
		<th width="190" class="k_intraBox_img">
		<%
	if (strImgFile != null && strImgFile.length() != 0) {
%> <img name="homeImg" id="homeImg"
			src="intranet.auth.do?method=prevImage&ORGANIZE_IDX=<%=organizeEntity.ORGANIZE_IDX%>" />
		<%
	} else {
%> <img src="/images/kor/img/img_photo.jpg" /> <%
	}
%>
		</th>
		<td class="k_intraBox_td">
		<table class="k_tableSt3">
			<tr>
				<th width="120" scope="row">타이틀(슬로건)</th>
				<td colspan="5"><%=com.nara.jdf.jsp.HtmlUtility.translate(organizeEntity.ORGANIZE_TITLE)%></td>
			</tr>
			<tr>
				<th scope="row">진행업무</th>
				<td><%=com.nara.jdf.jsp.HtmlUtility.translate(organizeEntity.ORGANIZE_OPERATION)%></td>
				<th width="40" scope="row">인 원</th>
				<td><%=organizeEntity.ORGANIZE_NUM%> 명</td>
				<th width="60" scope="row">관리자</th>
				<td><%=com.nara.jdf.jsp.HtmlUtility.translate(strAdminName)%></td>
			</tr>
			<tr class="k_tableTr">
				<th scope="row">소 개</th>
				<td class="k_tdSt3" colspan="5">
				<div><%=com.nara.jdf.jsp.HtmlUtility.translate(organizeEntity.ORGANIZE_STMT)%></div>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</div>
</div>
<div class="k_boxItrBtm"><img
	src="/images/kor/box/popBoxItr_cornersBotL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBoxItr_cornersBotR.gif" class="k_fltR"
	style="margin: 0 0 -1px" /></div>
</div>

<div id="div_board_main<%=uniqStr %>"></div>
</form>