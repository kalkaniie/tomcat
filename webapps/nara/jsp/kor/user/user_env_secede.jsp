<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />

<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<script language="javascript">
function secede() {
	var objForm = document.user_secede;
	
	if (objForm.USERS_PASSWD.value.length < 1) {
		alert("비밀번호을 입력하세요.");
		objForm.USERS_PASSWD.focus();
		return;
	} else if (objForm.USERS_NAME.value.length < 1) {
		alert("이름을 입력하세요.");
		objForm.USERS_NAME.focus();
		return;
	} else {
		if(!confirm("회원 탈퇴를 하시겠습니까?")) {
			return ;
		}
		//입력정보 체크
		var queryString = "method=aj_secede_chk"
		                + "&USERS_IDX=" + objForm.USERS_IDX.value
		                + "&USERS_PASSWD=" + objForm.USERS_PASSWD.value
		                + "&USERS_NAME=" + objForm.USERS_NAME.value;
  		CallSimpleAjax("userenv.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			objForm.USERS_PASSWD.focus();
			return ;
		} else {
			objForm.method.value="user_secede";
			objForm.action = "userenv.auth.do";
		    objForm.submit();
		}
  	}
  	alert("회원탈퇴가 완료되었습니다.");
	opener.parent.document.location.href = "user.public.do?method=logout";
  	self.close();
}
</script>
<form method=post name="user_secede">
<input type=hidden name='method' value=''>
<input type=hidden name='USERS_IDX' value='<%=USERS_IDX %>'>
<div class="k_puTit">
	<h2>회원탈퇴 <span>회원탈퇴를 할 수 있습니다.</span></h2>
</div>
<table class="k_tb_other" style="wdith: 500px">
	<tr>
		<th width="130" scope="row">아이디</th>
		<td><%=USERS_IDX%></td>
	</tr>
	<tr>
		<th scope="row">비밀번호</th>
		<td><input type="password" name="USERS_PASSWD" style="width: 150px" /></td>
	</tr>
	<tr>
		<th scope="row">이름</th>
		<td><input type="text" name="USERS_NAME" style="width: 150px" /></td>
	</tr>
	<tr>
		<th scope="row"></th>
		<td>회원 탈퇴 시 더 이상 아이디(<strong><%=USERS_ID%></strong>)를 사용할 수 없으며 <br />
		편지,일정관리,주소록 등 <strong><%=USERS_NAME%></strong>님의 모든 데이터는 완전히 삭제됩니다.</td>
	</tr>
</table>
<table width="100%" height="30">
  <tr>
    <td align="right"><a href="javascript:secede();"><img src="/images/kor/btn/popup_confirm.gif"/></a></td>
  </tr>
</table>
</form>