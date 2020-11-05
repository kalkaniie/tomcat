<%@ page contentType="text/html;charset=utf-8"%>




<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_error_code" class="java.lang.String"
	scope="request" />
<link rel='stylesheet' type='text/css' href='/css/km5.css' />


<script type="text/javascript" src="/js/eng/util/ControlUtils.js"></script>
<script type="text/javascript" src="/js/eng/util/WebUtil.js"></script>
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript"
	src="/js/ext/src/locale/ext-lang-en.js"></script>
</head>
<body>

<script language='javascript'>

</script>

<script language='javascript'>
function changePasswd() {
	var objForm = document.f;
	
	if (objForm.CURRENT_USERS_PASSWD.value == "") {
		alert("현재 사용중인 비밀번호를 입력하세요.");
		objForm.CURRENT_USERS_PASSWD.focus();
		return;
	} else if (objForm.NEW_USERS_PASSWD.value == "") {
		alert("신규 비밀번호를 입력하세요.");
		objForm.NEW_USERS_PASSWD.focus();
		return;
	} else if (objForm.NEW_USERS_PASSWD_CONFIRM.value == "") {
		alert("신규 비밀번호를 확인하세요.");
		objForm.NEW_USERS_PASSWD_CONFIRM.focus();
		return;
	} else if (objForm.NEW_USERS_PASSWD.value != objForm.NEW_USERS_PASSWD_CONFIRM.value) {
		alert("변경하실 비밀번호가 일치하지 않습니다.");
		objForm.NEW_USERS_PASSWD_CONFIRM.focus();
		return;
	} else if (objForm.CURRENT_USERS_PASSWD.value == objForm.NEW_USERS_PASSWD.value) {
		alert("현재 사용중인 비밀번호와 변경하실 비밀번호가 동일합니다.");
		objForm.NEW_USERS_PASSWD_CONFIRM.focus();
		return;
	}

	Ext.Ajax.request({
   		scope :this,
   		url: 'user.public.do',
   		method : 'POST',
   		params:{
   			method:'aj_password_chk',
   			USERS_PASSWD:objForm.CURRENT_USERS_PASSWD.value
   		},
   		success : function(response, options) {
   			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
   	  		var resultXML = reader.read(response);
   	  		if (resultXML.records[0].data.RESULT == "success") {
   	  			objForm.method.value = "change_password";
   	  			objForm.action = "user.public.do";
   	  			
   	  			objForm.submit();
   	  		}else{
   	  			alert(resultXML.records[0].data.MESSAGE);
   	  		}
     	},
   		failure : function(response, options) {
   		 	alert("정의되지 않은 오류가 발생하였습니다.");
   		}
   	});
}
</script>

<form name=f mehotd=post><input type="hidden" name="method"
	value="">
<div class='k_msgBox'>
<div><img src='/images/kor/box/msgBox_top.gif' /></div>
<div class='k_msgBox_left'>
<div class='k_msgBox_right'>
<div class='k_msgBox_cont'><%=jdf_user_msg %></div>
<div class=''>현재 비밀번호 : <input type="password"
	name="CURRENT_USERS_PASSWD" style="ime-mode:inactive"><br>
신규 비밀번호 : <input type="password" name="NEW_USERS_PASSWD" style="ime-mode:inactive"><br>
신규 비밀번호 확인 : <input type="password" name="NEW_USERS_PASSWD_CONFIRM" style="ime-mode:inactive"><br>
<a href='javascript:changePasswd();'><img
	src='/images/kor/btn/btnA_confirm.gif' /></a> <a
	href='user.public.do?method=login' ><img
	src='/images/kor/btn/btnA_confirm.gif' /></a></div>
</div>
</div>
<div class='k_msgBox_botm'><a href='/'><img
	src='/images/kor/btn/btnA_confirm.gif' /></a></div>
</div>
</form>

</body>


