<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.AdminLogTrackEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />


<script language="javascript">
<!--
//조건검색
function condSearch() {
	var objForm = document.f;
	if(objForm.strIndex.value == "USERS_ID" && objForm.strKeyword.value == ""){
	    alert("아이디를 입력하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_AUTH" && objForm.strKeyword.value == ""){
	    alert("사용자권한은 S:시스템관리자 A:도메인관리자를  입력하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USER_ACTION" && objForm.strKeyword.value == ""){
	    alert("작업(I:insert U:update D:delete)입력하세요");
	    objForm.strKeyword.focus();
	    return;
  	}
	objForm.nPage.value = "1";
	objForm.action = "grantip.system.do";
	// objForm.submit();
	objForm.submit();
}

function condReset() {
	var objForm = document.f;
	
	objForm.USERS_ID.value = "";
	objForm.USERS_AUTH.value = "";
	objForm.USER_ACTION.value = "";
}

  function popAdminDetail(_login_log) {
	var link = "grantip.system.do?method=pop_domain_add_detail&ADMIN_LOG_IDX=" + _login_log;
	MM_openBrWindow(link,'sys_userdetail','scrollbars=yes,resizable=yes,width=740,height=600')
}
  
	
//-->
</script>

<form name="f" method="post"><input type=hidden name='method'
	value='grantIp_control'> <input type=hidden name='nPage'
	value='<%=nPage%>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>관리자 로그 추적</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>등록된 관리자 로그 리스트입니다.</li>
</ul>
<div>
<table class="k_tb_other6" style="margin-top: 5px">
	<tr>

		<th width="120" scope="col">권한</th>
		<th width="120">접속아이디</th>
		<th width="120">대상아이디</th>
		<th width="130">메뉴</th>
		<th width="150">작업(I:insert U:update D:delete)</th>
		<th width="245">접속시간</th>

	</tr>
	<%
    String WEB_SESSION_ID = request.getSession().getId();
	Iterator iterator = list.iterator();
	if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="7" align="center">조회된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		while(iterator.hasNext()) {
			AdminLogTrackEntity entity = (AdminLogTrackEntity)iterator.next();
%>
	<tr>
		<input type="hidden" name="ADMIN_LOG_IDX"
			value="<%=entity.ADMIN_LOG_IDX %>">
		<%String USERS_AUTH = "";
      String ACTION_MENU = "";
       if(entity.USERS_AUTH.equals("S")){
    	   USERS_AUTH = "시스템관리자";   
      %>
		<td class="k_txAliC"><%=USERS_AUTH %></td>
		<%} 
       else if(entity.USERS_AUTH.equals("A")){
    	   USERS_AUTH = "도메인관리자";   
       %>
		<td class="k_txAliC"><%=USERS_AUTH %></td>
		<%} else{
    	   USERS_AUTH = entity.USERS_AUTH;   
       %>
		<td class="k_txAliC"><%=USERS_AUTH %></td>
		<%} %>

		<td class="k_txAliC"><a
			href="javascript:popAdminDetail('<%=entity.ADMIN_LOG_IDX %>');"><%=entity.USERS_ID %></td>

		<td class="k_txAliC"><%=entity.TARGET_USERS_IDS %></td>

		<%if(entity.ACTION_MENU.equals("01")){
    	   ACTION_MENU = "사용자관리";   
      %>
		<td class="k_txAliC"><%=ACTION_MENU%></td>
		<%} else if(entity.ACTION_MENU.equals("02")){
    	   ACTION_MENU = "도메인관리";  %>
		<td class="k_txAliC"><%=ACTION_MENU %></td>
		<%} else if(entity.ACTION_MENU.equals("03")){
    	   ACTION_MENU = "아카이브관리"; %>
		<td class="k_txAliC"><%=ACTION_MENU %></td>
		<%} else{ ACTION_MENU = entity.ACTION_MENU;%>
		<td class="k_txAliC"><%=ACTION_MENU %></td>
		<%} %>

		<td class="k_txAliC"><%=entity.USER_ACTION %></td>
		<td class="k_txAliC"><span alt="csosls"><%=entity.CONNECT_TIME %></span></td>
	</tr>
	<%
		}
	}
%>
</table>
<p><span style="padding: 5px 0 0; display: block">[ 총 <b><%=nListNum %></b>개
]</span></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
</div>


<div class="k_puAdmin_box" style="margin: 10px 0">
<table>
	<tr>
		<td align="center">
		<table>
			<tr>
				<td>
			<tr>
				권&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;한&nbsp;
				<select name="strIndex1" id="strIndex">
					<option value="">-선택하세요-</option>
					<option value="S">S:시스템관리자</option>
					<option value="A">A:도메인관리자</option>
			<tr>
				작&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;업&nbsp;
				<select name="strIndex2" id="strIndex">
					<option value="">-선택하세요-</option>
					<option value="I">I:insert</option>
					<option value="U">U:update</option>
					<option value="D">D:delete</option>
			<tr>
			<tr>
				메&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;뉴&nbsp;
				<select name="strIndex3" id="strIndex">
					<option value="">-선택하세요-</option>
					<option value="1">01:사용자</option>
					<option value="2">02:도메인</option>
					<option value="3">03:아카이브</option>
			<tr>
				</select>
				</td>
				<td>
				<div id="div_cond1"><select name="strIndex4" id="strIndex">
					<option value="A">접속아이디</option>
					<option value="U">대상아이디</option>
					<input type="text" name="strKeyword" id="input" class="k_intx00"
						style="width: 110px"
						onKeyDown="javascript:if(event.keyCode == 13) { condSearch(); return false}" /></div>
				<td><a href="javascript:condSearch();"><img
					src="/images/kor/btn/popup_search.gif" /></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</form>

