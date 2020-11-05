
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
    parent.js_notify_note(arr);
    /*arr[0] : 메세지인덱스
    arr[1] : 보낸사람계정
    arr[2] : 보낸사람명
    arr[3] : 폰트정보
    arr[4] : 보낸시간
    arr[5] : 보안타임(사용안해도됨)
    arr[6] : 온/오프라인 수신여부
    arr[7] : 수신확인여부
    arr[8] : 첨부파일갯수
    arr[9] : 파일사이즈
    arr[10] : 파일정보
    arr[11] : 본문*/
    //수신확인여부가 true(Y or 1)일 경우 수신확인 packet을 보내야함.
    
}

//==============================================================================================
//  Message : UA_NOTE_REPLY_RELAY
//	함수명 : NoteConfirmRelay
//  설명 : 쪽지 확인 전달
function NoteConfirmRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
    
    /*
    arr[0] : 메세지인덱스
    arr[1] : 보낸사람계정
    arr[2] : 보낸사람명
    arr[3] : 폰트정보
    arr[4] : 보낸시간
    */
}


