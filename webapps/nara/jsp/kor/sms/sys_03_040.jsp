<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.SmsEmotiFlagEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<script type="text/javascript" src="js/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>
<script language="javascript">
<!--
//등록 팝업
function addEmotiFlag() {
	var link = "sms.system.do?method=sys_03_040cb";
	MM_openBrWindow(link,'pop_emoti_flag','width=350,height=80');
}

//수정모드
function updateEmotiFlagMode(flagNo,flagName) {
	var link = "sms.system.do?method=sys_03_040ub&FLAG_NO="+flagNo+"&FLAG="+flagName;
	MM_openBrWindow(link,'pop_emoti_flag','width=350,height=80');
}

//수정
function updateEmotiFlag() {

}

//삭제
function deleteEmotiFlag(obj) {
	
	var tableNode = obj.parentNode.parentNode.parentNode;
	var trObj = obj.parentNode.parentNode;
	var _flag_no = trObj.childNodes[0].childNodes[0].value;
	
	var queryString = "method=aj_del_emoti_flag&FLAG_NO=" + _flag_no;
	CallSimpleAjax("sms.system.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return ;
	} else {
		if (tableNode.childNodes.length == 2) {
			location.href="sms.system.do?method=sys_03_040";
		} else {
			tableNode.removeChild(trObj);
		}
	}
}

function resetList(_flag_no, _flag) {
	alert(_flag_no);
}
//-->
</script>

<form name="f" method="post">
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>SMS관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>이모티콘을 관리하고 분류합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="sms.system.do?method=sys_03_010">전송내역관리</a></li>
	<li><a href="sms.system.do?method=sys_03_020">사용량관리</a></li>
	<li><a href="sms.system.do?method=sys_03_060">SMS기본 Quota관리</a></li>
	<li class="k_tab_menuOn"><b><a href="sms.system.do?method=sys_03_040">이모티콘분류관리</a></b></li>
	<li><a href="sms.system.do?method=sys_03_050">이모티콘관리</a></li>
</ul>
<div class="k_tab_boxTop">
  <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="60" scope="col">분류번호</th>
		<th scope="col">분류명</th>
		<th width="100" scope="col">수정</th>
		<th width="100" scope="col">삭제</th>
	</tr>
<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	<tr>
		<td class="k_txAliC" colspan="4" align="center">검색된 결과가 없습니다.</td>
	</tr>
<%
	} else {
		SmsEmotiFlagEntity entity = new SmsEmotiFlagEntity();
		while(iterator.hasNext()) {
			entity = (SmsEmotiFlagEntity)iterator.next();
			
%>
	<tr>
		<input type="hidden" name="FLAG_NO" value="<%=entity.FLAG_NO %>" />
		<input type="hidden" name="FLAG" value="<%=entity.FLAG %>" />
		<td class="k_txAliC"><%=entity.FLAG_NO %></td>
		<td class="k_txAliC"><%=entity.FLAG %></td>
		<td class="k_txAliC"><a href="javascript:updateEmotiFlagMode('<%=entity.FLAG_NO %>','<%=entity.FLAG %>');"><img src="/images/kor/ico/ico_modify.gif" /></a></td>
		<td class="k_txAliC"><a href="javascript:deleteEmotiFlag(this)"><img	src="/images/kor/ico/ico_paperBasket.gif" width="16" height="16" /></a></td>
	</tr>
<%
		}
	}
%>
</table>
<p><span class="k_fltR"><a href="javascript:addEmotiFlag();"><img src="/images/kor/btn/popup_entry.gif" /></a></span></p>
<div style="clear: both"></div>
</div>
<div class="k_tab_boxBott">
  <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>

</form>