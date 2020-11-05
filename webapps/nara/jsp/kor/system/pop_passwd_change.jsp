<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>


<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />


<script type="text/javascript" src="/js/common/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>



<script language="javascript">
<!--
function changePassword() {
	var objForm = document.change_passwd;
	
	if(!confirm("비밀번호를 변경 하시겠습니까?")) return;
	
//	if(objForm.USERS_PASSWD[0].value.length < 6 ){
//	    alert('비밀번호는 영문+숫자 조합으로 최소 6자 이상입니다.');
//	    objForm.USERS_PASSWD[0].focus(); 
//	    return;     
//  	}else 
  	
  	if(objForm.USERS_PASSWD[0].value != objForm.USERS_PASSWD[1].value){
	    alert('입력하신  비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
	    objForm.USERS_PASSWD[1].focus();
	    return;
	}else{
		var queryString = "method=aj_change_password&USERS_IDX=" + objForm.USERS_IDX.value + "&USERS_PASSWD=" + objForm.USERS_PASSWD[0].value;
	
  		CallSimpleAjax("user.system.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			objForm.USERS_PASSWD.focus();
			return ;
		} else {
			self.close();
		}
  	}
}
//-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="change_passwd" method="post"><input type=hidden
	name='method' value='userList'> <input type=hidden
	name='USERS_IDX' value='<%=USERS_IDX%>'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />비밀번호변경</td>
	</tr>
</table>
      <table width="100%" class="k_tb_other" style="border-top:none;">
	<tr>
		<th width="120" scope="row">새로운 비밀번호</th>
		<td><input type="password" name="USERS_PASSWD" id="textfield" style="ime-mode:inactive"/>
		</td>
	</tr>
	<tr>
		<th scope="row">비밀번호확인</th>
		<td><input type="password" name="USERS_PASSWD" id="textfield2" style="ime-mode:inactive"/></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="javascript:changePassword();"><img src="/images_std/kor/pop/btn_enter.gif" /></a><a href="javascript:window.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
		</tr>
	</table>
</form>
