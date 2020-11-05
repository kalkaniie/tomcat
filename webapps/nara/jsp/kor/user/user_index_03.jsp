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

.indexBody { background:url(../images/kor/index/bg_index02.gif) repeat-x left top; background-color:#fff;}
.login2 {margin:30px auto 0; width:700px; height:544px; background:url(../images/kor/index/img_indexBg03.jpg) no-repeat left top; position:relative;}

.login2_input { position:absolute; left:405px; top:293px; _top:292px; *top:292px;}
.login2_input input { height:15px; line-height:15px; border:1px solid #cce3dc; background-color:#e6f5f0; padding:1px 0; font-size:12px; color:#307e66;}
.login2_input p { margin-bottom:6px; _margin-bottom:4px; *margin-bottom:4px;}
.saveId2 { position:absolute; left:379px; _left:375px; *left:375px; top:383px; _top:380px; *top:380px;}
.saveId2 img { margin-bottom:4px; _margin-bottom:2px; *margin-bottom:2px; _margin-left:-3px; *margin-left:-2px;}
.search2 { position:absolute; left:342px; top:409px; _top:411px; *top:410px;}
.login2_btn { position:absolute; left:463px; top:379px; _top:378px; *top:378px;}
.mail2 { position:absolute; left:483px; top:521px; _top:519px; *top:519px;}

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
<div class="login2">
  <div class="txtGr"><img src="/images/kor/index/ico_install.gif" /><a href="#" onclick="javascript:ActiveXDownLoad()">ActiveX 수동설치</a></div>
  <div class="login2_input">
    <p><input name="USERS_ID" type="text" tabIndex="1" value="<%=USERS_IDX%>" style="width:115px; ime-mode:inactive"/></p>
    <p><input name="USERS_PASSWD" type="password" tabIndex="2" value="" id="pw" style="width:115px; ime-mode:inactive"/></p>
  </div>
  <div class="saveId2"><input name="keepid" type="checkbox" value="1" <%=USERS_IDX.length()>0?"checked":""%>><img src="/images/kor/index/btn_id02.gif" /></div>
  <div class="search2">
    <a href="user.public.do?method=show_regist_form" ><img src="/images/kor/index/btn_join2.gif" /></a>
    &nbsp;
    <a href="user.public.do?method=showPasswdHint" ><img src="/images/kor/index/btn_search2.gif" /></a>
  </div>
  <div class="login2_btn">
  	<input type="image" src="/images/kor/index/btn_login2.gif" id="Image1" tabIndex="3" />
  </div>
  <div class="mail2">
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
