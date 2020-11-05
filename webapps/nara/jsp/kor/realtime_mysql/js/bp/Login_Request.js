//==============================================================================================
//	함수명 : LoginReq
//  설명 : 로그인
function LoginReq(userid,userpass)
{
    var op_code = UA_LOGON_REQ;
 		var strSendData = "";
		var _user_type = '';
		if(userid.indexOf('.com') != -1)
		{
				_user_type = '3';
		} else
		{
				_user_type = '1';
		}
		
		strSendData = userid + chField +
		              userpass + chField + 
		              ''+chField+
		              ''+chField+
		              "W"+chField+
		              _user_type+chField+
		              '0';

		Send_Msg(op_code,strSendData);
}


//==============================================================================================
//	함수명 : LoginReq
//  설명 : 리얼 타임 로그인 
function LoginReq(userid)
{
    var op_code = UA_MAIL_LOGON_REQ;
 		var local_ip = '192.168.32.151';
		var local_port = '80';
		
		strSendData = userid + chField +
		              local_ip + chField + 
		              local_port+chField+
		              'M';

		Send_Msg(op_code,strSendData);
}
//==============================================================================================
//	함수명 : NameModifySend
//  설명 : 대화명 변경 알림
//  value : userid      - 보내는사람 ID
//          recvusers   - 받는사람들. ','로 구분
//          changename  - 바뀐대화명
function NameModifySend(userid,recvusers,changename)
{
    var op_code = UA_NAME_NOTI_REQ;
		var strSendData = "";
		
		strSendData = userid + chField +
		              recvusers + chField + 
		              changename;
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : StatusSend
//  설명 : 상태 변경 알림
//  value : userid    - 보내는사람 ID(mandatory)
//          recvusers - 받는사람들. ','로 구분(mandatory)
//          status1   - 변경될 상태(mandatory) : 
//          status2   - Tray 상태 구분(mandatory)  0:알리지 않음, 1:알림(현재 무조건 1로 세팅하면됨)
//          strstatus - 상태이름(optional)

// 상태정의 - status1 사용
// status_name             status1 
// STATUS_CONSULT_REFUSAL = -9   //상담불가능,
// STATUS_PRETEND_OFFLINE = -4   //오프라인인척. 
// STATUS_VACATION        = -3   // 휴가중
// STATUS_UNKNOWN         = -2   //친구가 아닌 상태를 알수없는 사용자.
// STATUS_OFF             = -1   //오프라인. 
// STATUS_ON              =  0   // 사용중
// STATUS_AWAY            =  1   // 자리비움
// STATUS_WORKING         =  2   // 지금바쁨, 예전 다른용무중
// STATUS_OUT             =  3   // 외출중 
// STATUS_CALLING         =  4   // 통화중
// STATUS_EATING          =  5   // 식사중
// STATUS_MEETING         =  6   // 회의중
// STATUS_ONLYMSG         =  7   //쪽지만 받음
// STATUS_CUSTOMER        =  8   // 사용자 정의 상태.


function StatusSend(userid,recvusers,status1,status2,strstatus)
{
		//alert('StatusSend');
    var op_code = UA_STAT_NOTI_REQ; //1400, 1401
		var strSendData = "";
		
		strSendData = userid + chField + 
		              recvusers + chField + 
		              status1 + chField + 
		              status2 + chField + 
		              strstatus + chField + 
		              server_ip + chField + 
		              server_port;
		
		Send_Msg(op_code,strSendData);
		
		
}


//==============================================================================================
//	함수명 : GetWatcherList
//  설명 : Online Watcher List 가져오기
function WatcherListReq(userid, usertype)
{
    var strInput = "";

	strInput = userid + chField_Tab +  // 시용자 ID
               usertype;               // 사용자 Type 사용자타입 - 1:일반_개인고객,2:일반_기업고객,3:회사직원,4:호스팅고객 
		              	    
	AppleWorkRequest("30002104",strInput);
}
