<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.nara.jdf.servlet.*,com.nara.util.*,java.util.*,com.nara.jdf.util.*,java.util.Random" %>
<%
	Box box = HttpUtility.getBox(request); 
	String mailResult = box.getString("MailResult");
	boolean Wrong_path =false;
	String alertmessage = "";
	String message = "";
	String intervalDay_flag = "false";
	String dec_string="";
	try{
		//dec_string = UtilBase64.getDecode(mailResult);
	      dec_string=  new String(new sun.misc.BASE64Decoder().decodeBuffer(mailResult));

		String[] params = new String[10] ;
		if(dec_string != null){
			
			//dddd|dreem@demo.kebi.com|세현|dreem@demo.kebi.com|20090622|1|0|0 //1일간12시부터 24시
	
			StringTokenizer tokenStringId = new StringTokenizer(dec_string, "|");
	
			int i = 0;
			while (tokenStringId.hasMoreTokens()){
				params[i] = (String)tokenStringId.nextToken().trim();
				i++;
			}	
			
			String todayDay = (params[4] != null && !params[4].equals(""))
				? DateTime.getDateDD(params[4],Integer.parseInt(params[5])) : DateTime.getFormatString("yyyyMMdd"); // 오늘 yyyyMMdd
					
			Date startTime = DateTime.getDate( todayDay +"00:00:00", "yyyyMMddHH:mm:ss");
			long intervalDay = (startTime.getTime() - System.currentTimeMillis()) / 1000 / 60 / 60 / 24 ;
			
		
			
			if(intervalDay < 0){ //대화요청 기간 만료 알림
				intervalDay_flag = "true" ;
				alertmessage = "대화요청 기간이 만료되어, 쪽지창으로 자동변경됩니다.";
				message = "대화요청 기간이 만료되어, 쪽지창으로 자동변경됩니다.</br>" +
						   "기간은 발송일["+ DateTime.replaceKRType(params[4]) +
						            "]기준으로 "+params[5]+"일[<b><font color='red'>"+ DateTime.replaceKRType(todayDay) +"</b></font>] 입니다.";
			}	
			else{
				alertmessage = "상대방이 대화를 할 수 없는 상태입니다.쪽지창으로 자동 변경됩니다.";
				message = "상대방이 대화를 할 수 없는 상태일 경우 쪽지창으로 자동 변경됩니다.</br>"+
						  "KEBI Realtime을 통해 메일 발신인과의 대화 및 파일 전송, 원격제어가 가능합니다</br>"+
						  "기간은 발송일["+ DateTime.replaceKRType(params[4]) +
				            "] 기준으로 "+params[5]+"일[<b><font color='red'>"+ DateTime.replaceKRType(todayDay) +"</b></font>] 입니다.";
				}
			
			
			String[] call_user_info = Utility.getUserIdDomain(params[1]);	
			String[] receive_user_info = Utility.getUserIdDomain(params[3]);
			
			session.setAttribute("call_user_id",call_user_info[1]);          //dddd
			session.setAttribute("call_domain", call_user_info[0]);	   		  //
			session.setAttribute("call_user_nm", params[0]);	  
			//session.setAttribute("call_user_nm", new String((params[0].trim()).getBytes("iso-8859-1"), "EUC-KR"));	  
			
			session.setAttribute("receive_user_id", receive_user_info[1]);	  //dreem
			session.setAttribute("receive_domain", receive_user_info[0]);	  //demo.kebi.com
			session.setAttribute("receive_user_nm", params[2]); 		  		//세현
			//session.setAttribute("receive_user_nm", new String((params[2].trim()).getBytes("iso-8859-1"), "EUC-KR")); 		  //세현
			
			session.setAttribute("intervalDay_flag", intervalDay_flag);
			
	System.out.println("++++1+++++" + (String)session.getAttribute("call_user_id"));
	System.out.println("++++2+++++" + (String)session.getAttribute("call_domain"));
	
	System.out.println("++++3+++++" + (String)session.getAttribute("receive_user_id"));
	System.out.println("++++4+++++" + (String)session.getAttribute("receive_domain"));
	System.out.println("++++dec_string+++++" + dec_string);
	System.out.println("++++intervalDay+++++" +intervalDay);
	
		}
		
	}catch(Exception ex)
	{
		Wrong_path = true ;
		message = "잘못된 접근입니다.</br>"+
		   "KEBI Realtime 서비스를 정상적으로 수행할 수 없습니다.</br>관리자에게 문의하시기 바랍니다.1544-0605";
		System.out.println("++++error+++++" + ex.toString()+ " :" + dec_string);
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>:: KEBI Realtime ::</title>
	<style type="text/css">
		<!--
		*{padding:0; margin:0;}
		html,body{ font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif;}
		img{border:none; vertical-align:middle;}
		
		.bgTitle { background:url(/jsp/kor/realtime_mysql/images/realtime_mysql/img_popup.gif) no-repeat;}
		.bgMsg { background:url(/jsp/kor/realtime_mysql/images/realtime_mysql/img_popupBg.gif) repeat-x left top;}
		.tTitle { font-family:"Dotum","DotumChe","돋움","굴림","Arial","Tahoma","Verdana"; font-size:10pt; color:#444; padding-bottom:25px; text-align:center;}
		-->
	</style>

	<script language=javascript>
	<!--

	var Wrong_path = "<%=Wrong_path%>";
	var intervalDay_flag = "<%=intervalDay_flag%>";
	
	if(Wrong_path=="true"){
		alert('잘못된 접근입니다\n정상적인 서비스를 진행할 수 없습니다.');
	}else if(intervalDay_flag=="true"){
		alert("<%=alertmessage%>");
	}

	function resizewindow(){
		var i_width  = 520;
		var i_height = 630;
		window.resizeTo(i_width, i_height);
	  }
	-->
	</script>

</head>

<body  onLoad="resizewindow();">
<table width="520" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="200" align="center" valign="bottom" class="bgTitle">
      <table width="500" border="0" cellspacing="0" cellpadding="0"> 
        <tr>
          <td class="tTitle"><%=message%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="370" class="bgMsg">
	<%
	if(Wrong_path == false){
	%>
	<!---시작 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:520 H:570  )---------------------------------------------------------->
		
			<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />
			<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />
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
		
			<%@ include file = "/jsp/kor/realtime_mysql/massenger_index.jsp" %>
		
		<!---끝 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:520 H:570  )---------------------------------------------------------->
	<%
	}
	%>

	</td>
  </tr>
</table>
</body>
</html>


<SCRIPT LANGUAGE="JavaScript">
<!--
// var link = "/jsp/kor/realtime_mysql/realtime_main_popup.jsp?MailResult=<%=mailResult%>"
// window.open( link ,"win1","status=yes,location=no,resizable=yes,toolbar=no,scrollbars=auto,width=520,height=570,top=100,left=100");
//self.close();
//-->
</SCRIPT>
