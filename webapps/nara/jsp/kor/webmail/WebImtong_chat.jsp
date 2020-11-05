<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="com.nara.jdf.servlet.*" %>
<%
Box box = HttpUtility.getBox(request); 
%>
<html>
<head>
<title>Kebiportal Realtime (실시간 대화)</title>
<style type="text/css">
<!--
body {margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px;}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<script src="/js/kor/util/WebImtongPlay.js"></script>
<script language=javascript>
<!--
function resizewindow(){
    var i_width  = 900;
    var i_height = 740;
    window.resizeTo(i_width, i_height);
  }
-->
</script>

<body onLoad="resizewindow();">
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="0d2e56">
  <tr>
    <td width="429" valign="top" bgcolor="162c54">
	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_01.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_02.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_03.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_04.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_05.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_06.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_01_07.jpg" width="429" height="44"></td>
      </tr>
     </table>
	</td>
    <td width="404" valign="top" bgcolor="162c54">
	 <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_02_01.jpg" width="404" height="86"></td>
      </tr>
      <tr>
        <td height="403" align="center" bgcolor="3d5d98">
		<!---시작 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:404 H:533  )---------------------------------------------------------->

<% if(!box.get("MailResult").equals("")){%>
		<!-- New Method Jiseong 2007. 02. 12 -->
		<script language="JavaScript">WebImtongBase64("<%= box.get("MailResult")%>");</script>
		<!-- New Method Jiseong -->
		
<% }else if(!box.get("MailToName").equals("")&&!box.get("MailToIDX").equals("")){ %>		
		<!-- Old Method Start Jiseong -->
		<script language="JavaScript">
			WebImtongStart(
							 "<%= box.get("MailToName")%>"
							,"<%=box.get("MailToIDX")%>"
							,"<%=box.get("MailFromName")%>"
							,"<%=box.get("MailFromIDX")%>"
							);
		</script>
		<!-- Old Method End Jiseong -->
<%}%>		

		<!---끝 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:404 H:533  )---------------------------------------------------------->
		</td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_02_02.jpg" width="404" height="71"></td>
      </tr>
     </table>
	</td>
    <td width="31" valign="top" bgcolor="162c54">
	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_03_01.jpg" width="31" height="270"></td>
      </tr>
      <tr>
        <td><img src="http://naravision.net/nara/msg/images/chatbg_03_02.jpg" width="31" height="290"></td>
      </tr>
     </table>
	</td>
    <td width="1" bgcolor="6490c7"></td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
