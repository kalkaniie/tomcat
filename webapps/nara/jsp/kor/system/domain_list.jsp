<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.DomainEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="strHomeDir" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script language="javascript">
<!--
//조건검색
function condSearch() {
	var objForm = document.f;
	
	objForm.nPage.value = "1";
	objForm.action = "domain.system.do?method=domain_list";
	objForm.submit();
}
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''>
<input type=hidden name='M_TO' value=''> 
<input type=hidden name='nPage' value='<%=nPage%>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>도메인관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>등록된 도메인 리스트입니다.</li>
</ul>
<div>
<table class="k_tb_other6" style="margin-top: 5px">
	<tr>
		<th width="22" scope="col"><img src="/images/kor/ico/ico_checkBl.gif" onClick="checkAll(document.f, 'DOMAIN');" /></th>
		<th width="130" scope="col">도메인</th>
		<th width="130" scope="col">대표명</th>
		<th scope="col">현재상태</th>
		<th width="150" scope="col">개통일</th>
		<th scope="col">사용자</th>
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
			DomainEntity domainEntity = (DomainEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="DOMAIN" value="<%=domainEntity.DOMAIN %>" /></td>
		<td class="k_txAliC"><a href="domain.system.do?method=domain_detail&DOMAIN=<%=domainEntity.DOMAIN %>"><%=domainEntity.DOMAIN %></a></td>
		<td class="k_txAliC"><%=domainEntity.DOMAIN_NAME %></td>
		<td class="k_txAliC">
<%
	if(domainEntity.DOMAIN_CERTIFY.equals("Y")) {
   		out.println("서비스중");
	} else if(domainEntity.DOMAIN_CERTIFY.equals("W")) {
   		out.println("서비스대기");
	} else if(domainEntity.DOMAIN_CERTIFY.equals("N")) {
   		out.println("서비스중지");
	}
%>
		</td>
		<td class="k_txAliC"><%=domainEntity.DOMAIN_JOINDATE%></td>
		<td class="k_txAliC"><%=domainEntity.nUserNum %>명</td>
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
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<table>
	<tr>
		<td align="center">
			<select name="strIndex" id="select">
			<option value="DOMAIN_NAME">대표명</option>
			<option value="DOMAIN">도메인</option>
			</select> 
			<input type="text" name="strKeyword" id="input" class="k_intx00" style="width: 250px" value="<%=strKeyword %>" /> 
			<a href="javascript:condSearch();"><img src="/images/kor/btn/popup_search.gif" /></a>&nbsp;&nbsp; 
			<!-- 
            <input type="checkbox" name="checkbox7" id="checkbox7" />
            <label for="checkbox7">결과내 검색</label>
            -->
        </td>
	</tr>
</table>
</div>
<p class="k_fltR" style="padding:10px 5px 10px"><a href="domain.system.do?method=domain_regist_form"><img src="/images/kor/btn/popup_applyDomain.gif" /></a></p>
</form>

<script language=javascript>
<!--
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
-->
</script>