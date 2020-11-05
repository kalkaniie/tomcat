<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*" %>
<jsp:useBean id="countDown"  class="java.lang.String" scope="request" />
<jsp:useBean id="sessionTime"  class="java.lang.String" scope="request" />

<script LANGUAGE="JavaScript">
	var countDown = parseInt(<%=countDown%>);
	var sessionTime =parseInt(<%=sessionTime%>);
	function setlogin(){
		location.href= "/mail/user.public.do?method=login_form";
	}
	
</script>

<div class='k_msgBox_A'>
<div class='k_msgBox'>
<div><img src='/images_std/kor/img/img_msgTop.gif' /></div>
<div class='k_msgBox_cont'>
안전한 서비스를 위해 로그인후 약  <%=Integer.parseInt(sessionTime)%>분 동안 </br>서비스 이용이 없어 자동 로그아웃 되었습니다. </br>
다시 로그인 하시려면 </br>아래  버튼을 클릭 하세요.</br>
</div>
<div class='k_msgBox_botm'>
	<a href='javascript:setlogin();'><img src='/images/kor/btn/btnA_confirm.gif' style="margin-top:25px;" /></a>
</div>
</div>
</div>