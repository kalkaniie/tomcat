﻿<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<script language="javascript">
<!--
function forwordInfoSearch(){
	var objForm = document.f_forword_info_list;
	
  	if(objForm.strIndex.value==""){
	    alert("검색옵션을 션택하세요.");
	    objForm.strIndex.focus();
	    return;
  	}
	
  	objForm.nPage.value=0;
  	objForm.action="user.admin.do?method=forword_info_list";
  	objForm.submit();
}

//포워딩 설정
function forwordAuthUpdate(_flag) {
  	var objForm = document.f_forword_info_list;
  	var confirm_msg = "";
  		if(!isCheckedOfBox(objForm, "USERS_IDX")){
	    alert("사용자를 선택하십시오.");
	    return;
  	}
  	
   	if (_flag == "Y") {
   		confirm_msg = "선택된 사용자의 포워딩기능을 설정 하시겠습니까?";
   	} else {
   		confirm_msg = "선택된 사용자의 포워딩기능을 해제 하시겠습니까?";
   	}
   	
  	if(confirm(confirm_msg)){
    	objForm.method.value = "forword_info_change";
    	objForm.USERS_FWD_AUTH.value = _flag;
    	objForm.action="user.admin.do";
    	//objForm.submit();
    	objForm.submit();
  	}
}

//모든 사용자 포워딩 설정
function forwordAuthUpdateAll_Y(){
var objForm = document.f_forword_info_list;
if(confirm("모든 사용자 자동전달 허용하겠습니까?")){
  objForm.method.value = "forword_info_changeall";
  objForm.FORWORD_AUTH.value = "Y";
  objForm.action="user.admin.do";
  objForm.submit();
}
}
function forwordAuthUpdateAll_N(){
var objForm = document.f_forword_info_list;
if(confirm("모든 사용자 자동전달 해제하겠습니까?")){
  objForm.method.value = "forword_info_changeall";
  objForm.FORWORD_AUTH.value = "N";
  objForm.action="user.admin.do";
  objForm.submit();

}
}

//-->
</script>
<style type="text/css">
:root .k_tab_boxMid {
	border-bottom: 1px solid #fff
}
</style>

<form name="f_forword_info_list" method="post">
<input type=hidden name='method' value='forword_info_list'> 
<input type=hidden name='nPage' value='<%=nPage%>'> 
<input type=hidden name='USERS_FWD_AUTH' value=''> 
<input type=hidden name='FORWORD_AUTH' value=''> 
<input type=hidden name='orderCol' value='<%=orderCol%>'> 
<input type=hidden name='orderType' value='<%=orderType%>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>사용자관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>자동전달(포워딩사용)기능을 관리합니다.</li>
	<li>
	<p style="background-image: none">Y : 자동전달(포워딩)사용 / N : 사용안함</p>
	</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list">사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form">개별등록</a></li>
	<li><a href="user.admin.do?method=user_multi_regist_form" >일괄등록</a></li>
	<li><a href="user.admin.do?method=user_multi_delete_form">일괄삭제</a></li>
	<li><a href="user.admin.do?method=user_multi_pause_form">일괄중지</a></li>
	<li><a href="user.admin.do?method=reservation_list">예약아이디</a></li>
	<li class="k_tab_menuOn"><a href="user.admin.do?method=forword_info_list" >자동전달</a></li>
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.f_forword_info_list, 'USERS_IDX')" ;/></th>
		<th width="80">아이디</th>
		<th width="75">이름</th>
		<th width="88" scope="col">권한</th>
		<th scope="col">포워딩 목록</th>
	</tr>
	<%
	if (list == null) {
%>
	<tr>
		<td colspan="5" align="center">리스트가 없습니다.</td>
	</tr>
	<%		
	} else {  
		Iterator iterator = list.iterator();
		
		if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="9" align="center">리스트가 없습니다.</td>
	</tr>
	<%
		} else {
			while(iterator.hasNext()) {
				UserEntity userEntity = (UserEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="USERS_IDX"
			value="<%=userEntity.USERS_IDX %>"></td>
		<td><%=userEntity.USERS_ID %></td>
		<td class="k_txAliC"><%=userEntity.USERS_NAME %></td>
		<td class="k_txAliC"><%=userEntity.USERS_FWD_AUTH %></td>
		<td class="k_txAliC"><%=userEntity.USERS_FWD_LIST %></td>
	</tr>
	<%
			}
		}
	}
%>
</table>
<p style="width:767px;"><span class="k_fltL"
	style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> <span
	class="k_fltR" style="padding: 0 0 1px"> <a
	href="javascript:forwordAuthUpdateAll_N();"><img
	src="/images/kor/btn/popup_forwordAutoAllN.gif" /></a> <a
	href="javascript:forwordAuthUpdateAll_Y();"><img
	src="/images/kor/btn/popup_forwordAutoAllY.gif" /></a> <a
	href="javascript:forwordAuthUpdate('Y');"><img
	src="/images/kor/btn/popup_forwordAdd.gif" /></a> <a
	href="javascript:forwordAuthUpdate('N');"><img
	src="/images/kor/btn/popup_forwordOut.gif" /></a> </span></p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox"><select name="strIndex">
	<option value="USERS_ID">아이디</option>
	<option value="USERS_NAME">이름</option>
	<option value="USERS_FWD_LIST">포워딩메일주소</option>
</select> <input type="text" name="strKeyword" style="width: 130px"
	class="k_intx00" value="<%=strKeyword %>" /> <a
	href="javascript:forwordInfoSearch();"><img
	src="/images/kor/btn/popup_search.gif" /></a></div>
</div>
<div class="k_tab_boxBott k_clr"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
<div style="clear: both"></div>
</div>
</form>

<script language=javascript>
setSelectedIndexByValue( document.f_forword_info_list.strIndex, "<%=strIndex%>" );
</script>

