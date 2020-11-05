
var MainForm;
var user_id;
var user_pass;

function FormSet(obj)
{
    MainForm = obj;
}

//==============================================================================================
//	알림 메시지를 출력한다.
//  @param	: msg
//  @return 
function traceMsg(msg)
{
		var rtnmsg = '';
		if(msg == SOCK_CONNECT)
		{
	      rtnmsg = "소켓이 연결되었습니다.";
	      // LoginReq(user_id,user_pass;);
	      LoginReq(user_id,user_pass);
		  Socket_Connect = 1;
	  }
	  else if(msg == SOCK_DISCONNECT)
	  {
	      rtnmsg = "소켓 연결이 끊어졌습니다";
	  }
	  else if(msg == SOCK_NOTCONNECT)
	  {
	      rtnmsg = "소켓에 연결할 수 없습니다.";
	      Login_Flag = '8';
	  }
	  else if(msg == SOCK_AUTH_ERROR)
	  {
	      rtnmsg = "보안 문제로 소켓에 연결할 수 없습니다. ";
	      Login_Flag = '9';
	  }
	  else
	  {
	      rtnmsg = "[" + msg + "]";
	  }
	  //alert(msg);
	  parent.window.status ="+++++++++" + msg + "::::::" +rtnmsg;
}

function test(resultmsg1, resultmsg2){
	//alert(resultmsg1 + " : "  + resultmsg2);
}
function errMsg(errmsg){
	alert("error code :" + errmsg);
}
//==============================================================================================
//  수신된 메시지를 받는다.
//  @param	: op_cde : op_code msg : 받은 메시지 스트링
//  @return 
function receiveMsg(op_code,resultmsg)
{
//	if(op_code == 1207) 
  //  	alert(op_code + "["+resultmsg.length+"]"+ "------------------" + resultmsg);
    // alert(op_code + "   : " +resultmsg );
    var szResultCode = resultmsg.substring(0, 4);
    
    var msg = resultmsg.substring(4, resultmsg.length);
    
    //alert('op_code:'+op_code+',op_code.length:'+op_code.length+'\n'+'resultmsg:'+resultmsg+'\n'+'msg:'+msg);
    //alert(UA_APPLE_RESP.length());
    //alert(op_code+','+UA_APPLE_RESP+',');
    //alert(op_code == UA_APPLE_RESP)
     
    if(szResultCode == "0200" || op_code==UA_APPLE_RESP)
    {    
    
      if(op_code == UA_LOGON_RESP)
      {
         LoginResp(szResultCode,msg);
      }
      else if(op_code == UA_DUP_LOG_RELAY)
      { 
         DupLoginNotify(szResultCode,msg);
      }
      else if(op_code == UA_NAME_NOTI_RELAY)
      {
         NameNotify(szResultCode,msg);
      }
      else if(op_code == UA_STAT_NOTI_RELAY)
      {
         StatusNotify(szResultCode,msg);
      }
      //친구추가
      else if(op_code == UA_BADD_AUTH_RELAY)
      {
         BuddyAddResp(szResultCode,msg);
      } 
      //친구 추가에 대한 수락/거절
      else if(op_code == UA_BADD_ACCEPT_RELAY)
      {    	
         BuddyAddAcceptResp(szResultCode, msg);
      } 
      //친구 삭제/차단/차단해제 
      else if(op_code == UA_BAUTH_MODIFY_RESP)
      {
         BuddyAuthModify(szResultCode,msg);
      } else if(op_code == UA_GROUP_COPY_RESP)
      {
      	BuddyGroupCopyResp(szResultCode, msg);	
      }
      else if(op_code == UA_DIALOG_INDEX_RELAY)
      {
         DialogIndexResp(szResultCode,msg);
      }
      else if(op_code == UA_DIALOG_RELAY)
      {
       	// alert(szResultCode +" : " + msg);
         DialogRelay(szResultCode,msg);
      }
      else if(op_code == UA_DIALOG_DEL_REQ)
      {
         DialogLeaveNotify(szResultCode,msg);
      }
      else if(op_code == UA_INVITE_RELAY)
      {
         DialogInviteRelay(szResultCode,msg);
      }
      else if(op_code == UA_INV_AGR_RELAY)
      {
         DialogAgreementRelay(szResultCode,msg);
      }
      else if(op_code == UA_OFF_NOTE_RESP)
      {
         OfflineNoteResp(szResultCode,msg);
      }
      else if(op_code == UA_NOTE_RELAY)
      {			
         NoteRelay(szResultCode,msg);
      }
      else if(op_code == UA_NOTE_REPLY_RELAY)
      {
         NoteConfirmRelay(szResultCode,msg);
      }
      else if(op_code == UA_APPLE_RESP)
      {
      	// alert('apple' +szResultCode );
      	 AppleWorkResponse(szResultCode,msg);
      }
      else if(op_code == UA_TYPE_RELAY)
      {
      	 //alert(szResultCode +":: "+msg);
         KeyTypeNotify(szResultCode,msg);
      }
      else if(op_code == UA_PHOTO_REQ_REQ)
      {
      }
      else if(op_code == UA_PHOTO_REQ_RELAY)
      {
      }
      else if(op_code == UA_ROOM_ENTER_RELAY)
      {
         DialogRoomEnterRelay(szResultCode,msg);  
      }
      else if(op_code == UA_ROOM_LEAVE_RELAY)
      {
         DialogRoomLeaveRelay(szResultCode,msg); 
      }else if(op_code == UA_EXTNOTI_RELAY) //시스템 연동 관련 2009.07.13 추가 
      {
         //DialogRoomLeaveRelay(szResultCode,msg); 
      }else if(op_code == UA_KEEPALIVE_DUMMY_RELAY)
      {
      	 keepAlive_packet(); 
      }else if(op_code == UA_RCS_INV_AGR_RELAY)
      {
      	 RcsInviteRes(szResultCode,msg); 
      }else if(op_code == UA_RCS_INVITE_RELAY) //상대방으로 부터 원격제어 요청이 들어 왔을때
      {
      	 RcsInviteRelay(szResultCode,msg); 
      }
      else
      {
         //alert('No Response Code:'+op_code);
      }
   }
   else
   {      
      //alert("Flash Response ERROR OPCODE   ["+ op_code +"]resultCode["+szResultCode+ "]" + resultmsg);
   }
}

//==============================================================================================
//	서버에 연결한다.
//  ip와 port를 object에 담아 flash의 server_connect를 호출한다.
//  @return
/*
function Connect_Server(srvip,srvport,crossport)
{
	  try{
 	      if(Socket_Connect == 1)
 	      {
 	          thisMovie("FClient").close();
 	          Socket_Connect = 0;
 	      }
		// alert('connect_server');
        var conn=new Object();
		    conn.ip = srvip ;
		    conn.port = srvport;
		    conn.crossport = crossport;
		    
		    thisMovie("FClient").connect(conn);
	  }catch(e){
		    //alert("[Error] Connect_Server : "+e);
		    parent.window.status = "[Error] Connect_Server : "+e;
	  }
	  
	  // thisMovie("FClient").connect(conn);
}*/
var cnt = 0;
function Connect_Server(srvip,srvport,crossport)
{
	  try{
 	      if(Socket_Connect == 1)
 	      {
 	          thisMovie("FClient").close();
 	          Socket_Connect = 0;
 	      }
			
			cnt++;
		
        var conn=new Object();
		    conn.ip = srvip ;
		    conn.port = srvport;
		    conn.crossport = crossport;
		   
		    thisMovie("FClient").connect(conn);
		    parent.window.status = "[Socket sucees...............] ::::::" + cnt;
		   // alert(thisMovie("FClient") + ":" + srvip+ ":" +srvport+ ":" +crossport);
	  }catch(e){
	  		//alert("실패" + thisMovie("FClient") + ":" + srvip+ ":" +srvport+ ":" +crossport+":" + e );
	  	 	//alert("실패" + thisMovie("FClient") + ":" + srvip+ ":" +srvport+ ":" +crossport+":" + e + ":"+rtnstr);
		    parent.window.status = "[Error] Connect_Server : "+e + ":::::" + cnt;
	  		
		    // 재접속 시도...........retry...........
		    
	  		if(cnt < 30000)
	  		 	window.setTimeout("Connect_Server(srvip,srvport,crossport);",1000);
	  			// window.setTimeout("Connect_Server("+srvip+","+srvport+","+crossport+");",1000);
	  			//Connect_Server(srvip,srvport,crossport);
	  			
	  				
	  		
		    
	  }
	  
	  // thisMovie("FClient").connect(conn);
}
//==============================================================================================
//  서버 접속을 끊는다.
//  @param	: 
//  @return 
function Close_Server()
{
    if(Login_Flag == 1)
    {
    		try
    		{
	  	    thisMovie("FClient").close();	  	    
	  	  } catch(e)
	  	  {
	  	  }
	  	  Login_Flag = 0;
        
        //버디창 Map Remove
        js_allClose(); 

    }
}

//==============================================================================================
//	메시지를 전송한다.
//  @
//  @return 
function Send_Msg(op_code,message)
{       
	//alert(op_code + ":" + message);
    //if((Login_Flag == 1)||(op_code == UA_LOGON_REQ)||(op_code == UA_INVITE_REQ))
	
    if((Login_Flag == 1)||(op_code == UA_LOGON_REQ)||(op_code == UA_INVITE_REQ)||(op_code == UA_ROOM_LEAVE_NOTI))
    {
      	try{
            var send=new Object();
            send.op_code = op_code;
            send.message = message;
            thisMovie("FClient").sendMsg(send);
      	}
      	catch(e){
            alert("[Error] Send_Msg : "+e);
      	}
      	
      	//thisMovie("FClient").sendMsg(send);
  	}
  	else
  	{
  		parent.window.status = "서버가 연결 되어 있지 않습니다.";
        //alert("서버가 연결 되어 있지 않습니다.");
  	}
}

//==============================================================================================
//	암호화 Flag를 설정한다.
//  @param	: flag :암호화 플래그 
//  @return 
function SetCipherFlag(flag)
{
   	try{
	      thisMovie("FClient").cipher_flag(flag);
   	}catch(e){
        alert("[Error] SetCipherFlag : "+e);
    }
}

function GetCipherFlag()
{
	  var cipher_flag = -1;

   	try{
	      cipher_flag = thisMovie("FClient").getCipher_flag();
   	}catch(e){
        alert("[Error] GetCipherFlag : "+e);
    }
    
    return cipher_flag;
}

//==============================================================================================
//	패킷 타입을 설정한다.
//  @param	: type 
//  @return 
function SetPackType(type)
{	
   	try{
	      thisMovie("FClient").packetType(type);
   	}catch(e){
        alert("[Error] SetPackType : "+e);
    }
}

function GetPackType()
{
	  var pack_type = -1;

   	try{
   	    pack_type = thisMovie("FClient").getPacketType();
   	}catch(e){
        alert("[Error] GetPackType : "+e);
    }
    
    return pack_type;
}

//==============================================================================================
//	Field 1을 설정한다.
//  @param	: field
//  @return 
function SetField1(field)
{
   	try{
	      thisMovie("FClient").field1(field);
   	}catch(e){
        alert("[Error] SetField1 : "+e);
    }
}

function GetField1()
{
	  var field1 = -1;

   	try{
   	    field1 = thisMovie("FClient").getField1();
   	}catch(e){
        alert("[Error] GetField1 : "+e);
    }
    
    return field1;
}

//==============================================================================================
//	Field 2을 설정한다.
//  @param	: filed 
//  @return 
function SetField2(field)
{
   	try{
        thisMovie("FClient").field2(field);
   	}catch(e){
        alert("[Error] SetField2 : "+e);
    }
}

function GetField2()
{
	  var field2 = -1;

   	try{
   	    field2=thisMovie("FClient").getField2();
   	}catch(e){
        alert("[Error] GetField2 : "+e);
    }
    
	  return field2;
}

//========================================================================
//euc-kr
var rtnstr;
function flash_load( file_name,width,height,ip,crossport)
{	
	//alert('flash_load');
	try{

	
		
		rtnstr = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" ";
		rtnstr += "codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=9,0,0,0 onerror=OnErr()\" ";
		rtnstr += "width=\'"+width+"'\" height=\'"+height+"'\" id='FClient' align=\"middle\">";
		rtnstr += "<param name=\"movie\" value=\'"+file_name+"'  /><param name=\"quality\" value=\"high\" />";
		rtnstr += "<param name=\"bgcolor\" value=\"#ffffff\" />";
		rtnstr += "<param name='allowScriptAccess' value='always' />";
		rtnstr += "<param name=\"FlashVars\" value='ip="+ip+"&crossport="+crossport+"&isutf=true&isUseBS=false' />";
		rtnstr += "<param name=\"wmode\" value=\"transparent\" /><embed src=\'"+file_name+"' ";
		rtnstr += "quality=\"high\" bgcolor=\"#ffffff\" width=\'"+width+"'\" height=\'"+height+"'\" ";
		rtnstr += "name='FClient' align=\"middle\" showLiveConnect='true' FlashVars='ip="+ip+"&crossport="+crossport+"'";
		rtnstr += "type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></object>";		
		return rtnstr;
	}catch(e){
		alert(e);
	}
}

//utf-8
/*
function flash_load( file_name,width,height,ip,crossport)
{	
	try{

		var rtnstr;
		
		rtnstr = "<object name='FClient' id='FClient' classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" ";
		rtnstr += "codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=9,0,0,0 onerror=OnErr()\" ";
		rtnstr += "width=\'"+width+"'\" height=\'"+height+"'\" align=\"middle\">";
		rtnstr += "<param name=\"movie\" value=\'"+file_name+"?v=100'  />";
		rtnstr += "<param name=\"quality\" value=\"high\" />";
		rtnstr += "<param name=\"bgcolor\" value=\"#ffffff\" />";
		rtnstr += "<param name='allowScriptAccess' value='always' />";
		rtnstr += "<param name=\"FlashVars\" value='isutf=true&isUseBS=false' />";
		rtnstr += "<param name=\"wmode\" value=\"transparent\" />"
		rtnstr += "</object>";
		
		document.write(rtnstr);
	}catch(e){
		alert(e);
	}
}
*/
function thisMovie(movieName)
{
		
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName];
    }
    else {
        return document[movieName];
    }
}

function OnErr()
{
    alert('Error');
}


//==============================================================================================
//	함수명 : GetUAConfig
//  설명 : UACONFIG 데이터처리
function GetUAConfig(msg)
{	
	var Record_arr = msg.split(chRecord_Enter);
	var usertype='';
   //alert("Record_arr:"+ Record_arr);
	uaconfArr = new Array(7);
	Record_arr.each(function(value,index)
									{
										if(value.indexOf("user_nm=") == 0)
										{
											uaconfArr[0] = value.substring(value.indexOf("=")+1);
											
										}else if(value.indexOf("displayname=") == 0)
										{
											uaconfArr[1] = value.substring(value.indexOf("=")+1);
										} else if(value.indexOf("mobile_phone=") == 0)
										{
											uaconfArr[2] = value.substring(value.indexOf("=")+1);
										} else if(value.indexOf("userid=") == 0)
										{
											uaconfArr[3] = value.substring(value.indexOf("=")+1);	//id@domain
										} else if(value.indexOf("usertype=") == 0 )
										{
											uaconfArr[4]=value.substring(value.indexOf("=")+1);
												
										}	else if(value.indexOf("org_cd=") == 0 )
										{
											uaconfArr[5]=value.substring(value.indexOf("=")+1);
												
										}	else if(value.indexOf("org_nm=") == 0 )
										{
											uaconfArr[6]=value.substring(value.indexOf("=")+1);
												
										}	
									});
	
	//setUAConfigHTML(uaconfArr);
	parent.window.status="GETUACONF 성공";

	//cho added	
	setUAConfigHTML(uaconfArr);
	window.setTimeout("AppleWorkRequest('30003101',user_id);", 1000);
	//js_getReqBuddyList();
	
	//alert(uaconfArr[4]);
	
}


/*
* XML Socket Flash를 통해 Timer를 실행한다.
  op_code: command
  message : Packet
  delay : 0이면 즉시 양수이면 (n Miliseconds)만큼 지연
  repeat : true, false
*/
function startTimer(op_code, message, delay, repeat)
{
	try{
		var send = new Object();
		send.op_code = op_code;
		send.message = message;
	}catch(e){
		alert("error, "+e);
	}
	//alert(op_code+','+message+','+delay+','+repeat);
  thisMovie("FClient").startTimer(send, delay, repeat);
  //thisMovie("FClient").sendMsg(send);
}

function stopTimer(id)
{
	thisMovie("FClient").stopTimer(id);
}

function timerMsg(code, msg)
{
  alert("타이머 : " + code + "," + msg );
}

//2009.07.13
function onSwfLoaded(){
	Connect_Server(server_ip,server_port,server_port);
}