//==============================================================================================
//	함수명 : RcsInviteReq
//  설명 : 원격제어 요청 
//  value : userid   		 - 보내는사람 가상 ID
//          user_nm  		 - 보내는사람 이름
//          receive_user_id  - 원격제어할 사람(상대방ID)
//          room_id  		 - 룸아이디
//          real_user_id     - 보내는사람 실제 ID


function RcsInviteReq(user_id, user_nm, receive_user_id, room_id ,real_user_id )
{
   var op_code = UA_RCS_INVITE_REQ;
   var strSendData = "";
  // alert(user_id + "      :    " +receive_user_id );
		
   strSendData = //user_id+ chField +  //보내는 사람
   				 user_id+ chField +  //보내는 사람
                 user_nm + chField +
                 //receive_user_id + chField + //받는 사람
                 receive_user_id + chField + //받는 사람
                 room_id + chField +
                 "1" + chField + 	//원격제어타입
                 "1" + chField +	//뷰타입
                 "1101" + chField +	//옵션
                 real_user_id ;
             
   Send_Msg(op_code,strSendData);
}
