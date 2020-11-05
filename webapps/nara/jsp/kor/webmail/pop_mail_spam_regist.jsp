<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page
	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
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

<script language="javascript">
function goSpamRegist() {
  Ext.Ajax.request({
		scope :this,
		url:'webmail.auth.do',
		method:'POST',
		form:'pop_mail_spam',
		success : function(response, options) {
	  		Ext.Msg.alert('message', "스팸신고 되었습니다");
	  		newWindowClose();
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
</script>
<form method=post name="pop_mail_spam" action="webmail.auth.do">
<input type=hidden name='method' value='aj_pop_mail_prosecution_regist'>
<input type='hidden' name='M_IDX' value='<%=webMailEntity.M_IDX %>'>
<input type='hidden' name='MBOX_IDX'
	value='<%=webMailEntity.MBOX_IDX %>'> <input type='hidden'
	name='M_TIME' value='<%=webMailEntity.M_TIME %>'> <input
	type='hidden' name='FILTER_AUTH' value='3'> <input
	type='hidden' name='FILTER_TYPE' value='1'> <input
	type='hidden' name='FILTER_KEYWORD' value='<%=strFrom%>'> <input
	type='hidden' name='VIEW_TYPE' value='<%=VIEW_TYPE %>'>
<table class="k_puTableB">
	<tr>
		<th width="20%" scope="row">제목</th>
		<td width="80%"><%=HtmlUtility.translate(webMailEntity.M_TITLE)%></td>
	</tr>
	<tr>
		<th scope="row">보낸사람</th>
		<td><%=HtmlUtility.translate(webMailEntity.M_SENDER)%></td>
	</tr>
	<tr>
		<th scope="row">보낸날짜</th>
		<td><%=webMailEntity.M_TIME%></td>
	</tr>
	<tr>
		<th scope="row">신고사유</th>
		<td><textarea name="content"
			style="width: 314px; height: 70px; overflow: auto"></textarea></td>
	</tr>
	<tr>
		<td colspan="2"><label><input type="checkbox"
			name="refuse_delete" value="Y" alt="불량메일신고와 동시에 편지를 자동으로 삭제" />
		편지자동삭제 </label>&nbsp;&nbsp; <label><input type="checkbox"
			name="refuse_regist" value="Y" alt="자동으로 수신거부 목록에 추가" /> 자동등록</label>&nbsp;&nbsp;
		<label><input type="checkbox" name="refuse_domain" value="Y"
			alt="위 도메인에서 발송되는 모든 편지를 수신거부함" /> 도메인등록</label></td>
	</tr>
</table>

<div class="k_puBtn"><a href="#"><img
	src="/images/kor/btn/btnA_confirm.gif"
	onClick="javascript:goSpamRegist();" /></a> <a href="#"><img
	src="/images/kor/btn/btnA_cancel.gif"
	onclick="javascript:newWindowClose()" /></a></div>
</form>