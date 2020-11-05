<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_debug_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="href" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_LASTDATE" class="java.lang.String"
	scope="request" />

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/base.css" type="text/css">
<script language=javascript>
<!--
function update(){
  if(confirm("<%=USERS_NAME%>(<%=USERS_ID%>)님은 휴면상태입니다.\n\n휴면 상태를 해제 하시겠습니까? "))
  	document.f.submit();
  else{
        history.back(-1);
  }
}
-->
</SCRIPT>
<% 
  if (href == null || href.length() < 1)
    href = "javascript:history.back(-1);";
%>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<form method=post name="f" action="user.UserServ"><input
	type=hidden name='cmd' value='permitUser'> <input type=hidden
	name='USERS_NAME' value='<%=USERS_NAME%>'> <input type=hidden
	name='USERS_ID' value='<%=USERS_ID%>'> <input type=hidden
	name='USERS_IDX' value='<%=USERS_IDX%>'> <input type=hidden
	name='USERS_LASTDATE' value='<%=USERS_LASTDATE%>'> <input
	type=hidden name='DOMAIN' value='<%=DOMAIN%>'>
<table width="100%" height="100%" border="0" cellpadding="0"
	cellspacing="0" background="../image/kor/loginpage/BG.gif">
	<tr>
		<td align="center"><!-- 시작 -->
		<table width="594" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="594" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="../image/kor/loginpage/table_d_00.gif"
							width="175" height="224"></td>
						<td><img src="../image/kor/loginpage/table_d_01.gif"
							width="235" height="224"></td>
						<td><img src="../image/kor/loginpage/table_d_02.gif"
							width="184" height="224"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="594" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="61" valign="top"
							background="../image/kor/loginpage/table_a_05.gif"><img
							src="../image/kor/loginpage/table_d_03.gif" width="61"
							height="247"></td>
						<td align="center" valign="middle" bgcolor="#FFFFFF">
						<table width="98%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="45" valign="top"><img
									src="../image/kor/loginpage/table_d_05_00_stop.gif" width="274"
									height="40"></td>
							</tr>
						</table>
						<table width="97%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="16"><img
									src="../image/kor/loginpage/table_b_00.gif" width="16"
									height="16"></td>
								<td background="../image/kor/loginpage/table_b_01.gif">&nbsp;</td>
								<td width="16"><img
									src="../image/kor/loginpage/table_b_02.gif" width="16"
									height="16"></td>
							</tr>
							<tr>
								<td width="16" valign="top"
									background="../image/kor/loginpage/table_b_05.gif"><img
									src="../image/kor/loginpage/table_b_03.gif" width="16"
									height="161"></td>
								<td height="165" align="center" valign="top"
									background="../image/kor/loginpage/table_b_bg.gif">
								<table width="99%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="130"><img
													src="../image/kor/loginpage/table_c_00_00_stop.gif"
													width="130" height="119"></td>
												<td width="15" align="center" valign="middle"
													background="../image/kor/loginpage/user_mes_06.gif"><img
													src="../image/kor/loginpage/user_mes_07.gif" width="15"
													height="9"></td>
												<td>
												<table width="100%" height="100" border="0" cellpadding="0"
													cellspacing="0">
													<tr>
														<td width="12" height="8"><img
															src="../image/kor/loginpage/user_mes_table_00_01.gif"
															width="12" height="8"></td>
														<td height="8"
															background="../image/kor/loginpage/user_mes_table_00_02.gif"></td>
														<td width="8" height="8"
															background="../image/kor/loginpage/user_mes_table_00_03.gif"></td>
													</tr>
													<tr>
														<td width="12"
															background="../image/kor/loginpage/user_mes_table_00_04.gif">&nbsp;</td>
														<td>
														<table width="100%" border="0" cellpadding="0"
															cellspacing="5">
															<tr>
																<td width="6%" valign="top"><img
																	src="../image/kor/loginpage/bullet_01.gif" width="9"
																	height="9" align="absmiddle"></td>
																<td><font color="#FF9705"><b>
																Information Message</b></font></td>
															</tr>
															<tr>
																<td valign="top"><img
																	src="../image/kor/loginpage/bullet_01.gif" width="9"
																	height="9" align="absmiddle"></td>
																<td><%=USERS_NAME%>(<%=USERS_ID%>)님은 현재 사용중지 상태
																입니다.<br>
																최근 접속 시간은 <%=USERS_LASTDATE%> 입니다.<br>
																사용중지 상태를 해제하려면 관리자에게 문의하십시오.</td>
															</tr>
														</table>
														</td>
														<td width="8"
															background="../image/kor/loginpage/user_mes_table_00_06.gif">&nbsp;</td>
													</tr>
													<tr>
														<td width="12" height="8"><img
															src="../image/kor/loginpage/user_mes_table_00_07.gif"
															width="12" height="8"></td>
														<td height="8"
															background="../image/kor/loginpage/user_mes_table_00_08.gif"></td>
														<td width="8" height="8"><img
															src="../image/kor/loginpage/user_mes_table_00_09.gif"
															width="8" height="8"></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td height="5"></td>
									</tr>
									<tr>
										<td height="30" align="center" valign="bottom"><a
											href='<%=href%>'><img
											src="../image/kor/loginpage/user_provision_butt_ok.gif"
											width="58" height="23" border="0"></a></td>
									</tr>
								</table>
								</td>
								<td width="16" valign="top"
									background="../image/kor/loginpage/table_b_06.gif"><img
									src="../image/kor/loginpage/table_b_04.gif" width="16"
									height="163"></td>
							</tr>
							<tr>
								<td width="16"><img
									src="../image/kor/loginpage/table_b_07.gif" width="16"
									height="16"></td>
								<td background="../image/kor/loginpage/table_b_08.gif">&nbsp;</td>
								<td width="16"
									background="../image/kor/loginpage/table_b_09.gif">&nbsp;</td>
							</tr>
						</table>
						</td>
						<td width="61" valign="top"
							background="../image/kor/loginpage/table_a_06.gif"><img
							src="../image/kor/loginpage/table_d_04.gif" width="61"
							height="247"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><img src="../image/kor/loginpage/table_d_06.gif"
					width="594" height="70"></td>
			</tr>
		</table>
		<table width="570" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<% 	com.nara.jdf.Config conf = null;
        boolean mode = false;
        try {
           conf = new com.nara.jdf.Configuration();
           mode = conf.getBoolean("com.nara.jdf.jspDebugMessageMode");
        }catch(Exception e){}
        if ( mode ) {
%>
				<hr class="hr" align="left" width="100%" noshade size="1">
				Debugging Message: <xmp><%= jdf_debug_msg %></xmp> <%      }
 
%>
				</td>
			</tr>
		</table>
		<!-- 끝 -->

		<p>&nbsp;</p>
		</td>
	</tr>
</table>
</form>
</body>