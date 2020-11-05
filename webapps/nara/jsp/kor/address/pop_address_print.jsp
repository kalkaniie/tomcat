<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.AddressEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />주소록 인쇄</td>
	</tr>
</table>
<table class="bl">
	<tr>
		<td colspan="4" class="line"></td>
	</tr>
	<tr>
		<th class="man">이름</th>
		<th class="title">이메일</th>
		<th class="time">전화번호</th>
		<th class="time">핸드폰번호</th>
  </tr>
 <%
 	Iterator iterator = list.iterator();
 	if (!iterator.hasNext()) {
 %>  
  <tr>
     <td colspan="4" class="txt">조회된 결과가 없습니다.</td>
  </tr>
 <%
 	} else {
 		while(iterator.hasNext()) {
 			AddressEntity entity = (AddressEntity)iterator.next();
 %>
  <tr>
    <td class="man"><%=entity.ADDRESS_NAME%></td>
    <td class="title"><%=entity.ADDRESS_EMAIL%></td>
    <td class="time"><%=entity.ADDRESS_TEL%></td>
    <td class="time"><%=entity.ADDRESS_CELLTEL%></td>
  </tr>
<%
		}
	}
   	%>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:self.print()"><img src="/images_std/kor/pop/btn_print.gif"/></a><a href="javascript:window.close()"><img src="/images_std/kor/pop/btn_cancel.gif"/></a></td>
	</tr>
</table>