<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="BBS_GROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />

<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript"
	src="/js/kor/bbs/bbs_intranet_list.js?<%=uniqStr %>"></script>

<form method=post name="f_bbs_intranet_list" action=""><input
	type=hidden name='method' value='bbs_list'> <input type=hidden
	name='BBS_GROUP_IDX' value='<%=BBS_GROUP_IDX %>'>

<div class="k_gridA3"><a
	href="javascript:bbs_intranet_list_space.bbs_intranet_list.createBoard('<%=BBS_GROUP_IDX %>');"><img
	src="/images/kor/btn/btnA_create.gif" /></a> <a
	href="javascript:bbs_intranet_list_space.bbs_intranet_list.removeBoard();"><img
	src="/images/kor/btn/btnA_delete2.gif" /></a> <a
	href="javascript:bbs_intranet_list_space.bbs_intranet_list.goOrganizeHome('<%=BBS_GROUP_IDX%>');"><img
	src="/images/kor/btn/btnA_inraHome.gif" /></a></div>

<div class="k_gridB">
<p class="k_grBlink3"><a
	href="javascript:bbs_intranet_list_space.bbs_intranet_list.goOrganizeGroupMgr('<%=BBS_GROUP_IDX %>');"
	style="color: #3461e1">그룹관리 </a> <a
	href="javascript:bbs_intranet_list_space.bbs_intranet_list.goOrganizeBoardMgr('<%=BBS_GROUP_IDX %>');"
	style="color: #3461e1"><strong>게시판관리</strong></a>(읽기:<strong
	style="font-weight: bold">R</strong> 쓰기:<strong
	style="font-weight: bold">W</strong>)</p>
<p class="k_grBpage">
<% 
  int lastInfo = Integer.parseInt(nPage) * 9 > Integer.parseInt(nListNum) ? Integer.parseInt(nListNum) : Integer.parseInt(nPage) * 9;
  out.println("<b style=color:#000>"+(Integer.parseInt(nPage) * 9 -9 +1) +"-"+ Integer.toString(lastInfo)+"</b>" +" / 총 "+nListNum+"개");
  %> <span><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></span>
</p>
</div>

<table class="k_tableSt5">
	<tr>
		<th width="33" scope="col"><img
			src="/images/kor/ico/ico_checkBl.gif"
			onClick="javascript:bbs_intranet_list_space.bbs_intranet_list.checkAll();" /></th>
		<th scope="col">게시판이름</th>
		<th width="80" scope="col">형식</th>
		<th width="100" scope="col">Member권한</th>
		<th width="90" scope="col">Guest권한</th>
		<th width="90" scope="col">답변가능</th>
		<th width="90" scope="col">파일첨부</th>
		<th width="90" scope="col">간단한답글</th>
	</tr>
	<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="8" align="center">리스트가 없습니다.</td>
	</tr>
	<%
	} else {
		Map _Entty = null;
		while(iterator.hasNext()) {
			_Entty = (Map)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="BBS_IDX" id="BBS_IDX" value='<%=_Entty.get("BBS_IDX").toString() %>' /></td>
		<td class="k_txAliL"><a href="javascript:bbs_intranet_list_space.bbs_intranet_list.modifyBoard('<%=_Entty.get("BBS_IDX").toString()%>');"><%=_Entty.get("BBS_NAME") %></a></td>
		<td class="k_txAliL"><%=BbsService.getBBSMode(Integer.parseInt(_Entty.get("BBS_MODE").toString())) %></td>
		<td><%=BbsService.getBBSAuth(Integer.parseInt(_Entty.get("BBS_AUTH_MEMBER").toString())) %></td>
		<td><%=BbsService.getBBSAuth(Integer.parseInt(_Entty.get("BBS_AUTH_GUEST").toString())) %></td>
		<td><%=_Entty.get("BBS_USE_REPLY").toString().equals("1") ? "O" : "X" %></td>
		<td><%=_Entty.get("BBS_USE_ATTACHE").toString().equals("1") ? "O" : "X" %></td>
		<td><%=_Entty.get("BBS_USE_APPEND").toString().equals("1") ? "O" : "X" %></td>
	</tr>
	<%
		}
	}
%>
</table>
</form>