
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
	  }
    else
    {
      Login_Flag = -1;
	    rtnmsg = "로그인 실패 [" + szResult + "]";
    }
    //alert('LoginResp:'+Login_Flag);
    parent.frames[0].window.status = rtnmsg;
}

//==============================================================================================
//  Message : UA_DUP_LOG_RELAY
//	함수명 : DupLoginNotify
//  설명 : 중복 로그인 알림
function DupLoginNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_NAME_NOTI_RELAY
//	함수명 : NameNotify
//  설명 : 대화명 변경 알림
function NameNotify(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szSendID      = arr[0];     // 보내는 사람 ID
    var szDialogName  = arr[1];     // 변경된 대화명

    alert("대화명 변경 : " + szSendID+"/"+szDialogName);
}

//==============================================================================================
//  Message : UA_STAT_NOTI_RELAY
//	함수명 : StatusNotify
//  설명 : 상태 변경 알림
function StatusNotify(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szSendID      = arr[0];     // 보내는 사람 ID
    var szStatus      = arr[1];     // 변경된 상태
    var szTrayStatus  = arr[2];     // 변경된 Tray 상태값 - 사용않해도 됨
    var szStatusName  = arr[3];     // 변경된 상태 이름
    var szServerIdx   = arr[4];     // 변경된 상대방이 로그인한 메신저 서버 Index

    parent.frames[0].window.status="상태 변경 : " + szSendID+"/"+szStatus+"/"+szTrayStatus+"/"+szStatusName+"/"+szServerIdx;
    updateBuddy(szSendID, szStatus, szServerIdx);
    
    
}

//==============================================================================================
//  Message : UA_BUDDY_ADD_RELAY
//	함수명 : BuddyAddResp
//  설명 : 친구 추가 상대방에게 알림
function BuddyAddRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_BUDDY_ADD_RESP
//	함수명 : BuddyAddResp
//  설명 : 친구 추가 결과
function BuddyAddResp(szResultCode,msg)
{
    var arr = msg.split(chField);

    alert("친구 추가 결과 : " + msg);
    
    //버디리스트
    
}

//==============================================================================================
//  Message : UA_BUDDY_DEL_RELAY
//	함수명 : BuddyDelResp
//  설명 : 친구 삭제 결과
function BuddyDelResp(szResultCode,msg)
{
    var arr = msg.split(chField);
    
    alert("친구 삭제 결과 : " + msg);
}

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
		
		//alert("대화 Index : " + szIndex+"/"+szDlgIndex+"/"+szSendID+"/"+szRecvID);
		
		processMakeDialogue(szIndex, szDlgIndex, szSendID, szRecvID);
		
		
		//parent.frames[1].$('dialogueid').innerText = arr[1];
		
		//alert(parent.frames[1].$('dialogueid').innerText);
    
}

//==============================================================================================
//  Message : UA_DIALOG_RELAY
//	함수명 : DialogRelay
//  설명 : 대화내용전달
function DialogRelay(szResultCode,msg)
{
		//alert(msg);
    var arr = msg.split(chField);

    var szIndex         = arr[0];     // 대화창 Index
    var szSendID        = arr[1];     // 보내는 사람 ID
    var szSendName      = arr[2];     // 보내는 사람 대화명
    var szFont          = arr[3];     // Font
    var szDate          = arr[4];     // 시간
    var szCont          = arr[5];     // 내용
    var szDisplayID     = arr[6];     // 화면에 보여지는 ID

    var id_domain = szSendID.split('@');

    var objDate = new Date();
    objDate.setTime(Number(szDate));
    
    //alert(arr);
    js_receivemsg(szIndex, szSendID, szSendName, szFont, szDate, szCont, szDisplayID);
    /*var strMsg = MainForm.dialogstr.value;
    strMsg += id_domain[0] + " : " +szCont + "\r\n" ;
    MainForm.dialogstr.value = strMsg;*/
    
    
    //alert("대화내용 : " + szIndex+"/"+szSendID+"/"+szSendName+"/"+szFont+"/"+objDate+"/"+szDisplayID);
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
}

//==============================================================================================
//  Message : UA_INV_AGR_RELAY
//	함수명 : DialogAgreementRelay
//  설명 : 대화 초대에 대한 응답 전달
function DialogAgreementRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_OFF_NOTE_RESP
//	함수명 : OfflineNoteResp
//  설명 : 오프라인 쪽지 List
function OfflineNoteResp(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_NOTE_RELAY
//	함수명 : NoteRelay
//  설명 : 쪽지 전달
function NoteRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_NOTE_REPLY_RELAY
//	함수명 : NoteConfirmRelay
//  설명 : 쪽지 확인 전달
function NoteConfirmRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_TYPE_NOTI
//	함수명 : KeyTypeNotify
//  설명 : 키보드 입력중 알림
function KeyTypeNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_LOGON_RESP
//	함수명 : AppleWorkResponse
//  설명 : Apple 작업 결과
function AppleWorkResponse(szResultCode,msg)
{		
    var result_arr = msg.split(chField);
    //alert(result_arr);
    var szTrCode    = result_arr[0];  // TR Code
    var szMsgID     = result_arr[1];  // 보냈던 메세지 ID
    var szRtnCode   = result_arr[2];  // 결과값
    var szResult    = result_arr[3];  // 결과 Data
  
    if(szRtnCode == "0200")
    {
        if((szTrCode == "30003101")&&(szMsgID == "GETBUDDY____")) // 버디 리스트 처리
        {
            GetBuddyWork(szResult);
        }
        else if((szTrCode == '30001102')&&(szMsgID == "GETUACONF___"))
        {
        	GetUAConfig(szResult);	
        }
        else if((szTrCode == '30003105')&&(szMsgID == "GETUSERSEARC"))
        {
        	  GetUserSearch(szResult);	
        }
    }
    
    Work_Status = "";
}

//=========================================================
// Apple 작업 결과에 대한 상세 처리 함수
//=========================================================

//==============================================================================================
//	함수명 : GetUserSearch
//  설명 : 사용자 검색 결과
function GetUserSearch(msg)
{
    alert("사용자 검색 결과 [" + msg + "]");

    var isNextPage = msg.substring(0, 2);             // 다음 페이지 유무
    var szSearchStr = msg.substring(2, msg.length);
    
    var Record_arr = szSearchStr.split(chRecord_Enter);
    var szRecord;

    var szField1,szField2,szField3,szField4,szField5,szField6,szField7,szField8,szField9,szField10,szField11,szField12,szField13,szField14,szField15;

    for(nLoop = 0; nLoop < Record_arr.length; nLoop++) 
    {
        szRecord = Record_arr[nLoop];
        Field_arr = szRecord.split(chField_Tab);
        
        if(Field_arr.length == 15)
        {
            szField1 = Field_arr[0]; //번호
            szField2 = Field_arr[1]; //사용자ID
            szField3 = Field_arr[2]; //사용자상태
            szField4 = Field_arr[3]; //대화명
            szField5 = Field_arr[4]; //접속매체(W:A)
            szField6 = Field_arr[5]; //사용자이름
            szField7 = Field_arr[6]; //성별
            szField8 = Field_arr[7]; //생일
            szField9 = Field_arr[8]; //양음력
            szField10 = Field_arr[9]; //핸드폰번호
            szField11 = Field_arr[10]; //팩스번호
            szField12 = Field_arr[11]; //전화번호
            szField13 = Field_arr[12]; //회사번호
            szField14 = Field_arr[13]; //부서번호
            szField15 = Field_arr[14]; //전체갯수
    
            alert(szField1+"/"+szField2+"/"+szField3+"/"+szField4+"/"+szField5+"/"+szField6+"/"+szField7+"/"+szField8+"/"+szField9+"/"+szField10+"/"+szField11+"/"+szField12+"/"+szField13+"/"+szField14+"/"+szField15);
        }
    }
}

