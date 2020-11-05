<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.AdminLogTrackEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex1" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex3" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex2" class="java.lang.String" scope="request" />
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

	//각 분류에 대한 배열
	Cats=new Array(4);
	Cats[0]=new Array(0);
	Cats[1]=new Array(13);
	Cats[2]=new Array(2);
	Cats[3]=new Array(4);
	
		
	//사용자
	Cats[1][0]="-선택하세요-";
	Cats[1][1]="사용자생성";
	Cats[1][2]="사용자수정";
	Cats[1][3]="사용자삭제";
	Cats[1][4]="인증서입력";
	Cats[1][5]="인증서삭제";
	Cats[1][6]="아이디변경";
	Cats[1][7]="사용자자동전달";
	Cats[1][8]="사용자권한변경";
	Cats[1][9]="사용자비밀번호변경";
	Cats[1][10]="사용자용량변경 ";
	Cats[1][11]="[전체]용량변경  ";
	Cats[1][12]="[전체]자동포워드잠김 ";
	
	//도메인
	Cats[2][0]="-선택하세요-";
	Cats[2][1]="사용자수정";
	
	//아카이브
	Cats[3][0]="-선택하세요-";
	Cats[3][1]="아카이브목록저장";
	Cats[3][2]="아카이브복구";
	Cats[3][3]="아카이브삭제";
	Cats[3][4]="아카이브보기";
	
	//특정 채널을 선택하면 해당 카테고리를 생성
	function BuildCats(num)
	{
	var ct;
	//첫 번째 카테고리 선택
	document.f.strIndex2.selectedIndex=0;
	
	//해당 채널의 서브 카테고리 배열 길이만큼 반복
	for(ctr=0;ctr<Cats[num].length; ctr++)
	{
	//카테고리에 해당하는 콤보박스의 값을 채움
	document.f.strIndex2.options[ctr]=new Option(Cats[num][ctr],'0'+ctr);
	//document.f.strIndex2.options[ctr].value=crt;
	}
	//select 리스트 길이 지정
	document.f.strIndex2.length=Cats[num].length;
	}  
	
//-->
</script>

<body onLoad="BuildCats(document.f.strIndex3.selectedIndex);">
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
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<table>
	<tr>
		<td width="150" align="right"><strong>관리자 로그 검색</strong></td>
		<td width="600">
		<div style="padding-bottom: 10px"><span
			style="padding-left: 20px; text-align: right">권한 : </span> <select
			name="strIndex1" id="strIndex">
			<option value="">-선택하세요-</option>
			<option value="S">S:시스템관리자</option>
			<option value="A">A:도메인관리자</option>
		</select> <span style="padding-left: 20px; text-align: right">메뉴 : </span> <select
			name="strIndex3" id="strIndex"
			onChange="BuildCats(this.selectedIndex);">
			<option value="0">-선택하세요-</option>
			<option value="1">01:사용자</option>
			<option value="2">02:도메인</option>
			<option value="3">03:아카이브</option>
		</select> <span style="padding-left: 20px; text-align: right">작업 : </span> <select
			name="strIndex2" id="strIndex">
			<option value="">------------</option>
		</Select></div>
		<div id="div_cond1" style="padding-left: 55px"><select
			name="strIndex4" id="strIndex">
			<option value="A">관리자아이디</option>
			<option value="U">대상아이디</option>
		</select> <input type="text" name="strKeyword" id="input" class="k_intx00"
			style="width: 200px"
			onKeyDown="javascript:if(event.keyCode == 13) { condSearch(); return false}"
			value="<%=strKeyword %>" /> <a href="javascript:condSearch();"><img
			src="/images/kor/btn/popup_search.gif" /></a></div>
		</td>
	</tr>
</table>
</div>

<div>
<table class="k_tb_other6" style="margin-top: 5px">
	<tr>

		<th width="120" scope="col">권한</th>
		<th width="120">관리자아이디</th>
		<th width="120">대상아이디</th>
		<th width="130">메뉴</th>
		<th width="150">작업</th>
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
      	String USER_ACTION = "";
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


		<%
       if(entity.ACTION_MENU.equals("01")){
       if(entity.USER_ACTION.equals("01")){
    	   USER_ACTION = "사용자 생성";   
      %>
		<td class="k_txAliC"><%=USER_ACTION%></td>
		<%} else if(entity.USER_ACTION.equals("02")){
    	  USER_ACTION = "사용자 수정";  %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("03")){
    	   USER_ACTION = "사용자 삭제"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("04")){
    	   USER_ACTION = "인증서 입력"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("05")){
    	   USER_ACTION = "인증서 삭제"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("06")){
    	   USER_ACTION = "아이디 변경"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("07")){
    	   USER_ACTION = "사용자 자동전달"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("08")){
    	   USER_ACTION = "사용자  권한 변경"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("09")){
    	   USER_ACTION = "사용자 비밀번호 변경"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("10")){
    	   USER_ACTION = "사용자 용량 변경"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("11")){
    	   USER_ACTION = "[전체]사용자용량변경 "; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("12")){
    	   USER_ACTION = "[전체]사용자자동포워드잠김"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else{ USER_ACTION = entity.USER_ACTION;%>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} }%>


		<%
       if(entity.ACTION_MENU.equals("02")){
       if(entity.USER_ACTION.equals("01")){
    	   USER_ACTION = "사용자수정";   
      %>
		<td class="k_txAliC"><%=USER_ACTION%></td>
		<%} else{ USER_ACTION = entity.USER_ACTION;%>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} }%>

		<%
       if(entity.ACTION_MENU.equals("03")){
       if(entity.USER_ACTION.equals("01")){
    	   USER_ACTION = "아카이브목록저장";   
      %>
		<td class="k_txAliC"><%=USER_ACTION%></td>
		<%} else if(entity.USER_ACTION.equals("02")){
    	  USER_ACTION = "아카이브복구";  %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("03")){
    	   USER_ACTION = "아카이브삭제"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else if(entity.USER_ACTION.equals("04")){
    	   USER_ACTION = "아카이브보기"; %>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} else{ USER_ACTION = entity.USER_ACTION;%>
		<td class="k_txAliC"><%=USER_ACTION %></td>
		<%} }%>

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


</form>
</body>

<script language=javascript>
<!--

setSelectedIndexByValue( document.f.strIndex1, "<%=strIndex1%>" );
setSelectedIndexByValue( document.f.strIndex3, "<%=strIndex3%>" );
setSelectedIndexByValue( document.f.strIndex2, "<%=strIndex2%>" );
-->
</script>