var watcherMap = new HashMap();
var buddyMap = new HashMap();
var groupMap = new HashMap();

function HashMap()
{
   var m_objHash = new Object();


   this.put = function (key, value)
   {
      m_objHash[key] = value;
   }

   this.get = function (key)
   {
      return m_objHash[key];
   }

   this.remove = function (key)
   {
      var temp = m_objHash[key];
      delete m_objHash[key];
      return temp;
   }

   this.getKeys = function ()
   {
      var keys = new Array();
      for (var key in m_objHash)
      {
         keys.push(key);
      }
      return keys;
   }
}


function BuddyBlockListResp(szResult)
{
	//alert(szResult);
	var arr = szResult.split(chRecord_Enter);	
	//alert(arr);
	parent.blockListView(arr);
}




//==============================================================================================
//  Message : UA_BUDDY_ADD_RESP
//	함수명 : BuddyAddResp
//  설명 : 친구 추가 결과  UA_BADD_AUTH_RELAY
function BuddyAddResp(szResultCode,msg)
{
    var _arr = msg.split(chRecord);
    var arr = _arr[0].split(chField);
    
    //alert("친구 추가 결과 : " + msg);
    
   //같으면 RESPONSE 내 목록에 추가(OffLine)
   if (arr[0] == user_id )
   {
      //alert("친구추가 RESPONSE..");

      var arr = msg.split(chField);
      var Record_arr = arr[2].split(chRecord_Enter);
      var Field_arr;
      var cnt = 0;
	
      while(Record_arr[cnt] != "")
      {
      	Field_arr = Record_arr[cnt].split(chRecord);
      
      	if(Field_arr[0] != '1')
      	{
            if (Field_arr[0] != '')//맘에 안들엄.
            {
               //alert("결과:"+ Field_arr +"||");
               parent.defaultBuddyAdd(Field_arr);         
            }               
         }
         cnt++;
      }
   }

   else
   {
       //alert("친구추가 Relay..");
       parent.buddyAuthRelayWindow(arr[0], arr[1], arr[2]);
   }            
}

//==============================================================================================
//  Message : UA_BAUTH_MODIFY_RESP
//	함수명 : BuddyAuthModify
//  설명 : 친구 삭제/차단/차단해제 결과

function BuddyAuthModify(szResultCode,msg)
{
   var _arr = msg.split(chRecord);
   var arr = _arr[0].split(chField);
   
   var gubun="[내꺼]삭제/차단/차단해제";
    
  //alert("친구 삭제/차단/차단해제 결과 : " + msg);
   
   
    
   //같으면 RESPONSE 내 목록에 추가(OffLine)
   if (arr[0] == user_id )
      gubun="[내꺼]삭제/차단/차단해제";
   else
      gubun="[Replay]삭제/차단/차단해제";

   var arr = msg.split(chField);
   var Record_arr = arr[2].split(chRecord_Enter);
   var Field_arr;
   var cnt = 0;

   while(Record_arr[cnt] != "")
   {
   	Field_arr = Record_arr[cnt].split(chRecord);
   
   	if(Field_arr[0] != '1')
   	{
         if (Field_arr[0] != '')//맘에 안들엄.
         {
            //alert(gubun+ "결과:"+ Field_arr +"||");
            parent.updateBuddyStatusOne(Field_arr);
         }               
      }
      cnt++;
   }
}




function BuddyAddAcceptResp(szResultCode,msg)
{
    var _arr = msg.split(chRecord);
    var arr = _arr[0].split(chField);
    
   alert("친구추가 수락/거절 결과 : " + msg);
    
   //같으면 RESPONSE 내 목록에 추가할준비
   if (arr[0] == user_id )
   {
      //alert("친구추가 수락/거절 결과 RESPONSE..");

      var arr = msg.split(chField);
      var Record_arr = arr[2].split(chRecord_Enter);
      var Field_arr;
      var cnt = 0;
	
      while(Record_arr[cnt] != "")
      {
      	Field_arr = Record_arr[cnt].split(chRecord);
      
      	if(Field_arr[0] != '1')
      	{
            if (Field_arr[0] != '')//맘에 안들엄.
            {

               if (Field_arr[10] =='3')//승인이면
               { 
                  //alert("수락/거절내꺼:"+ Field_arr +"||");
                  parent.defaultBuddyAdd(Field_arr);         
               }
            }               
         }
         cnt++;
      }
   }

   else
   {
      var arr = msg.split(chField);
      var Record_arr = arr[2].split(chRecord_Enter);
      var Field_arr;
      var cnt = 0;
	
      while(Record_arr[cnt] != "")
      {
      	Field_arr = Record_arr[cnt].split(chRecord);
      
      	if(Field_arr[0] != '1')
      	{
            if (Field_arr[0] != '')//맘에 안들엄.
            {
               if (Field_arr[10] =='3') //승인상태이면
               {
                  //alert("수락/거절Relay..:"+ Field_arr +"||");
                  parent.updateBuddyStatusResp(Field_arr);         
               }
            }               
         }
         cnt++;
      }
   } 

}

function BuddyGroupCopyResp(szResultCode,msg)
{

   //alert("복사결과:"+ msg);
  
   var Record_arr = msg.split(chRecord_Enter);

   var Field_arr;
   var cnt = 0;

   while(Record_arr[cnt] != "")
   {
   	Field_arr = Record_arr[cnt].split(chRecord);
   
   	if(Field_arr[0] == '2')
   	{
         if (Field_arr[0] != '')//맘에 안들엄.
         {
            //alert("결과:"+ Field_arr +"||");
            parent.defaultBuddyAdd(Field_arr);
         }               
      }
      cnt++;
   }
}

function BuddyMoveGroupResp(szResultCode,msg)
{
}

function GetFriendProfile(msg)
{
   
    var arr = msg.split(chField_Tab);
    //alert(arr);
    parent.displayFiendInfo(arr);
}	



function transSex(val)
{
   var rslt ='';

   if (val =='M')      rslt = '남자';
   else if (val =='F')      rslt = '여자';

   return rslt;
}   


//=========================================================
// Apple 작업 결과에 대한 상세 처리 함수
//=========================================================

//==============================================================================================
//	함수명 : GetUserSearch
//  설명 : 사용자 검색 결과
function GetUserSearch(msg)
{
    var isNextPage = msg.substring(0, 1);             // 다음 페이지 유무
    var szSearchStr = msg.substring(2, msg.length);
    var Record_arr = szSearchStr.split(chRecord_Enter);
    
    var szRecord = null;
    
    var usertype = 0;
    
    var tot_cnt = 0;
    
    var row_range = 0;
    
    var rslt = new Array(Record_arr.length-1); //결과값
    
    try
    {
    	usertype = parseInt(uaconfArr[4]);
    } catch(e)
    {
    }
  
    
    switch (usertype)
    { 
    	
    	case 3 : 
    		szRecord = new Array(15);     		    		
    		break;    	
    		    	
    	default :  
    		szRecord = new Array(10);
    		break;
    }
    
    //로우셋 마지막에 항상 \n이 하나 더 들어옴에따로 하나 뺀다.
    for(i=0; i<Record_arr.length-1; i++)
    {
    	szRecord = Record_arr[i];
    	if(Record_arr[i] != '')
    	{
    			szRecord = Record_arr[i].split(chField_Tab);  

            if(usertype == '1' || usertype == '2')
  				{	   
                 rslt[i] = [ szRecord[3], szRecord[2], transCustomer(szRecord[0]), '','','','', szRecord[4] ];

						tot_cnt = szRecord[8];				
						row_range = szRecord[9];						  					
  					 			 
  				}
  				else if(usertype == '3')
  				{
                  rslt[i] = [ szRecord[3], szRecord[2], transCustomer(szRecord[0]), szRecord[8], szRecord[9], szRecord[11], szRecord[12], szRecord[4] ];

						tot_cnt = szRecord[13];	
						row_range = szRecord[14];										  					
  					
  				} 
  				else if(usertype == '4')
  				{

                  rslt[i] = [szRecord[3], szRecord[2], transCustomer(szRecord[0]), szRecord[8], '', szRecord[7], '', szRecord[4] ];
						tot_cnt = szRecord[8];
						row_range = szRecord[9];
  				}
    	}    	
    }
    
    parent.GetUserSearch(rslt, isNextPage, tot_cnt);
}




//==============================================================================================
//	함수명 : GetWatcherList
//  설명 : 와쳐리스트

function GetWatcherList(msg)
{
    // alert("와쳐리스트 결과 [" + msg + "]");

    watcherMap = new HashMap();		

    var Record_arr = msg.split(chRecord_Enter);
    var szRecord;
    for(nLoop = 0; nLoop < Record_arr.length; nLoop++) 
    {
        szRecord = Record_arr[nLoop];
        Field_arr = szRecord.split(chField_Tab);
        
        if(Field_arr.length == 4)
        {
            watcherMap.put(Field_arr[0], "0");
        }
    }
    
    window.setTimeout("StatusSend(user_id, js_getWatcherList(), '0','0', ''), 500");
}



function transCustomer(gubun)
{
   var rslt = '';
   
   if (gubun == '1')
   {
      rslt ='일반';
   }
   else if (gubun == '2')
   {
      rslt ='기업';
   }
   else if  (gubun == '3')
   {
      rslt ='직원';
   }
   else if  (gubun == '4')
   {
      rslt ='호스팅';
   }
   return rslt;
}   


function getDateStr( date )
{
	//var temp = replaceStr( date, ",", "" );
	if( date.length == 8 )
	{
		date = left( date, 4 ) + "-" + mid( date, 4, 2 ) + "-" + right( date, 2 );
		return temp;
	}

   else
   {      
      return date;
   }
}

