<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="domainEntity"
	class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_PERMIT" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_AUTH" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />


<script type="text/javascript" src="/js/common/common.js"></script>

<script language="javascript">
<!--
//유저 삭제
function removeUser() {
  	var objForm = document.f;
  	if(!isCheckedOfBox(objForm, "USERS_IDX")){
    	alert("삭제할 사용자 정보를 선택하십시오.");
    	return;
  	}
 
  	if(confirm("선택하신 사용자 정보가 삭제됩니다.\n삭제하시겠습니까?")){
    	objForm.method.value = "remove_standby_user";
    	objForm.action="user.admin.do";
    	document.f.submit();
  	}
}

//사용허가
function permitUser() {
  	var objForm = document.f;
  	if(!isCheckedOfBox(objForm, "USERS_IDX")){
    	alert("사용자 정보를 선택하십시오.");
    	return;
  	}
   
  	if(confirm("선택하신 사용자를 사용허가 합니다.")){
    	objForm.method.value = "permit_standby_user";
    	objForm.action="user.admin.do";
    	document.f.submit();
 	}
}

//조건 검색
function reSearch() {
	var objForm = document.f;
  	if(objForm.strIndex.value==""){
    	alert("검색옵션을 션택하세요.");
    	objForm.strIndex.focus();
    	return;
  	}else if(objForm.strKeyword.value == ""){
    	alert("검색어를 입력하세요.");
   		objForm.strKeyword.focus();
    	return;
  	}
  	
  	objForm.action="user.admin.do?method=standby_user_list";
  	objForm.submit();
}

//사용자정보 상세보기
function popUserDetail(_users_idx) {
	var link = "user.admin.do?method=show_user_detail&USERS_IDX=" + _users_idx;
	MM_openBrWindow(link,'userdetail','scrollbars=yes,resizable=yes,width=740,height=600')
}

//-->
</script>

<form name="f" method="post" action="user.admin.do">
<input type=hidden name='method' value=''> 
<input type=hidden name='USERS_PERMIT' value='<%=USERS_PERMIT %>'> 
<input type=hidden name='USERS_AUTH' value='<%=USERS_AUTH %>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>가입옵션</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>가입후 인증 선택 시 신청자의 등록정보를 확인하고 가입을 결정할 수 있습니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=join_opt">가입옵션</a></li>
	<li><a href="user.admin.do?method=agreement_opt">가입동의서</a></li>
	<li><a href="user.admin.do?method=greetings_opt">가입인사말</a></li>
	<li><a href="certify.admin.do?method=certify_list">인증정보관리</a></li>
	<li class="k_tab_menuOn"><b><a
		href="user.admin.do?method=standby_user_list">신청자관리</a></b></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><img
			src="/images/kor/ico/ico_check.gif" width="13" height="13"
			onClick="checkAll(document.f, 'USERS_IDX');" /></th>
		<th width="100" scope="col">아이디</th>
		<th width="100" scope="col">이름</th>
		<th width="150" scope="col">주민등록번호</th>
		<%	if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
		<th scope="col">부서</th>
		<th width="100" scope="col">사번</th>
		<%	} else { %>
		<th scope="col">학과</th>
		<th width="100" scope="col">학번</th>
		<%	} %>
	</tr>
	<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="6" align="center">검색된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		UserEntity userEntity = new UserEntity();
		while(iterator.hasNext()) {
			userEntity = (UserEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="USERS_IDX"
			value="<%=userEntity.USERS_IDX %>" /></td>
		<td><%=userEntity.USERS_ID %></td>
		<td class="k_txAliC"><a
			href="javascript:popUserDetail('<%=userEntity.USERS_IDX %>');"><%=userEntity.USERS_NAME %></a></td>
		<td class="k_txAliC"><%=userEntity.USERS_JUMIN1 %>-<%=userEntity.USERS_JUMIN2 %></td>
		<td class="k_txAliC"><%=userEntity.USERS_DEPARTMENT %></td>
		<td class="k_txAliC"><%=userEntity.USERS_LICENCENUM %></td>
	</tr>
	<%
		}
	}
%>
</table>
<p style="width:767px;"><span class="k_fltL"
	style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> <span
	class="k_fltR"> <a href="javascript:permitUser();"><img
	src="/images/kor/btn/popup_useallow.gif" /></a> <a
	href="javascript:removeUser();"><img
	src="/images/kor/btn/popup_delete2.gif" /></a></span></p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox"
	style="margin: 10px 180px; padding: 10px 30px"><select
	name="strIndex">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
	<option value="USERS_JUMIN">주민등록번호</option>
	<%	if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
	<option value="USERS_DEPARTMENT">부서명</option>
	<option value="USERS_LICENCENUM">사번</option>
	<%	} else { %>
	<option value="USERS_DEPARTMENT">학과</option>
	<option value="USERS_LICENCENUM">학번</option>
	<%	} %>
</select> <input type="text" name="strKeyword" style="width: 150px"
	class="k_intx00" value="<%=strKeyword %>" /> <a
	href="javascript:reSearch();"><img
	src="/images/kor/btn/popup_search.gif" /></a></div>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>

</form>

<script language=javascript>
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
</script>
