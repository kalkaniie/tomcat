<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.BbsService"%>

<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity"
	scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript"
	src="/js/kor/bbs/bbs_intranet_detail.js?<%=uniqStr %>"></script>

<form method=post name="f_bbs_intranet_detail" action=""><input
	type=hidden name='method' value='bbs_update'> <input
	type="hidden" name="BBS_IDX" value="<%=bbsEntity.BBS_IDX%>"> <input
	type="hidden" name="BBS_GROUP_IDX" value="<%=bbsEntity.BBS_GROUP_IDX%>">
<input type="hidden" name="BBS_TYPE" value="<%=bbsEntity.BBS_TYPE%>">

<div class="k_gridA3"><a
	href="javascript:bbs_intranet_detail_space.bbs_intranet_detail.bbsUpdate();"><img
	src="/images/kor/btn/btnA_modify.gif" /></a> <a
	href="javascript:bbs_intranet_detail_space.bbs_intranet_detail.goOrganizeBoardMgr('<%=bbsEntity.BBS_GROUP_IDX %>');"><img
	src="/images/kor/btn/btnA_cancel.gif" /></a> <a
	href="javascript:bbs_intranet_detail_space.bbs_intranet_detail.bbsRemove();"><img
	src="/images/kor/btn/btnA_delete2.gif" /></a></div>

<div class="k_gridB3">
<p class="k_grBlink2"><a
	href="javascript:bbs_intranet_detail_space.bbs_intranet_detail.goOrganizeGroupMgr('<%=bbsEntity.BBS_GROUP_IDX %>');"
	style="color: #3461e1">그룹관리 </a> <a
	href="javascript:bbs_intranet_detail_space.bbs_intranet_detail.goOrganizeBoardMgr('<%=bbsEntity.BBS_GROUP_IDX %>');"
	style="color: #3461e1"><strong>게시판관리</strong></a>(읽기:<strong>R</strong>
쓰기:<strong>W</strong>)</p>
</div>

<table class="k_tableSt4">
	<tr>
		<th width="120" scope="row">게시판이름</th>
		<td><input type="text" name="BBS_NAME" style="width: 97%"
			value="<%=bbsEntity.BBS_NAME %>" /></td>
	</tr>
	<tr>
		<th scope="row">형식</th>
		<td><select name="BBS_MODE" id="BBS_MODE" style="width: 120px">
			<option value=0 selected>----- 형식 -----</option>
			<option value=1>공지사항</option>
			<option value=2>일반게시판</option>
			<option value=3>자료실</option>
			<option value=4>사진게시판</option>
		</select></td>
	</tr>
	<tr>
		<th scope="row">답변기능</th>
		<td><label for="BBS_USE_REPLY"><input type="checkbox"
			name="BBS_USE_REPLY" id="BBS_USE_REPLY" value='1' /> 답변기능 사용을 허가합니다.</label>
		</td>
	</tr>
	<tr>
		<th scope="row">파일첨부</th>
		<td><label for="BBS_USE_ATTACHE"><input type="checkbox"
			name="BBS_USE_ATTACHE" id="BBS_USE_ATTACHE" value='1' /> 파일첨부 사용을
		허가합니다.</label></td>
	</tr>
	<tr>
		<th scope="row">간단한 답글 가능</th>
		<td><label for="BBS_USE_APPEND"><input type="checkbox"
			name="BBS_USE_APPEND" id="BBS_USE_APPEND" value='1' /> 간단한 답글기능 사용을
		허가합니다.</label></td>
	</tr>
	<tr>
		<th scope="row">Member 권한</th>
		<td><select name="BBS_AUTH_MEMBER" id="BBS_AUTH_MEMBER"
			style="width: 120px">
			<option value=-1 selected>--- 권한설정 ---</option>
			<option value=0>권한없음</option>
			<option value=1>읽기허용</option>
			<option value=2>읽기/쓰기허용</option>
		</select></td>
	</tr>
	<tr>
		<th scope="row">Guest 권한</th>
		<td><select name="BBS_AUTH_GUEST" id="BBS_AUTH_GUEST"
			style="width: 120px">
			<option value=-1 selected>--- 권한설정 ---</option>
			<option value=0>권한없음</option>
			<option value=1>읽기허용</option>
			<option value=2>읽기/쓰기허용</option>
		</select></td>
	</tr>
</table>

</form>

<script language=javascript>
setSelectedIndexByValue( document.f_bbs_intranet_detail.BBS_MODE, "<%=bbsEntity.BBS_MODE%>" );
setSelectedIndexByValue( document.f_bbs_intranet_detail.BBS_AUTH_MEMBER, "<%=bbsEntity.BBS_AUTH_MEMBER%>" );
setSelectedIndexByValue( document.f_bbs_intranet_detail.BBS_AUTH_GUEST, "<%=bbsEntity.BBS_AUTH_GUEST%>" );
setCheckBoxByValue( document.f_bbs_intranet_detail.BBS_USE_REPLY, '<%=bbsEntity.BBS_USE_REPLY%>' );
setCheckBoxByValue( document.f_bbs_intranet_detail.BBS_USE_ATTACHE, '<%=bbsEntity.BBS_USE_ATTACHE%>' );
setCheckBoxByValue( document.f_bbs_intranet_detail.BBS_USE_APPEND, '<%=bbsEntity.BBS_USE_APPEND%>' );
setFocusToFirstTextField( document.f_bbs_intranet_detail );
</script>