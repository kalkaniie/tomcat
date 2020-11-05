<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.MemberEntity"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="aList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="ORGANIZE_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="AUTHORITY_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="organizeEntity"
	class="com.nara.jdf.db.entity.OrganizeEntity" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />

<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript"
	src="/js/kor/intranet/intranet_grouplist.js?<%=uniqStr %>"></script>
<link href='/css/km5.css' rel='stylesheet' type='text/css'>
<form method=post name="f_intranet_grouplist" action="intranet.auth.do">
<input type=hidden name='method' value='groupList'> <input
	type=hidden name='ORGANIZE_IDX' value='<%=ORGANIZE_IDX %>'>

<div class="k_gridA3"><a href="javascript:intranet_grouplist_space.intranet_grouplist.chkMailSend();"><img src="/images/kor/btn/btnA_mailWrite.gif" style="margin-right:10px;" /></a><b class="k_bullet">그룹회원 검색</b> 
	<select id="strIndex" name="strIndex">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
	</select> <input type="text" name="strKeyword" id="strKeyword" class="k_inpColor" style="width: 80px" /> <a href="javascript:intranet_grouplist_space.intranet_grouplist.search();"><img src="/images/kor/ico/btn_find.gif" /></a></div>
<div class="k_gridB">
<p class="k_grBlink4"><%=DOMAIN_NAME%> &gt; <%= IntranetService.getOrganizeFullName2(gList,organizeEntity)%></p>
<p class="k_grBpage">총 <strong style="font-weight: bold"><%=pagingInfo.nTotLineNum %>명</strong>
<%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></p>
</div>

<table class="k_tableSt6">
	<tr>
		<th width="33" class="k_txAliC" scope="col"><img
			src="/images/kor/ico/ico_checkBl.gif"
			onclick="intranet_grouplist_space.intranet_grouplist.checkAll();" /></th>
		<th width="150" scope="col">이름</th>
		<th width="130" scope="col">아이디</th>
		<th scope="col">이메일</th>
		<th width="120" scope="col">직급</th>
	</tr>
	<%
	Iterator iterator = list.iterator();
	if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="5" style="text-align:center;">검색 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		int i=0;
		while(iterator.hasNext()) {
			Map memberMap = (Map)iterator.next();
%>


	<tr>
		<td class="k_txAliC"><input type="checkbox" name="USERS_IDX"
			id="USERS_IDX" value="<%=memberMap.get("USERS_IDX").toString() %>" />
		<input type="hidden" name="USERS_NAME" id="USERS_NAME"
			value="<%=memberMap.get("USERS_NAME").toString() %>" /></td>
		<td class="k_txAliC"><a href="#" onclick="onoff('k_nameInfo_<%=i%>')"><%=memberMap.get("USERS_NAME").toString() %></a>
		<div id="k_nameinfo_<%=i%>" class="k_miniLay"><pre>
<a
			href="javascript:intranet_grouplist_space.intranet_grouplist.showUserInfo('<%=memberMap.get("USERS_IDX").toString()%>');"
			onClick="k_nameinfo_<%=i%>.style.display='none'">상세정보보기</a>
<a
			href="javascript:intranet_grouplist_space.intranet_grouplist.mailSend('<%=memberMap.get("USERS_IDX").toString()%>', '<%=memberMap.get("USERS_NAME").toString()%>');"
			onClick="k_nameinfo_<%=i%>.style.display='none'">메일 보내기</a>
<a
			href="javascript:intranet_grouplist_space.intranet_grouplist.registAddress('<%=memberMap.get("USERS_IDX").toString()%>', '<%=memberMap.get("USERS_NAME").toString()%>');"
			onClick="k_nameinfo_<%=i%>.style.display='none'">주소록 추가</a>
</pre></div>
		</td>
		<td class="k_txAliC"><%=memberMap.get("USERS_ID").toString() %></td>
		<td><%=memberMap.get("USERS_IDX").toString() %></td>
		<td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(IntranetService.getAuthorityNameByMap(aList, Integer.parseInt(memberMap.get("AUTHORITY_IDX").toString())))%></td>
	</tr>
	<%
			i++;

		}
	}
%>
</table>
</form>