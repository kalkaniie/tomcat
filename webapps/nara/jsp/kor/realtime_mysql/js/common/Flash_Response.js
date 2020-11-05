

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
    //alert(szResultCode);
    //alert(msg);
    var result_arr = msg.split(chField);
    //alert(result_arr);
    var szTrCode    = result_arr[0];  // TR Code
    var szMsgID     = result_arr[1];  // 보냈던 메세지 ID
    var szRtnCode   = result_arr[2];  // 결과값
    var szResult    = result_arr[3];  // 결과 Data
    
    
    if(szRtnCode == "0200")
    {
      //alert('here');
    	// alert(szMsgID + ":" + szTrCode );
        if((szTrCode == "30003101")&&(szMsgID == "GETBUDDY____")) // 버디 리스트 처리
        {
        	//alert(szTrCode+'||'+szMsgID+'||'+szResult);
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
        else if((szTrCode == '30002104')&&(szMsgID == "GETWATCHER__")) // 와쳐리스트 처리
        {
        	
        	  GetWatcherList(szResult);	
        }

        else if((szTrCode == '30003102')&&(szMsgID == "ADDMYGROUPNM")) // 그룹추가
        {
			parent.GetAppendMyGroup(szResult);
            parent.window.status = '[30003102]그룹추가';
        }

        else if((szTrCode == '30003103')&&(szMsgID == "UDTMYGROUPNM")) // 그룹수정
        {
						parent.window.status = '[30003102]그룹변경';
        }

        else if((szTrCode == '30003104')&&(szMsgID == "DELMYGROUPNM")) // 그룹삭제
        {
						parent.window.status = '[30003102]그룹삭제';
        }

        else if((szTrCode == '30003112')&&(szMsgID == "FRIENDPROFIL")) //친구 프로파일
        {
						GetFriendProfile(szResult);
        }

        else if((szTrCode == '30002102')&&(szMsgID == "DISPYNAMEUDT")) //내 대화명 수정
        {
						parent.window.status = '[30002102]대화명수정';
        }

        else if((szTrCode == '30003113')&&(szMsgID == "BUDDYMEMOUDT")) //버디메모 수정
        {
						// alert("버디메모수정:" +result_arr);
						//GetFriendProfile(szResult);
        } else if((szTrCode == '30004102')&&(szMsgID == "OFFNOTECNT__")) //오프라인 쪽지 카운트
        {
        		parent.GetOffLineNoteCnt(szResult);
					
						//GetFriendProfile(szResult);
				} else if((szTrCode == '30003115')&&(szMsgID == "GETBLOCKLIST"))	//차단리스트
				{
					//alert('-------');
					BuddyBlockListResp(szResult);
					
					//alert("BlockList :"+szResult)	;
				} else if((szTrCode == '30003108')&&(szMsgID == "BUDDYMOVE___"))	//버디이동
				{
					BuddyMoveGroupResp(szResultCode,msg);
				} 
   
    } else
    {
    	alert("Flash Response ERROR TRCODE["+ szTrCode + "]" + szRtnCode+", "+szResult);
    }
    
    Work_Status = "";
}


