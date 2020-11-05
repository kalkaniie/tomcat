<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_AUTH" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_BOARD_AUTH" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_TRAC_AUTH" class="java.lang.String" scope="request" />
<jsp:useBean id="td_idx" class="java.lang.String" scope="request" />


<script type="text/javascript" src="/js/common/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<script language="javascript">
<!--
function changeAuth() {
	var objForm = document.f;
	var USERS_AUTH = "";
	var USERS_BOARD_AUTH ="N";
	
	if(!confirm("사용자 권한을 변경 하시겠습니까?")) return;
	
	for(var i=0; i<objForm.USERS_AUTH.length; i++) {
		if(objForm.USERS_AUTH[i].checked) {
			USERS_AUTH = objForm.USERS_AUTH[i].value;
			break;
		}
	}
	if(USERS_AUTH == "B")
		USERS_BOARD_AUTH = "Y";
	if(USERS_AUTH == "T")
		USERS_BOARD_AUTH = "T";
		
	var queryString = "method=aj_change_auth&USERS_IDX=" + objForm.USERS_IDX.value 
										+ "&USERS_AUTH=" + USERS_AUTH
										+ "&CURRENT_AUTH=<%=USERS_AUTH%>" 
										+ "&USERS_BOARD_AUTH=" + USERS_BOARD_AUTH;
									
 		CallSimpleAjax("user.system.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		objForm.USERS_PASSWD.focus();
		return ;
	} else {
		opener.resetUserAuth(objForm.USERS_IDX.value, USERS_AUTH, objForm.td_idx.value);
		self.close();
	}
}
//-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='USERS_IDX' value='<%=USERS_IDX%>'> 
<input type=hidden name='td_idx' value='<%=td_idx%>'> 
<input type=hidden name='USERS_BOARD_AUTH' value='N'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />사용자권한 변경</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_td" style="padding:10px;">
<label><input type="radio" name="USERS_AUTH" id="radio" value="U" /> 일반유저</label>&nbsp;&nbsp; 
<label><input type="radio" name="USERS_AUTH" id="radio2" value="A" /> 도메인관리자</label>&nbsp;&nbsp;
<label><input type="radio" name="USERS_AUTH" id="radio3" value="S" /> 시스템관리자</label> 
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
<%
	if(USERS_BOARD_AUTH != null && USERS_BOARD_AUTH.equals("T"))
		USERS_AUTH  = "T";
	if(USERS_BOARD_AUTH != null && USERS_BOARD_AUTH.equals("Y"))
		USERS_AUTH  = "B";
%>
setCheckedRadioByValue( document.f.USERS_AUTH, "<%=USERS_AUTH%>" );
</script>
