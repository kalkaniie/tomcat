<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.db.entity.PopupEntity"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.nara.web.narasession.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.springframework.service.PopupService"%>
<%@ page import="com.nara.springframework.service.DomainService"%>
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
	<% if (conf.getBoolean("com.nara.kebimail.ssl")) { %>
	objForm.action="<%=DomainService.getHttpsUrl(request.getServerName())%>mail/user.public.do";	
	<% } else { %>
	objForm.action="user.public.do";
	<% } %>
  	objForm.method.value="login";
  	objForm.submit();
}

function notice_getcookie( name ){
    var nameOfcookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length ) {
		var y = (x+nameOfcookie.length);
		if ( document.cookie.substring( x, y ) == nameOfcookie ) {
			if ((endOfcookie=document.cookie.indexOf( ";", y )) == -1 ) {
		    	endOfcookie = document.cookie.length;
		    }
			
			return unescape( document.cookie.substring( y, endOfcookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 ) {
			break;
		}
    }
    return "";
}

<%
	List popList = PopupService.popup_list("F");
	
	if ( popList != null ) {
		Iterator iterator = popList.iterator();
		if(iterator.hasNext()){
		    PopupEntity entity = null;
		    while(iterator.hasNext()) {
		        entity = (PopupEntity)iterator.next();
		      	String str = "";
%>   
				if ( notice_getcookie( "Notice<%=entity.POPUP_IDX%>" ) != "done" ) {	
					var link = "/jsp/kor/popup/popup_page.jsp?POPUP_IDX=" + <%=entity.POPUP_IDX%> ;
					var t_left =(<%=entity.POPUP_LEFT%> > 0)?<%=entity.POPUP_LEFT%> : 10;
					var t_top = (<%=entity.POPUP_TOP%> > 0)?<%=entity.POPUP_TOP%> : 10;
					var t_width =(<%=entity.POPUP_WIDTH%> > 0)?<%=entity.POPUP_WIDTH%> : 350;
					var t_height = (<%=entity.POPUP_HEIGHT%> > 0)?<%=entity.POPUP_HEIGHT%> : 350;
					var env_val = "status=yes,toolbar=no,scrollbars=yes,left="+t_left+",top="+t_top+",width="+t_width+",height="+t_height;
					window.open(link,"<%=entity.POPUP_IDX%>",env_val);
				}
<%     
	    	}
	  	}
	}
%>

function chkCapsLock(e){
	var keyCode = 0;
	var isShiftKey = false;
	if(document.all){
		keyCode = e.keyCode;
		isShiftKey = e.shiftKey;
	} else if (document.layers){
		keyCode = e.which;
		isShiftKey = (keyCode == 16) ? true : false;
	} else if(document.getElementById){
		keyCode = e.which;
		isShiftKey = (keyCode == 16) ? true : false;
	}
	if(((keyCode >= 65 && keyCode <= 90) && !isShiftKey) || ((keyCode >= 97 && keyCode <= 122) && isShiftKey)){
		msg.innerHTML = "<img src='/images_std/kor/login/btn_capslock.gif'>";		
	} else {
		msg.innerHTML = '';
	}
}
-->
</script>
</head>
<style type="text/css">
<!--
*html, body {margin:0; padding:0; height:100%;}
body {background:url(/images_std/kor/login/bg_bg.gif) repeat;}
img {border:0;}

p {margin:0 0 5px 0; _margin:0 0 2px 0;}
* + html p {margin:0 0 3px 0;}

#bgimg { position:absolute; top:50%; left:50%; width:799px; height:491px; overflow:hidden; margin-top:-250px; margin-left:-400px; background:url(/images_std/kor/login/img_loginBg.png) no-repeat; _background:none; _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='/images_std/kor/login/img_loginBg.png',sizingMethod='image'); z-index:1;} 
#center { position:absolute; top:50%; left:50%; width:799px; height:491px; overflow:hidden; margin-top:-250px; margin-left:-400px; z-index:100;} 

#inputIdPw {position:absolute; top:217px; right:122px; _right:115px; width:134px;} 
* + html #inputIdPw {position:absolute; top:217px; right:122px; width:134px;}
#inputIdPw input {border:1px solid #b4b4b4; width:120px; height:16px; line-height:16px; padding-left:3px; color:#333;}

#loginBtn {position:absolute; top:217px; right:60px; width:60px; height:46px;}
#saveId {position:absolute; top:272px; _top:299px; right:199px; width:60px; height:13px;}
* + html #saveId {position:absolute; top:272px; right:199px; width:60px; height:13px;}
#saveId img { _vertical-align:middle;}
* + html #saveId img { vertical-align:middle;}
#wholeBtn {position:absolute; top:308px; _top:339px; right:71px; width:185px;}
* + html #wholeBtn {position:absolute; top:339px; right:71px; width:185px;}
-->
</style>
<center>
<form method=post name="login" action="/mail/user.public.do">
<input type='hidden' name='method' value='login'> 
<input type='hidden' name='strUri' value='<%=strUri%>'> 
<input type='hidden' name='ssl'> 
<input type='hidden' name='DOMAIN' value='<%=DOMAIN %>'>
<input type='hidden' name='login_mode' value='ent'>
<body>
<div id="bgimg">
	<div id="center">
		<div id="inputIdPw">
			<p><input name="USERS_ID" type="text" value="<%=USERS_IDX%>" ime-mode:disabled" tabIndex="1" value=""/></p>
  			<p><input name="USERS_PASSWD" type="password" tabIndex="2" value="" onkeydown="if(event.keyCode==13){userLogin();}"/></p>
		</div>
		<div id="loginBtn"><img src="/images_std/kor/login/btn_login.gif" tabIndex="3" onclick="userLogin();" style="cursor:pointer;"/></a></div>
		<div id="saveId"><input name="keepid" type="checkbox" value="1" <%=USERS_IDX.length()>0?"checked":""%> /><img src="/images_std/kor/login/img_saveId.gif"/></div>
	</div>
</div>	
</body>
<script language="javascript">
function setLoginFocus(){
  document.login.USERS_ID.focus();
  if(document.login.USERS_ID.value != "" && document.login.keepid) document.login.USERS_PASSWD.focus();
}
setLoginFocus();
</script>
</form>
</center> 