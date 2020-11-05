<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="ORGANIZE_IDX" class="java.lang.String" scope="request" />
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript"
	src="/js/kor/bbs/bbs_intranet_regist.js?<%=uniqStr %>"></script>

<script language="JavaScript">
function select(){
  var link = "bbs.BBSGroupServ?cmd=select&objForm=f";
  window.open( link ,"select","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function regist(){
  var objForm = document.f;
  if(objForm.BBS_NAME.value == ""){
    alert("게시판명을 입력하십시오.");
    objForm.BBS_NAME.focus();
    return;
  }else if(objForm.BBS_MODE.value == 0){
    alert("게시판 형식을 지정하십시오.");
    return;
  }else if(objForm.BBS_AUTH_MEMBER.value == -1){
    alert("Member 권한을 지정하십시오.");
    return;
  }else if(objForm.BBS_AUTH_GUEST.value == -1){
    alert("Guest 권한을 지정하십시오.");
    return;
  }else{
    objForm.action="bbsintranet.auth.do";
    objForm.submit();
  }
}
</script>

<form method=post name="f_bbs_intranet_regist" action=""><input
	type=hidden name='method' value='aj_bbs_regist'> <input
	type="hidden" name="BBS_GROUP_IDX" value="<%=ORGANIZE_IDX %>">
<input type="hidden" name="BBS_TYPE" value="2">

<div class="k_gridA3"><a
	href="javascript:bbs_intranet_regist_space.bbs_intranet_regist.createBoard('<%=ORGANIZE_IDX %>');"><img
	src="/images/kor/btn/btnA_entry.gif" /></a> <a
	href="javascript:bbs_intranet_regist_space.bbs_intranet_regist.goOrganizeBoardMgr('<%=ORGANIZE_IDX %>');"><img
	src="/images/kor/btn/btnA_cancel.gif" /></a></div>

<div class="k_gridB3">
<p class="k_grBlink2"><a
	href="javascript:bbs_intranet_regist_space.bbs_intranet_regist.goOrganizeGroupMgr('<%=ORGANIZE_IDX %>');"
	style="color: #3461e1">그룹관리 </a> <a
	href="javascript:bbs_intranet_regist_space.bbs_intranet_regist.goOrganizeBoardMgr('<%=ORGANIZE_IDX %>');"
	style="color: #3461e1"><strong>게시판관리</strong></a>(읽기:<strong
	style="font-weight: bold">R</strong> 쓰기:<strong
	style="font-weight: bold">W</strong>)</p>
</div>

<table class="k_tableSt4">
	<tr>
		<th width="120" scope="row">게시판이름</th>
		<td><input type="text" name="BBS_NAME" style="width: 97%" /></td>
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
			<option value=-1 selected>--권한설정--</option>
			<option value=0>권한없음</option>
			<option value=1>읽기허용</option>
			<!-- 
         <option value=2>읽기/쓰기허용</option>
          -->
		</select></td>
	</tr>
</table>

</form>