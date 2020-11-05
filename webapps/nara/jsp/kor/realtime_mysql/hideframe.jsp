<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="java.util.*, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<%	

	//********************************1. 초기화 작업***********************************
		// call 사용자 (외부)
		String tmp_call_user_id = ((String)session.getAttribute("call_user_id")==null || "".equals(session.getAttribute("call_user_id")))
				?"test1" 
				:(String)session.getAttribute("call_user_id");
		
		String tmp_call_domain = ((String)session.getAttribute("call_domain")==null || "".equals(session.getAttribute("call_domain")))
				?"demo.kebi.com" 
				:(String)session.getAttribute("call_domain");

		
		String tmp_call_user_nm = ((String)session.getAttribute("call_user_nm")==null || "".equals(session.getAttribute("call_user_nm")))
		? tmp_call_user_id
		:(String)session.getAttribute("call_user_nm");
		
		
		// 실 답변 사용자(내부)
		String tmp_receive_user_id = ((String)session.getAttribute("receive_user_id")==null || "".equals(session.getAttribute("receive_user_id")))
			?"webmaster" 
			:(String)session.getAttribute("receive_user_id");
		
		String tmp_receive_domain = ((String)session.getAttribute("receive_domain")==null || "".equals(session.getAttribute("receive_domain")))
			?"demo.kebi.com" 
			:(String)session.getAttribute("receive_domain");
		
		String tmp_receive_user_nm = ((String)session.getAttribute("receive_user_nm")==null || "".equals(session.getAttribute("receive_user_nm")))
		? tmp_receive_user_id
		:(String)session.getAttribute("receive_user_nm");
		
		String intervalDay_flag = (session.getAttribute("intervalDay_flag")==null || "".equals(session.getAttribute("intervalDay_flag")))
		? "false"
		:(String)session.getAttribute("intervalDay_flag");
	
	//********************************2. 실 사용 아이디 생성 ***********************************
	
	RndUtil rnd = new RndUtil(4);
	String call_user_id = tmp_call_user_id + "_" + rnd.getRND() +"@nwc." +  tmp_call_domain;
	String call_real_user_id =tmp_call_user_id +"@" + tmp_call_domain ;
	String call_user_nm = tmp_call_user_nm;
	
	
	//메세지 받을 사람(실메신저 사용자)
	String receive_user_id = tmp_receive_user_id +"@" + tmp_receive_domain ;
	String receive_user_nm = tmp_receive_user_nm ;
	
	
	
	//String passwd = UserSession.getString(request,"USERS_PASSWD");
	String passwd = "11111";
	System.out.println("+++call_user_id+++++" + call_user_id);
	System.out.println("++++call_real_user_id+++++" + call_real_user_id);
	System.out.println("++++call_user_nm+++++" + call_user_nm);
	
	System.out.println("++++receive_user_id+++++" + receive_user_id);
	System.out.println("++++receive_user_nm+++++" + receive_user_nm);
	
%>
<SCRIPT SRC="js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/lib/ajax.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/common/Basic_flash.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/bp/Basic_BP.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<script>

var user_id = '<%=call_user_id%>';
var user_nm = '<%=call_user_nm%>';
var real_user_id = '<%=call_real_user_id%>';

var receive_user_id = '<%=receive_user_id%>';
var receive_user_nm = '<%=receive_user_nm%>';
var intervalDay_flag ='<%=intervalDay_flag%>';

var user_pass = '<%=passwd%>';

//demo.kebi.com
var server_ip = '211.238.156.202';
var server_port = '21002';

//naravision.net
//var server_ip = '211.238.156.22';
// var server_port = '21002';

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

var prsbar;
 
if( user_id != '' )
{
	
	/*XML socket  /jsp/kor/realtime_mysql/common */
	//$('xmlsocket').innerHTML = flash_load('/js/common/socket_client.swf','0','0', server_ip, server_port);
	$('xmlsocket').innerHTML = flash_load('/jsp/kor/realtime_mysql/common/socket_client_utf8.swf','0','0', server_ip, server_port);
	//alert('here');
	
	/*
	prsbar= parent.loadingProgress();
 	prsbar.wait();
	prsbar.show();
	*/
	//alert(parent.$('messenger_loading'));
	//parent.Ext.get('messenger_loading').remove();
	
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
		// alert(2);
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
