
//==============================================================================================
//  Message : UA_LOGON_RESP
//	함수명 : LoginResp
//  설명 : 로그인 결과
function LoginResp(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szResult = arr[0];
    //alert('szResult:'+szResult);
    if(szResult == "5")
    {
        Login_Flag = 1;
		    rtnmsg="로그인 성공";
		   
		    GetUAConfig(arr[1]);
		    //alert('LoginResp');
		    startTimer(UA_KEEPALIVE_DUMMY, user_id, 60*1000, true);
	  }
    else
    {
      Login_Flag = -1;
	    rtnmsg = "로그인 실패 [" + szResult + "]";
    }
    //alert('LoginResp:'+Login_Flag);
    parent.window.status = rtnmsg;
}

//==============================================================================================
//  Message : UA_DUP_LOG_RELAY
//	함수명 : DupLoginNotify
//  설명 : 중복 로그인 알림
function DupLoginNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
    alert('다른곳에서 고객님의 아이디로 로긴하였습니다.\n 메신저 서버와의 연결이 끊어집니다.');
    parent.buddyOff();
    
    
    //parent.mboxnWinM = null; 
}

//==============================================================================================
//  Message : UA_NAME_NOTI_RELAY
//	함수명 : NameNotify
//  설명 : 대화명 변경 알림
function NameNotify(szResultCode,msg)
{
    var _msg = msg.split(chRecord)
    var arr = _msg[0].split(chField);

    var szSendID      = arr[0];     // 보내는 사람 ID
    var szDialogName  = arr[1];     // 변경된 대화명
     parent.NameNotify(szSendID, szDialogName);
    //alert("대화명 변경 : " + szSendID+"/"+szDialogName);
}

//==============================================================================================
//  Message : UA_STAT_NOTI_RELAY
//	함수명 : StatusNotify
//  설명 : 상태 변경 알림
function StatusNotify(szResultCode,msg)
{
    //alert("상태 변경 알림 : " + msg);
    
    var arr = msg.split(chField);
    
    var szSendID      = arr[0];     // 보내는 사람 ID
    var szStatus      = arr[1];     // 변경된 상태
    var szTrayStatus  = arr[3];     // 변경된 Tray 상태값 - 사용않해도 됨(0:알리지 않음, 1:알림)
    var szStatusName  = arr[4];     // 변경된 상태 이름
    var szServerIP    = arr[5];     // 변경된 상대방이 로그인한 메신저 서버 Index
    
    var szServerPort  = arr[6];     // 변경된 상대방이 로그인한 메신저 서버 Index
    parent.window.status="상태 변경 : "+szSendID+"/"+szStatus+"/"+szTrayStatus+"/"+szStatusName+"/"+szServerIP+"/"+szServerPort;
    
   // updateBuddy(szSendID, szStatus, szServerIdx);

   if (szStatus =='0')
      watcherMap.put(szSendID, szStatus);
   else
      watcherMap.remove(szSendID);

   updateBuddy(szSendID, szStatus, '0');



}

