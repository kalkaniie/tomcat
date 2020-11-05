<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.nara.jdf.servlet.*,com.nara.util.*,java.util.*,com.nara.jdf.util.*" %>
<%
	Box box = HttpUtility.getBox(request); 
	String mailResult = box.getString("MailResult");
	String Wrong_path ="false";
	
	try{
		String dec_string = UtilBase64.getDecode(mailResult);
		String[] params = new String[10] ;
		if(dec_string != null){
			
	System.out.println(":::" + dec_string);
	//params = dec_string.split("|");
	System.out.println(":::" + params.length);
	
	
	//dddd|dreem@demo.kebi.com|세현|dreem@demo.kebi.com|20090622|1|0|0 //1일간12시부터 24시
	
			StringTokenizer tokenStringId = new StringTokenizer(dec_string, "|");
	
			int i = 0;
			while (tokenStringId.hasMoreTokens()){
				//params[i] = new String(((String)tokenStringId.nextToken()).getBytes("iso-8859-1"), "EUC-KR");
				params[i] = (String)tokenStringId.nextToken();
				i++;
			}	
			
			String[] call_user_info = Utility.getUserIdDomain(params[1].trim());	
			String[] receive_user_info = Utility.getUserIdDomain(params[3].trim());
			
			session.setAttribute("call_user_id", params[0].trim());          //dddd
			session.setAttribute("call_domain", call_user_info[0]);	   		  //
			
			session.setAttribute("receive_user_id", receive_user_info[1]);	  //dreem
			session.setAttribute("receive_domain", receive_user_info[0]);	  //demo.kebi.com
			session.setAttribute("receive_user_nm", new String((params[2].trim()).getBytes("iso-8859-1"), "EUC-KR")); 		  //세현
			
	System.out.println("++++1+++++" + (String)session.getAttribute("call_user_id"));
	System.out.println("++++2+++++" + (String)session.getAttribute("call_domain"));
	
	System.out.println("++++3+++++" + (String)session.getAttribute("receive_user_id"));
	System.out.println("++++4+++++" + (String)session.getAttribute("receive_domain"));
	System.out.println("++++5+++++" + (String)session.getAttribute("receive_user_nm"));
	
		}
		
	}catch(Exception ex)
	{
		Wrong_path = "true";
		System.out.println("++++error+++++" + ex.toString());
	}
%>

<html>
<head>
<title>Kebiportal Realtime (실시간 대화)</title>
<style type="text/css">
<!--
body {margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px;}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<!-- script src="http://naravision.net/nara/js/kor/util/WebImtongPlay.js"></script-->
<script language=javascript>
<!--

/*
var Wrong_path = "";
if(Wrong_path=="true"){
	alert('잘못된 접근입니다. 이창을 종료합니다.');
	self.close();
}
*/
function resizewindow(){
    var i_width  = 850;
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
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_01.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_02.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_03.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_04.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_05.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_06.jpg" width="429" height="86"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_01_07.jpg" width="429" height="44"></td>
      </tr>
     </table>
	</td>
    <td width="404" valign="top" bgcolor="162c54">
	 <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_02_01.jpg" width="404" height="86"></td>
      </tr>
      <tr>
        <td height="403" align="center" bgcolor="3d5d98">
		<!---시작 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:404 H:533  )---------------------------------------------------------->
		
	<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />
	<link rel="stylesheet" type="text/css" href="/css/km5.css" />
	<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />
	<link rel="stylesheet" type="text/css" href="/css/portal.css" />

	<!-- web messenger include start -->
		<link href="/jsp/kor/messenger/css/basic.css" rel="stylesheet" type="text/css" />
		<link href="/jsp/kor/messenger/css/buddy_window.css" rel="stylesheet" type="text/css" />
		<SCRIPT SRC="/jsp/kor/messenger/js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
		<SCRIPT SRC="/jsp/kor/messenger/js/lib/scriptaculous/scriptaculous.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
	<!-- web messenger include end -->
	
	<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="/js/ext/ext-all.js"></script>

	<%@ include file = "/jsp/kor/realtime/massenger_index.jsp" %>
		
		<!---끝 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:404 H:533  )---------------------------------------------------------->
		</td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_02_02.jpg" width="404" height="71"></td>
      </tr>
     </table>
	</td>
    <td width="31" valign="top" bgcolor="162c54">
	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_03_01.jpg" width="31" height="270"></td>
      </tr>
      <tr>
        <td><img src="/jsp/kor/realtime/images/realtime/chatbg_03_02.jpg" width="31" height="290"></td>
      </tr>
     </table>
	</td>
    <td width="1" bgcolor="6490c7"></td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
