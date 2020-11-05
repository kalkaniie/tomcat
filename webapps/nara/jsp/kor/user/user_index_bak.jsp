<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="strUri" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<link rel="stylesheet" type="text/css" href="/css/km5_logBox.css" />
<script language="JavaScript" src="/js/kor/util/ControlUtils.js"></script>
<script language="JavaScript" src="/js/common/common.js"></script>
<style type="text/css">
<!--
#divswf {
	position: absolute;
	z-index: 100;
	visibility: visible;
	overflow: visible;
	display: none;
	margin: -60px 0 0 -30px
}
-->
</style>
<script language=javascript>
<!--
function userLogin(str){
  var objForm = document.login;
  if(objForm.DOMAIN.value.length < 1){
    alert("도메인명을 입력해 주십시오");
    objForm.DOMAIN.focus();
    return;
  }else if(objForm.USERS_ID.value.length < 1){
    alert("아이디를 입력해 주십시오");
    objForm.USERS_ID.focus();
    return;
  }else if(objForm.USERS_PASSWD.value.length < 1){
    alert("비밀번호를 입력해 주십시오");
    objForm.USERS_PASSWD.focus();
    return;
  }else{
    if(objForm.ssl != null && objForm.ssl.checked)
      objForm.action="";
    else
      objForm.action="";
    if(str=="ssl") objForm.ssl.value='1';
    
    objForm.action="user.public.do";
    objForm.method.value="login";
    objForm.submit();
  }
}
-->
</script>
<form method=post name="login" action="javascript:userLogin('')">
<input type='hidden' name='method' value='login'> <input
	type='hidden' name='strUri' value='<%=strUri%>'> <input
	type='hidden' name='ssl'>
<div class="k_login">
<table class="k_logBox">
	<tr>
		<td class="k_logBox_bgL"></td>
		<td class="k_logBox_bgC">
		<div><img src="/images/kor/index/index_img01.jpg" /></div>
		<div class="k_logMid">
		<div class="k_loginImg"><img
			src="/images/kor/index/index_img02.gif" /></div>
		<div class="k_logForm">
		<div class="k_logForm_in"><input name="DOMAIN"
			value="nonghyup.com" tabIndex="4" type="text"
			onFocus="this.style.borderColor='000'"
			onBlur="this.style.borderColor='#cedde5'" style="display: none" /> <input
			name="USERS_ID" type="text" tabIndex="1" value="<%=USERS_IDX%>"
			onFocus="this.style.borderColor='#00ccff'"
			onBlur="this.style.borderColor='#cedde5'" /><br />
		<input name="USERS_PASSWD" type="password" tabIndex="2"
			onFocus="this.style.borderColor='#00ccff'"
			onBlur="this.style.borderColor='#cedde5'" /></div>
		</div>
		</div>
		<div class="k_logFunt">
		<div class="k_logFunt_in"><input type="checkbox" name="keepid"
			value="1" <%=USERS_IDX.length()>0?"checked":""%>><img
			src="/images/kor/index/index_txImg_id.gif" /><br />
		<a href="user.public.do?method=show_provision"><img
			src="/images/kor/index/index_txImg_join.gif" /></a>&nbsp; <a
			href="user.public.do?method=showPasswdHint"><img
			src="/images/kor/index/index_txImg_find.gif" /></a></div>
		<div class="k_logFunt_btn"><input type=image
			src="/images/kor/index/index_btnLogin.gif" tabIndex="3" /></div>
		</div>
		<div class="k_logCopy"><img
			src="/images/kor/index/index_copy.gif" /></div>
		</td>
		<td class="k_logBox_bgR"></td>
	</tr>
</table>
</div>
</form>