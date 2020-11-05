<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>


<%@page import="java.util.*"%>
<%@page	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.RecentAddressService"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="webMailEntity"
	class="com.nara.jdf.db.entity.WebMailEntity" scope="request" />
<jsp:useBean id="VIEW_TYPE" class="java.lang.String" scope="request" />

<%
	String strFrom = webMailEntity.M_SENDER;
	try{
  		javax.mail.internet.InternetAddress[] addr = javax.mail.internet.InternetAddress.parseHeader(webMailEntity.M_SENDER,false);
  		strFrom = addr[0].getAddress();
	}catch(Exception e){}
%>

<script type="text/javascript" src="/js/common/common.js"></script>
<SCRIPT LANGUAGE=JavaScript>
	function showText(value){
	  	objForm=document.pop_mail_refuse;
	  	if(value == 1){
	    	if(objForm.refuse_send.checked == true)
	      		send.style.display = "inline";
	    	else
	      		send.style.display = "none";
	  	}else if(value == 2){
	    	if(objForm.refuse_prosecution.checked == true)
	      		prosecution.style.display = "inline";
	    	else
	      		prosecution.style.display = "none";
	  	}
	}

function WindowClose(){
	if(opener.entOrStd() =="ent" ){
		newWindowClose();
	}else{
		self.close();
	}
}
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<form method=post name="pop_mail_refuse" action="webmail.auth.do">
<input type=hidden name='method' value='pop_mail_refuse_regist'>
<input type='hidden' name='M_IDX' value='<%=webMailEntity.M_IDX %>'>
<input type='hidden' name='MBOX_IDX' value='<%=webMailEntity.MBOX_IDX %>'>
<input type='hidden' name='M_TIME' value='<%=webMailEntity.M_TIME %>'>
<input type='hidden' name='FILTER_AUTH' value='3'>
<input type='hidden' name='FILTER_TYPE' value='1'>
<input type='hidden' name='FILTER_KEYWORD' value='<%=strFrom%>'>
<input type='hidden' name='VIEW_TYPE' value='<%=VIEW_TYPE %>'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />수신거부</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_tt" width="70">제목</td>
		<td class="pop_form_td"><%=HtmlUtility.translate(webMailEntity.M_TITLE)%></td>
	</tr>
	<tr>
		<td class="pop_form_tt">보낸사람</td>
		<td class="pop_form_td"><%=HtmlUtility.translate(webMailEntity.M_SENDER)%></td>
	</tr>
	<tr>
		<td class="pop_form_tt">보낸날짜</td>
		<td class="pop_form_td"><%=webMailEntity.M_TIME%></td>
	</tr>
	<tr>
		<td colspan="2" class="pop_form_td">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><input type="checkbox" name="refuse_delete" alt="등록 동시에 편지를 자동으로 삭제" value="Y" /></td>
				<td>편지자동삭제</td>
				<td style="text-align:center; width:20px;">|</td>
				<td><input type="checkbox" name="refuse_prosecution" alt="자동으로 관리자에게 신고" value="Y" onclick="showText(2);" /></td>
				<td>자동등록</td>
				<td style="text-align:center; width:20px;">|</td>
				<td><input type="checkbox" name="refuse_domain" alt="위 도메인에서 발송되는 모든 편지를 수신거부함" value="Y" /></td>
				<td>도메인등록</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr id='prosecution' style='display: none'>
		<td class="pop_form_tt">신고내용</td>
		<td class="pop_form_td"><textarea name="content" style="width: 95%; height: 70px" wrap="VIRTUAL"></textarea></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:document.pop_mail_refuse.submit();"><img src="/images_std/kor/pop/btn_enter.gif"/></a><a href="javascript:WindowClose()"><img src="/images_std/kor/pop/btn_cancel.gif"/></a></td>
	</tr>
</table>
</form>