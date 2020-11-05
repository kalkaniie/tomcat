
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
    //alert(recvusers);
    var op_code = UA_DIALOG_REQ ;
		var strSendData = "";

    var objDate = new Date();
    var nTime = objDate.getTime();
    
		strSendData = dindex + chField + 
		              userid + chField + 
		              username + chField + 
		              recvusers + chField + 
		              strfont  + chField + 
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
//	함수명 : DialogInvite
//  설명 : 대화 초대
//  value : dindex      - Index
//          userid      - 보내는사람 ID
//          username    - 보내는사람 Display Name
//          recvusers   - 받는사람들. ','로 구분
//          curtusers   - 현재 대화 참여자들, ','로 구분
function DialogInvite(dindex, userid, username, recvusers, curtusers)
{
    var op_code = UA_INVITE_REQ;
		var strSendData = "";

		strSendData = dindex + chField + 
		              userid + chField + 
		              username + chField + 
		              recvusers + chField + 
		              curtusers + chField + 
		              "" 


		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogInviteAgreement
//  설명 : 대화 초대에 대한 응답
function DialogInviteAgreement(dindex, userid, username, recvuser, state)
{
    var op_code = UA_INV_AGR_SEND;
		var strSendData = "";

		//alert(dindex +"/"+userid +"/"+username+"/"+recvuser+"/"+state);


		strSendData = dindex + chField + 
		              userid + chField + 
		              username + chField + 
		              recvuser + chField + 
		              state + chField + 
		              "" 
		              
		Send_Msg(op_code,strSendData);
}


//==============================================================================================
//	함수명 : DialogRoomEnterNotice
//  설명 : 대화창 참여 
function DialogRoomEnterNotice(dindex, userid, username, recvusers, state)
{
    var op_code = UA_ROOM_ENTER_NOTI;
		var strSendData = "";

		//alert(dindex +"/"+userid +"/"+username+"/"+recvuser+"/"+state);
		strSendData = dindex + chField + 
		              userid + chField + 
		              username + chField + 
		              recvusers + chField + 
		              state + chField + 
		              "" 
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : DialogRoomLeaveNotice
//  설명 : 대화창 나감 
function DialogRoomLeaveNotice(dindex, userid, username, recvusers)
{
    var op_code = UA_ROOM_LEAVE_NOTI;
		var strSendData = "";

		//alert(dindex +"/"+userid +"/"+username+"/"+recvusers+"/");
		strSendData = "LeaveNotice___" + chField + 
		              dindex + chField + 
		              userid + chField + 
		              //username + chField + 
		              recvusers
		              
		Send_Msg(op_code,strSendData);
}