//==============================================================================================
//	함수명 : GetBuddyWork
//  설명 : 버디 리스트 처리



function GetBuddyWork(msg)
{
   
	var Record_arr = msg.split(chRecord_Enter);
	var Field_arr;
	
	//alert('Record_arr:'+Record_arr);
	var groupArray = new Array();
	listArray  = new Array();
	
	var cnt = 0;
	var groupcnt = 0;
	var listcnt = 0;
	while(Record_arr[cnt] != "")
	{
		Field_arr = Record_arr[cnt].split(chRecord);
		if(Field_arr[0] == '1')	//그룹
		{
			groupArray[groupcnt] = new Array(3);
			groupArray[groupcnt][0] = Field_arr[1]; // 그룹 Index
			groupArray[groupcnt][1] = Field_arr[2]; // 그룹 이름
			groupArray[groupcnt][2] = Field_arr[3]; // default구분, '0' OR 'N' 이면 그룹 삭제 불가.

			groupMap.put(Field_arr[1], groupArray[groupcnt]);
			//alert(groupArray[groupcnt][0] + ":" +groupArray[groupcnt][1] + ":" + groupArray[groupcnt][2]);
			groupcnt++;
			//alert('group:'+groupArray[groupcnt][0] + ":" + groupArray[groupcnt][1]+ ":" +groupArray[groupcnt][2]);
			
		} else
		{		
			listArray[listcnt]  = new Array(17);

			listArray[listcnt][0] = Field_arr[1]; // 버디Index
			
			var id_domain = Field_arr[2].split('@');
			
			listArray[listcnt][1] = id_domain[0]; // 버디ID
			listArray[listcnt][2] = id_domain[1]; // 버디DOMAIN
			listArray[listcnt][3] = Field_arr[3]; // 버디이름
			listArray[listcnt][4] = Field_arr[4]; // 버디대화명
			listArray[listcnt][5] = Field_arr[5]; // 버디그룹인덱스
			listArray[listcnt][6] = Field_arr[6]; // 버디상태값
			//listArray[listcnt][7] = Field_arr[9]; // 버디로그인서버index
			listArray[listcnt][7] = Field_arr[2]; //버디아이디@도메인
			listArray[listcnt][8] = Field_arr[8]; //버디로그인서버IP
			listArray[listcnt][9] = Field_arr[9]; // 버디로그인서버PORT
			listArray[listcnt][10] = Field_arr[10]; //버디인증상태(0:알수없음,1:승인신청발신,2:승인신청수신,3:승인, -1:거절, -2:거절및차단,-3:삭제, -4:삭제및차단, -5:내가상대방차단 -6:상대방이차단)
			listArray[listcnt][11] = Field_arr[11]; //버디사용자타입(1:일반_개인고객,2:일반_기업고객,3:회사직원,4:호스팅고객)
			listArray[listcnt][12] = Field_arr[12]; //버디요청자이름
			listArray[listcnt][13] = Field_arr[13]; //버디요청메세지
			listArray[listcnt][14] = Field_arr[14]; //버디고객등급
			listArray[listcnt][15] = Field_arr[15]; //핸드폰번호
			listArray[listcnt][16] = Field_arr[7]; //버디메모

         	buddyMap.put(Field_arr[2]+"|"+Field_arr[5] , listArray[listcnt]);
			//alert(listArray[listcnt][1] + " : "  + listArray[listcnt][2]  + " : "  + listArray[listcnt][3] );
			listcnt++;
			//alert('buddy:'+listArray[listcnt][1]);
			
		}
		cnt++;
	}
	
	//by 박세현 추가 
	GETBuddy_Flag = 1;
	
}




//BuddyListArray(listArray)에 버디를 추가한다.
function addBuddy(buddyarr)
{	
		listArray.push(buddyarr);
}

//특정버디의 정보를 알아온다.
//버디index, 버디ID, 버디DOMAIN, 버디이름, 버디대화명, 버디그룹인덱스, 
//버디상태값, 버디로그인서버index, 아이디@도메인
function getBuddyInfo(buddyid)
{
		
   var gorupNode = parent.root.childNodes;
   var groupLength = gorupNode.length;
	
   var buddyNode;
   var buddyLength;
   var buddy_id;
   var arr;
   var tmp
 
   for(var i=0; i<groupLength; i++) 
   { 
 
      buddyNode = gorupNode[i].childNodes; 
      buddyLength = buddyNode.length;

      for(var k=0; k<buddyLength; k++) 
      {
 
         buddy_id = buddyNode[k].attributes.id;
         tmp = buddy_id.split("|");

         if (tmp[0] == buddyid)
         {        

            arr = buddyMap.get(buddyNode[k].attributes.id);
   	      return arr;
            break;
         }
      }
   } 
}

/*var szSendID      = arr[0];     // 보내는 사람 ID
var szStatus      = arr[1];     // 변경된 상태
var szTrayStatus  = arr[2];     // 변경된 Tray 상태값 - 사용않해도 됨
var szStatusName  = arr[3];     // 변경된 상태 이름
var szServerIdx   = arr[4];     // 변경된 상대방이 로그인한 메신저 서버 Index*/

function updateBuddy(buddyid, _status, imsidx)
{	
/*	
	listArray.each(function(valueTop, indexTop)
	{	
	 	listArray[indexTop].each(function(value, index)
		{													
			//alert('before:'+listArray[indexTop]);		 	
		 	if(value == buddyid)
		 	{
		 			listArray[indexTop][6] = _status;
		 			listArray[indexTop][7] = imsidx;
		 			//alert(listArray[indexTop][6]);
		 	}
		});
		//alert('after:'+listArray[indexTop]);		 	
	});
*/

	parent.updateBuddyStatusAll(buddyid, _status);

	
	//버디상태 변화에 따른 대화창 상태 아이콘 업데이트 및
	//메세지 입력창 업데이트..
   try
   {
      curtIDHash.each(function(pair)
      { 
         var array = pair.value.split(",");
         if(array.size() < 2) 
         {
            array.each(function(value, index)
            { 
               if(value == buddyid)
               {
            
                  if(_status == -1 || _status == -4)
                  {
                    // 창 화면 밖으로 일때 메세지 전송
                	if(!Object.isUndefined(parent.openPopDialHash.get(pair.key))) {
                	    var szCont = "<br><font color='red'>대화 상대가 오프라인 상태이므로 메시지를 입력 할 수 없습니다.</font>";
                        parent.openPopDialHash.get(pair.key).js_pop_receiveAlertmsgUpdate(pair.key, szCont, '1');
                	}            

                     parent.$('msg_'+pair.key).disabled = true;
                     parent.$('msg_'+pair.key).style.backgroundColor='#C0C0C0';
                     parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML = parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML + "<br><font color='red'>대화 상대가 오프라인 상태이므로 메시지를 입력 할 수 없습니다.</font>";
                     parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop = parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop + 100;
                  } 
                  else 
                  {
                	if(!Object.isUndefined(parent.openPopDialHash.get(pair.key))) {
                	    var szCont = "<br><font color='blue'>대화 상대가 다시 온라인 상태이므로 메시지를 입력 할 수 있습니다.</font>";
                        parent.openPopDialHash.get(pair.key).js_pop_receiveAlertmsgUpdate(pair.key, szCont, '2');
                	}                       

                     parent.$('msg_'+pair.key).disabled = false;
                     parent.$('msg_'+pair.key).style.backgroundColor='#FFFFFF';
                     
                     if(_status == 0)    
                     {
                        parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML = parent.$('mlMsg_window_cntnt_'+pair.key).innerHTML + "<br><font color='blue'>대화 상대가 다시 온라인 상태이므로 메시지를 입력 할 수 있습니다.</font>";
                        parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop = parent.$('mlMsg_window_cntnt_'+pair.key).scrollTop + 100;
                     }
                    // 창 화면 밖으로 일때 메세지 전송
                  }
               }
            });
         }
      });
   }
   catch(e){}

}  



function js_getReqBuddyList()
{			
		var url = '/jsp/kor/messenger/test/sendTest.jsp?body=30003101GETBUDDY____'+user_id;
		
		var submitAjax = new Ajax.Request(
			url, 
			{
				method : 'get',
				requestHeaders : new Array("X-UserAgent-Naravision","Naravision"),
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				//parameters: Form.serialize("inputForm"), 
				onComplete: submitBuddyList
			});
		
		
}
	
function submitBuddyList(data)
{
		var sResult = data.responseText;
	
		var szResultCode = sResult.substring(0, 4);
		var msg = sResult.substring(4)
		
		
		AppleWorkResponse(szResultCode, msg);
      parent.setBuddyExpand();
}

function js_getWatcherList()
{

   
   var watcher='';
   var keys = watcherMap.getKeys();
   var len = keys.length;
   var val ='';


   for (var i=0; i<len; i++)
   {
      val = watcherMap.get(keys[i]);
      
      if (keys[i]!='')
      {
         if (val =="-4" || val =="-1")
         {}
         else
         {
            watcher = keys[i]+ "," + watcher;
         }
      }
   }      
   

   if(watcher != '')
      return watcher.substring(0, watcher.length-1);
   else
      return watcher;

}



function js_getWatcherChatList()
{

   var len;
   var chatMap = new HashMap();
   var keys = watcherMap.getKeys();
   var buddyArr;
   var arr;
   var val ='';
   var n;
   var childNode;
   var groupIdx;

   if (keys !=null)
      len = keys.length;


   for (var i=0; i<len; i++)
   {
      val = watcherMap.get(keys[i]);
      
      if (keys[i] !='')
      {
         if(val >="0" && (val !="-4" || val !="-1") )
         {
            var child = parent.root.childNodes;
            var lens = child.length;
   
            for (var k=0; k<lens; k++)
            {
               buddyArr = buddyMap.get(keys[i] +"|" +child[k].attributes.id);
   
               if (buddyArr !=null)            
               {
                  arr = new Array(2);
                  arr[0] = buddyArr[1] + "@" +buddyArr[2];//id@domain
                  arr[1] = buddyArr[3];//이름
                  
                  chatMap.put(arr[0], arr);
               }
            }
         }
      }
   }      

   return chatMap;
}




function js_getWatcherChatListTest()
{
   var map = js_getWatcherChatList();

   alert(map.getKeys());
}
