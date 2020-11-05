<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.BbsService"%>

<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity"
	scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />



<script language="JavaScript">
function select(){
  var link = "bbs.BBSGroupServ?cmd=select&objForm=f";
  MM_openBrWindow(link ,"select","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function bbsRemove(){
  objForm = document.f;
  var isRemove = confirm("선택하신 게시판이 삭제됩니다.\n 삭제하시겠습니까?");    
  if(isRemove){
    objForm.method.value = "bbs_remove";
    objForm.action="bbs.admin.do";
    // objForm.submit();
    objForm.submit();
  }
}

function bbsUpdate(){
  var objForm = document.f;
  if(objForm.BBS_NAME.value == ""){
    alert("게시판명을 입력하십시오.");
    objForm.BBS_NAME.focus();
    return;
  }else if(objForm.BBS_GROUP_IDX.value == ""){
    alert("게시판 그룹 위치를 지정하십시오.");
    return;
  }else if(objForm.BBS_MODE.value == 0){
    alert("게시판 형식을 지정하십시오.");
    return;
  }else if(objForm.BBS_AUTH_MEMBER.value == -1){
    alert("Member 권한을 지정하십시오.");
    return;
  }else if(objForm.BBS_AUTH_GUEST.value == -1){
    alert("Guest그룹 권한을 지정하십시오.");
    return;
  }else{
    if(objForm.BBS_MODE.value ==4) {
      objForm.BBS_USE_ATTACHE.checked = true;
    }
    
    objForm.method.value = "bbs_update";
    objForm.action="bbs.admin.do";
    // objForm.submit();
    objForm.submit();
  }
}

function selectParent(){
  var link = "bbs.admin.do?method=bbsGroupSelect&objForm=f&adminMode=select";
  MM_openBrWindow(link ,"move","status=yes,toolbar=no,scrollbars=no,resizable=no,width=320,height=361");
}
</script>

<form method=post name="f" action=""><input type=hidden
	name='method' value='bbs_update'> <input type="hidden"
	name="BBS_IDX" value="<%=bbsEntity.BBS_IDX%>"> <input
	type="hidden" name="BBS_GROUP_IDX" value="<%=bbsEntity.BBS_GROUP_IDX%>">
<input type="hidden" name="BBS_TYPE" value="<%=bbsEntity.BBS_TYPE%>">


<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>게시판관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>게시판 생성 및 관리를 하실수 있습니다. (읽기:R 쓰기:W )</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a
		href="bbs.admin.do?method=bbs_list" >게시판관리</a></b></li>
	<li><a href="bbsgroup.admin.do?method=bbs_group_main"
		>게시판그룹관리</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">

	<tr>
		<th width="20%" scope="row">게시판이름</th>
		<td width="80%"><input type="text" name="BBS_NAME" maxlength="20" size="20" 
		class="intx00" style="width: 200px" value="<%=bbsEntity.BBS_NAME %>" /></td>
	</tr>
	<tr>
		<th scope="row">그룹위치지정</th>
		<td><input type="text" name="BBS_GROUP_NAME" class="intx00"
			style="width: 162px"
			value="<%=BbsService.getGroupNameByMap(gList,DOMAIN_NAME,bbsEntity.BBS_GROUP_IDX)%>"
			readonly="readonly" /> <a href="javascript:selectParent()"><img
			src="/images/kor/btn/popupin_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">형식</th>
		<td><select name="BBS_MODE" id="BBS_MODE">
			<option value=0 selected>--형식--</option>
			<option value=1>공지사항</option>
			<option value=2>일반게시판</option>
			<option value=3>자료실</option>
			<option value=4>사진게시판</option>
		</select></td>
	</tr>
	<!--  <tr>
       <th scope="row">My Page 등록</th>
       <td><label><input type="checkbox" name="BBS_USE_MYPAGE" id="BBS_USE_MYPAGE" value='1'/>
       My Page 메뉴로 등록 합니다.</label>
       </td>
     </tr>
      -->
	<tr>
		<th scope="row">답변기능</th>
		<td><label><input type="checkbox" name="BBS_USE_REPLY"
			id="BBS_USE_REPLY" value='1' /> 답변기능 사용을 허가합니다.</label></td>
	</tr>
	<tr>
		<th scope="row">파일첨부</th>
		<td class="k_tb_other"><label><input type="checkbox"
			name="BBS_USE_ATTACHE" id="BBS_USE_ATTACHE" value='1' /> 파일첨부 사용을
		허가합니다.</label></td>
	</tr>
	<tr>
		<th scope="row">간단한 답글기능</th>
		<td class="k_tb_other"><label><input type="checkbox"
			name="BBS_USE_APPEND" id="BBS_USE_APPEND" value='1' /> 간단한 답글기능 사용을
		허가합니다.</label></td>
	</tr>
	<tr>
		<th scope="row">Member권한</th>
		<td><select name="BBS_AUTH_MEMBER" id="BBS_AUTH_MEMBER"
			style="width: 110px">
			<option value=-1 selected>--권한설정--</option>
			<option value=0>권한없음</option>
			<option value=1>읽기허용</option>
			<option value=2>읽기/쓰기허용</option>
		</select></td>
	</tr>
	<tr>
		<th scope="row">Guest권한</th>
		<td><select name="BBS_AUTH_GUEST" id="BBS_AUTH_GUEST"
			style="width: 110px">
			<option value=-1 selected>--권한설정--</option>
			<option value=0>권한없음</option>
			<option value=1>읽기허용</option>
		</select></td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>
<p style="padding: 0 5px 10px; display: block; text-align: right"><a
	href="javascript:bbsUpdate();"><img
	src="/images/kor/btn/popup_modify.gif" /></a> <a
	href="bbs.admin.do?method=bbs_list" ><img
	src="/images/kor/btn/popup_cancel.gif" /></a> <a
	href="javascript:bbsRemove();"><img
	src="/images/kor/btn/popup_delete2.gif" /></a></p>
</form>

<script language=javascript>
setSelectedIndexByValue( document.f.BBS_MODE, "<%=bbsEntity.BBS_MODE%>" );
setSelectedIndexByValue( document.f.BBS_AUTH_MEMBER, "<%=bbsEntity.BBS_AUTH_MEMBER%>" );
setSelectedIndexByValue( document.f.BBS_AUTH_GUEST, "<%=bbsEntity.BBS_AUTH_GUEST%>" );
setCheckBoxByValue( document.f.BBS_USE_REPLY, '<%=bbsEntity.BBS_USE_REPLY%>' );
setCheckBoxByValue( document.f.BBS_USE_ATTACHE, '<%=bbsEntity.BBS_USE_ATTACHE%>' );
setCheckBoxByValue( document.f.BBS_USE_APPEND, '<%=bbsEntity.BBS_USE_APPEND%>' );
setCheckBoxByValue( document.f.BBS_USE_MYPAGE, '<%=bbsEntity.BBS_USE_MYPAGE%>' );
setFocusToFirstTextField( document.f )
</script>
