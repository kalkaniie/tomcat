<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.util.UtilCalendar"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.SmsEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strDomainSelectOption" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />

<script type="text/javascript" src="/js/common.js"></script>

<script language="javascript">
<!--
function reSearch() {
	var objForm = document.f;
	
	objForm.action = "sms.system.do?method=sys_03_020";
	objForm.submit();
}

function editQuotaMode(obj) {
	var _sms_quota = obj.parentNode.getAttribute("sms_quota");
	obj.parentNode.innerHTML = "<input type=\"text\" name=\"USERS_SMS_QUOTA\" class=\"intx00\" style=\"text-align:right; width:120px\" onkeypress=\"checkNum(this)\" value=\"" + _sms_quota + "\"/>";
}

function updateQuota(obj) {
	var _users_idx = obj.parentNode.getAttribute("users_idx");
	var _users_sms_quota = obj.value;
	
	//숫자일때만
	if (!isCheckChar(obj.value)) {
		Ext.Ajax.request({
			scope :this,
			url: 'sms.system.do?method=aj_update_sms_quota',
			method : 'POST',
			params: { USERS_IDX: _users_idx,
			          USERS_SMS_QUOTA: _users_sms_quota
			        },
			success : function(response, options) {
				var reader = new Ext.data.XmlReader({
	    		   	record: 'RESPONSE'
	    			}, 
	    			['RESULT','MESSAGE']);
	    		var resultXML = reader.read(response);
	    		if (resultXML.records[0].data.RESULT == "success") {
	    			obj.parentNode.setAttribute("sms_quota", _users_sms_quota);
					obj.parentNode.innerHTML = "<a href=\"javascript:;\" onClick=\"editQuotaMode(this);\">" + _users_sms_quota + "</a>";
	    		}else{
	    			alert(resultXML.records[0].data.MESSAGE);
					return ;
	    		}
	    	},
			failure : function(response, options) {callAjaxFailure(response, options);}
		}); 
	} else {
		alert("숫자만 입력 가능합니다.");
		obj.focus();
		return;
	}
}
//-->
</script>
<script event="onclick" for="document">
	if (document.activeElement.name != "USERS_SMS_QUOTA") {
		var objList = document.getElementsByName("USERS_SMS_QUOTA");
		for (var i=0; i<objList.length; i++) {
			updateQuota(objList[i]);
		}
	}
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>SMS관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>SMS 사용량을 관리합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="sms.system.do?method=sys_03_010">전송내역관리</a></li>
	<li class="k_tab_menuOn"><b><a href="sms.system.do?method=sys_03_020">사용량관리</a></b></li>
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
		<!--<th width="20" scope="col"><img	src="/images/kor/ico/ico_check.gif" width="13" height="13" /></th>-->
		<th width="130" scope="col">이름</th>
		<th scope="col">이메일주소</th>
		<th width="130" scope="col">핸드폰번호</th>
		<th width="130" scope="col">쿼터수</th>
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
		UserEntity userEntity = new UserEntity();
		while(iterator.hasNext()) {
			userEntity = (UserEntity)iterator.next();
%>
	<tr>
		<!--<td><input type="checkbox" name="checkbox2" id="checkbox2" /></td>-->
		<td class="k_txAliC"><%=userEntity.USERS_NAME %></td>
		<td class="k_txAliC"><%=userEntity.USERS_IDX %></td>
		<td class="k_txAliC"><%=userEntity.USERS_CELLNO %></td>
		<td class="k_txAliC" users_idx="<%=userEntity.USERS_IDX %>"	sms_quota="<%=userEntity.USERS_SMS_QUOTA %>">
		<a href="javascript:;" onClick="editQuotaMode(this);"><%=userEntity.USERS_SMS_QUOTA %></a></td>
	</tr>
	<%
		}
	}
%>
</table>
<p><span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> 
<span class="k_fltR"><!-- <a href="#"><img src="/images/kor/btn/popup_confirm.gif" /></a> --></span></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox">도메인 <select name="DOMAIN">
	<option value="">전체</option>
	<%=strDomainSelectOption %>
</select> 
<select name="strIndex">
	<option value="USERS_ID">ID</option>
	<option value="USERS_NAME">이름</option>
</select> 
<input type="text" name="strKeyword" style="width: 120px" class="intx00" <%=strKeyword %> /> 
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
setSelectedIndexByValue( document.f.DOMAIN, "<%=DOMAIN%>" );
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
//-->
</script>