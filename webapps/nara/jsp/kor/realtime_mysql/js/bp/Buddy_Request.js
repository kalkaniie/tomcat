//==============================================================================================
//	함수명 : BuddyAddReq
//  설명 : 친구 추가 요청
//  value : userid    - 보내는사람 ID
//          groupidx  - 추가될 그룹 Index
//          buddyid   - 추가될 친구 ID
function BuddyAcceptReq(owner_id, buddy_id, auth_type)
{
   var op_code = UA_BADD_ACCEPT_REQ;
   var strSendData = "";
		
   strSendData = owner_id + chField + 
                 buddy_id + chField +
                 auth_type;
		              
   Send_Msg(op_code,strSendData);
}




//==============================================================================================
//	함수명 : BuddyAddReq
//  설명 : 친구 추가 요청
//  value : userid    - 보내는사람 ID
//          groupidx  - 추가될 그룹 Index
//          buddyid   - 추가될 친구 ID
function BuddyAddReq(owner_id,owner_nm,buddy_id,owner_group_idx,reqMsg)
{
    var op_code = UA_BADD_AUTH_REQ;
		var strSendData = "";
		
		strSendData = owner_id + chField + 
		              owner_nm + chField + 
		              buddy_id + chField +
		              owner_group_idx + chField + 
		              reqMsg;
		//alert(strSendData)	;	              
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


function BuddyCopyGroupReq(groupindex,owner_id,buddy_id)
{
	var op_code = UA_GROUP_COPY_REQ;
	var strSendData = "";
	strSendData = groupindex + chField +
								owner_id + chField +
								buddy_id;
	Send_Msg(op_code,strSendData);
}

function BuddyMoveGroupReq(buddyindex, groupindex)
{
	AppleWorkRequest("30003108", buddyindex+chField_Tab+groupindex);	
}

function myDisplayNameReq(displayName)
{
    var op_code = UA_NAME_NOTI_REQ;
	 var strSendData = "";

		strSendData = user_id + chField + 
		              js_getWatcherList() + chField + 
		              displayName + chField +
		              server_ip + chField + 
		              server_port;
		
      //alert("strSendData:"+ strSendData);

		Send_Msg(op_code,strSendData);
}


//==============================================================================================
//	함수명 : userSearchReq
//  설명 : 버디검색
//  value : schType    - 검색조건
//          keyword  - 검색어
//          start_num   - 페이지번호

function userSearchReq(schType, keyword, start_num)
{
	strSendData = user_id+chField_Tab+
								uaconfArr[4]+chField_Tab+
								uaconfArr[5]+chField_Tab+
								schType+chField_Tab+
								keyword+chField_Tab+
								start_num;
	 //alert(strSendData);
   AppleWorkRequest('30003105', strSendData);
}


function authModifyReq(owner_id, buddy_id, buddy_idx, auth_type)
{
    var op_code = UA_BAUTH_MODIFY_REQ;
	 var strSendData = "";

		strSendData = owner_id + chField + 
		              buddy_id + chField + 
		              buddy_idx + chField +
		              auth_type;
		
      //alert("authModifyReq:"+ strSendData);

		Send_Msg(op_code,strSendData);
}