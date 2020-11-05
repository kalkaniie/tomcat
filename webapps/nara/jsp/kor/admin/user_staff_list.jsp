﻿<%@page language="java" contentType="text/html;charset=utf-8"%>



<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="inResearch" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_DEPARTMENT" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_ID" class="java.lang.String" scope="request" />

<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<script language="javascript">
<!--
function userSearch(){
	var objForm = document.user_staff_list;
	
  	if(objForm.strIndex.value==""){
	    alert("검색옵션을 션택하세요.");
	    objForm.strIndex.focus();
	    return;
  	}
  	
  	if (objForm.inResearch.checked) {
  		var obj;
  		
  		obj = eval("objForm.COND_" + objForm.strIndex.value);
	  	if (obj.value == "") {
	  		obj.value = objForm.strKeyword.value;
	  	} else {
	  		obj.value = obj.value + "" + objForm.strKeyword.value;
	  	}	  	
	} else {
  		condReset();
  		var obj;
  		obj = eval("objForm.COND_" + objForm.strIndex.value);
	  	obj.value = objForm.strKeyword.value;	  	
  	}
  	
  	objForm.nPage.value=0;
  	objForm.method.value = "uesr_staff_info_list";
  	objForm.action="user.admin.do";
  	//objForm.submit();
  	objForm.submit(); 	
}

//이전 검색조건 리셋
function condReset() {
	var objForm = document.user_staff_list;
	
	objForm.COND_USERS_NAME.value = "";
	objForm.COND_USERS_DEPARTMENT.value = "";
	objForm.COND_USERS_ID.value = "";
}

//다운로드
function download() {
	var objForm = document.user_staff_list;
	objForm.action = "user.admin.do";
	objForm.method.value = "aj_user_staff_list_download";
	//objForm.submit();
	objForm.submit();
}

//-->
</script>
<style type="text/css">
:root .k_tab_boxMid {
	border-bottom: 1px solid #fff
}
</style>

<form name="user_staff_list" method="post">
<input type=hidden name='method' value='uesr_staff_info_list'> 
<input type=hidden name='nPage'	value='<%=nPage%>'> 
<input type=hidden name='orderCol' value='<%=orderCol%>'> 
<input type=hidden name='orderType' value='<%=orderType%>'>
<input type=hidden name='COND_USERS_NAME' value="<%=COND_USERS_NAME%>"> 
<input type=hidden name='COND_USERS_DEPARTMENT' value="<%=COND_USERS_DEPARTMENT%>">
<input type=hidden name='COND_USERS_ID' value="<%=COND_USERS_ID%>"> 
<div class="k_puTit">
  <h2 class="k_puTit_ico2">도메인관리자 <strong>사용자관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li>현재 재직중인 사용자의 정보를 관리합니다.</li>
</ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list" >사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></li>
	<!--<li><a href="user.admin.do?method=user_xecure_regist_form" >인증서등록</a></li>-->
	<!--<li><a href="user.admin.do?method=user_multi_regist_form">일괄등록</a></li>-->
	<!--<li><a href="admin103-4.html">일괄삭제</a></li> -->
	<li><a href="user.admin.do?method=reservation_list" >예약아이디</a></li>
	<!--<li><a href="admin103-6.html">일괄중지</a></li> -->
	<!--<li><a href="user.admin.do?method=id_change_list" >계정변경</a></li>-->
	<!--<li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li> -->
	<!--<li><a href="user.admin.do?method=info_open_list" >정보공개</a></li>-->
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li>
	<li><a href="user.admin.do?method=uesr_temp_info_list" >가입대기</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=uesr_staff_info_list" >직원정보</a></b></li>
	<li><a href="user.admin.do?method=uesr_expire_info_list" >퇴직직원정보</a></li>
</ul>
<div class="k_tab_boxTop"><img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
  <div class="k_tab_boxMid">
    <table class="k_tb_other4">
	  <tr>
		<!--<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.user_staff_list, 'USERS_ID')" ;/></th>-->
		<th scope="col">아이디</th>
		<th width="100" scope="col">이름</th>
		<th width="100" scope="col">소속</th>
		<th width="100" scope="col">직급</th>
		<th width="100" scope="col">직위</th>
		<th width="100" scope="col">내선번호</th>
		<th width="100" scope="col">휴대폰</th>
	  </tr>
<%
	if (list == null) {
%>
	  <tr>
		<td colspan="7" align="center">리스트가 없습니다.</td>
	  </tr>
<%		
	} else {  
		Iterator iterator = list.iterator();
		
		if(!iterator.hasNext()) {
%>
  	  <tr>
		<td colspan="7" align="center">리스트가 없습니다.</td>
	  </tr>
<%
		} else {
			Map tempMap = new HashMap();
	        while(iterator.hasNext()) {
	        	tempMap = (Map)iterator.next();
%>
	  <tr>
		<%--<td><input type="checkbox" name="USERS_ID" value="<%=tempMap.get("USERS_ID")%>" /></td>--%>
		<td class="k_txAliC"><%=tempMap.get("USERS_ID")%></td>
		<td class="k_txAliC"><%=tempMap.get("USERS_NAME")%></td>
		<td class="k_txAliC"><%=tempMap.get("USERS_DEPARTMENT") == null ? "" : tempMap.get("USERS_DEPARTMENT")%></td>
		<td class="k_txAliC"><%=tempMap.get("USERS_JOBCODE") == null ? "" : tempMap.get("USERS_JOBCODE")%></td>
		<td class="k_txAliC"><%=tempMap.get("USERS_COMPNAME") == null ? "" : tempMap.get("USERS_COMPNAME")%></td>
		<td class="k_txAliC"><%=tempMap.get("USERS_INSIDETELNO") == null ? "" : tempMap.get("USERS_INSIDETELNO")%></td>
		<td class="k_txAliC"><%=tempMap.get("USERS_CELLNO") == null ? "" : tempMap.get("USERS_CELLNO")%></td>
	  </tr>
<%
			}
		}
	}
%>
</table>
<p style="float: left;">
  <span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum%></b>명 ]</span> 
  <span class="k_fltR"><a href="javascript:download();"><img src="/images/kor/btn/popup_download.gif" /></a></span>  
</p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
  <div class="k_puAdmin_sBox">
    <select name="strIndex">
	  <option value="USERS_ID">아이디</option>
	  <option value="USERS_NAME">이름</option>
	  <option value="USERS_DEPARTMENT">소속</option>
    </select> 
    <input type="text" name="strKeyword" style="width: 130px" class="k_intx00" value="<%=strKeyword %>" onKeyDown="javascript:if(event.keyCode == 13) { userSearch(); return false}" />
    <a href="javascript:userSearch();"><img src="/images/kor/btn/popup_search.gif" /></a> &nbsp;&nbsp;&nbsp; 
    <label><input type="checkbox" name="inResearch" value="Y" /> 결과내 검색</label>
  </div>
</div>
<div class="k_tab_boxBott k_clr"><img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
  <div style="clear: both"></div>
</div>
</form>

<script language=javascript>
	setSelectedIndexByValue( document.user_staff_list.strIndex, "<%=strIndex%>" );
	setCheckBoxByValue( document.user_staff_list.inResearch, "<%=inResearch%>" );
</script>
