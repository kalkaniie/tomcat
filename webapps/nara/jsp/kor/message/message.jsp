<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_debug_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_error_code" class="java.lang.String" scope="request" />
<jsp:useBean id="pre_method" class="java.lang.String" scope="request" />
<%
	String login_mode = UserSession.getString(request, "USERS_LOGIN_MODE");	//ent, std, text
	jdf_user_msg = jdf_user_msg.replaceAll("\n", "<br>").replaceAll(System.getProperty("line.separator"), "");
%>

<script language="javascript">
var isPopup = false;
//parent.document.getElementById("main");
//if (parent.document.getElementById("main") != null || document.getElementById("main_ent") != null || document.getElementById("main_std") != null || document.getElementById("main_text") != null) {
//	isPopup = false;
//} else {
//	isPopup = true;
//}

function isOk() {
	if ("<%=jdf_error_code%>" == "S019") {
		if(opener != null){
			opener.location ="user.public.do?method=logout";
			self.close();
		}else if(parent.document.getElementById("mainPanel") != null){
			parent.location.href ="user.public.do?method=logout";
		}else{
			location.href ="user.public.do?method=logout";
		}
	}else{
		if(opener != null){
			opener.location ="/";
			self.close();
		}else if(parent.document.getElementById("mainPanel") != null){
			parent.location.href ="/";
		}else{
			location.href ="/";
		}
	}	
}
</script>

<link rel="stylesheet" href="/css_std/km5_std.css" type="text/css">
<form name="f_message" method="">
<input type="hidden" name="method" id="method" value="top_message"> 
<input type="hidden" name="jdf_user_msg" id="jdf_user_msg" value=""> 
<input type="hidden" name="jdf_debug_msg" id="jdf_debug_msg" value="">
</form>
<div class='k_msgBox_A'>
<div class='k_msgBox'>
<div><img src='/images_std/kor/img/img_msgTop.gif' /></div>
<div class='k_msgBox_cont'><%=jdf_user_msg%></div>
<div class='k_msgBox_botm'>
	<a href='javascript:isOk();'><img src='/images/kor/btn/btnA_confirm.gif' style="margin-top:25px;" /></a>
</div>
</div>
</div>