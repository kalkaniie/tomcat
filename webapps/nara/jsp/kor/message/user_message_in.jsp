<%@ page contentType="text/html;charset=EUC-KR" %>

<jsp:useBean id="message"  class="java.lang.String" scope="request" />
<jsp:useBean id="href" class="java.lang.String" scope="request" />

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../css/base.css" type="text/css">
<% if(href.length() <= 0)
     href = "javascript:history.back(-1)";
%>
<SCRIPT LANGUAGE="JavaScript"> 
function nextWin() { 
  location = '<%=href%>';
} 
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ���� -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="22" bgcolor="00D5F3">&nbsp;&nbsp;<span class="style2"></td>
  </tr>
  <tr>
    <td height="5" bgcolor="#FFFFFF"></td>
  </tr>
  <tr>
    <td align="right" bgcolor="#FFFFFF">
      <table width="99%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="9" align="left" valign="top" background="../image/kor/main_def_tabl_a_bg.gif"><img src="../image/kor/main_def_tabl_a_00.gif" width="9" height="228"></td>
          <td valign="top" background="../image/kor/main_def_tabl_a_bg.gif"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center" bgcolor="#FFFFFF"><table width="100%" height="92"  border="0" cellpadding="0" cellspacing="0">
                    <tr valign="top">
                      <td width="10" align="left" background="../image/kor/main_def_tabl_title_bg.gif"><img src="../image/kor/main_def_tabl_title_00.gif" width="10" height="92"></td>
                      <td background="../image/kor/main_def_tabl_title_bg.gif">
                        <table width="98%"  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><table width="98%" height="53"  border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td background="../image/kor/main_def_tabl_title_02.gif">
                                    <table width="100%" height="53"  border="0" cellpadding="0" cellspacing="0">
                                      <tr>
                                        <td height="6"></td>
                                      </tr>
                                      <tr>
                                        <td align="left" valign="middle">
                                          <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td height="20"><img src="../image/kor/main_def_icon_00.gif" width="7" height="9" align="absmiddle"> <span class="style13">�۾�; �Ϸ��Ͽ��4ϴ�.</span></td>
                                            </tr>
                                        </table></td>
                                      </tr>
                                      <tr>
                                        <td height="4"></td>
                                      </tr>
                                  </table></td>
                                  <td width="9" align="right"><img src="../image/kor/main_def_tabl_title_01.gif" width="9" height="53"></td>
                                </tr>
                            </table></td>
                          </tr>
                      </table></td>
                      <td width="228" align="right" background="../image/kor/main_def_tabl_title_bg.gif"><img src="../image/kor/main_def_tabl_title_complete.gif" width="228" height="92"></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td align="center" bgcolor="#FFFFFF"><table width="97%" height="450"  border="0" cellpadding="30" cellspacing="0">
                  <tr>
                    <td align="center"><table width="518" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="../image/kor/main_util_mess_ok.gif" width="518" height="130"></td>
                      </tr>
                      <tr>
                        <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="20" background="../image/kor/main_util_mess_00.gif">&nbsp;</td>
                              <td><table width="100%"  border="0" cellspacing="0" cellpadding="5">
                                <tr>
                                  <td width="12" height="5" valign="top"></td>
                                  <td height="5"></td>
                                </tr>
                                <tr>
                                  <td width="12" valign="top"><img src="../image/kor/main_mail_sendmess_bullet_00.gif" width="12" height="12" align="absmiddle"></td>
                                  <td><font color="#009FCD"><b><%=message%></b></font></td>
                                </tr>
                                <tr>
                                  <td width="12" valign="top"><img src="../image/kor/main_mail_sendmess_bullet_00.gif" width="12" height="12" align="absmiddle"></td>
                                  <td>3���� ��=ȭ��8�� �̵��մϴ�.</td>
                                </tr>
                              </table>                                
                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td height="40" align="center" valign="bottom"><a href='<%=href%>'><img src="../image/kor/main_util_mess_butt_ok.gif" width="61" height="18" border="0"></a></td>
                                  </tr>
                                </table></td>
                              <td width="12" background="../image/kor/main_util_mess_01.gif">&nbsp;</td>
                              <td width="174" align="right" valign="bottom" background="../image/kor/main_util_mess_02.gif"><img src="../image/kor/main_util_mess_ok_img.gif" width="174" height="158"></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td><img src="../image/kor/main_util_mess_ok_bottimg.gif" width="518" height="27"></td>
                      </tr>
                    </table>
                    </td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
              </tr>
          </table></td>
          <td width="9" align="right" valign="top" background="../image/kor/main_def_tabl_a_bg.gif"><img src="../image/kor/main_def_tabl_a_01.gif" width="9" height="228"></td>
        </tr>
    </table></td>
  </tr>
</table>
<!-- �� -->
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
setTimeout('nextWin()', 3000);
-->
</SCRIPT>

