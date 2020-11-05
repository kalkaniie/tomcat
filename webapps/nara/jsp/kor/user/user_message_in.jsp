<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="message" class="java.lang.String" scope="request" />
<jsp:useBean id="href" class="java.lang.String" scope="request" />

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/km5.css" type="text/css">
<% if(href.length() <= 0)
     href = "javascript:history.back(-1)";
%>
<SCRIPT LANGUAGE="JavaScript"> 
function nextWin() { 
   location = '<%=href%>';
  
} 
</SCRIPT>
</head>
<div class="k_errorLay">
<div class="k_errorLay_in">
<div class="k_errorWin">
<div class="k_msgTit">
<p><span></span></p>
</div>
<div class="k_errorCont"><img
	src="/images/kor/shared/blue-loading.gif"><br />
잠시만 기다려 주십시오 <br />
<%=message%></div>
<div class="k_errorBotm">
<div class="k_errorBotm_in">
<div class="k_errorBtn"><a href='<%=href%>'><img
	src="/images/kor/btn/btnA_confirm.gif" /></a></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
setTimeout('nextWin()', 3000);
-->
</SCRIPT>