<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.util.UtilCalendar"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.SmsEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="JEOBSU_TIME" class="java.lang.String" scope="request" />
<jsp:useBean id="COMPANY_NO" class="java.lang.String" scope="request" />
<jsp:useBean id="USER_NO" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="strDomainSelectOption" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />

<script type="text/javascript" src="/js/common.js"></script>

<script language="javascript">
<!--
function reSearch() {
	var objForm = document.f;
	
	objForm.action = "sms.system.do?method=sys_03_010";
	objForm.submit();
}
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>SMS관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>SMS 전송내역을 관리합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a href="sms.system.do?method=sys_03_010">전송내역관리</a></b></li>
	<li><a href="sms.system.do?method=sys_03_020">사용량관리</a></li>
	<li><a href="sms.system.do?method=sys_03_060">SMS기본 Quota관리</a></li>
	<li><a href="sms.system.do?method=sys_03_040">이모티콘분류관리</a></li>
	<li><a href="sms.system.do?method=sys_03_050">이모티콘관리</a></li>
</ul>
<div class="k_tab_boxTop">
  <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="130" scope="col">전송요청시간</th>
		<th scope="col">발신자아이디</th>
		<th width="100" scope="col">발송번호</th>
		<th width="130" scope="col">발송날짜</th>
		<th width="80" scope="col">현황</th>
	</tr>
	<%
	Iterator iterator = list.iterator();

	if(!iterator.hasNext()) {
%>
	<tr>
		<td class="k_txAliC" colspan="5" align="center">검색된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		SmsEntity smsEntity = new SmsEntity();
		while(iterator.hasNext()) {
			smsEntity = (SmsEntity)iterator.next();
%>
	<tr>
		<td class="k_txAliC"><%=smsEntity.JEOBSU_TIME %></td>
		<td class="k_txAliC"><%=smsEntity.USER_NO %></td>
		<td class="k_txAliC"><%=smsEntity.CALLBACKNO %></td>
		<td class="k_txAliC"><%=smsEntity.JEOBSU_TIME %></td>
		<td class="k_txAliC"><%=(smsEntity.RESULT.startsWith("200 ") == true ? "Success" : "Fail")%></td>
	</tr>
	<%
		}
	}
%>
</table>
<p style="float: none; display: block"><span style="padding: 5px 0 0; display: block">[ 총 <b><%=nListNum %></b>개
]</span></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox">도메인 <select name="COMPANY_NO">
	<option value="">전체</option>
	<%=strDomainSelectOption %>
</select> <select name="JEOBSU_TIME">
	<option value='<%=UtilCalendar.getCalsDate(0,1,"yyyy-MM")%>'><%=UtilCalendar.getCalsDate(0,1,"yyyy-MM")%></option>
	<option value='<%=UtilCalendar.getCalsDate(2,-1,"yyyy-MM")%>'><%=UtilCalendar.getCalsDate(2,-1,"yyyy-MM")%></option>
	<option value='<%=UtilCalendar.getCalsDate(2,-2,"yyyy-MM")%>'><%=UtilCalendar.getCalsDate(2,-2,"yyyy-MM")%></option>
	<option value='<%=UtilCalendar.getCalsDate(2,-3,"yyyy-MM")%>'><%=UtilCalendar.getCalsDate(2,-3,"yyyy-MM")%></option>
	<option value='<%=UtilCalendar.getCalsDate(2,-4,"yyyy-MM")%>'><%=UtilCalendar.getCalsDate(2,-4,"yyyy-MM")%></option>
	<option value='<%=UtilCalendar.getCalsDate(2,-5,"yyyy-MM")%>'><%=UtilCalendar.getCalsDate(2,-5,"yyyy-MM")%></option>
</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ID 
<input type="text" name="USER_NO" style="width: 150px" class="k_intx00" value="<%=USER_NO %>" /> 
<a href="javascript:;" onClick="reSearch();"><img src="/images/kor/btn/popup_find2.gif" /></a></div>
</div>
<div class="k_tab_boxBott">
  <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>

</form>

<script language=javascript>
<!--
setSelectedIndexByValue( document.f.COMPANY_NO, "<%=COMPANY_NO%>" );
setSelectedIndexByValue( document.f.JEOBSU_TIME, "<%=JEOBSU_TIME%>" );
//-->
</script>

