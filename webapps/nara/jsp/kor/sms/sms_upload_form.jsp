<%@ page contentType="text/html;charset=EUC-KR"%>

<html>
<head>
<title>SMS �߼� ���� (���ε�)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../css/base.css" type="text/css">
<script language=javascript>
<!--
function upload(){
  var objForm= document.file;
  if(objForm.file.value ==""){
    alert("������ ������ �ֽʽÿ�.");
    return;
  }else{
    objForm.strFileName.value = objForm.file.value.substr(objForm.file.value.lastIndexOf("\\") + 1);
    objForm.submit();
  }
}
-->
</script>
<style type="text/css">
<!--
body {
	background-color: #ddddd3;
}
-->
</style>
</head>
<body bgcolor="#EBF7F5" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<table width="100%" height="100%" border="0" cellpadding="0"
	cellspacing="0" bgcolor="DDDDD3">
	<tr>
		<td width="21" align="left"><img
			src="../image/kor/pop_mail_addrupdown_00.gif" width="21" height="81"></td>
		<td height="81" background="../image/kor/pop_mail_mess_err_02.gif">
		<table width="100%" height="81" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="105"><img
					src="../image/kor/pop_mail_addrupdown_01.gif" width="105"
					height="81"></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="31">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;<font color="#FFFFFF">S<strong><font
							color="#6CD0DF">��</font></strong>M<strong><font color="#6CD0DF">��</font></strong>S<strong><font
							color="#6CD0DF">��</font></strong>��<strong><font color="#6CD0DF">��</font></strong>��
						&nbsp;<font color="#85E4F2">���ε�</font></font></td>
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
		<table width="98%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="5" align="center" valign="top"></td>
			</tr>
			<tr>
				<td align="center" bgcolor="E6F3F1">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="1" align="center" bgcolor="DDDDDD"></td>
					</tr>
					<tr>
						<td height="10" align="center"></td>
					</tr>
					<tr>
						<td align="center">
						<table width="96%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td bgcolor="D5E4E4">
								<table border="0" cellspacing="1" cellpadding="2" width="100%">
									<form method=post name="file" action="sms.SmsUploadServ"
										enctype="multipart/form-data"><input type=hidden
										name='cmd' value=''> <input type=hidden
										name='strFileName' value=''>
									<tr>
										<td width="110" bgcolor="#DCF4F0">&nbsp;<img
											src="../image/kor/main_def_icon_05.gif" width="5" height="6"
											align="absmiddle">&nbsp;<span class="style14">SMS
										���� ���ε�</span></td>
										<td bgcolor="#EBF7F5">
										<table width="100%" border="0" cellspacing="0" cellpadding="1">
											<tr>
												<td><input type=file size=28 name=file value=""
													class="boxline00"> <a
													href=javascript:onClick=upload();><img
													src="../image/kor/main_def_butt_upload.gif" border=0
													align="absmiddle"></a></td>
											</tr>
										</table>
										</td>
									</tr>
									</form>
								</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;File Format&nbsp;:&nbsp;�����ڴ� "&lt;TAB&gt;"�� �ؼ�
								ó���� �˴ϴ�.<BR>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������
								��ȭ��ȣ&lt;TAB&gt;������ ��� ��ȭ��ȣ&lt;TAB&gt;����<BR>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EX)&nbsp;01012345678&lt;TAB&gt;01087654321&lt;TAB&gt;��ſ�
								�Ϸ�Ǽ���.<BR>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="14" background="../image/kor/pop_mail_mess_err_10.gif"></td>
			</tr>
			<tr>
				<td height="25" align="center" valign="bottom"><a
					href="javascript:window.close()"><img
					src="../image/kor/main_def_butt_close.gif" border="0"
					align="absmiddle"></a></td>
			</tr>
		</table>
		</td>
		<td width="21" align="right"
			background="../image/kor/pop_mail_mess_err_05.gif">&nbsp;</td>
	</tr>
	<tr>
		<td width="21" height="19" align="left"><img
			src="../image/kor/pop_mail_mess_err_06.gif" width="21" height="19"></td>
		<td background="../image/kor/pop_mail_mess_err_07.gif">&nbsp;</td>
		<td width="21" align="right"><img
			src="../image/kor/pop_mail_mess_err_08.gif" width="21" height="19"></td>
	</tr>
</table>
</body>
</html>
