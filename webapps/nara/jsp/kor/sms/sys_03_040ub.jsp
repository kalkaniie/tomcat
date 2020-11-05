<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="FLAG_NO" class="java.lang.String" scope="request" />
<jsp:useBean id="FLAG" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<script language="javascript">
<!--
function updateEmotiFalg() {
	var objForm = document.f;
	
	if(objForm.FLAG.value == "") {
		alert("분류명을 입력하세요.");
		objForm.FLAG.focus();
		return;
	}
	
	var queryString = "method=aj_update_emoti_flag&FLAG_NO=" + objForm.FLAG_NO.value + "&FLAG=" + objForm.FLAG.value ;
	CallSimpleAjax("sms.system.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return ;
	} else {
		opener.document.location.reload();
		window.close();
	}
}
//-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f" method="post" action="sms.system.do"><input
	type=hidden name='method' value=''> <input type=hidden
	name='FLAG_NO' value='<%=FLAG_NO %>'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />이모티콘 분류명 입력</td>
	</tr>
</table>
      <table width="100%" class="k_tb_other" style="border-top:none;">
	<tr>
		<th width="80" scope="row">분류명</th>
		<td><input type="text" name="FLAG" value="<%=FLAG %>"
			onkeypress="if(event.keyCode == 13) return false;" /></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_enter.gif" onClick="updateEmotiFalg();" /></a><a href="#"><img src="/images_std/kor/pop/btn_cancel.gif" onclick="window.close()" /></a></td>
	</tr>
</table>
</form>