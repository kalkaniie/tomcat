
//==============================================================================================
//  Message : UA_DIALOG_INDEX_RELAY
//	함수명 : DialogIndexResp
//  설명 : 대화 Index 요구 결과
function DialogIndexResp(szResultCode,msg)
{
	
    var arr = msg.split(chField);

    var szIndex     = arr[0];  // Index
    var szDlgIndex  = arr[1];  // 대화창 Index
    var szSendID    = arr[2];  // ID1
    var szRecvID    = arr[3];  // ID2
	//alert(szResultCode);	
	//alert(szIndex);
	//alert(szDlgIndex);
    //alert("대화 Index : " + szIndex+"/"+szDlgIndex+"/"+szSendID+"/"+szRecvID);
	
	var rlSendID = szSendID.split('@');
	var rlRendID = szRecvID.split('@');
    
	//szDlgIndex = rlSendID[0] + "_" + rlRendID[0];
	

	processMakeDialogue(szIndex, szDlgIndex, szSendID, szRecvID);
	
		
		
	//hidef.$('dialogueid').innerText = arr[1];
		
	//alert(hidef.$('dialogueid').innerText);
    
}

//==============================================================================================
//  Message : UA_DIALOG_RELAY
//	함수명 : DialogRelay
//  설명 : 대화내용전달
function DialogRelay(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szIndex         = arr[0];     // 대화창 Index
    var szSendID        = arr[1];     // 보내는 사람 ID
    var szSendName      = arr[2];     // 보내는 사람 대화명
    var szFont          = arr[3];     // Font
    var szDate          = arr[4];     // 시간
    var szCont          = arr[5].split(chRecord)[0];     // 내용
    var szDisplayID     = ""; //arr[6];     // 화면에 보여지는 ID

    var id_domain = szSendID.split('@');

    var objDate = new Date();
    objDate.setTime(Number(szDate));
    
   
    js_receivemsg(szIndex, szSendID, szSendName, szFont, szDate, szCont, szDisplayID);
    /*var strMsg = MainForm.dialogstr.value;
    strMsg += id_domain[0] + " : " +szCont + "\r\n" ;
    MainForm.dialogstr.value = strMsg;*/
    
    //alert(szCont);
    //alert("대화내용 : " + szIndex+"/"+szSendID+"/"+szSendName+"/"+szFont+"/"+objDate+"/"+szDisplayID+"/"+szCont);
}

//==============================================================================================
//  Message : UA_DIALOG_DEL_REQ
//	함수명 : DialogLeaveNotify
//  설명 : 대화창 나감 알림
function DialogLeaveNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_INVITE_RELAY
//	함수명 : DialogInviteRelay
//  설명 : 대화 초대 전달
function DialogInviteRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
    //alert(msg);

    var szIndex         = arr[0];     // 대화창 Index
    var szSendID        = arr[1];     // 보내는 사람 ID
    var szSendName      = arr[2];     // 보내는 사람 대화명
    var szCurtID        = arr[3];     // 현재 대화 참여중인 사람
    
    js_invite_relay(szIndex, szSendID, szSendName, szCurtID);

		

}

//==============================================================================================
//  Message : UA_INV_AGR_RELAY
//	함수명 : DialogAgreementRelay
//  설명 : 대화 초대에 대한 응답 전달
function DialogAgreementRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
    
    var szIndex         = arr[0];     // 대화창 Index
    var szSendID        = arr[1];     // 보내는 사람 ID
    var szSendName      = arr[2];     // 보내는 사람 성명
    var szState         = arr[3];     // 초대에 대한 응답
    
    js_invite_arg_relay(szIndex, szSendID, szSendName, szState);


}

//==============================================================================================
//  Message : UA_ROOM_ENTER_RELAY
//	함수명 : DialogRoomEnterRelay
//  설명 : 대화창 참여에 대한 응답
function DialogRoomEnterRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
    
    //alert(arr);

    var szIndex         = arr[0];     // 대화창 Index
    var szSendID        = arr[1];     // 보내는 사람 ID
    var szSendName      = arr[2];     // 보내는 사람 성명
    var szState         = arr[3];     // 초대에 대한 응답

    js_room_inter_relay(szIndex, szSendID, szSendName, szState)

}

//==============================================================================================
//  Message : UA_ROOM_LEAVE_RELAY
//	함수명 : DialogRoomLeaveRelay
//  설명 : 대화창 참여에 대한 응답
function DialogRoomLeaveRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
    
    //alert(arr);

    var szIndex         = arr[0];     // 대화창 Index
    var szSendID        = arr[1];     // 보내는 사람 ID
    var szSendName      = arr[2];     // 보내는 사람 성명
    //var szSendName      = "";     // 보내는 사람 성명

    szSendID = szSendID.replace(chRecord, "");
    js_room_leave_relay(szIndex, szSendID, szSendName);

}