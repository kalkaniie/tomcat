<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="cn" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_INDEX_PAGE" class="java.lang.String"
	scope="request" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language=javascript>
	<!--
		function userLogin(){
			  var objForm = document.login;
				objForm.action="notice.public.do";
				objForm.method.value="notice_redirect_page";
				objForm.cn.value="<%=cn%>";
				objForm.USERS_INDEX_PAGE.value="<%=USERS_INDEX_PAGE%>";
				objForm.submit();
			  
		}
		-->
	</script>





<form method=post name="login"><input type='hidden'
	name='method' value='notice_redirect_page'> <input
	type='hidden' name='cn' value='<%=cn%>'> <input type='hidden'
	name='USERS_INDEX_PAGE' value='<%=USERS_INDEX_PAGE%>'></form>
.....암호화 중입니다............잠시만 기다려 주세요.....
<script language=javascript>
	<!--
		userLogin();
		-->
	</script>