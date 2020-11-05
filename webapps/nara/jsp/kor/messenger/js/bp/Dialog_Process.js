// 대화창 관리를 위한 Hash 
var dialogueHash = new Hash();

// 1:N 채팅을 위한 Hash
var recvIDArray = new Array();
var curtIDHash = new Hash();
var curtIDCnt = 0;

/*
	대화창을 연다.
	@param1:Index
	@param2:대화창 Index
	@param3 보내는사람 ID
	@param4 받는사람ID
	1.상대방 온/오프라인확인	
	2.이미 열려진 대화창인지 확인
*/
function processMakeDialogue(szIndex, szDlgIndex, szSendID, szRecvID)
{    if(szDlgIndex == -1)
	{
			updateBuddy(szRecvID, '-1', '');
			return;
	}
	var buddyinfo = getBuddyInfo(szRecvID);	
	
	if(!js_isExistDialogue(szDlgIndex))
	{	
		
	 	js_curtUserAdd(szDlgIndex, buddyinfo[7]);
	    parent.makeDialogue(szDlgIndex, buddyinfo[4], buddyinfo[7]);
    
	} else
	{	
	    parent.$('msg_'+szDlgIndex).focus();
	}
	
}

/*
	대화창 아이디에 해당하는 대화창이 존재하는지 체크. (사용안함)
*/
function js_isExistDialogue(dialogueID)
{

	var check_id = 'mlMsg_window_'+dialogueID;
    
	var obj = $(check_id);
	if(obj == null)
	{   
  		return false;	

	}

    return true;
}


/* 서버에 대화 메세지를 보낸다.
//  value : dindex      - Index
//          userid      - 보내는사람 ID
//          username    - 보내는사람 Display Name
//          recvusers   - 받는사람들. ','로 구분
//          strfont     - 화면 Font
//          strTime     - 보내는 시각
//          msg         - 대화 메세지
*/
function js_sendmsg(dialogueID, recvID)
{	
	var trnsMsg = '';
    var recvusers = '';
    var setFont = ''; 
	if(parent.event.keyCode == 13)
	{
		
		var msg = parent.$F('msg_'+dialogueID);
        var mlMsg_ctnt = parent.$('mlMsg_window_cntnt_'+dialogueID);
        var mlMsg_textarea = parent.$('msg_'+dialogueID);
         
        // msg 가 없을때 
        if(msg.blank()) {
            return;   
        }

//        var isBold      = (mlMsg_textarea.style.fontWeight == '700' ? 'true' : 'false');
//        var isItalic    = (mlMsg_textarea.style.fontStyle == 'italic' ? 'true' : 'false');
//        var isUnderline = (mlMsg_textarea.style.textDecoration == 'underline' ? 'true' : 'false');
        var isBold      = (mlMsg_textarea.style.fontWeight == '700' ? '1' : '0');
        var isItalic    = (mlMsg_textarea.style.fontStyle == 'italic' ? '1' : '0');
        var isUnderline = (mlMsg_textarea.style.textDecoration == 'underline' ? '1' : '0');
        var fontName    =  parent.$('fontName_'+dialogueID).value;
        var fontSize    =  parent.$('fontSize_'+dialogueID).value;
        var fontColor   = (mlMsg_textarea.style.color == '' ? '#000000' : mlMsg_textarea.style.color);
        var fontColors ="";
        
        if(fontColor.length >6){
        		for(var k=1; k<6; k=k+2){
        		fontColors = fontColors +js_HexToDec(fontColor.substring(k,k+2)) +","
        		}
        }else{
        		for(var k=1; k<6; k=k+2){
        		fontColors = fontColors + '00'  +","
        		}
        }		
        
        //setFont = "WEB_"+ isBold + "," + isItalic + "," + isUnderline + "," + fontName + "," + fontSize + "," + fontColor;
        setFont =  fontName + "," + fontSize + "," + fontColors  +  isBold + "," + isItalic + "," + isUnderline;
       
        trnsMsg = js_msgStyeTras(msg, isBold, isItalic, isUnderline, fontName, fontSize, fontColor);

		mlMsg_ctnt.innerHTML = mlMsg_ctnt.innerHTML + "<b>"+uaconfArr[1]+":</b><br/>"+ trnsMsg;
		mlMsg_ctnt.scrollTop = mlMsg_ctnt.scrollTop + 600;
		mlMsg_textarea.value="";
		mlMsg_textarea.focus();
        
        if(curtIDHash.get(dialogueID) == "") {
            recvusers = recvID;
        } else {
            recvusers = curtIDHash.get(dialogueID);
        }

        DialogSend(dialogueID,uaconfArr[3],uaconfArr[1],setFont,recvusers, msg.stripTags().stripScripts());
	}
}

/*
    서버에서 전달된 메세지를 처리한다.
    대화창 Index, 보내는 사람 ID, 보내는 사람 대화명, Font, 시간, 내용, 화면에 보여지는 ID
*/
function js_receivemsg(szIndex, szSendID, szSendName, szFont, szDate, szCont, szDisplayID)
{       
        var msg = '';

		if(!js_isExistDialogue(szIndex))
		{   
            js_curtUserAdd(szIndex, szSendID);
            parent.makeDialogue(szIndex, szSendName, szSendID);
            
		} else
		{	
		    //alert("js_receivemsg : 다이얼 로그 전환")
		}
        var mlMsg_ctnt = parent.$('mlMsg_window_cntnt_'+szIndex);


        var arrSzFont = szFont.split(",");
//        var arrChkIM = arrSzFont[0].split("_");
//        
//        if(Object.isUndefined(arrChkIM[1])) {
//            msg = szCont + "<br/>";   
//
//        } else {
        if(szFont = null || szFont=='') {
            msg = szCont + "<br/>";   
        } else {
            var HexTmp = "";
        		for(var kk=2; kk<5; kk++){
        			HexTmp += js_DecToHex(parseInt(arrSzFont[kk])) ;
        		}
        		
            msg = js_msgStyeTras(szCont,arrSzFont[5], arrSzFont[6], arrSzFont[7], arrSzFont[0], arrSzFont[1], HexTmp);
          //  msg = js_msgStyeTras(szCont, arrChkIM[1], arrSzFont[1], arrSzFont[2], arrSzFont[3], arrSzFont[4], arrSzFont[5]);

        }
            

		mlMsg_ctnt.innerHTML = mlMsg_ctnt.innerHTML + "<b>"+ szSendName +":</b><br/>"+ msg;
		mlMsg_ctnt.scrollTop = mlMsg_ctnt.scrollTop + 600;
        
        // 창 화면 밖으로 일때 메세지 전송
		if(!Object.isUndefined(parent.openPopDialHash.get(szIndex))) {
	        parent.openPopDialHash.get(szIndex).js_pop_receivemsg(szIndex, szSendID, szSendName, szFont, szDate, msg, szDisplayID);
		}

}

/*
    초대 하기
*/

function js_inviteUser(szIndex, selection)
{
    var invertUserids = "";

    if(selection != "") {
   	for( var i = 0; i < selection.length;  i++ ) {
    
    	     invertUserids = selection[i].get("userId")+ "," + invertUserids;
    	}
    	invertUserids = invertUserids + "";
    	invertUserids = invertUserids.split(",").without("")
        
        var currIDHashVal = curtIDHash.get(szIndex);
    
        if(currIDHashVal != null && currIDHashVal != uaconfArr[3])
        {
            curtID = invertUserids + "," + uaconfArr[3] + "," + currIDHashVal;
        } 
        
        DialogInvite(szIndex, uaconfArr[3], uaconfArr[1], invertUserids, curtID);  
    } else {
        alert("초대하실 분을 선택해 주세요");   
    }
	
	
}
/*
    초대 하기
*/
/*
function js_invite(szIndex, szSendID, szSendName, szRecvID) 
{
    //alert("js_invite");
    // 현재 대화 참여중인 ID 를 넣는다.
    var currIDHashVal = curtIDHash.get(szIndex);

    if(currIDHashVal != null && currIDHashVal != szSendID)
    {
        curtID = szRecvID + "" + szSendID + "," + currIDHashVal;
    }  

    DialogInvite(szIndex, szSendID, szSendName, szRecvID, curtID);   
} 
*/

/*
    초대 응답 여부 확인 
*/
function js_invite_relay(szIndex, szSendID, szSendName, szCurtID) {

    js_curtDialogSet(szIndex, szSendID);
    var arrCurtUser = szCurtID.split(",").without(uaconfArr[3]);
    // 대화 참여중인 ID 저장
    js_curtUserSet(szIndex, arrCurtUser);
	parent.dialogueWindow.create(szIndex, szSendName, szSendID, 'show');
    parent.js_hiddenLayCreate(szIndex);

    js_invite_arg(szIndex,uaconfArr[3],uaconfArr[1],szSendID,'accept');
}


/*
   초대 응답
*/
function js_invite_arg(szIndex, szSendID, szSendName, szRecvID, argState) {
    
    //alert("js_invite_arg");

    var szCont = "<font color='red'>대화에 참여 합니다.</font><br/>";
    js_alertMsg(szIndex, szCont) // 메시지 출력
    DialogInviteAgreement(szIndex, szSendID, szSendName, szRecvID, argState);
    //js_curtBuddyload(szIndex);
    js_curtUserDisplay(szIndex); //대화창에 참여한 사람들 display


    
}

/*
    초대에 대한 응답 전달
*/
function js_invite_arg_relay(szIndex, szSendID, szSendName, szState){

    //alert("js_invite_arg_relay");
        
    var recvusers =curtIDHash.get(szIndex);
    var currIDHashVal = curtIDHash.get(szIndex);
    curtIDHash.set(szIndex, currIDHashVal + ","+  szSendID);
    js_room_inter(szIndex, szSendID, szSendName, recvusers, szState);
    
}

/*
   대화창 참여
*/
function js_room_inter(szIndex, szSendID, szSendName, szRecvID, argState) {

    //alert("js_room_inter");

    //var currIDHashVal = curtIDHash.get(szIndex);
    DialogRoomEnterNotice(szIndex, szSendID, szSendName, szRecvID, argState);
  	szCont = "<font color='red'>" + szSendName + "님께서 대화에 참여 하셨습니다.</font><br/>";
    js_alertMsg(szIndex, szCont) // 메시지 출력
    js_curtUserDisplay(szIndex); //대화창에 참여한 사람들 display
    
}

/*
   대화창 참여 확인 
*/
function js_room_inter_relay(szIndex, szSendID, szSendName, argState) {

    js_curtUserAdd(szIndex, szSendID);
    
    szCont = "<font color='red'>" + szSendName + "님께서 대화에 참여 하셨습니다.</font><br/>";
    js_alertMsg(szIndex, szCont) // 메시지 출력

    js_curtUserDisplay(szIndex); //대화창에 참여한 사람들 display
    
}

/*
    대화창 닫기
*/
function js_removeDialog(szIndex)
{
	//alert(szIndex + ":::1");
    //alert("js_removeDialog-szIndex : " + szIndex);
    js_room_leave(szIndex);
} 

/*
    대화창 나감 알림
*/
function js_room_leave(szIndex)
{

    //alert("js_room_leave-szIndex : " + szIndex);
	//alert(szIndex + ":::2");
    var recvusers = curtIDHash.get(szIndex);
	//alert(szIndex + ":::3");
    DialogRoomLeaveNotice(szIndex, uaconfArr[3], uaconfArr[1], recvusers)
   // alert(szIndex + ":::4");
   // js_saveMsg(szIndex, recvusers);
   // alert(szIndex + ":::5");
    curtIDHash.unset(szIndex);
   // alert(szIndex + ":::6");
    //alert(szIndex);
   // alert(szIndex + ":::7");
  	$('mlMsg_window_main').removeChild($('mlMsg_window_'+szIndex));
  	//alert(szIndex + ":::8");
  	
} 

/*
    대화창 나감
*/
function js_room_leave_relay(szIndex, szSendID, szSendName)
{
    //alert("js_room_leave_relay-szIndex : " + szIndex);
    var curtUserCnt = js_curtUserUnset(szIndex, szSendID);
    js_curtUserDisplay(szIndex) //대화창에 참여한 사람들 display

    if (curtUserCnt > 1) {
        szSendName = szSendID;
        szCont = "<font color='red'>" + szSendName + "님께서 나가셨습니다.</font><br/>";
        js_alertMsg(szIndex, szCont) // 메시지 출력
    }
    
} 

    
function js_curtUserDisplay(szIndex) {
    
    var curtUserList = "";
    var curtUserVal = curtIDHash.get(szIndex) + "";

    var arrCurtUsers = curtUserVal.split(",");
    /*
    */
    if(arrCurtUsers.size() > 1) {
        var watcherHash = js_getWatcherChatList();
    
        for(i = 0 ; i < arrCurtUsers.length ; i++) 
        {   
           var watcherHashVal = watcherHash.get(arrCurtUsers[i]); 
           curtUserList = curtUserList + watcherHashVal[1] + " (" + watcherHashVal[0] + ")" + "<br/>"     
        }
    
        parent.$('mlMsg_window_crutUser_'+szIndex).innerHTML = "";
        parent.$('mlMsg_window_crutUser_'+szIndex).style.display='block';
        parent.$('mlMsg_window_crutUser_'+szIndex).innerHTML = "<a href=\"javascript:hidef.js_curtInviteUserShow('"+szIndex+"');\">대화 참여자 ("+ arrCurtUsers.size() +"명)</a>";
        parent.$('mlMsg_window_cntnt_'+szIndex).style.height='90%';

        var curtUserListNode = parent.$('mlMsg_window_crutUser_'+szIndex);
    
        var newCurtItem = parent.document.createElement("div");
        newCurtItem.className="msgWdw_crut_user_item";
        newCurtItem.setAttribute("id", 'mlMsg_window_crutUser_item_'+szIndex);  
      	curtUserListNode.appendChild(newCurtItem); 	  	
        parent.$('mlMsg_window_crutUser_item_'+szIndex).innerHTML = curtUserList;

    } else {
        parent.$('mlMsg_window_crutUser_item_'+szIndex).innerHTML = "";
        parent.$('mlMsg_window_crutUser_'+szIndex).removeChild(parent.$('mlMsg_window_crutUser_item_'+szIndex));
        parent.$('mlMsg_window_crutUser_'+szIndex).style.display='none';
        parent.$('mlMsg_window_cntnt_'+szIndex).style.height='100%';
    }

	if(!Object.isUndefined(parent.openPopDialHash.get(szIndex))) {
        parent.openPopDialHash.get(szIndex).js_curtUserDisplay(szIndex);
	} 
    
}

function js_curtInviteUserShow(szIndex) {
    
    if(parent.$('mlMsg_window_crutUser_item_'+szIndex).style.display == "block") {
        parent.$('mlMsg_window_crutUser_item_'+szIndex).style.display='none'; 
        parent.$('mlMsg_window_cntnt_'+szIndex).style.height='90%';
    } else {
        parent.$('mlMsg_window_crutUser_item_'+szIndex).style.display='block'; 
        parent.$('mlMsg_window_cntnt_'+szIndex).style.height='75%';
        
    }
}



function js_alertMsg(szIndex, szCont) {

    parent.$('mlMsg_window_cntnt_'+szIndex).innerHTML = parent.$('mlMsg_window_cntnt_'+szIndex).innerHTML + szCont;
 
    // 창 화면 밖으로 일때 메세지 전송
	if(!Object.isUndefined(parent.openPopDialHash.get(szIndex))) {
        parent.openPopDialHash.get(szIndex).js_pop_receiveAlertmsg(szIndex, szCont);
	}        
}



/*
    초대하기 DATA 
*/
function js_curtBuddyload(szIndex) {
    
    var arrCrutBuddy = new Array();
    var currIDHashVal = curtIDHash.get(szIndex) + "";  
    var watcherHashVal = js_getWatcherChatList();
    var keys = watcherHashVal.getKeys();

    if(!Object.isUndefined(currIDHashVal) && currIDHashVal != "") {

        var arrChatUser = currIDHashVal.split(",");
    
        for( var i = 0; i < arrChatUser.length; i++) {
            keys = keys.without(arrChatUser[i]);
        }
        
    }

    var buddyArr;
    var len = keys.length;
    
    for ( var i = 0; i < len; i++)
    {
        buddyArr = watcherHashVal.get(keys[i]);
        arrCrutBuddy[i] = new Array(2);
        arrCrutBuddy[i][0] = buddyArr[1];
        arrCrutBuddy[i][1] = buddyArr[0];
    }      
    return arrCrutBuddy;

} 

// Font 처리 
function js_msgStyeTras(msg, isBold, isItalic, isUnderline, fontName, fontSize, fontColor) {

    msg = (isBold == 'true' ? "<b>" : "") + (isItalic == 'true' ? "<i>" : "") + (isUnderline == 'true' ? "<u>" : "") + "<span style=\"font-family:" + fontName + "; font-size:" + fontSize + "pt; color:" + fontColor + ";\">" + msg + "</span>" + (isBold == 'true' ? "</b>" : "") + (isItalic == 'true' ? "</i>" : "") + (isUnderline == 'true' ? "</u>" : "") + "<br/>\n";
    return msg;

}
// 대화내용 저장하기
function js_saveMsg(dialogueID, recvid) {
    
    var msg = parent.$('mlMsg_window_cntnt_'+dialogueID).innerHTML;
    var url = "dialogue_execute.jsp";
    //msg = msg.stripTags();
    msg = replaceAll(msg,"#","");
    var recvid = recvid.split(",")[0];
    
    var buddyinfo = getBuddyInfo(recvid);
    // alert(uaconfArr[3] + "  " + uaconfArr[1]+ "  " + uaconfArr[7]+ "  " + recvid);
    var index = "";
    var senderId = uaconfArr[3];
    var senderName = uaconfArr[1];
    
    var recv_id = "";
    try{
    	recv_id = buddyinfo[7];
    	//recv_id = uaconfArr[3];
    }catch(e){
    	recv_id = uaconfArr[3];
    }
    var recv_user_nm = "";
    try{
    	//recv_id = buddyinfo[3];
    	recv_id = buddyinfo[3];
    }catch(e){
    	recv_user_nm = uaconfArr[3];
    }
   
    var receiverList = "";
    var noteMessage = msg;
    var msg_group = "1"; //1:일반대화 2:쪽지
    var backimageindex = "-1";
    
    var params = "cmd=save&sessionid=" + dialogueID + "&send_id=" + senderId.split("@")[0] + "&send_domain=" + senderId.split("@")[1] + "&recv_id=" + recv_id.split("@")[0] + "&recv_domain=" + recv_id.split("@")[1] + "&recv_user_nm=" + recv_user_nm +"&contents=" + msg;
    //alert(params);
     new Ajax.Updater({ success: 'out' }, url, {
          method: 'post',
             asynchronous:false,
                onSuccess  : function(returnValue)
                {
                    //alert("성공");
                },
          contentType: 'application/x-www-form-urlencoded',      
          parameters: params  
            }
        );
    //NoteSend2(index, senderId, senderName, receiverList, fontInfo, secTime, onoffFlag, confirm, msg_group, backimageindex, fileCount, fileSize, fileInfo, noteMessage)   
}

//로그 아웃시
function js_allClose() {
    
    var curtDialogueIDs = curtIDHash.keys();
    curtDialogueIDs = curtDialogueIDs + "";
    if (curtDialogueIDs != "") {
        var arrCurtDialogueIDs = curtDialogueIDs.split(",");
        for(var i = 0; i < arrCurtDialogueIDs.length; i++) {
             js_removeDialog(arrCurtDialogueIDs[i]);
        }
           
    }
    
}


//16진수 10진수로
function js_HexToDec( myHexStr )
 {
   myHexStr = "0x" + myHexStr
   var kHexVale = parseInt(myHexStr)
   
   return kHexVale
 }
 
 //10진수 16진수
function js_DecToHex(x_dec) {
        var x_Hex = new Array();
        var x_serial = 0;
        var x_over16 = x_dec;
        var x_tempNum = 0;
        while(x_dec > 15) {
            var x_h = x_dec % 16; //나머지
            x_dec = parseInt(x_dec/16); //몫
            x_Hex[x_serial++] = (x_h > 9 ? String.fromCharCode(x_h + 55) : x_h); //16진수코드변환
        }
        //마지막은 몫의 값을 가짐
        x_Hex[x_serial++] = (x_dec > 9 ? String.fromCharCode(x_dec + 55) : x_dec); //16진수코드변환
        //몫,나머지,나머지,.....
        var retValue = "";
        for(var i=x_Hex.length ; i>0 ;i--) {
            retValue += x_Hex[i-1];
        }
        if(retValue.length < 2)
        	retValue ="0" +retValue;
        	
        return retValue+"";
    }

/*
function js_testClose() {
    alert("aaa");
    var buddyid = "010078@ibk.com";
    var _status = -1;

    curtIDHash.each(function(pair)
                        { 
                            var array = pair.value.split(",");
                                if(array.size() < 2) {
                                    array.each(function(value, index)
                                           { 
                                                if(value == buddyid) {     
                                                     
                                                     if(_status == -1 || _status == -4)
                                                     {
                                                          parent.$('msg_'+pair.key).disabled = true;
                                                          parent.$('msg_'+pair.key).style.backgroundColor='#C0C0C0';
                                                          parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML = parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML + "<br><font color='red'>대화 상대가 오프라인 상태이므로 메시지를 입력 할 수 없습니다.</font>";
                                                          parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop = parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop + 100;
                                                            // 창 화면 밖으로 일때 메세지 전송
                                                        	if(!Object.isUndefined(parent.openPopDialHash.get(pair.key))) {
                                                        	    
                                                        	    var szCont = "<br><font color='red'>대화 상대가 오프라인 상태이므로 메시지를 입력 할 수 없습니다.</font>";
                                                                parent.openPopDialHash.get(szIndex).js_pop_receiveAlertmsg(pair.key, szCont);
                                                                parent.openPopDialHash.get(szIndex).$('msg_'+pair.key).disabled = true;
                                                        	} 
                                                     } else {
    
                                                          parent.$('msg_'+pair.key).disabled = false;
                                                          parent.$('msg_'+pair.key).style.backgroundColor='#FFFFFF';  
    
                                                          if(_status == 0)    
                                                          {
                                                           parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML = parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML + "<br><font color='blue'>대화 상대가 다시 온라인 상태이므로 메시지를 입력 할 수 있습니다.</font>";
                                                           parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop = parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop + 100;
                                                          }
                                                            // 창 화면 밖으로 일때 메세지 전송
                                                        	if(!Object.isUndefined(parent.openPopDialHash.get(pair.key))) {
                                                        	    var szCont = "<br><font color='blue'>대화 상대가 다시 온라인 상태이므로 메시지를 입력 할 수 있습니다.</font>";
                                                                parent.openPopDialHash.get(szIndex).js_pop_receiveAlertmsg(pair.key, szCont);
                                                                parent.openPopDialHash.get(szIndex).$('msg_'+pair.key).disabled = false;
                                                        	}                                                          
                                                     }
                                                }
                                           });
                                    }
    
                        });
}
*/