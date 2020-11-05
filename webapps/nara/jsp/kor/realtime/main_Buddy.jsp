<%@page language="java" contentType="text/html;charset=utf-8"%>

<div id="tree-div" style="overflow:auto;position:absolute;left:10px;top:434px;">
<!-- div id="tree-div" style="overflow:auto;position:absolute;left:9px;top:234px;"-->
</div>

<!--div id="progress-div" style="overflow:auto;position:relative;left:9px;top:214px;"-->
<div id="progress-div" style="position:absolute;left:10px;top:660px;"></div>


<!--div class="add_box3" id="mlAdd_displayName"-->
<div class="dispName_box" id="mlAdd_displayName" style="display:none;">
<input type="text" name="myDisplayName" size="25" maxlength="20" onKeyDown="if(event.keyCode == 13) myDisplayNamecheckEnter(this,event.keyCode)" onblur="myDisplayNamecheck(this)" style="background:#CEE1F8;">
</div>


<div id='searchResult'></div>


<br><br>
<!--input type=button value='히든리프레쉬' onclick="javascript:hidef.location.reload();"-->
<!--input type="button" value="버디리스트" onClick="alert(hidef.buddyMap.getKeys());"-->

<!--input type="button" value="채팅와처" onClick="hidef.js_getWatcherChatListTest();"-->
<!--input type="button" value="와처" onClick="watcherList();"-->
<!--input type="button" value="재시작" onclick="parent.restart();"-->
<!--input type="button" value="로그인" onclick="startMessenger();"-->

<Script>

  
  
function startMessenger()
{	
  //var users_id = $('user_id').value;
  
	$('tree-div').innerHTML = '';
   try
   {
     //	init();
     // Ext.onReady(init());
     // Ext.onReady(web_messenger_init());
      
   }
   catch(e){
   alert(e);
   }
   
   //hidef.location.reload();
  //hidef.location.href="hideframe.jsp?user_id=<%=(String)session.getAttribute("USERS_IDX")%>&passwd=<%=(String)session.getAttribute("PASSWD")%>";
   //hidef.location.href="hideframe.jsp?user_id="+$('users_id').value+"&passwd="+$('password').value;
   //hidef.location.href="hideframe.jsp?user_id="+users_id+"&passwd=0000";
}      
   
function  restart()
{
   try
   {
      panel.destroy();
      init();  
      hidef.setUAConfigHTML(hidef.uaconfArr);
      setBuddyExpand();
      
      $('progress-div').hide();
   }
   catch(e){}      
   
   /*if(progress != 'undefined')
   {
   	progress.reset();   
   	progress.destroy();
   } else
   {
   	alert('null');
   }*/
}   
   
 Event.observe(window, 'load', js_onLoad, false);
// Event.observe(window, 'load', loading, false);

var reTry  = 0;
var exeFlag = false;
	
function js_onLoad()
{
	
	// setTimeout("loading()",5000);
	// 최초 20회 시도 (by 박세현) - 패킷 전송전 화면 Painting 작업 오류 수정
	
	if(reTry < 20){
	
		reTry ++;
		if(hidef.Socket_Connect == 1 &&	hidef.GETBuddy_Flag && !exeFlag ){
			
			hidef.setUAConfigHTML(hidef.uaconfArr);
		    setBuddyExpand();
		    $('progress-div').hide();
		    exeFlag = true;
	   	
	   	}
	   		
	 	if(!exeFlag)
			setTimeout("js_onLoad()",1000);
			
	}else{
		$('progress-div').hide();
		alert('서버 접속에 실패 하였습니다. \n 관리자에게 문의해 주십시오');
	}	
	
	
}   


	function loading(){
	
		
	 if(hidef.Socket_Connect == 1)
	  {
			hidef.setUAConfigHTML(hidef.uaconfArr);
		    setBuddyExpand();
		    $('progress-div').hide();
	   }
	 }

 startMessenger();
</Script>   

