<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="SK_USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="SK_USERS_PERMIT" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_BOARD_AUTH" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_TRAC_AUTH" class="java.lang.String" scope="request" />
<jsp:useBean id="td_idx" class="java.lang.String" scope="request" />


<script type="text/javascript" src="/js/common/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<script language="javascript">
<!--
function changeAuth() {
	var objForm = document.f;
	var SK_USERS_PERMIT = "";
	var USERS_BOARD_AUTH ="N";
	
	if(!confirm("서비스권한을 변경 하시겠습니까?")) return;
	
	for(var i=0; i<objForm.SK_USERS_PERMIT.length; i++) {
		if(objForm.SK_USERS_PERMIT[i].checked) {
			SK_USERS_PERMIT = objForm.SK_USERS_PERMIT[i].value;
			break;
		}
	}
	
	///		사용여부 변경...
	var queryString = "method=aj_change_skUser_permit&SK_USERS_IDX=" 
										+objForm.SK_USERS_IDX.value 
										+ "&SK_USERS_PERMIT=" + SK_USERS_PERMIT;
 		CallSimpleAjax("user.system.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		objForm.USERS_PASSWD.focus();
		return ;
	} else {
		opener.top.location.reload();
		window.close();
	}
}
//-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='SK_USERS_IDX' value='<%=SK_USERS_IDX%>'> 
<input type=hidden name='td_idx' value='<%=td_idx%>'> 
<input type=hidden name='USERS_BOARD_AUTH' value='N'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />서비스상태 변경</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_td" style="padding:10px;">
		&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 
<label><input type="radio" name="SK_USERS_PERMIT" id="radio" value="Y" /> 사용중</label>&nbsp;&nbsp; 
<label><input type="radio" name="SK_USERS_PERMIT" id="radio2" value="N" /> 사용정지</label>&nbsp;&nbsp; 
<!--<label><input type="radio" name="USERS_AUTH" id="radio3" value="B" /> 게시판관리자</label> 
<label><input type="radio" name="USERS_AUTH" id="radio3" value="T" /> 로그추적관리자</label>--></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="javascript:changeAuth();"><img src="/images_std/kor/pop/btn_enter.gif" /></a><a href="javascript:window.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
		</tr>
	</table>
</form>
<script language="javascript">
<%-- <%
	if(USERS_BOARD_AUTH != null && USERS_BOARD_AUTH.equals("T"))
		USERS_AUTH  = "T";
	if(USERS_BOARD_AUTH != null && USERS_BOARD_AUTH.equals("Y"))
		USERS_AUTH  = "B";
%> --%>
setCheckedRadioByValue( document.f.SK_USERS_PERMIT, "<%=SK_USERS_PERMIT%>" ); 
</script>
