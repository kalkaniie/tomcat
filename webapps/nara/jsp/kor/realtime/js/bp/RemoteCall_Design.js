  var R_C_window ; 
function RemoteCallDesignRequest(szSendID ,szSendNAME ,szRoomID ,szFlag ,szView ,szOption ,szDisplayID)
{
	
	try{
			  //alert(szSendID + ":" +szSendNAME );
	       var Message = szSendNAME +"님이 원격지원를 요청합니다.<br/>"+
		   				"수락하시겠습니까? &nbsp;&nbsp;&nbsp;남은시간 :<font id='showA'></font> 초";
			
		   var form = new Ext.form.FormPanel({
		        baseCls: 'x-plain',
		        labelWidth: 280,
		        defaultType: 'textfield',
		
		        items: [{
		            fieldLabel: Message,
		            labelSeparator:'',
		            name: 'to',
		            anchor:'0%'
		        }]
		    });
	
		    R_C_window = new Ext.Window({
		        title: '원격제어',
		        width: 280,
		        height:120,
		        resizable:false,
		        layout: 'fit',
		        plain:true,
		        bodyStyle:'padding:5px;',
		        buttonAlign:'center',
		        closeAction:'close',
		        items: form ,
		       buttons: [{
		            text: '수락',
		             handler: function(){
		            	//acceptRemoteCall(szSendID ,szSendNAME ,szRoomID ,szFlag ,szView ,szOption ,szDisplayID);
		            	acceptRemoteCall(hidef.user_id ,hidef.user_nm ,szRoomID ,szFlag ,szView ,szOption ,szDisplayID ,szSendID ,szSendNAME);
		            	//alert("+1+++" + szSendID +":"+szSendNAME+":"+hidef.user_id+":"+szDisplayID);
		                    }
		        },{
		            text: '거절',
		             handler: function(){
		            	hidef.RcsInviteSend("0", hidef.user_id, hidef.user_nm, szSendID,szRoomID ,szFlag ,szView ,szOption ,szDisplayID);
		            	//hidef.RcsInviteSend("0", szSendID, szSendNAME, hidef.receive_user_id,szRoomID ,szFlag ,szView ,szOption ,szDisplayID);
		                R_C_window.destroy();
		                    }
		        }]
		      });
			
		     R_C_window .show();
		     
		     startTimer();
//		} 
		
		
	}catch(e)
	{
		//alert("설치안wwww됨" + e);
	}
}


function acceptRemoteCall(user_id ,user_nm ,szRoomID ,szFlag ,szView ,szOption ,szDisplayID ,szSendID ,szSendNAME){
		try{
			hidef.RemoteCallSetup();
			var room_id = hidef.GetRemoteRoomID(hidef.user_id);
		    
			if(room_id == -1){  //설치 안되었을 경우
			   var Message ="자동으로 설치 되지 않을 경우 <br/>"+
			   				"수동 설치 하셔야 합니다. 다운 받으시겠습니까?";
			
			   var acceptform = new Ext.form.FormPanel({
			        baseCls: 'x-plain',
			        labelWidth: 220,
			        defaultType: 'textfield',
			
			        items: [{
			            fieldLabel: Message,
			            labelSeparator:'',
			            name: 'to',
			            anchor:'0%'
			        }]
			    });
			    
			   var a_window = new Ext.Window({
			        title: '원격제어',
			        width: 280,
			        height:120,
			        resizable:false,
			        layout: 'fit',
			        plain:true,
			        bodyStyle:'padding:5px;',
			        buttonAlign:'center',
			        closeAction:'close',
			        items: acceptform ,
			       buttons: [{
			            text: '확인',
			             handler: function(){
			             	ifmKebiRemoteCaller.location.href =	"/jsp/kor/realtime/activeX/KebiRemoteCaller.exe";
			                     //buddyAuthSend(window, form);
			                    }
			        },{
			            text: '취소',
			             handler: function(){
			                     a_window.destroy();
			                    }
			        }]
			      });
				a_window.show();
			}else 
			{		
					R_C_window.destroy();
					hidef.RcsInviteSend("1", user_id, user_nm, szSendID,szRoomID ,szFlag ,szView ,szOption ,szDisplayID);
					//ifmKebiRemoteCaller.KebiRemoteCaller.RemoteCall("1","1","aquaesun@naravision.net","테스트","nafree_1234@nwc.naravision.net","145215057859nafree_1234@nwc.naravision.net");
					
					//alert("2222222222" + user_id +":"+user_nm+":"+szSendID+":"+szRoomID+":"+ szFlag +":"+szView+":"+szOption+":"+szDisplayID);
					ifmKebiRemoteCaller.KebiRemoteCaller.RemoteCall("1","1",szSendID,szSendNAME,user_id,szDisplayID);
 
			}
	}catch(e)
	{
		// alert("설치안됨" + e);
	}
}


	var now = new Date();
	var minute = now.getMinutes().toString();
	var second = now.getSeconds().toString();
	end = false;
	var interval_time = 31;
	
	function timeclock(){
		second -= 1;

	  if (second == 0) {
	  	R_C_window.destroy();
	  	return;
	  }

	  if (second < 10) interval_time = 0 + interval_time +"";
	  else interval_time = second;
	  
	 if($('showA') != null){
		 	$('showA').innerText= second;
		  	setTimeout('timeclock()', 1000);
	 }else{
	 	return;
	 }
	}
	
	function startTimer(){
	  second = interval_time;
	  end=false;
	 
	  $('showA').innerText='';
	  timeclock();
	}
	
	function doReset(){
	  $('showA').innerText='';
	}