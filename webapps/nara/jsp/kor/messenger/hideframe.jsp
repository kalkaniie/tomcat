<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="java.util.*, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>
<%	
	
	//HttpAttributes attr = getAttributes( request );
	//DataSet input = attr.getDataSet();   
	//String user_id = input.getText("user_id");
	//String passwd = input.getText("passwd");	
	
	
	String user_id = UserSession.getString(request,"USERS_ID")+ "@" + UserSession.getString(request,"DOMAIN");
	String user_nm = UserSession.getString(request,"USERS_NAME");
	//String passwd = UserSession.getString(request,"USERS_PASSWD");
	String passwd = UserSession.getString(request,"USERS_PASSWD_ENC");
	
	Config confhost = Configuration.getInitial();
	String ims_ip = confhost.getString("com.nara.msg.ims.serverip");
	String ims_port = confhost.getString("com.nara.msg.ims.serverport");
	
	System.out.println(ims_ip + "****************" + ims_port);
	
	String ServerDomain = request.getServerName();
%>
<SCRIPT SRC="js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/lib/ajax.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/common/Basic_flash.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/bp/Basic_BP.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<script>

var user_id = '<%=user_id%>';
var user_pass = '<%=passwd%>';
var user_nm = '<%=user_nm%>';
var ServerDomain ='<%=ServerDomain%>';
// var server_ip = '211.238.156.201'; //demo.kebi.com
//var server_ip = '210.116.116.202';	//naravisio.net
//var server_port = '21002';

var server_ip = '<%=ims_ip%>';	//local
var server_port = '<%=ims_port%>';
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
	
	/*XML socket  /jsp/kor/messenger/common */
	//$('xmlsocket').innerHTML = flash_load('/js/common/socket_client.swf','0','0', server_ip, server_port);
	$('xmlsocket').innerHTML = flash_load('/jsp/kor/messenger/common/socket_client_utf8.swf','100','100', server_ip, server_port);
//	 alert($('xmlsocket'));
	
	
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
		// alert('sever connecting.....');
		/*SERVER CONNECT AND LOGIN*/
		window.setTimeout("Connect_Server(server_ip,server_port,server_port);",2500);			
		
	}
	
	function js_reTryconnectAndLogin()
	{	
		/*SERVER CONNECT AND LOGIN*/
		alert('reconnect');
		Connect_Server(server_ip,server_port,server_port);			
		
	}
	
	// js_connectAndLogin();	
	
	var thread =  setInterval("getLoginStatus();", 1000);	
	
	
	
	
	/*
		listArray : BUDDY INFO. see Flash_Process.js
	*/
	function js_getBuddyList()
	{
//		alert(2);
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
