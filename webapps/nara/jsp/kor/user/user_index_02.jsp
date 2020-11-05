<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.db.entity.PopupEntity"%>
<%@ page import="java.util.Iterator"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="strUri" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_TEL" class="java.lang.String" scope="request" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>예금보험공사 웹메일에 오신것을 환영합니다.</title>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<script language="JavaScript" src="/js/kor/util/ControlUtils.js"></script> 
<script language="JavaScript" src="/js/common/common.js"></script>

<script language=javascript>
<!--
function userLogin(str , flag){
  var objForm = document.login;
	  
  //if(objForm.ssl != null && objForm.ssl.checked)
  //  objForm.action = "";
  //else
  //  objForm.action = "";
	
  //if(str == "ssl") objForm.ssl.value='1';
		    
  //if(flag == 1){  //인증
  // 	objForm.signed_msg.value = Sign_with_option(0, objForm.plain.value);
  // 	objForm.certYN.value = 'Y';
  //  if(objForm.signed_msg.value=="")
  //    return;
	   
  //}else if(flag == 2){ //ID
	if(objForm.USERS_ID.value.length < 1){
      alert("아이디를 입력해 주십시오");
	  objForm.USERS_ID.focus();
	  return;
	}else if(objForm.USERS_PASSWD.value.length < 1){
	  alert("비밀번호를 입력해 주십시오");
	  objForm.USERS_PASSWD.focus();
	  return;
	}
	objForm.certYN.value = 'N';
  //}
		
  objForm.action="user.public.do";
  objForm.method.value="login";
  objForm.submit();
}

function ActiveXDownLoad() {
  location.href = "/activeX/KBinstaller.exe";
}
-->
</script>

<style type="text/css">
<!--
*{padding:0; margin:0; overflow:hidden;}
html,body{ font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif;}
img{border:none; vertical-align:middle;}

.login { margin:0 auto 0; width:680px; height:605px; background:url(../images/kor/index/img_indexBg02.jpg) no-repeat left top; position:relative;}
.login_input { position:absolute; left:279px; top:362px; _top:361px; *top:361px;}
.login_input input { height:15px; line-height:15px; border:1px solid #c1c1c1; background-color:#fafafa; padding:1px 0; font-size:12px; color:#666666;}
.login_input p { margin-bottom:5px; _margin-bottom:3px; *margin-bottom:3px;}
.login_btn { position:absolute; left:445px; top:361px; _top:360px; *top:360px; width:68px; height:45px;}
.saveId { position:absolute; left:279px; _left:275px; *left:275px; top:413px; _top:410px; *top:410px;}
.search { position:absolute; left:279px; top:440px; _top:442px; *top:442px;}
.mail { position:absolute; left:525px; top:578px; _top:576px; *top:576px;}
.installBtn { position:absolute; left:525px; top:578px;}

.txtBl { font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif; font-size:12px; font-weight:bold; color:#23569e; position:absolute; left:601px; top:15px;}
.txtBl a:link, .txtBl a:visited { color:#2a599c; text-decoration: none; }
.txtBl a:active, .txtBl a:hover { color:#2a599c; text-decoration: underline;}

.txtVio { font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif; font-size:12px; font-weight:bold; color:#814bdb; position:absolute; left:416px; top:39px;}
.txtVio a:link, .txtVio a:visited { color:#844edf; text-decoration: none; }
.txtVIO a:active, .txtVio a:hover { color:#844edf; text-decoration: underline;}

.txtGr {font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif; font-size:12px; font-weight:bold; color:#226f10; position:absolute; left:474px; top:0;}
.txtGr a:link, .txtGr a:visited { color:#226f10; text-decoration: none; }
.txtGr a:active, .txtGr a:hover { color:#226f10; text-decoration: underline;}
-->
</style>
</head>

<body>

<form method=post name="login" action="javascript:userLogin()">
<input type='hidden' name='method' value='login'> 
<input type='hidden' name='strUri' value='<%=strUri%>'> 
<input type='hidden' name='ssl'> 
<input type='hidden' name='DOMAIN' value='<%=DOMAIN %>'> 
<input type='hidden' name='certYN' value=''>
<div class="login">
  <div class="txtVio"><img src="/images/kor/index/ico_install.gif" /><a href="#" onclick="javascript:ActiveXDownLoad()">ActiveX 수동설치</a></div>
  <div class="login_input">
    <p><input name="USERS_ID" type="text" tabIndex="1" value="<%=USERS_IDX%>" style="width:156px; ime-mode:inactive"/></p>
    <p><input name="USERS_PASSWD" type="password" tabIndex="2" value="" id="pw" style="width:156px; ime-mode:inactive"/></p>
  </div>
  <div class="login_btn">
  	<input type="image" src="/images/kor/index/btn_login.gif" id="Image1" tabIndex="3" />
  </div>
  <div class="saveId"><input name="keepid" type="checkbox" value="1" <%=USERS_IDX.length()>0?"checked":""%>><img src="/images/kor/index/btn_id.gif" /></div>
  <div class="search">
    <a href="user.public.do?method=show_regist_form" ><img src="/images/kor/index/btn_join.gif" style="padding-right:10px" /></a>
    <a href="user.public.do?method=showPasswdHint" ><img src="/images/kor/index/btn_search.gif" /></a>
  </div>
  <div class="mail">
    <a href="mailto:mailmaster@kdic.or.kr"><img src="/images/kor/index/ico_mail.gif" /></a>
  </div>
</div>
</form>
<script language="javascript">
function setLoginFocus(){
  document.login.USERS_ID.focus();
  if(document.login.USERS_ID.value != "" && document.login.keepid) document.login.USERS_PASSWD.focus();
}
setLoginFocus();
</script>
</body>
</html>
