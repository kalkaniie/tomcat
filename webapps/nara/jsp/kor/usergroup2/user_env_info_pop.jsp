<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ page import="com.nara.util.UserInfoOpen"%>
<%@ page import="com.nara.springframework.service.KebiCommonService"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="domainEntity"
	class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String"
	scope="request" />

<%
com.nara.util.UserInfoOpen openinfo = new com.nara.util.UserInfoOpen(userEntity.USERS_ISOPEN);
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<div class="k_puLayout">
<div class="k_puLayHead">사용자정보</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">

<div class="k_popBox">
<div class="k_popBoxTop"><img
	src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" /></div>
<div class="k_popBoxCont">
<table class="k_puUserInfo">
	<tr>
		<th width="170" style="text-align: center">
		<%if(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.PHOTO)){
    	    
    	    String strPhotoImage = conf.getString("com.nara.jdf.user.homedir")
    	      + java.io.File.separator + (userEntity.DOMAIN)
    	      + java.io.File.separator + com.nara.base.Dir.PHOTO
    	      + java.io.File.separator + userEntity.USERS_IDX;
    	                  
    	      if(com.nara.util.UtilFileApp.isExists(strPhotoImage)){
    	%> <img
			src="userenv.auth.do?method=show_my_photo&DOMAIN=<%= userEntity.DOMAIN %>&USERS_IDX=<%= userEntity.USERS_IDX %>"
			width='118' height='148' OnLoad="resizeImg(this);" /> <%}else{%> <img
			src="/images/kor/img/img_notOpen_user.gif" width="118" height="148" />
		<%}%> <%}else{%> <img src="/images/kor/img/img_notOpen_user.gif"
			width="118" height="148" /> <%}%>
		</th>
		<td>
		<table class="k_puTableB2">
			<tr>
				<th width="90" scope="row">이름</th>
				<td><%= userEntity.USERS_NAME %></td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td><%= userEntity.USERS_IDX %></td>
			</tr>
			<tr>
				<th scope="row">성별</th>
				<td>
				<%if(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.SEX)){
        	  if(userEntity.USERS_SEX.equals("M"))
        		    out.println("남자");
        		  else if(userEntity.USERS_SEX.equals("F"))
        		    out.println("여자");
        		  }else{
        		    out.println("비공개");
        		  }
        		%>
				</td>
			</tr>
			<tr>
				<th scope="row">생년월일</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.BIRTH))?userEntity.USERS_BIRTH:""%></td>
			</tr>
			<tr>
				<th scope="row">전화</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.TEL))?userEntity.USERS_TELNO:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">휴대폰</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.CELL))?userEntity.USERS_CELLNO:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">FAX</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.FAX))?userEntity.USERS_FAXNO:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">주소</th>
				<td><%=openinfo.isOpenInfo(com.nara.util.UserInfoOpen.ADDR)? "("+userEntity.USERS_ZIPCODE+")<br>"+userEntity.USERS_ADDRESS1+" "+userEntity.USERS_ADDRESS2:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">학교/회사명</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.COMPANY))?userEntity.USERS_COMPNAME:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">학과/부서명</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.DEPT))?userEntity.USERS_DEPARTMENT:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">직업</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.JOB))?strSelectJob:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">관심분야</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.INTREST))?strSelectInterest:"비공개"%></td>
			</tr>
			<tr>
				<th scope="row">최종학력</th>
				<td><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.SCHOOL))?strSelectSchool:"비공개"%></td>
			</tr>
			<tr>
				<th colspan="2" scope="row">자기소개</th>
			</tr>
			<tr>
				<td colspan="2" scope="row">
				<div style="height: 80px; overflow: auto"><%=(openinfo.isOpenInfo(com.nara.util.UserInfoOpen.INTRO))?userEntity.USERS_MEMO:"비공개"%></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<div class="k_popBoxBtm"><img
	src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR"
	style="margin: 0 0 -1px" /></div>
</div>

</div>
</div>
<div class="k_puLayBott"><a href="#"><img
	src="/images/kor/btn/btnA_close.gif" onclick="window.close()" /></a></div>
</div>