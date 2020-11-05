<%@ page contentType="text/html;charset=EUC-KR"%>
<jsp:useBean id="list" class="java.util.Vector" scope="request" />
<jsp:useBean id="result" class="java.util.Vector" scope="request" />
<jsp:useBean id="errorlist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="success" class="java.lang.String" scope="request" />
<jsp:useBean id="back_list" class="java.util.ArrayList" scope="request" />

<html>
<head>
<title>SMS 발송 관리 (업로드)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../css/base.css" type="text/css">
<script language=javascript>
<!--
function upload(){
  var objForm= document.file;
  if(objForm.file.value ==""){
    alert("파일을 선택해 주십시오.");
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
							color="#6CD0DF">ㅣ</font></strong>M<strong><font color="#6CD0DF">ㅣ</font></strong>S<strong><font
							color="#6CD0DF">ㅣ</font></strong>관<strong><font color="#6CD0DF">ㅣ</font></strong>리
						&nbsp;<font color="#85E4F2">업로드</font></font></td>
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
						<td align="left"><!-- 발송 결과에 대한 목록 시작 --> <%
  int result_count = 0;
  int errorlist_count = 0;
  sms.TEMP_SMS_ADDRESS tsa = (sms.TEMP_SMS_ADDRESS) result.elementAt(0); 
  if(tsa.text.equals("TRUE")){ //전체발송이 안된경우
        result_count = list.size() - back_list.size(); //정상 발송 요청 개수
        errorlist_count = result_count;
  } else {
        result_count = result.size();
        errorlist_count = errorlist.size();
  }

         
%>
						<UL>
							<LI>총 발송 요청은 <%=list.size()%>개 요청</LI>
							<LI>정상적인 <%=result_count%>개 발송 요청 중 <%=success%>를 성공했습니다.</LI>
							<LI>정상적 발송요청 중 <%=errorlist_count%>개 오류</LI>
							<LI>발송건수 부족에 의해 발송되지 않은 건수는 <%=back_list.size()%>개</LI>
						</UL>
						<!-- 발송 결과에 대한 목록 끝 --></td>
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

<!-- 메인 윈도우를 다시 로딩시킨다.(정보갱신을 위해서..) -->
<script language=javascript>
<!--
   opener.document.location.reload();
-->
</script>

</body>
</html>
