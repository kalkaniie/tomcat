<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="java.util.*, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<%	

	String user_id = UserSession.getString(request,"USERS_ID")+ "@" + UserSession.getString(request,"DOMAIN");
	String user_nm = UserSession.getString(request,"USERS_NAME");
	//String passwd = UserSession.getString(request,"USERS_PASSWD");
	String passwd = UserSession.getString(request,"USERS_PASSWD_ENC");
	System.out.println(user_id + "****************" + passwd);
%>
<SCRIPT SRC="js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/lib/ajax.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>

<SCRIPT SRC="js/common/Basic_flash.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/bp/Basic_BP.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<script>

var user_id = '<%=user_id%>';
var user_pass = '<%=passwd%>';
//var server_ip = '211.238.156.202';
var server_ip = '211.238.156.28';
var server_port = '21002';

var temp = '';
</script>
</head>

<body onUnload="javascript:Close_Server();">
<div id='xmlsocket'></div>
<div id='dialogueid'></div>
<div id='mlMsg_window_main'></div>
<div id='_buddygroup'></div>
<div id='_buddylist'></div>
<div id='_debugger'></div>
</body>

<script>
function mainUnLoad()
{
	alert('main unLoad Event');
}

if( user_id != '' )
{

	$('xmlsocket').innerHTML = flash_load('/jsp/kor/realtime_mysql/common/socket_client_utf8.swf','0','0', server_ip, server_port);
	
	
	function getLoginStatus()
	{		
		if(Login_Flag == '1') 
		{			
			clearInterval(thread);				
			parent.window.status = 'Login_Flag:'+Login_Flag +' monitor stop.';			
		} else if(Login_Flag == '8' || Login_Flag == '9' || Login_Flag == '0')
		{
			parent.window.status = 'Login_Flag:'+Login_Flag +' relogin....';			
			Close_Server();					
		}
	}
	
	function js_connectAndLogin()
	{	
		
		/*SERVER CONNECT AND LOGIN*/
		window.setTimeout("Connect_Server(server_ip,server_port,server_port);",1500);			
		
	}
	
	
	js_connectAndLogin();	
	
	var thread =  setInterval("getLoginStatus();", 1000);	
	
	
	
	
	/*
		listArray : BUDDY INFO. see Flash_Process.js
	*/
	function js_getBuddyList()
	{
		var buddy = '';
		listArray.each(function(valueTop, indexTop)
									{													
									 	
									 	listArray[indexTop].each(function(value, index)
										{													
										 	if(index == 8)
										 	{
										 		buddy = value+ "," + buddy;
										 	}
										});	
									 	
									});
		return buddy;
	}
	

} else
{

//alert('USER ID IS NOT EXIST!');

}
</script>
</html>
