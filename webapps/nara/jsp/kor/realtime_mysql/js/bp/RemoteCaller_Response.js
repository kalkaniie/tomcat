
//==============================================================================================
//	함수명 : RcsInviteRes
//  설명 : 원격제어 요청 
//  value : userid   		 - 보내는사람 가상 ID
//          user_nm  		 - 보내는사람 이름
//          receive_user_id  - 원격제어할 사람(상대방ID)
//          room_id  		 - 룸아이디
//          real_user_id     - 보내는사람 실제 ID


function RcsInviteRes(szResultCode,msg)
{
	var arr = msg.split(chField);
	//alert(222);
	//prsbar.hide();
	if(parent.Ext.get('remoteCaller_loading')!=null)
		parent.Ext.get('remoteCaller_loading').hide();
        // parent.Ext.get('remoteCaller_loading').fadeOut({remove:true});     
  
    var szAcceptYN     = arr[0];  //1. 상대방 수락여부
    var szRecvID  	   = arr[1];  //2. 상대방 아이디
    var szRecvName     = arr[2];  //3. 상대방 이름
    var szSendID	   = arr[3];  //4. 자기 아이디
    var szRoomID       = arr[4];  //5. 룸아이디
    var szFlag  	   = arr[5];  //6. 원격제어 플래그
    var szView    	   = arr[6];  //7. 뷰플래그
    var szOption       = arr[7];  //8. 옵션
	var szDisplayID    = arr[8];  //9. 디스플래이 아이디
    RemoteCallStart(szAcceptYN ,szFlag ,szRecvID ,szRecvName ,szSendID ,szRoomID);
} 
