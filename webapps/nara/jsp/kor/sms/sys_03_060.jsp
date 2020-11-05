<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserGroupEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="strDomainSelectOption" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/common.js"></script>

<script language="javascript">
<!--
//도메인별 검색
function goSearch() {
	var objForm = document.f;
	
	objForm.method.value = "sys_03_060";
	objForm.action = "sms.system.do";
	objForm.submit();
}

//SMS Quota 편집모드
function smsQuotaEditMode(obj) {
	var strInnerHTML = "<input type=\"text\" name=\"USERS_GROUP_SMS_QUOTA\" value=\"" + obj.getAttribute("sms_quota") + "\" class=\"intx00\" style=\"text-align:right; width:200px\" user_group_idx=\"" + obj.getAttribute("user_group_idx") + "\" sms_quota=\"" + obj.getAttribute("sms_quota") + "\"/>";
	obj.parentNode.innerHTML = strInnerHTML;
}

//UserGroup SMS Quota 수정
function UpdateUserGroupSmsQuota(obj) {
	var _user_group_idx = obj.getAttribute("user_group_idx");
	var _user_group_sms_quota = obj.value;

	//숫자일때만
	if (!isCheckChar(obj.value)) {
		var queryString = "method=aj_update_usergroup_sms_quota" +
	                 	  "&USER_GROUP_IDX=" + _user_group_idx +
	                 	  "&USER_GROUP_SMS_QUOTA=" + _user_group_sms_quota;
	    CallSimpleAjax("sms.system.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			obj.parentNode.innerHTML = "<a href=\"javascript:;\" ondblclick=\"smsQuotaEditMode(this)\" sms_quota=\"" + _user_group_sms_quota + "\" user_group_idx=\"" + _user_group_idx + "\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + _user_group_sms_quota + "</a>";
		}
	} else {
		obj.focus();
		return;
	}
}

//-->
</script>
<script event="onclick" for="document">
	if (document.activeElement.name != "USERS_GROUP_SMS_QUOTA") {
		var objList = document.getElementsByName("USERS_GROUP_SMS_QUOTA");
		for (var i=0; i<objList.length; i++) {
			UpdateUserGroupSmsQuota(objList[i]);
		}
	}
</script>

<form name="f" method="post"><input type=hidden name='method'
	value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>SMS관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>SMS 기본Quota를 관리합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="sms.system.do?method=sys_03_010">전송내역관리</a></li>
	<li><a href="sms.system.do?method=sys_03_020">사용량관리</a></li>
	<li class="k_tab_menuOn"><b><a href="sms.system.do?method=sys_03_060">SMS기본 Quota관리</a></b></li>
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
		<!-- <th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" /></th> -->
		<th scope="col">그룹명</th>
		<th scope="col">기본쿼터수</th>
	</tr>
<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="2" align="center">검색된 결과가 없습니다.</td>
	</tr>
<%
	} else {
		UserGroupEntity userGroupEntity = new UserGroupEntity();
		while(iterator.hasNext()) {
			userGroupEntity = (UserGroupEntity)iterator.next();
%>
	<tr>
		<!-- <td><input type="checkbox" name=USER_GROUP_IDX value="<%=userGroupEntity.USER_GROUP_IDX %>" /></td> -->
		<td align="center"><%=userGroupEntity.USER_GROUP_NAME.replaceAll(" ", "&nbsp;") %></td>
		<td class="k_txAliC"><a href="javascript:;"	ondblclick="smsQuotaEditMode(this)"	sms_quota="<%=userGroupEntity.USER_GROUP_SMS_QUOTA %>" user_group_idx="<%=userGroupEntity.USER_GROUP_IDX %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=userGroupEntity.USER_GROUP_SMS_QUOTA %></a></td>
	</tr>
<%
		}
	}
%>
</table>
<!-- <p><span class="k_fltR"><a href="#"><img src="/images/kor/btn/popup_confirm.gif" /></a></span></p> -->
<div class="k_puAdmin_sBox">도메인 <select name="DOMAIN">
	<option value="">전체</option>
	<%=strDomainSelectOption %>
</select> 
<a href="javascript:;" onClick="goSearch();"><img src="/images/kor/btn/popup_confirm.gif" /></a>
</div>
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
//-->
</script>