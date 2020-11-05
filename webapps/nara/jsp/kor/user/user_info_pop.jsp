<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.util.UserInfoOpen"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>
<%@page import="com.nara.base.Dir"%>
<%@page import="com.nara.util.UtilFileApp"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String"
	scope="request" />

<%
UserInfoOpen openinfo = new UserInfoOpen(userEntity.USERS_ISOPEN);
Config conf = Configuration.getInitial();
%>

<html>
<head>

<title>상세정보보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../css/base.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #ddddd3;
}
-->
</style>
<script language="JavaScript" src="../js/kor/util/util_image.js"></script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<!-- start;again -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="DDDDD3">
	<tr>
		<td width="21" align="left"><img
			src="../image/kor/pop_mail_info_00.gif" width="21" height="81"></td>
		<td background="../image/kor/pop_mail_mess_err_02.gif">
		<table width="100%" height="81" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="120"><img src="../image/kor/pop_mail_info_01.gif"
					width="120" height="81"></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="31">&nbsp;</td>
					</tr>
					<tr>
						<td><font color="#FFFFFF">사<strong><font
							color="#6CD0DF">ㅣ</font></strong>용<strong><font color="#6CD0DF">ㅣ</font></strong>자<strong><font
							color="#6CD0DF">ㅣ</font></strong>정<strong><font color="#6CD0DF">ㅣ</font></strong>보</font>
						</td>
					</tr>
					<tr>
						<td height="30"><img src="../image/kor/pop_def_textimg.gif"
							width="160" height="30"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td width="21" align="right"><img
			src="../image/kor/pop_mail_mess_err_03.gif" width="21" height="81"></td>
	</tr>
	<tr>
		<td width="21" align="left"
			background="../image/kor/pop_mail_mess_err_04.gif">&nbsp;</td>
		<td align="center" bgcolor="#FFFFFF">
		<table width="96%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="5" align="center" valign="top"></td>
			</tr>
			<tr>
				<td height="8" align="center" bgcolor="F6F9FA"></td>
			</tr>
			<tr>
				<td align="center" bgcolor="F6F9FA">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="200" align="center">
						<table width="78%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="25" height="20"><img
									src="../image/kor/main_mail_grmap_tabl00_00.gif" width="25"
									height="20"></td>
								<td height="20"
									background="../image/kor/main_mail_grmap_tabl00_02.gif"><img
									src="../image/kor/main_mail_grmap_tabl00_01.gif" width="27"
									height="20"></td>
								<td width="25" height="20" align="right"><img
									src="../image/kor/main_mail_grmap_tabl00_03.gif" width="25"
									height="20"></td>
							</tr>
							<tr>
								<td width="25" valign="top"
									background="../image/kor/main_mail_grmap_tabl00_10.gif"><img
									src="../image/kor/main_mail_grmap_tabl00_04.gif" width="25"
									height="18"></td>
								<td align="center" bgcolor="#FFFFFF">
								<table width=120 height=150 border="0" cellspacing="1"
									cellpadding="0" bgcolor="E1ECEF">
									<tr>
										<td align=center
											background="../image/kor/main_mail_grmap_tabl00_12.gif">
										<DIV ID=photo>
										<%if(openinfo.isOpenInfo(UserInfoOpen.PHOTO)){
    
    String strPhotoImage = conf.getString("com.nara.jdf.user.homedir")
      + java.io.File.separator + (userEntity.DOMAIN)
      + java.io.File.separator + Dir.PHOTO
      + java.io.File.separator + userEntity.USERS_IDX;
                  
      if(UtilFileApp.isExists(strPhotoImage)){
%> <img
											src='user.UserEnvServ?cmd=showPhoto&DOMAIN=<%=userEntity.DOMAIN%>&USERS_IDX=<%=userEntity.USERS_IDX%>'
											border=0 wight='120' height='150' OnLoad="resizeImg(this);">
										<%}else{%> 사진없음 <%}%> <%}else{%> <br>
										<br>
										<br>
										<br>
										<br>
										<br>
										비공개 <%}%>
										</DIV>
										</td>
									</tr>
								</table>
								</td>
								<td width="25" align="right" valign="bottom"
									background="../image/kor/main_mail_grmap_tabl00_11.gif"><img
									src="../image/kor/main_mail_grmap_tabl00_05.gif" width="25"
									height="15"></td>
							</tr>
							<tr>
								<td width="25" height="16"><img
									src="../image/kor/main_mail_grmap_tabl00_06.gif" width="25"
									height="20"></td>
								<td height="16" align="right"
									background="../image/kor/main_mail_grmap_tabl00_07.gif"><img
									src="../image/kor/main_mail_grmap_tabl00_08.gif" width="19"
									height="20"></td>
								<td width="25" height="16" align="right"><img
									src="../image/kor/main_mail_grmap_tabl00_09.gif" width="25"
									height="20"></td>
							</tr>
						</table>
						</td>
						<td align="center">
						<table width="94%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td bgcolor="E1ECEF">
								<table border="0" cellspacing="1" cellpadding="3" width="100%">
									<tr>
										<td width=100 height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">이름&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=userEntity.USERS_NAME%> <%=(userEntity.USERS_ENGNAME.length() > 0)?"("+userEntity.USERS_ENGNAME+")":""%>
										<%=(userEntity.USERS_NICKNAME.length() > 0)?"("+userEntity.USERS_NICKNAME+")":""%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">이메일&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=userEntity.USERS_IDX%></td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">성별&nbsp;</td>
										<td bgcolor="#FFFFFF">
										<%if(openinfo.isOpenInfo(UserInfoOpen.SEX)){
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
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">생년월일&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.BIRTH))?userEntity.USERS_BIRTH:""%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">전화&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.TEL))?userEntity.USERS_TELNO:"비공개"%></td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">휴대폰&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.CELL))?userEntity.USERS_CELLNO:"비공개"%></td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">FAX&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.FAX))?userEntity.USERS_FAXNO:"비공개"%></td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">주소&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=openinfo.isOpenInfo(UserInfoOpen.ADDR)? "("+userEntity.USERS_ZIPCODE+")<br>"+userEntity.USERS_ADDRESS1+" "+userEntity.USERS_ADDRESS2:"비공개"%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">학교/회사명&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.COMPANY))?userEntity.USERS_COMPNAME:"비공개"%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">학과/부서명&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.DEPT))?userEntity.USERS_DEPARTMENT:"비공개"%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">직업&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.JOB))?strSelectJob:"비공개"%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">관심분야&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.INTREST))?strSelectInterest:"비공개"%>
										</td>
									</tr>
									<tr>
										<td height="22" align="left" bgcolor="F0F4F6"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">최종학력&nbsp;</td>
										<td bgcolor="#FFFFFF"><%=(openinfo.isOpenInfo(UserInfoOpen.SCHOOL))?strSelectSchool:"비공개"%>
										</td>
									</tr>
									<tr align="left" bgcolor="F0F4F6">
										<td colspan=2 height="22"><img
											src="../image/kor/main_def_icon_14.gif" width="8" height="5"
											align="absmiddle">자기소개&nbsp;</td>
									</tr>
									<tr valign="top" bgcolor="#FFFFFF">
										<td height="50" colspan=2><%=(openinfo.isOpenInfo(UserInfoOpen.INTRO))?userEntity.USERS_MEMO:"비공개"%>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="8" align="center" valign="bottom" bgcolor="F6F9FA"></td>
			</tr>
			<tr>
				<td height="25" align="center" valign="bottom"><a
					href=javascript:onClick=self.close()><img
					src="../image/kor/main_def_butt_close.gif" border="0"></a></td>
			</tr>
			<tr>
				<td height="4"></td>
			</tr>
		</table>
		</td>
		<td width="21" align="right"
			background="../image/kor/pop_mail_mess_err_05.gif">&nbsp;</td>
	</tr>
	<tr>
		<td width="21" align="left"><img
			src="../image/kor/pop_mail_mess_err_06.gif" width="21" height="19"></td>
		<td background="../image/kor/pop_mail_mess_err_07.gif">&nbsp;</td>
		<td width="21" align="right"><img
			src="../image/kor/pop_mail_mess_err_08.gif" width="21" height="19"></td>
	</tr>
</table>
<script language=javascript>
window.resizeTo(600, 590);
</script>
</body>
</html>
