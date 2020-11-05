﻿<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AccountChangeEntity"%>
<jsp:useBean id="domainEntity"
	class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_START_DATE" class="java.lang.String"
	scope="request" />
<jsp:useBean id="COND_END_DATE" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>

<script language="javascript">
<!--
function userSearch(){
	var objForm = document.id_change_list;
	
  	if(objForm.strIndex.value==""){
	    alert("검색옵션을 션택하세요.");
	    objForm.strIndex.focus();
	    return;
  	} else if (objForm.strIndex.value != "REQ_DATE" && objForm.strIndex.value != "CONFIRM_DATE" && objForm.strIndex.value != "STATUS") {
  		if(objForm.strKeyword.value == ""){
	    	alert("검색어를 입력하세요.");
	    	objForm.strKeyword.focus();
	    	return;
	    }
  	}

	if (objForm.strIndex.value == "STATUS") {
		objForm.strKeyword.value = objForm.STATUS.value; 
	}
  	objForm.nPage.value=0;
  	objForm.method.value = "id_change_list";
  	objForm.action="user.admin.do";
 //objForm.submit(); 
   objForm.submit();
}

function condSetting() {
	if (document.id_change_list.strIndex.value == "REQ_DATE" || document.id_change_list.strIndex.value == "CONFIRM_DATE") {
		cond_type1.style.display = "none";
		cond_type2.style.display = "inline";
		cond_type3.style.display = "none";
	} else if (document.id_change_list.strIndex.value == "STATUS") {
		cond_type1.style.display = "none";
		cond_type2.style.display = "none";
		cond_type3.style.display = "inline";
	} else {
		cond_type1.style.display = "inline";
		cond_type2.style.display = "none";
		cond_type3.style.display = "none";
	}
}

function ProcChangeID() {
	var objForm = document.id_change_list;
	
	if (!bCheck()) {
		alert("변경처리할 계정을 선택해 주십시오.");
		return;
	}
	if (procCompleteChk()) {
		alert("변경처리 중이거나  변경처리 완료된 계정은 제외 됩니다.");
	}
	
	if (confirm("계정 변경 처리 하시겠습니까?")) {
		objForm.nPage.value=0;
	  	objForm.method.value = "id_change_proc";
	  	objForm.action="user.admin.do";
	  	//objForm.submit();
	  	 objForm.submit();
	  	 
	}
}

function bCheck() {
	var obj = document.getElementsByName("USERS_IDX");
	for(var i=0; i<obj.length; i++) {
		if (obj[i].checked) {
			return true;
		}
	}
	
	return false;
}

function procCompleteChk() {
	var objForm = document.id_change_list;
	var obj = document.getElementsByName("USERS_IDX");
 	var flag = false;
	for(var i=0; i<obj.length; i++) {
		if (obj[i].checked && (obj[i].getAttribute("procStatus") == "P" || obj[i].getAttribute("procStatus") == "I")) {
			obj[i].checked = false;
			flag = true;
		}
	}
	
	return flag;
}
//-->
</script>
<style type="text/css">
:root .k_tab_boxMid {
	border-bottom: 1px solid #fff
}
</style>

<form name="id_change_list" method="post"><input type=hidden
	name='method' value='userList'> <input type=hidden name='nPage'
	value='<%=nPage%>'> <input type=hidden name='orderCol'
	value='<%=orderCol%>'> <input type=hidden name='orderType'
	value='<%=orderType%>'>
<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>사용자관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>모든 사용자의 계정변경 정보를 관리합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list"
		>사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form"
		>개별등록</a></li>
	<!-- <li><a href="user.admin.do?method=user_xecure_regist_form"
		>인증서등록</a></li>-->
	<!--<li><a href="user.admin.do?method=user_multi_regist_form" >일괄등록</a></li>-->
	<!-- <li><a href="admin103-4.html">일괄삭제</a></li> -->
	<li><a href="user.admin.do?method=reservation_list"
		>예약아이디</a></li>
	<!-- <li><a href="admin103-6.html" >일괄중지</a></li> -->
	<!-- <li class="k_tab_menuOn"><b><a
		href="user.admin.do?method=id_change_list"
		>계정변경</a></b></li>-->
	<!-- <li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li> -->
	<!--<li><a href="user.admin.do?method=info_open_list" >정보공개</a></li>-->
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><img
			src="/images/kor/ico/ico_check.gif" width="13" height="13"
			onClick="checkAll(document.id_change_list, 'USERS_IDX')" ;/></th>
		<th>사용 아이디</th>
		<th>신청 아이디</th>
		<th width="140" scope="col">변경요청일</th>
		<th width="100" scope="col">변경자</th>
		<th width="140" scope="col">변경일</th>
		<th width="50" scope="col">상태</th>
	</tr>
	<%
	if (list == null) {
%>
	<tr>
		<td colspan="9" align="center">리스트가 없습니다.</td>
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
				AccountChangeEntity entity = (AccountChangeEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="USERS_IDX"
			value="<%=entity.USERS_IDX %>" procStatus="<%=entity.STATUS %>" /></td>
		<td class="k_txAliC"><%=entity.USERS_IDX.substring(0, entity.USERS_IDX.lastIndexOf("@")) %></td>
		<td class="k_txAliC"><%=entity.REQ_ID %></td>
		<td class="k_txAliC"><%=entity.REQ_DATE %></td>
		<td class="k_txAliC"><%=entity.CONFIRM_USERS_IDX %></td>
		<td class="k_txAliR"><%=entity.CONFIRM_DATE %></td>
		<td class="k_txAliC"><em><%=entity.getStausDesc() %></em></td>
	</tr>
	<%
			}
		}
	}
%>
</table>
<p style="float: left;"><span class="k_fltL"
	style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> <span
	class="k_fltR" style="padding: 0 0 1px"> <a
	href="javascript:ProcChangeID();"><img
	src="/images/kor/btn/popup_change.gif" /></a> </span></p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox">
<ul class="k_puAdmin_sBoxIn">
	<li><select name="strIndex" onchange="condSetting()">
		<option value="USERS_IDX">사용아이디</option>
		<option value="REQ_ID">변경아이디</option>
		<option value="CONFIRM_USERS_IDX">변경자</option>
		<option value="STATUS">처리상태</option>
		<option value="REQ_DATE">요청일</option>
		<option value="CONFIRM_DATE">처리일</option>
	</select></li>
	<li id="cond_type1"><input type="text" name="strKeyword"
		style="width: 130px" class="k_intx00" value="<%=strKeyword %>"
		onKeyDown="javascript:if(event.keyCode == 13) { userSearch(); return false}" /></li>
	<li id="cond_type2">
	<ul>
		<li id="STARTDT_DIV"></li>
		<li>&nbsp;-&nbsp;</li>
		<li id="ENDDT_DIV"></li>
	</ul>
	</li>
	<li id="cond_type3"><select name="STATUS">
		<option value="R">요청</option>
		<option value="P">처리완료</option>
		<option value="E">변경오류</option>
	</select></li>
	<li><a href="javascript:userSearch();"><img
		src="/images/kor/btn/popup_search.gif" /></a></li>
</ul>
</div>
</div>
<div class="k_tab_boxBott k_clr"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
<div style="clear: both"></div>
</div>

</form>

<script language=javascript>
setSelectedIndexByValue( document.id_change_list.strIndex, "<%=strIndex%>" );
condSetting();
//calendar_space.setcalendar.renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "COND_START_DATE", "COND_END_DATE", "", "");
</script>

