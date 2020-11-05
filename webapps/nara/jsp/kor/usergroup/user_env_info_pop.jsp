<%@page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="com.nara.util.UserInfoOpen"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String" scope="request" />

<%
com.nara.util.UserInfoOpen openinfo = new com.nara.util.UserInfoOpen(userEntity.USERS_ISOPEN);
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />사용자 정보</td>
	</tr>
</table>
<table class="k_tb_other" style="border-top:none;">
        <!--tr>
		   <th width="90" scope="row">사진</th>
		   <td><img src="http://192.168.200.18/imgserv.do?kind=emp&amp;ext=er.jpg&amp;memberId=<%=userEntity.USERS_LICENCENUM%>" style="width: 90px; height: 120px;margin:7px 0">	</td>
		 </tr-->
         <tr>
		    <th width="90" scope="row">이름</th>
			<td><%=userEntity.USERS_NAME%></td>
		  </tr>
		  <tr>
			<th scope="row">이메일</th>
			<td><%=userEntity.USERS_IDX%></td>
		  </tr>
		  <%--<tr>
			<th scope="row">성별</th>
			<td>
<% 
if(userEntity.USERS_SEX.equals("M"))
	out.println("남자");
else if(userEntity.USERS_SEX.equals("F"))
    out.println("여자");
%>			</td>
		  </tr>
		  <tr>
			<th scope="row">생년월일</th>
			<td><%=userEntity.USERS_BIRTH%></td>
		  </tr>--%>
		  <tr>
			<th scope="row">전화</th>
			<td><%=userEntity.USERS_TELNO%></td>
		  </tr>
          <tr>
			<th scope="row">휴대폰</th>
			<td><%=userEntity.USERS_CELLNO%></td>
		  </tr>
		  <%--tr>
			<th scope="row">사내번호</th>
			<td><%=userEntity.USERS_INSIDETELNO%></td>
		  </tr--%>
		  <tr>
			<th scope="row">FAX</th>
			<td><%=userEntity.USERS_FAXNO%></td>
		  </tr>
		  <tr>
			<th scope="row">주소</th>
			<td><%="("+userEntity.USERS_ZIPCODE+")<br>"+userEntity.USERS_ADDRESS1+" "+userEntity.USERS_ADDRESS2%></td>
		  </tr>
		  <tr>
			<th scope="row"><% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>회사<% } else { %>학교<% } %></th>
			<td><%=userEntity.USERS_COMPNAME%></td>
		  </tr>
		  <tr>
			<th scope="row"><% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>부서<% } else { %>학과<% } %></th>
			<td><%=userEntity.USERS_DEPARTMENT%></td>
		  </tr>
		  <%--<tr>
			<th colspan="2" scope="row">자기소개</th>
		  </tr>
		  <tr>
			<td colspan="2" scope="row">
			  <div style="height: 80px; overflow: auto"><%=userEntity.USERS_MEMO%></div>
			</td>
		  </tr>--%>
      </table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_close.gif" onclick="window.close()" /></a></td>
		</tr>
	</table>