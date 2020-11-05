<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.db.entity.PopupEntity"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.nara.web.narasession.*"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="strUri" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_TEL" class="java.lang.String" scope="request" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>웹메일시스템에 오신것을 환영합니다.</title>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<script language="JavaScript" src="/js/kor/util/ControlUtils.js"></script> 
<script language="JavaScript" src="/js/common/common.js"></script>
<script language="JavaScript" src="/js/common/embed.js"></script>
<script language=javascript>
<!--
function getCookieValLogin (offset){
    var endstr = document.cookie.indexOf (';', offset);
    if (endstr == -1)
    endstr = document.cookie.length;
    return unescape(document.cookie.substring(offset, endstr));
}
function GetCookieLogin(name){
  var arg = name + '=';
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while (i < clen) {
	  var j = i + alen;
	  if (document.cookie.substring(i, j) == arg)
		  return getCookieValLogin(j);
	  i = document.cookie.indexOf(' ', i) + 1;
      if (i == 0) break;
    }
    return null;
}
var historyYN = GetCookieLogin('loginHistory');
if(historyYN != null && historyYN =="Y") history.go(1);

function userLogin(){
	var objForm = document.login;
	if(objForm.USERS_ID.value.length < 1){
      alert("아이디를 입력해 주십시오");
	  objForm.USERS_ID.focus();
	  return;
	}else if(objForm.USERS_PASSWD.value.length < 1){
	  alert("비밀번호를 입력해 주십시오");
	  objForm.USERS_PASSWD.focus();
	  return;
	}
	objForm.action="user.public.do";
  	objForm.method.value="login";
  	objForm.submit();
}
-->
</script>
</head>
<style>
<!--
*{padding:0; margin:0;}
html,body{font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif;}
img {border:none; vertical-align:middle;}

.login {margin:130px auto 0; width:743px; height:397px; background:url(/images/img_logInBg.gif) no-repeat left top; position:relative;}
.login_input {position:absolute; left:500px; top:174px; _top:172px;}
* + html .login_input {position:absolute; left:500px; top:173px;}
.login_input input {height:15px; line-height:15px; border:1px solid #b4b4b4; background-color:#fff; padding:1px 0; font-size:12px; color:#666666;}
.login_input p {margin-bottom:4px;}
.login_btn {position:absolute; left:644px; top:172px;}
.saveId {position:absolute; left:498px; top:224px;}
.saveId img {padding:0 0 2px 3px; _padding:0 0 2px 1px;}
* + html .saveId img {padding:0 0 2px 1px;}
.search {position:absolute; left:500px; top:262px;}
.search img {margin-bottom:1px;}
-->
</style>
<center>
<form method=post name="login" action="javascript:userLogin()">
<input type='hidden' name='method' value='login'> 
<input type='hidden' name='strUri' value='<%=strUri%>'> 
<input type='hidden' name='ssl'> 
<input type='hidden' name='DOMAIN' value='<%=DOMAIN %>'>
<input type='hidden' name='login_mode' value='ent'>

<div class="login">
<div class="login_input">
  <p><input name="USERS_ID" type="text" value="<%=USERS_IDX%>" style="width:134px;ime-mode:inactive" tabIndex="1" value="" /></p>
  <p><input name="USERS_PASSWD" type="password" style="width:134px" tabIndex="2" value=""/></p>
</div>
<div class="login_btn"><input type="image" src="/images/btn_logIn.gif" tabIndex="3"/></div>
<div class="saveId"><input name="keepid" type="checkbox" value="1" <%=USERS_IDX.length()>0?"checked":""%> /><img src="/images/img_saveId.gif" align="absmiddle" /></div>
<div class="search"><a href="user.public.do?method=show_provision"><img src="/images/btn_join.gif" style="margin-right:10px" /></a><a href="#"><img src="/images/btn_searchIdPw.gif" /></a></div>
</div> 

<script language="javascript">
function setLoginFocus(){
  document.login.USERS_ID.focus();
  if(document.login.USERS_ID.value != "" && document.login.keepid) document.login.USERS_PASSWD.focus();
}
setLoginFocus();
</script>
</form>
</center>