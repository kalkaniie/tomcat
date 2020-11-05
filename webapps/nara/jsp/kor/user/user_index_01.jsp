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
*{margin:0;padding:0;}
body {font:12px 돋움,Dotum,AppleGothic,sans-serif;}
@media print{body{color:#000;}}
html, body { margin:0; padding:0; border:0 none; height:100%; text-align: center; }

img{border:none;padding:0;margin:0}
input,textarea,select{font:12px 돋움,Dotum,AppleGothic,sans-serif;}
img,input, select, textarea{vertical-align:middle;}
input{padding:1px 0}

a {color: #333;}
a:link {color: #333;text-decoration: none;}
a:visited {color: #333;text-decoration: none;}
a:hover {text-decoration: underline;color: #333;}

.k_clr:after {content: "."; display: block; height: 0; clear: both; visibility: hidden;}
 
.k_clr{_height:1%}
* html .k_clr {height: 1%;}

.login{width:770px; text-align:left; margin:7% auto 0;}

.k_logTop{padding:0 0 6px}
.log_mainImg{border:3px solid #78afe7;padding:0; background:#fff;width:425px;float:left;zoom:1}
.log_mainImg img{ vertical-align:top;padding:0 1px 1px;_padding:0 0 1px 1px;margin:0; line-height:0; font-size:0}

.log_box{float:left;background:#e9edf2;padding:13px;}

.log_boxin{ width:294px; height:90px; background: url(/images/kor/index/logBox_login.gif) no-repeat left top; text-align:right;padding:22px 17px 0 0; position:relative }

.log_boxin_input{width:119px;padding:0 12px 0 0;_padding:0 6px 0 0;float:right}
.log_boxin_input input{border:1px solid #d2d2d2; width:119px; padding:3px 2px 2px;margin:0 0 3px}

.log_boxin_btn{width:47px; float:right;padding-top:1px;padding-bottom:1px}

.log_boxin_idSave{ position:absolute; left:112px;top:74px}

.log_boxBtn{ text-align:right;padding:13px 20px 7px 0; clear:both }
.log_boxBtn img{margin-right:23px }

.log_activex{ text-align:right; width:150px;float:right; margin-top:-25px}
.log_activex img{margin-bottom:4px}
.log_activex a{ color: #6666FF; font-weight:bold}
.log_activex a:hover{ color: #6666FF; font-weight:bold}
.log_activex a:visited{ color: #6666FF; font-weight:bold}

-->
</style>
</head>

<!--nProtect -->
<script language="javascript" src="http://update.nprotect.net/nprotect2007/kdic/netizenv.js"></script>

<!--keyboard -->
<script language="javascript" src="/cab/keyboardPorting.js"></script>

<body>
<form method=post name="login" action="javascript:userLogin()">
<input type='hidden' name='method' value='login'> 
<input type='hidden' name='strUri' value='<%=strUri%>'> 
<input type='hidden' name='ssl'> 
<input type='hidden' name='DOMAIN' value='<%=DOMAIN %>'> 
<input type='hidden' name='certYN' value=''>
<div class="login">
  <img src="/images/kor/index/logBox_top.gif" class="k_logTop"/>
  <div class="log_mainImg"><img src="/images/kor/index/logBox_imgMain.jpg" /></div>
  <div class="log_box">
    <img src="/images/kor/index/logBox_imgLog.gif" />
    <div class="log_boxin">
      <div class="log_boxin_btn">
         <input type="image" src="/images/kor/index/logBox_btnLogin.gif" id="Image1" onMouseOver="MM_swapImage('Image1','','/images/kor/index/logBox_btnLoginOvr.gif',1)" onMouseOut="MM_swapImgRestore()" tabIndex="3" />        
      </div>
      <div class="log_boxin_input">
        <input name="USERS_ID" type="text" tabIndex="1" value="<%=USERS_IDX%>" style="ime-mode:inactive"/>
        <input name="USERS_PASSWD" type="password" tabIndex="2" value="" id="pw" style="ime-mode:inactive"/>
      </div>
     <div class="log_boxin_idSave"><input type="checkbox" name="keepid" value="1" <%=USERS_IDX.length()>0?"checked":""%>> <img src="/images/kor/index/logBox_imgIdsave.gif"/></div>
    </div>
    <div class="log_boxBtn">
      <a href="user.public.do?method=show_regist_form" ><img src="/images/kor/index/logBox_btnJoin.gif" /></a>
      <a href="user.public.do?method=showPasswdHint" ><img src="/images/kor/index/logBox_btnFind.gif"/></a>
    </div>
  </div>
  <img src="/images/kor/index/logBox_copy.gif" usemap="#Map" />
<map name="Map" id="Map">
  <area shape="rect" coords="378,28,400,44" href="mailto:mailmaster@kdic.or.kr" />
</map>

<div class="log_activex"><img src="/images/kor/index/ico_activex.gif"/>
  <a href="#" onclick="javascript:ActiveXDownLoad()">ActiveX 수동설치</a></div>
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
