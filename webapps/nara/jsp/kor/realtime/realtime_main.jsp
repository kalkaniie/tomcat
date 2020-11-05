<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.nara.jdf.servlet.*,com.nara.util.*,java.util.*,com.nara.jdf.util.*,java.util.Random, com.nara.jdf.util.DateTime" %>
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
	      //dec_string=  new String(new sun.misc.BASE64Decoder().decodeBuffer(mailResult));
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
			
		
			
			if(intervalDay < 0 && Integer.parseInt(params[5]) != 0){ //대화요청 기간 만료 알림
				intervalDay_flag = "true" ;
				alertmessage = "대화요청 기간이 만료되어, 쪽지창으로 자동변경됩니다.";
				message = "대화요청 기간이 만료되어, 쪽지창으로 자동변경됩니다.</b></br>" ;
						   //"기간은 발송일["+ DateTime.replaceKRType(params[4]) +
						   //         "]기준으로 "+params[5]+"일[<b><font color='red'>"+ DateTime.replaceKRType(todayDay) +"</b></font>] 입니다.";
			}	
			else{
				alertmessage = "상대방이 대화를 할 수 없는 상태입니다.쪽지창으로 자동 변경됩니다.";
				message = "상대방이 대화를 할 수 없는 상태일 경우 쪽지창으로 자동 변경됩니다.</br>"+
						  "<b>메일 발신인과의 대화 및 파일 전송, 원격제어가 가능합니다</b></br>";
						  //"기간은 발송일["+ DateTime.replaceKRType(params[4]) +
				          //  "] 기준으로 "+params[5]+"일[<b><font color='red'>"+ DateTime.replaceKRType(todayDay) +"</b></font>] 입니다.";
				}
			
			
			String[] call_user_info = Utility.getUserIdDomain(params[1]);	
			String[] receive_user_info = Utility.getUserIdDomain(params[3]);
			
			session.setAttribute("call_user_id",call_user_info[1]);          //dddd
			session.setAttribute("call_domain", call_user_info[0]);	   		  //
			session.setAttribute("call_user_nm", new String(new sun.misc.BASE64Decoder().decodeBuffer( params[0])));	  
			//session.setAttribute("call_user_nm", params[0]);
			
			session.setAttribute("receive_user_id", receive_user_info[1]);	  //dreem
			session.setAttribute("receive_domain", receive_user_info[0]);	  //demo.kebi.com
			session.setAttribute("receive_user_nm", new String(new sun.misc.BASE64Decoder().decodeBuffer( params[2]))); 		  		//세현
			//session.setAttribute("receive_user_nm", params[2]); 		  		//세현
			//session.setAttribute("receive_user_nm", new String((params[2].trim()).getBytes("iso-8859-1"), "EUC-KR")); 		  //세현
			
			session.setAttribute("intervalDay_flag", intervalDay_flag);
	

	System.out.println("++++1+++++" + (String)session.getAttribute("call_user_id"));
	System.out.println("++++2+++++" + (String)session.getAttribute("call_domain"));
	
	System.out.println("++++3+++++" + (String)session.getAttribute("receive_user_id"));
	System.out.println("++++4+++++" + (String)session.getAttribute("receive_domain"));
	System.out.println("++++5++params[0]+++" + new String(new sun.misc.BASE64Decoder().decodeBuffer( params[0])));
	System.out.println("++++6++params[2]+++" + new String(new sun.misc.BASE64Decoder().decodeBuffer( params[2])));
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
<META HTTP-EQUIV="imagetoolbar" CONTENT="no"/>
<title>:: KEBI Realtime ::</title>
	<style type="text/css">
		<!--
		*{padding:0; margin:0;}
		html,body{ font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif;}
		img{border:none; vertical-align:middle;}
		
		.bgTitle { background:url(/jsp/kor/realtime/images/realtime/img_popup.gif) no-repeat;}
		.bgMsg { background:url(/jsp/kor/realtime/images/realtime/img_popupBg.gif) repeat-x left top;}
		.tTitle { font-family:"Dotum","DotumChe","돋움","굴림","Arial","Tahoma","Verdana"; font-size:10pt; color:#444; padding-bottom:25px; text-align:center;}
		-->
	</style>

	<script language=javascript>
	<!--

	var back_url = "<%=mailResult%>";
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
	  
 	function uf_popResize() {
		var thisX = document.getElementById("offsetTable").offsetWidth;
		var thisY = document.getElementById("offsetTable").offsetHeight;
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 80;
		var marginY = 48;
		var naviInfo = window.navigator.userAgent.toUpperCase();
		if (naviInfo.indexOf("NT 6") != -1){ // vista
			marginY = 80; //마지막 수는 상황에따라 알맞게 넣으세요. (템플릿의 헤더높이 + 풋터 높이 + 알파)
		} else if( naviInfo.indexOf("MSIE 7") != -1 ) { // : IE7
			marginY = 80; //71;
		} else {
			marginY = 49; //29; //마지막 수는 상황에따라 알맞게 넣으세요. (템플릿의 헤더높이 + 풋터 높이 + 알파)
		}
		
		if (thisX > maxThisX) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}	else{
			window.document.body.scroll = "no";
		}
		
		if (thisY > maxThisY - marginY) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}	else{
			window.document.body.scroll = "no";
		}
		
		var windowX = (screen.width - (thisX+10))/2;
		var windowY = (screen.height - (thisY+marginY))/2 - 20;
	//	window.moveTo(windowX,windowY);
		window.resizeTo(thisX+10,thisY+marginY);
}
 
	  
	-->
	</script>

</head>

<body  onLoad="uf_popResize();">
<table width="520" height="610" border="0" cellspacing="0" cellpadding="0"  id="offsetTable">
  <tr>
    <td height="180" align="center" valign="bottom" class="bgTitle">
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
				<link href="/jsp/kor/realtime/css/basic.css" rel="stylesheet" type="text/css" />
				<link href="/jsp/kor/realtime/css/buddy_window.css" rel="stylesheet" type="text/css" />
				<SCRIPT SRC="/jsp/kor/realtime/js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
				<SCRIPT SRC="/jsp/kor/realtime/js/lib/scriptaculous/scriptaculous.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
			<!-- web messenger include end -->
			
			<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
			<script type="text/javascript" src="/js/ext/ext-all.js"></script>
		
			<%@ include file = "/jsp/kor/realtime/massenger_index.jsp" %>
		
		<!---끝 : 아이엠통 메신져가 들어가는 TD ( 메진져 싸이즈 W:520 H:570  )---------------------------------------------------------->
	<%
	}
	%>

	</td>
  </tr>
</table>
</body>
</html>