<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.LoginLogEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script language="javascript">
<!--
//조건검색
function condSearch() {
	var objForm = document.f;
	objForm.nPage.value = "1";
	objForm.action = "loginlog.system.do?method=login_log_list";
	objForm.submit();
}

function setCond() {
	var objForm = document.f;
	if (objForm.strIndex.value == "CONNECT_TIME") {
		div_cond1.style.display = "none";
		div_cond2.style.display = "block";
	} else {
		div_cond1.style.display = "block";
		div_cond2.style.display = "none";
	}
}

function checkAll(){
  	objForm = document.f;
  	len = objForm.elements.length;
  	for(var i = 0; i < len; i++){
   		if(objForm.elements[i].name == "LOGIN_LOG_IDX"){
      		objForm.elements[i].checked = !objForm.elements[i].checked;
    	}
  	}
}
	
function removelogin_log_idx(){
  	var objForm = document.f;
  	if(!isCheckedOfBox(objForm, "LOGIN_LOG_IDX")){
    	alert("삭제할 로그를 선택하십시오.");
    	return;
    }
  	var isRemove = confirm("선택하신 로그가 모두 삭제됩니다.\r로그를 삭제하시겠습니까?");    
  	if(isRemove){
    	objForm.action="loginlog.system.do?method=delete_log_idx";
    	// document.f.submit();
    	document.f.submit();;
  	}
}	
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value='login_log_list'> 
<input type=hidden name='nPage'	value='<%=nPage%>'>
<div class="k_puTit">
<h2 class="k_puTit_ico2">통계및로그관리 <strong>로그인로그추적</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>등록된 로그 리스트입니다.</li>
</ul>
<div>
<table class="k_tb_other6" style="margin-top: 5px">
	<tr>
		<th width="22" scope="col"><img	src="/images/kor/ico/ico_checkBl.gif" onClick="checkAll(document.f, 'LOGIN_LOG_IDX');" /></th>
		<th width="130" scope="col">접속아이디</th>
		<th width="130" scope="col">접속이름</th>
		<th scope="col">접속IP</th>
		<th width="200">접속시간</th>
		<!--<th width="145">인증서</th>-->
		<th width="60">성공여부</th>
		<!--<th width="60">결과코드</th>-->
	</tr>
<%
	Iterator iterator = list.iterator();
	if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="6" align="center">조회된 결과가 없습니다.</td>
	</tr>
<%
	} else {
		while(iterator.hasNext()) {
			LoginLogEntity entity = (LoginLogEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="LOGIN_LOG_IDX"	value="<%=entity.LOGIN_LOG_IDX%>" /></td>
		<td class="k_txAliC"><%=entity.CONNECT_ID %></td>
		<td class="k_txAliC"><%=entity.USERS_NAME %></td>
		<td class="k_txAliC"><%=entity.CONNECT_IP %></td>
		<td class="k_txAliC"><%=entity.CONNECT_TIME %></td>
		<!--<td class="k_txAliC"><%=entity.CERTIY_YN%></td>-->
		<td class="k_txAliC"><%=entity.LOGIN_YN%></td>
		<!--<td class="k_txAliC"><span alt="csosls"><%=entity.ERROR_CODE %></span></td>-->
	</tr>
<%
		}
	}
%>
</table>
<p><span style="padding: 5px 0 0; display: block">[ 총 <b><%=nListNum %></b>개 ]</span></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
</div>
<span class="k_adminBtn"><a href="javascript:removelogin_log_idx();"><img src="/images/kor/btn/popup_delete2.gif" /></a></span>
<div class="k_puAdmin_box" style="margin: 10px 0">
<table>
	<tr>
		<td align="center">
		<table>
			<tr>
				<td><select name="strIndex" id="strIndex" onchange="javascript:setCond();">
					<option value="CONNECT_ID">접속아이디</option>
					<option value="USERS_NAME">접속이름</option>
					<option value="CONNECT_IP">접속IP</option>
					<!--<option value="CERTIY_YN">인증서</option>-->
					<option value="LOGIN_YN">성공여부</option>
					<option value="CONNECT_TIME">접속시간</option>
	           		<!--<option value="ERROR_CODE">에러코드</option>
		            <option value="DOMAIN">도메인</option> -->
				</select></td>
				<td>
				<div id="div_cond1"><input type="text" name="strKeyword" id="input" class="k_intx00" style="width: 250px" value="<%=strKeyword %>" onKeyDown="javascript:if(event.keyCode == 13) { condSearch(); return false}" />
				</div>
				<div id="div_cond2">
				<div id="STARTDT_DIV" style="width:200px"></div>
				&nbsp;~&nbsp;
				<div id="ENDDT_DIV" style="width:200px"></div>
				</div>
				</td>
				<td><a href="javascript:condSearch();"><img	src="/images/kor/btn/popup_search.gif" /></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</form>

<script language=javascript>
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
setCond();
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "S_CONNECT_DATE", "E_CONNECT_TIME", "", "");
</script>