<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.UserDeleteEntity"%>
<%@page import="com.nara.util.aria.NaraARIAUtil"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<script language="javascript">
<!--
function registFile() {
	var objForm = document.file_attach;

	if(objForm.objFile.value == "") {
		alert("파일을 선택해 주십시오");
    	objForm.objFile.focus();
    	return;
	}
	
	objForm.FILE_NAME.value = objForm.objFile.value.substr(objForm.objFile.value.lastIndexOf("\\") + 1);
	objForm.action = "user.admin.do?method=user_list_attach_delete";
	objForm.submit();
}

//선택한리스트삭제
function selectedDelete() {
 	var objForm = document.multi_delete;
  	if(!isCheckedOfBox(objForm, "USERS_DELETE_IDX")){
    	alert("삭제할 사용자 정보를 선택하십시오.");
    	return;
  	}
  	    
  	if(confirm("선택하신 사용자 정보가 삭제됩니다.\n삭제하시겠습니까?")){
    	objForm.method.value = "remove_multi_user_delete";
    	objForm.rtype.value = "selected";
    	objForm.action="user.admin.do";
    	objForm.submit();
  	}
}

//모든리스트삭제
function allDelete() {
	var objForm = document.multi_delete;
	
	if(confirm("모든 사용자 정보가 삭제됩니다.\n삭제하시겠습니까?")){
    	objForm.method.value = "remove_multi_user_delete";
    	objForm.rtype.value = "all";
    	objForm.action="user.admin.do";
    	objForm.submit();
  	}
}

//사용자일괄등록
function allRegist() {
	var objForm = document.multi_delete;

  	if(confirm("전체 사용자 리스트가 삭제됩니다. \n삭제하시겠습니까?")){
    	objForm.method.value = "delete_multi_user";
    	objForm.action="user.admin.do";
    	objForm.submit();
  	}
}

//조건검색
function keywordSrch() {
	var objForm = document.multi_delete;
	
	if(objForm.strIndex.value==""){
    	alert("검색옵션을 션택하세요.");
    	objForm.strIndex.focus();
    	return;
  	}else if(objForm.strKeyword.value == ""){
    	alert("검색어를 입력하세요.");
    	objForm.strKeyword.focus();
    	return;
  	}
  
	objForm.action = "user.admin.do?method=user_multi_delete_form";
	objForm.submit();
}
//-->
</script>

<form name="multi_delete" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='rtype' value=''><!-- 삭제 타입(selected:선택, all:전체 -->

<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>사용자관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>일괄등록파일 형식 : 아이디,이름,주민번호, <% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
	부서 , 사번 <% } else { %> 학과, 학번 <% } %>,비밀번호</li>
	<li>사용자 리스트를 아래의 형식에 맞추어 등록한 후 일괄적으로 중지 처리합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list">사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form">개별등록</a></li>
	<li><a href="user.admin.do?method=user_multi_regist_form">일괄등록</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=user_multi_delete_form">일괄삭제</a></b></li>
	<li><a href="user.admin.do?method=user_multi_pause_form">일괄중지</a></li>
	<li><a href="user.admin.do?method=reservation_list">예약아이디</a></li>
	<li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li>
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" onClick="checkAll(document.multi_delete, 'USERS_DELETE_IDX');" /></th>
		<th width="100" scope="col">아이디</th>
		<th width="100" scope="col">이름</th>
		<th width="150" scope="col">주민등록번호</th>
		<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
		<th scope="col">부서</th>
		<th width="100" scope="col">사번</th>
		<% } else { %>
		<th scope="col">학과</th>
		<th width="100" scope="col">학번</th>
		<% } %>
		<th width="100" scope="col">비밀번호</th>
	</tr>
	<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="7" align="center">조회된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		while(iterator.hasNext()) {
			UserDeleteEntity entity = (UserDeleteEntity)iterator.next();			
%>
	<tr>
		<td><input type="checkbox" name="USERS_DELETE_IDX" id="checkbox" value="<%=entity.USERS_DELETE_IDX %>" /></td>
		<td><%=entity.USERS_DELETE_ID %></td>
		<td class="k_txAliC"><a href="javascript:MM_openBrWindow('admin103_pop.html','','scrollbars=yes,resizable=yes,width=740,height=600');"><%=entity.USERS_DELETE_NAME %></a></td>
		<td class="k_txAliC"><%=entity.USERS_DELETE_JUMIN1%>-<%=entity.USERS_DELETE_JUMIN2%></td>
		<td class="k_txAliC"><%=entity.USERS_DELETE_DEPARTMENT %></td>
		<td class="k_txAliC"><%=entity.USERS_DELETE_LICENCENUM %></td>
		<td class="k_txAliC"><%=entity.USERS_DELETE_PASSWD%></td>
	</tr>
	<%
		}
	}
%>
</table>
<p style="width:767px;"><span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명]</span> 
<span class="k_fltR" style="padding: 0 0 1px"> 
<a href="javascript:selectedDelete();"><img	src="/images/kor/btn/popup_deleteSel.gif" /></a> 
<a href="javascript:allDelete();"><img src="/images/kor/btn/popup_deleteAllList.gif" /></a> 
<a href="javascript:allRegist();"><img src="/images/kor/btn/popup_userDel.gif" /></a></span></p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>

<div class="k_puAdmin_sBox"><select name="strIndex">
	<option value="USERS_DELETE_NAME">이름</option>
	<option value="USERS_DELETE_ID">아이디</option>
	<option value="USERS_DELETE_JUMIN">주민등록번호</option>
	<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
	<option value="USERS_DELETE_DEPARTMENT">부서명</option>
	<option value="USERS_DELETE_LICENCENUM">사번</option>
	<% } else { %>
	<option value="USERS_DELETE_DEPARTMENT">학과</option>
	<option value="USERS_DELETE_LICENCENUM">학번</option>
	<% } %>
</select> 
<input type="text" name="strKeyword" style="width: 150px" class="k_intx00" value="<%=strKeyword %>" /> 
<a href="javascript:keywordSrch();"><img src="/images/kor/btn/popup_search.gif" /></a>
</div>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
<div style="clear: both"></div>
</div>
</form>

<form name="file_attach" method="post" enctype="multipart/form-data">
<input type=hidden name="FILE_NAME" value="">

<div class="k_puAdmin_box">
<table>
	<tr>
		<td width="165" align="right"><strong>일괄등록파일</strong></td>
		<td><input name="objFile" type="file" style="width: 350px" /> <a href="javascript:registFile();"><img src="/images/kor/btn/popup_confirm.gif" /></a></td>
	</tr>
</table>
</div>
</form>

<script language=javascript>
setSelectedIndexByValue( document.multi_delete.strIndex, "<%=strIndex%>" );
</script>
