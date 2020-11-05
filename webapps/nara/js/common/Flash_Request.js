

//==============================================================================================
//	함수명 : LoginReq
//  설명 : 로그인
function LoginReq(userid,userpass)
{
    var op_code = UA_LOGON_REQ;
 		var strSendData = "";
		
		strSendData = userid + chField +
		              userpass + chField + 
		              "W";

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
//  value : userid    - 보내는사람 ID
//          recvusers - 받는사람들. ','로 구분
//          status1   - 변경될 상태
//          status2   - Tray 상태 구분
//          strstatus - 상태이름
		              
function StatusSend(userid,recvusers,status1,status2,strstatus)
{
    var op_code = UA_STAT_NOTI_REQ;
		var strSendData = "";
		
		strSendData = userid + chField + 
		              recvusers + chField + 
		              status1 + chField + 
		              status2 + chField + 
		              strstatus;
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : BuddyAddReq
//  설명 : 친구 추가 요청
//  value : userid    - 보내는사람 ID
//          groupidx  - 추가될 그룹 Index
//          buddyid   - 추가될 친구 ID
function BuddyAddReq(userid,groupidx,buddyid)
{
    var op_code = UA_BUDDY_ADD_REQ;
		var strSendData = "";
		
		strSendData = userid + chField + 
		              groupidx + chField + 
		              buddyid;
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : BuddyDelReq
//  설명 : 친구 삭제 요청
//  value : userid    - 보내는사람 ID
//          buddyidx  - 삭제할 친구 Index
//          buddyid   - 삭제할 친구 ID
function BuddyDelReq(userid,buddyidx,buddyid)
{
    var op_code = UA_BUDDY_DEL_REQ;
		var strSendData = "";
		
		strSendData = userid + chField + 
		              buddyidx + chField + 
		              buddyid;
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogIndexReq
//  설명 : 대화 Index 요구
//  value : userid    - 보내는사람 ID
//          recvid    - 상대방 ID
function DialogIndexReq(userid,recvid)
{
    var op_code = UA_DIALOG_INDEX_REQ ;
		var strSendData = "";
		
    var objDate = new Date();
    var nTime = objDate.getTime();
		
		strSendData = nTime + chField + 
		              userid + chField + 
		              recvid + chField + 
		              "";
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogSend
//  설명 : 대화내용전달
//  value : dindex      - Index
//          userid      - 보내는사람 ID
//          username    - 보내는사람 Display Name
//          recvusers   - 받는사람들. ','로 구분
//          strfont     - 화면 Font
//          strTime     - 보내는 시각
//          msg         - 대화 메세지
function DialogSend(dindex,userid,username,strfont,recvusers,msg)
{
    var op_code = UA_DIALOG_REQ ;
		var strSendData = "";

    var objDate = new Date();
    var nTime = objDate.getTime();

		strSendData = dindex + chField + 
		              userid + chField + 
		              username + chField + 
		              recvusers + chField + 
		              "굴림,9,128,0,0,0,0,0"  + chField + 
		              nTime + chField + 
		              msg;

		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogLeaveSend
//  설명 : 대화창 나감 알림
function DialogLeaveSend()
{
    var op_code = UA_DIALOG_DEL_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogInviteRelay
//  설명 : 대화 초대
function DialogInvite()
{
    var op_code = UA_INVITE_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogInviteAgreement
//  설명 : 대화 초대에 대한 응답
function DialogInviteAgreement()
{
    var op_code = UA_INV_AGR_SEND;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : OfflineNoteReq
//  설명 : 오프라인 쪽지 List 요구
function OfflineNoteReq()
{
    var op_code = UA_LOGON_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : NoteSend
//  설명 : 쪽지 전달
function NoteSend()
{
    var op_code = UA_NOTE_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : NoteConfirmSend
//  설명 : 쪽지 확인
function NoteConfirmSend()
{
    var op_code = UA_NOTE_REPLY_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : AppleWorkRequest
//  설명 : Apple 작업 요청
//  value : strSendData        - TR CODE
//          strdata            - 처리 Data
function AppleWorkRequest(trcode, strdata)
{
    var op_code = UA_APPLE_REQ;
		var strSendData = "";

    var szMsgID = ""; // 12자리의 값으로 서버로 보낸 후 다시 받는 값이다.
    //if(trcode == "10001102")
    if(trcode == "30003101")
    {
        szMsgID = "GETBUDDY____";
    }
    //else if(trcode == "10001107")
    else if(trcode == "30001102")
    {    	
    	szMsgID = "GETUACONF___";
    }
    else if(trcode == "30003105")
    {
    	szMsgID = "GETUSERSEARC";
    }
    
		strSendData = trcode + chField +
		              szMsgID + chField +
		              strdata;
		              		
		Send_Msg(op_code,strSendData);
}

