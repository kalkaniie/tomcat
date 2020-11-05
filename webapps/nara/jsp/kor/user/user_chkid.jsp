<%@ page contentType="text/html;charset=utf-8"%>



<%@ page import="java.io.*"%>

<!-- JSP import or useBean tags here. -->
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.UserEntity"scope="request" />
<jsp:useBean id="strIsValid" class="java.lang.String" scope="request" />
<jsp:useBean id="target_form" class="java.lang.String" scope="request" />
<!---[[ END: JSP import or useBean tags here. ]]--->

<%
	if (target_form == null || target_form.equals("")) {
		target_form = "f";
	}
%>


<SCRIPT LANGUAGE=JavaScript src=../js/kor/util/ControlUtils.js></SCRIPT>
<SCRIPT LANGUAGE=JavaScript src=../js/kor/user/user_id_check.js></SCRIPT>

<SCRIPT LANGAUGE=JavaScript>
function chkID(){
  	if(checkUserId(document.f.USERS_ID)){
    	document.f.action="user.public.do";
    	//document.f.submit();
    	document.f.submit();;
  	}
}

function insID(){
	if(checkUserId(document.f.USERS_ID)){
		if(opener.document.<%=target_form%>.USERS_ID != null) {
        	opener.document.<%=target_form%>.USERS_ID.value=document.f.USERS_ID_H.value;
      	}
      	if(opener.document.<%=target_form%>.ID_DUPL_CHK != null) {
      		opener.document.<%=target_form%>.ID_DUPL_CHK.value = "true";
      	}
      	if(opener.document.<%=target_form%>.ID_DUPL_CHK_VALUE != null) {
      		opener.document.<%=target_form%>.ID_DUPL_CHK_VALUE.value = document.f.USERS_ID_H.value;
      	}
    	if(opener.document.<%=target_form%>.ACCOUNT_IDX != null) {
       		opener.document.<%=target_form%>.ACCOUNT_IDX.value=document.f.USERS_ID_H.value;
       	}
     	if(opener.document.<%=target_form%>.USERS_PASSWD != null) {
       		opener.document.<%=target_form%>.USERS_PASSWD.focus();
       	}
       
       	self.close();
	}
}
  
</SCRIPT>
<!---[[ END: HEADER (JavaScript here) ]]--->


<form method="post" action="" name=f>
<input type=hidden name="DOMAIN" value="<%= entity.DOMAIN %>"> 
<input type=hidden name="USERS_ID_H" value="<%= entity.USERS_ID %>"> 
<input type=hidden name="method" value="chkDupId">
<input type=hidden name="target_form" value="<%= target_form %>">
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />아이디중복확인</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_td">
<% 
if(strIsValid.equals("1")){
  out.println("<b class=k_ftColor>"+entity.USERS_ID+"</b>는 사용하실 수 있습니다.");
  out.println("<input name=button type=image value='선택' onclick='javascript:insID(); return false;' src=/images/kor/btn/btnA_choice.gif>");
}else if(strIsValid.equals("2")){
  out.println("<b class=k_ftColor>"+entity.USERS_ID+"</b>는 이미 사용중입니다.");
}else if(strIsValid.equals("3")){
  out.println("<b style='letter-spacing:-0.01in;'>아이디는 영소문자와 숫자로만 이루어진 3자 이상 20자 이내여야 합니다.</b>");
}
%> <br />
다른ID <input type="text" name="USERS_ID" size="22" value="<%=entity.USERS_ID%>" onKeyDown="javascript:if(event.keyCode == 13) { chkID(); return false; }" />
<input name=button type=image value='찾기' onclick='javascript:chkID(); return false;' src='/images/kor/btn/btnA_find.gif'></td>
	</tr>
	<tr>
		<td class="btn_bgtd_c"><a href=javascript:self.close();><img src="/images_std/kor/pop/btn_close.gif" /></a></td>
	</tr>
</table>
</form>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
-->
</script>

