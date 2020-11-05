

//==============================================================================================
//	함수명 : OfflineNoteReq
//  설명 : 오프라인 쪽지 List 요구
function OfflineNoteReq()
{
    var op_code = UA_OFF_NOTE_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	함수명 : NoteSend
//  설명 : 쪽지 전달
function NoteSend(index, senderId, senderName, receiverList, fontInfo, secTime,
									onoffFlag, confirm, fileCount, fileSize, fileInfo, noteMessage)
{
    
    NoteSend2(index, 
    				senderId, 
    				senderName, 
    				receiverList, 
    				fontInfo, 
    				secTime,
						onoffFlag, 
						confirm, 
						'0', 
						'-1', 
						fileCount, 
						fileSize, 
						fileInfo, 
						noteMessage);    
}
//==============================================================================================
//	함수명 : NoteSend
//  설명 : 쪽지 전달
/* - index 유니크한 숫자(12바이트)
   - senderId : 보내는 사람 아이디
   - senderName : 보내는 사람 이름
   - receiverList : 받는 사람들 아이디(, 로 구분)
   - fontInfo : 폰트 정보(웹의 경우 css값으로대체하면되나?)
   - secTime : 보안타임(사용안함, 0으로 채우면됨)
   - onoffFlag : 온/오프라인 구분(0:온라인유저에게만 보냄,1:온/오프 모두 보냄)
   - confirm : 수신확인 체크 여부(N:체크안함, Y:체크함)
   - msggroup : 메세지타입(0:쪽지, 1:대화)
   - backimageindex :쪽지 배경 이미지 웹에선 무조건 -1로 고정
   - fileCount : 파일갯수
   - fileSize  : 파일용량(파일들의 용량 합계:사용안해도됨)
   - fileInfo : 파일 정보들(파일명,서버파일저장fullpath, 클라이언트 파일 경로, 파일사이즈, 파일순번, 파일서버아이피, 파일서버포트 |
   												 파일명,서버파일저장fullpath, 클라이언트 파일 경로, 파일사이즈, 파일순번, 파일서버아이피, 파일서버포트)
   							파일정보 예제: 개발관련예상질문.doc,data/20080225/1203901124429.2.11,C:\Documents and Settings\advan94\바탕 화면\,21504,0,192.168.224.25,3303|
				 											 SecureFX.EXE,data/20080225/1203901125853.5.39,C:\secureFX\,1605712,1,192.168.224.25,3303
				 				WEB의 경우 파일서버를 통해 파일을 올리지 않고 웹서버의 특정경로에 파일을 저장하기 때문에 파일서버아이피,포트는 웹서버의 아이피 포트를 setting.
				 				반드시 웹서버에 파일을 올린후 쪽지 패킷을 태워야함.   												 
   												
   - noteMessage : 쪽지 메세지
	
*/
function NoteSend2(index, senderId, senderName, receiverList, fontInfo, secTime,
									onoffFlag, confirm, msggroup, backimageindex, fileCount, fileSize, fileInfo, noteMessage)
{
	
	if(backimageindex == '') backimageindex = '-1'
    var op_code = UA_NOTE_REQ;
    
    //alert('msggroup:'+msggroup);
    //alert('backimageindex:'+backimageindex);
    
    if(fontInfo == '') fontInfo = "굴림,9,128,0,0,0,0,0";
    
		var strSendData = index + chField + 
											senderId + chField + 
											senderName + chField + 
											receiverList + chField + 
											fontInfo + chField + 
											secTime + chField + 
											onoffFlag + chField + 
											confirm + chField + 
											msggroup + chField +
											backimageindex + chField +
											fileCount + chField + 
											fileSize + chField + 
											fileInfo + chField + 
											noteMessage+ chField + 
											senderId;
											
		// alert( strSendData );
											
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