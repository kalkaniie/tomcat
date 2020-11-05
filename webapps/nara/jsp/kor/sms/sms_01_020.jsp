<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_HOMEDIR" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="url" class="java.lang.String" scope="request" />

<%
    String action = "/sms/user.do";
    String target = "/nara/servlet/sms.SmsServ";
    String img_path = "/nara/img/kor/sms";
    int msgLength = 80;
    
    //idx,domain,home_dir,user_name,time

    //문자를 Byte로 변환을 시킨다.
	sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
	String key = "";
	byte[] bytebuf;
	bytebuf = USERS_IDX.getBytes();
	key = encoder.encode(bytebuf).replaceAll("\r\n", "") + ":";
	bytebuf = DOMAIN.getBytes();
	key = key + encoder.encode(bytebuf).replaceAll("\r\n", "") + ":";
	bytebuf = USERS_HOMEDIR.getBytes();
	key = key + encoder.encode(bytebuf).replaceAll("\r\n", "") + ":";
	bytebuf = USERS_NAME.getBytes();
	key = key + encoder.encode(bytebuf).replaceAll("\r\n", "") + ":";
	bytebuf = (Long.toString(System.currentTimeMillis())).getBytes();
	key = key + encoder.encode(bytebuf).replaceAll("\r\n", "");
%>

<!--
<%=DOMAIN%>
<%=USERS_IDX%>
<%=USERS_HOMEDIR%>
<%=USERS_NAME%>
-->
<link rel="stylesheet" href="../css/base.css" type="text/css">
<form name=userForm method=post><input type=hidden name=id
	value=""></form>

<!-- 사용자 결과를 기다르는 화면에 대한 출력 시작 -->

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="9" align="left" valign="top"
			background="../image/kor/main_def_tabl_a_bg.gif"><img
			src="../image/kor/main_def_tabl_a_00.gif" width="9" height="228"></td>
		<td valign="top" background="../image/kor/main_def_tabl_a_bg.gif">
		<table width="100%" height="100%" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="92" align="center" bgcolor="#FFFFFF">
				<table width="100%" height="92" border="0" cellpadding="0"
					cellspacing="0">
					<tr valign="top">
						<td width="10" align="left"
							background="../image/kor/main_def_tabl_title_bg.gif"><img
							src="../image/kor/main_def_tabl_title_00.gif" width="10"
							height="92"></td>
						<td background="../image/kor/main_def_tabl_title_bg.gif">
						<table width="98%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table width="98%" height="53" border="0" cellpadding="0"
									cellspacing="0">
									<tr>
										<td background="../image/kor/main_def_tabl_title_02.gif">
										<table width="100%" height="53" border="0" cellpadding="0"
											cellspacing="0">
											<tr>
												<td height="6"></td>
											</tr>
											<tr>
												<td align="left" valign="middle">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td height="20"><img
															src="../image/kor/main_def_icon_00.gif" width="7"
															height="9" align="absmiddle"> <span class="style13">SMS
														전송결과를 확인 하실 수 있습니다.</span></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td height="4"></td>
											</tr>
										</table>
										</td>
										<td width="9" align="right"><img
											src="../image/kor/main_def_tabl_title_01.gif" width="9"
											height="53"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="9"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
						</td>
						<td width="228" align="right"
							background="../image/kor/main_def_tabl_title_bg.gif"><img
							src="../image/kor//main_def_tabl_title_sms.gif" width="228"
							height="92"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td align="center" bgcolor="#FFFFFF">
				<table width=600 height=400 align=center>
					<tr>
						<td height=400 align="center"><a href="JavaScript:Submit();"><img
							src="../image/kor/sms/loadingmsg.gif" width="415" height="127"
							border=0></a></td>
					</tr>
				</table>
				</td>
		</table>
		</td>
		<td width="9" align="right" valign="top"
			background="../image/kor/main_def_tabl_a_bg.gif"><img
			src="../image/kor/main_def_tabl_a_01.gif" width="9" height="228"></td>
	</tr>
</table>
<!-- 사용자 결과를 기다르는 화면에 대한 출력 끝 -->

<SCRIPT language=javascript>
<!--
function Submit(){
  document.userForm.id.value = '<%=key.replaceAll("\r\n","")%>';
  document.userForm.action = "http://<%=url%><%=action%>";
  document.userForm.submit();
}
//-->
</SCRIPT>

<SCRIPT>
  document.userForm.id.value = '<%=key.replaceAll("\r\n","")%>';
  document.userForm.action = "http://<%=url%><%=action%>";
  document.userForm.submit();
</SCRIPT>
