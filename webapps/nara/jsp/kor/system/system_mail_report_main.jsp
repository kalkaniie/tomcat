<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.MailReportEntity"%>
<%@page import="com.nara.springframework.service.AdminMailReportService"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="MAIL_REPORT_STATE" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />

<script language="JavaScript">
<!--
function checkAll() {
  objForm = document.f;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "MAIL_REPORT_IDX"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function remove() {
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "MAIL_REPORT_IDX")){
    alert("삭제할 메일을 선택하십시오.");
    return;
  }
  var isRemove = confirm("선택하신 신고된 불량메일이 삭제됩니다.\n삭제하시겠습니까?");    
  if(isRemove){
    objForm.action="mailreport.system.do?method=bad_mail_remove";
    document.f.submit();;
  }
}

function search(){
  var objForm = document.f;
  if(objForm.strIndex.value=="") {
    alert("검색옵션을 션택하세요.");
    objForm.strIndex.focus();
    return;
  } else if(objForm.strKeyword.value == "") {
    alert("검색어를 입력하세요.");
    objForm.strKeyword.focus();
    return;
  }
  objForm.nPage.value=0;
  objForm.action="mailreport.system.do?method=bad_mail_list";	
  objForm.submit();
}

function regist() {
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "MAIL_REPORT_IDX")){
    alert("불량메일로 등록할 메일을 선택하십시오.");
    return;
  }
  var isRemove = confirm("선택하신 메일이 불량메일로 등록됩니다.\n등록하시겠습니까?");    
  if(isRemove) {
    objForm.MAIL_REPORT_STATE_RE.value="3";
    objForm.action="mailreport.system.do?method=bad_mail_regist";
    document.f.submit();;
  }
}

/**
 2010-02-10 MODIFY ELLEPARK
**/
function change() {
  var objForm = document.f;  
  objForm.action="mailreport.system.do?method=bad_mail_list";	
  objForm.submit();
}

function detail(_mail_report_idx) {
  var link = "mailreport.system.do?method=detail&MAIL_REPORT_IDX=" + _mail_report_idx;
  MM_openBrWindow(link,'sys_reportdetail','scrollbars=yes,resizable=yes,width=770,height=570')
}
//-->
</script>

<form method=post name="f" action="#">
<input type=hidden name='method' value='bad_mail_list'> 
<input type=hidden name='nPage' value='<%=nPage%>'> 
<input type=hidden name='MAIL_REPORT_STATE_RE' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>불량메일차단</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>사용자로 부터 신고된 불량메일 리스트 입니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a href="mailreport.system.do?method=bad_mail_list">불량메일차단</a></b></li>
	<li><a href="mailreport.system.do?method=filter_list&FILTER_GUBUN=admin">수신거부목록</a></li>
	<!--<li><a href="admin204-3.html">유해성단어</a></li>-->
	<li class="k_fltR"><select name='MAIL_REPORT_STATE' onChange="JavaScript:change();;">
		<!-- onChange="JavaScript:document.f.submit();;"> -->
		<option value="0">전체리스트</option>
		<option value="1">신고된 불량메일</option>
		<option value="3">등록된 불량메일</option>
		<option value="6">미등록된 불량메일</option>
		<option value="4">등록된 불량도메인</option>
	</select></li>
</ul>
<div class="k_tab_boxTop">
  <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><a href="javascript:checkAll();"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" /></a></th>
		<th scope="col">신고자</th>
		<th width="110" scope="col">신고날짜</th>
		<th scope="col">불량메일 발송자</th>
		<th width="110" scope="col">발송날짜</th>
		<th width="50" scope="col">처리상태</th>
	</tr>
<%
	if (list.size() == 0) {
%>
	<tr>
		<td colspan="6" align="center">조회된 결과가 없습니다.</td>
	</tr>
<%
	} else {
		MailReportEntity entity = new MailReportEntity();
		Iterator iterator = list.iterator();
			
		while(iterator.hasNext()) {
			entity = (MailReportEntity)iterator.next();
%>
	<tr>
		<td>
		  <input type="checkbox" name="MAIL_REPORT_IDX" value="<%=entity.MAIL_REPORT_IDX%>" id="checkbox" /> 
		  <input type=hidden name="MAIL_REPORT_FROM_<%=entity.MAIL_REPORT_IDX%>" value="<%=entity.MAIL_REPORT_FROM%>">
		</td>
		<td class="k_txAliC"><a href="javascript:detail('<%=entity.MAIL_REPORT_IDX %>');">&nbsp;<%=com.nara.jdf.jsp.HtmlUtility.translate(entity.USERS_NAME+"<"+entity.USERS_IDX+">")%></a></td>
		<td class="k_txAliC"><%=entity.MAIL_REPORT_DATE%></td>
		<td class="k_txAliC"><a href="javascript:detail('<%=entity.MAIL_REPORT_IDX %>');">&nbsp;<%=com.nara.jdf.jsp.HtmlUtility.translate(entity.MAIL_REPORT_FROM)%></a></td>
		<td class="k_txAliC"><%=entity.MAIL_REPORT_SENDDATE%></td>
		<td class="k_txAliC"><%=AdminMailReportService.getMailState(entity.MAIL_REPORT_STATE)%></td>
	</tr>
<%
		}
	}
%>

</table>
<p style="width:767px;">
<span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>개 ]</span> 
<span class="k_fltR" style="padding-bottom: 1px"> 
  <a href="javascript:regist();"><img src="/images/kor/btn/popup_entry.gif" /></a> 
  <a href="javascript:remove();"><img src="/images/kor/btn/popup_delete2.gif" /></a>
</span></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%>
</div>
<div class="k_puAdmin_sBox" style="margin: 10px 170px"><select name='strIndex'>
	<option value="">검색옵션</option>
	<option value="USERS_NAME">신고자 이름</option>
	<option value="USERS_IDX">신고자 편지</option>
	<option value="MAIL_REPORT_FROM">불량메일</option>
	<option value="MAIL_REPORT_DOMAIN">불량도메인</option>
</select> 
<input type="text" name="strKeyword" value="<%=strKeyword%>" style="width: 200px" class="k_intx00" onKeyDown="javascript:if(event.keyCode == 13) { search(); return false}" />
<a href="javascript:onClick=search();"><img	src="/images/kor/btn/popup_search.gif" /></a></div>
</div>
<div class="k_tab_boxBott">
  <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>
</form>
<script language=javascript>
<!--
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
setSelectedIndexByValue( document.f.MAIL_REPORT_STATE, "<%=MAIL_REPORT_STATE%>" );
-->
</script>