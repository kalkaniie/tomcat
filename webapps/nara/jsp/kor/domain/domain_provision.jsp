<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="SYSTEM_AGREEMENT_STMT" class="java.lang.String"
	scope="request" />
<%@ page import="com.nara.jdf.*"%>
<%@ page import="java.util.*"%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/base.css" type="text/css">
<script language=javascript>
<!--
function chkValue(){
  var objForm = document.f;
  if(objForm.isAgree.checked != true){
    alert("이용약관에 동의 하셔야 가입하실 수 있습니다.");
    return;
  }else{
    objForm.submit();
  }
}
-->
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<form method=post name="f" action="domain.public.do"><input
	type=hidden name="method" value="domain_regist_form">
<table width="100%" height="100%" border="0" cellpadding="0"
	cellspacing="0" background="../image/kor/loginpage/BG.gif">
	<tr>
		<td align="center">
		<table width="650" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="9" height="9"><img
					src="../image/kor/loginpage/user_table_a_00.gif" width="9"
					height="9"></td>
				<td height="9"
					background="../image/kor/loginpage/user_table_a_01.gif"></td>
				<td width="9" height="9" align="right"><img
					src="../image/kor/loginpage/user_table_a_02.gif" width="9"
					height="9"></td>
			</tr>
			<tr>
				<td width="9" valign="bottom"
					background="../image/kor/loginpage/user_table_a_03.gif"><img
					src="../image/kor/loginpage/user_table_a_05.gif" width="9"
					height="36"></td>
				<td bgcolor="#FFFFFF">
				<table width="98%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"><img
							src="../image/kor/loginpage/user_domain_topimg.gif" width="632"
							height="175"></td>
					</tr>
					<tr>
						<td align="center">
						<table width="98%" border="0" cellspacing="0" cellpadding="0">
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
								<td height="175" align="center" valign="top"
									background="../image/kor/loginpage/table_b_bg.gif">
								<table width="98%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><img
											src="../image/kor/loginpage/user_domainprovision_title.gif"></td>
									</tr>
									<tr>
										<td height="15" align="center" valign="bottom">
										<table width="99%" border="0" cellspacing="0" cellpadding="0"
											style="filter: alpha(opacity =           80)">
											<tr>
												<td width="3" align="left"><img
													src="../image/kor/main_def_dotline_00.gif" width="3"
													height="7"></td>
												<td background="../image/kor/main_def_dotline_01.gif"><img
													src="../image/kor/blank.gif" width="3" height="7"></td>
												<td width="3" align="right"><img
													src="../image/kor/main_def_dotline_02.gif" width="3"
													height="7"></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td height="30"><img
											src="../image/kor/loginpage/user_provision_icon.gif"
											width="12" height="12" align="absmiddle"> 도메인 가입을 원하시면
										아래의<strong class="style15"> '가입동의서'</strong>를 반드시 읽고<strong
											class="style15"> '동의'</strong>를 체크해 주세요.</td>
									</tr>
									<tr>
										<td height="5"></td>
									</tr>
									<tr>
										<td height="5"><textarea name="textarea" cols="95"
											rows="20" class="boxline02" readonly><%=SYSTEM_AGREEMENT_STMT%></textarea></td>
									</tr>
									<tr>
										<td height="5">
										<table width="100%" height="35" border="0" cellpadding="0"
											cellspacing="0">
											<tr>
												<td><input type=checkbox name="isAgree" value="Y">
												위 약관에 동의합니다.</td>
												<td align="right" valign="bottom"><a
													href="javascript:chkValue()"><img
													src="../image/kor/loginpage/user_provision_butt_ok.gif"
													border="0"></a> <a
													href=javascript:onClick=history.back(-1);><img
													src="../image/kor/loginpage/user_provision_butt_cancel.gif"
													border="0"></a></td>
											</tr>
										</table>
										</td>
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
					</tr>
					<tr>
						<td height="5"></td>
					</tr>
				</table>
				</td>
				<td width="9" valign="top"
					background="../image/kor/loginpage/user_table_a_04.gif"><img
					src="../image/kor/loginpage/user_table_a_06.gif" width="9"
					height="22"></td>
			</tr>
			<tr>
				<td width="9" height="9"><img
					src="../image/kor/loginpage/user_table_a_07.gif" width="9"
					height="9"></td>
				<td height="9"
					background="../image/kor/loginpage/user_table_a_08.gif"></td>
				<td width="9" height="9" align="right"><img
					src="../image/kor/loginpage/user_table_a_09.gif" width="9"
					height="9"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>