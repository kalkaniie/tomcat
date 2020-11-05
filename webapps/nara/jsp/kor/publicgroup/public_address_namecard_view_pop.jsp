<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.PublicAddressEntity" scope="request" />

<%
String[] PUBLICADDRESS_HOMEZIP = {"",""};
if(entity.PUBLICADDRESS_HOMEZIP.indexOf("-") != -1)
  PUBLICADDRESS_HOMEZIP = entity.PUBLICADDRESS_HOMEZIP.split("-",2);
%>

<div class="k_puLayout">
<div class="k_puLayHead">사용자정보</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<table class="k_puTableB">
	<tr>
		<th width="130" scope="row">이름</th>
		<td><%=entity.PUBLICADDRESS_NAME%></td>
	</tr>
	<tr>
		<th scope="row">부서</th>
		<td><%=entity.PUBLICADDRESS_DEPT%></td>
	</tr>
	<tr>
		<th scope="row">직책</th>
		<td><%=entity.PUBLICADDRESS_DUTY%></td>
	</tr>
	<tr>
		<th scope="row">E-Mail</th>
		<td><%=entity.PUBLICADDRESS_EMAIL%></td>
	</tr>
	<tr>
		<th scope="row">전화</th>
		<td><%=entity.PUBLICADDRESS_TEL%></td>
	</tr>
	<tr>
		<th scope="row">휴대폰</th>
		<td><%=entity.PUBLICADDRESS_CELLTEL%></td>
	</tr>

	<tr class="k_puTableTr">
		<th scope="row">주소</th>
		<td>(<%=PUBLICADDRESS_HOMEZIP[0]%> - <%=PUBLICADDRESS_HOMEZIP[1]%>)<br>
		<%=entity.PUBLICADDRESS_HOMEADDR%>
		</td>
	</tr>	
</table>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img src="/images/kor/btn/btnA_close.gif" onclick="window.close()" /></a></div>
</div>
