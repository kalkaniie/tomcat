
var MainForm;

function FormSet(obj)
{
    MainForm = obj;
}

//==============================================================================================
//	�˸� �޽����� ����Ѵ�.
//  @param	: msg
//  @return 
function traceMsg(msg)
{
		var rtnmsg = '';
		if(msg == SOCK_CONNECT)
		{
	      rtnmsg = "������ ����Ǿ����ϴ�.";
		  Socket_Connect = 1;
	  }
	  else if(msg == SOCK_DISCONNECT)
	  {
	      rtnmsg = "���� ������ ���������ϴ�";
	  }
	  else if(msg == SOCK_NOTCONNECT)
	  {
	      rtnmsg = "���Ͽ� ������ �� �����ϴ�.";
	      Login_Flag = '8';
	  }
	  else if(msg == SOCK_AUTH_ERROR)
	  {
	      rtnmsg = "���� ������ ���Ͽ� ������ �� �����ϴ�. ";
	      Login_Flag = '9';
	  }
	  else
	  {
	      rtnmsg = "[" + msg + "]";
	  }
	  parent.frames[0].window.status = rtnmsg;
}

//==============================================================================================
//  ���ŵ� �޽����� �޴´�.
//  @param	: op_cde : op_code msg : ���� �޽��� ��Ʈ��
//  @return 
function receiveMsg(op_code,resultmsg)
{
    var szResultCode = resultmsg.substring(0, 4);
    //alert(op_code+"/"+szResultCode);
    
    var msg = resultmsg.substring(4, resultmsg.length);
    //alert(msg);
    
		if(op_code == UA_LOGON_RESP)
		{
		    LoginResp(szResultCode,msg);
    }
		else if(op_code == UA_DUP_LOG_RELAY)
		{
		    DupLoginNotify(szResultCode,msg);
    }
		else if(op_code == UA_NAME_NOTI_RELAY)
		{
		    NameNotify(szResultCode,msg);
    }
		else if(op_code == UA_STAT_NOTI_RELAY)
		{
		    StatusNotify(szResultCode,msg);
    }
		else if(op_code == UA_BUDDY_ADD_RELAY)
		{
		    BuddyAddRelay(szResultCode,msg);
    }
		else if(op_code == UA_BUDDY_ADD_RESP)
		{
		    BuddyAddResp(szResultCode,msg);
    }
		else if(op_code == UA_BUDDY_DEL_RELAY)
		{
		    BuddyDelResp(szResultCode,msg);
    }
		else if(op_code == UA_DIALOG_INDEX_RELAY)
		{
		    DialogIndexResp(szResultCode,msg);
    }
		else if(op_code == UA_DIALOG_RELAY)
		{
		    DialogRelay(szResultCode,msg);
		}
		else if(op_code == UA_DIALOG_DEL_REQ)
		{
		    DialogLeaveNotify(szResultCode,msg);
    }
		else if(op_code == UA_INVITE_RELAY)
		{
		    DialogInviteRelay(szResultCode,msg);
    }
		else if(op_code == UA_INV_AGR_RELAY)
		{
		    DialogAgreementRelay(szResultCode,msg);
    }
		else if(op_code == UA_OFF_NOTE_RESP)
		{
		    OfflineNoteResp(szResultCode,msg);
    }
		else if(op_code == UA_NOTE_RELAY)
		{
		    NoteRelay(szResultCode,msg);
    }
		else if(op_code == UA_NOTE_REPLY_RELAY)
		{
		    NoteConfirmRelay(szResultCode,msg);
    }
		else if(op_code == UA_APPLE_RESP)
		{
				//alert('here');
		    AppleWorkResponse(szResultCode,msg);
    }
		else if(op_code == UA_TYPE_NOTI)
		{
		    KeyTypeNotify(szResultCode,msg);
    }
		else if(op_code == UA_PHOTO_REQ_REQ) // ���� Request
		{
    }
		else
		{
    	  alert("["+op_code+"]["+szResultCode+"]["+msg+"]");
    }
}

//==============================================================================================
//	������ �����Ѵ�.
//  ip�� port�� object�� ��� flash�� server_connect�� ȣ���Ѵ�.
//  @return 
function Connect_Server(srvip,srvport,crossport)
{
	  try{
 	      if(Socket_Connect == 1)
 	      {
 	          thisMovie("FClient").close();
 	          Socket_Connect = 0;
 	      }

        var conn=new Object();
		    conn.ip = srvip ;
		    conn.port = srvport;
		    conn.crossport = crossport;
	  }catch(e){
		    alert("[Error] Connect_Server : "+e);
	  }
	  
	  thisMovie("FClient").connect(conn);
}

//==============================================================================================
//  ���� ������ ���´�.
//  @param	: 
//  @return 
function Close_Server()
{
    if(Login_Flag == 1)
    {
    		try
    		{
	  	    thisMovie("FClient").close();	  	    
	  	  } catch(e)
	  	  {
	  	  }
	  	  Login_Flag = 0;
    }
}

//==============================================================================================
//	�޽����� �����Ѵ�.
//  @
//  @return 
function Send_Msg(op_code,message)
{
		//alert(Login_Flag);
    if((Login_Flag == 1)||(op_code == UA_LOGON_REQ))
    {
      	try{
            var send=new Object();
            send.op_code = op_code;
            send.message = message;
      	}
      	catch(e){
            alert("[Error] Send_Msg : "+e);
      	}
      	
      	thisMovie("FClient").sendMsg(send);
  	}
  	else
  	{
        alert("������ ���� �Ǿ� ���� �ʽ��ϴ�.");
  	}
}

//==============================================================================================
//	��ȣȭ Flag�� �����Ѵ�.
//  @param	: flag :��ȣȭ �÷��� 
//  @return 
function SetCipherFlag(flag)
{
   	try{
	      thisMovie("FClient").cipher_flag(flag);
   	}catch(e){
        alert("[Error] SetCipherFlag : "+e);
    }
}

function GetCipherFlag()
{
	  var cipher_flag = -1;

   	try{
	      cipher_flag = thisMovie("FClient").getCipher_flag();
   	}catch(e){
        alert("[Error] GetCipherFlag : "+e);
    }
    
    return cipher_flag;
}

//==============================================================================================
//	��Ŷ Ÿ���� �����Ѵ�.
//  @param	: type 
//  @return 
function SetPackType(type)
{	
   	try{
	      thisMovie("FClient").packetType(type);
   	}catch(e){
        alert("[Error] SetPackType : "+e);
    }
}

function GetPackType()
{
	  var pack_type = -1;

   	try{
   	    pack_type = thisMovie("FClient").getPacketType();
   	}catch(e){
        alert("[Error] GetPackType : "+e);
    }
    
    return pack_type;
}

//==============================================================================================
//	Field 1�� �����Ѵ�.
//  @param	: field
//  @return 
function SetField1(field)
{
   	try{
	      thisMovie("FClient").field1(field);
   	}catch(e){
        alert("[Error] SetField1 : "+e);
    }
}

function GetField1()
{
	  var field1 = -1;

   	try{
   	    field1 = thisMovie("FClient").getField1();
   	}catch(e){
        alert("[Error] GetField1 : "+e);
    }
    
    return field1;
}

//==============================================================================================
//	Field 2�� �����Ѵ�.
//  @param	: filed 
//  @return 
function SetField2(field)
{
   	try{
        thisMovie("FClient").field2(field);
   	}catch(e){
        alert("[Error] SetField2 : "+e);
    }
}

function GetField2()
{
	  var field2 = -1;

   	try{
   	    field2=thisMovie("FClient").getField2();
   	}catch(e){
        alert("[Error] GetField2 : "+e);
    }
    
	  return field2;
}

//========================================================================

function flash_load( file_name,width,height,ip,crossport)
{	
	try{

		var rtnstr;
		
		rtnstr = "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" ";
		rtnstr += "codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=9,0,0,0 onerror=OnErr()\" ";
		rtnstr += "width=\'"+width+"'\" height=\'"+height+"'\" id='FClient' align=\"middle\">";
		rtnstr += "<param name=\"movie\" value=\'"+file_name+"'  /><param name=\"quality\" value=\"high\" />";
		rtnstr += "<param name=\"bgcolor\" value=\"#ffffff\" />";
		rtnstr += "<param name='allowScriptAccess' value='always' />";
		rtnstr += "<param name=\"FlashVars\" value='ip="+ip+"&crossport="+crossport+"' />";
		rtnstr += "<param name=\"wmode\" value=\"transparent\" /><embed src=\'"+file_name+"' ";
		rtnstr += "quality=\"high\" bgcolor=\"#ffffff\" width=\'"+width+"'\" height=\'"+height+"'\" ";
		rtnstr += "name='FClient' align=\"middle\" showLiveConnect='true' FlashVars='ip="+ip+"&crossport="+crossport+"'";
		rtnstr += "type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" /></object>";
	
		return rtnstr;
	}catch(e){
		alert(e);
	}
}


function thisMovie(movieName)
{
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName]
    }
    else {
        return document[movieName]
    }
}

function OnErr()
{
    alert('Error');
}

//UA CONFIG ����
var uaconfArr = new Array(4);

//==============================================================================================
//	�Լ��� : GetUAConfig
//  ���� : UACONFIG ������ó��
function GetUAConfig(msg)
{	
	var Record_arr = msg.split(chRecord_Enter);
	uaconfArr = new Array(4);
	Record_arr.each(function(value,index)
									{
										if(value.indexOf("user_nm=") == 0)
										{
											uaconfArr[0] = value.substring(value.indexOf("=")+1);
											
										}else if(value.indexOf("displayname=") == 0)
										{
											uaconfArr[1] = value.substring(value.indexOf("=")+1);
										} else if(value.indexOf("mobile_phone=") == 0)
										{
											uaconfArr[2] = value.substring(value.indexOf("=")+1);
										} else if(value.indexOf("userid=") == 0)
										{
											uaconfArr[3] = value.substring(value.indexOf("=")+1);
										}
									});
	
	//setUAConfigHTML(uaconfArr);
	parent.frames[0].window.status="GETUACONF ����";
	
}


//==============================================================================================
//	�Լ��� : GetBuddyWork
//  ���� : ���� ����Ʈ ó��

//���� �׷� ����
var groupArray = new Array();
//���� ����
var listArray  = new Array();

function GetBuddyWork(msg)
{
	var Record_arr = msg.split(chRecord_Enter);
	//alert(Record_arr);
	var Field_arr;
	
	
	//alert(Record_arr.length);
	groupArray = new Array();
	listArray  = new Array();
	
	var cnt = 0;
	var groupcnt = 0;
	var listcnt = 0;
	
	while(Record_arr[cnt] != "")
	{
		Field_arr = Record_arr[cnt].split(chRecord);
		//alert(Field_arr);
		if(Field_arr[0] == '1')	//�׷�
		{
			groupArray[groupcnt] = new Array(3);
			groupArray[groupcnt][0] = Field_arr[1]; // �׷� Index
			groupArray[groupcnt][1] = Field_arr[2]; // �׷� �̸�
			groupArray[groupcnt][2] = Field_arr[3]; // default����, '0' �̸� �׷� ���� �Ұ�.
			//alert(groupArray[groupcnt][1]);
			groupcnt++;
		} else
		{		
			listArray[listcnt]  = new Array(9);
			//24328test20@demo.imtong.com����������test2093-11414
			listArray[listcnt][0] = Field_arr[1]; // ����Index
			
			var id_domain = Field_arr[2].split('@');
			
			listArray[listcnt][1] = id_domain[0]; // ����ID
			listArray[listcnt][2] = id_domain[1]; // ����DOMAIN
			listArray[listcnt][3] = Field_arr[3]; // �����̸�
			listArray[listcnt][4] = Field_arr[4]; // �����ȭ��
			listArray[listcnt][5] = Field_arr[5]; // ����׷��ε���
			listArray[listcnt][6] = Field_arr[6]; // ������°�
			listArray[listcnt][7] = Field_arr[9]; // ����α��μ���index
			listArray[listcnt][8] = Field_arr[2]; // ���̵�@������
			
			listcnt++;
			
		}
		cnt++;
	}

	//For Debug.
	var grouplist = '';
	for(x=0; x<groupArray.length; x++)
	{
		var _tmpArr = groupArray[x];
		for(y=0; y<_tmpArr.length; y++)
		{
			switch(y)
			{
				case 0 : grouplist = grouplist + '�׷��ε���:'+_tmpArr[y]+' '; break;
				case 1 : grouplist = grouplist + '�׷��̸�:'+_tmpArr[y]+' '; break;
				case 2 : grouplist = grouplist + '����Ʈ����:'+_tmpArr[y]+'<br>'; break;				
			}
		}
	}
	parent.frames[1].$('_buddygroup').innerHTML = "--------����׷�--------<br>"+grouplist+"<br>--------------------";
	
	var buddylist = ''
	for(x=0; x<listArray.length; x++)
	{
		var _tmpArr = listArray[x];
		for(y=0; y<_tmpArr.length; y++)
		{
			switch(y)
			{
				case 0 : buddylist = buddylist + '����Index:'+_tmpArr[y]+' '; break;
				case 1 : buddylist = buddylist + '����ID:'+_tmpArr[y]+' '; break;
				case 2 : buddylist = buddylist + '����DOMAIN:'+_tmpArr[y]+' '; break;
				case 3 : buddylist = buddylist + '�����̸�:'+_tmpArr[y]+' '; break;
				case 4 : buddylist = buddylist + '�����ȭ��:'+_tmpArr[y]+' '; break;
				case 5 : buddylist = buddylist + '����׷��ε���:'+_tmpArr[y]+' '; break;
				case 6 : buddylist = buddylist + '������°�:'+_tmpArr[y]+' '; break;
				case 7 : buddylist = buddylist + '����α��μ���index:'+_tmpArr[y]+'<br>'; break;				
				
			}
		}
	}
	parent.frames[1].$('_buddylist').innerHTML = "--------���𸮽�Ʈ--------<br>"+buddylist+"<br>---------------------";		
	parent.frames[0].window.status="GET BUDDY LIST ����";
	//setBuddyGroupHtml(groupArray, listArray);
		
}




//BuddyListArray(listArray)�� ���� �߰��Ѵ�.
function addBuddy(buddyarr)
{	
		listArray.push(buddyarr);
}

//Ư�������� ������ �˾ƿ´�.
//����index, ����ID, ����DOMAIN, �����̸�, �����ȭ��, ����׷��ε���, 
//������°�, ����α��μ���index, ���̵�@������
function getBuddyInfo(buddyid)
{
	var rtnIndex;
	listArray.each(function(valueTop, indexTop)
	{	
	 	listArray[indexTop].each(function(value, index)
		{
		 	if(value == buddyid)
		 	{
		 			rtnIndex = indexTop;
		 			//break;
		 	}
		});
		
	});
	//alert(rtnIndex);
	//alert(listArray[rtnIndex]);
	return 	listArray[rtnIndex];
}

/*var szSendID      = arr[0];     // ������ ��� ID
var szStatus      = arr[1];     // ����� ����
var szTrayStatus  = arr[2];     // ����� Tray ���°� - �����ص� ��
var szStatusName  = arr[3];     // ����� ���� �̸�
var szServerIdx   = arr[4];     // ����� ������ �α����� �޽��� ���� Index*/
    
function updateBuddy(buddyid, _status, imsidx)
{	
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
	
	updateBuddyStatusHTML(buddyid, _status);
	
	//������� ��ȭ�� ���� ��ȭâ ���� ������ ������Ʈ ��
	//�޼��� �Է�â ������Ʈ..
	dialogueHash.each(function(pair)
	{	
		var array = pair.value.split(",");
		
		array.each(function(value, index)
		{	
		 	if(value == buddyid)
		 	{		 		
		 		parent.frames[0].document['mlMsg_window_icon_'+pair.key].src=getStatusImageSrc(_status);
		 		if(_status == -1 || _status == -4)
		 		{
		 			parent.frames[0].$('msg_'+pair.key).disabled = true;
		 			parent.frames[0].$('msg_'+pair.key).style.backgroundColor='#C0C0C0';
		 			parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).innerHTML = parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).innerHTML + "<br><font color='red'>��ȭ ��밡 �������� �����̹Ƿ� �޽����� �Է� �� �� �����ϴ�.</font>";
		 			parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).scrollTop = parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).scrollTop + 100;
		 		} else 
		 		{
		 			parent.frames[0].$('msg_'+pair.key).disabled = false;
		 			parent.frames[0].$('msg_'+pair.key).style.backgroundColor='#FFFFFF';		
		 			if(_status == 0) 			
		 			{
		 				parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).innerHTML = parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).innerHTML + "<br><font color='blue'>��ȭ ��밡 �ٽ� �¶��� �����̹Ƿ� �޽����� �Է� �� �� �ֽ��ϴ�.</font>";
		 				parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).scrollTop = parent.frames[0].$('mlMsg_window_cntnt_'+pair.key).scrollTop + 100;
		 			}
		 		}
		 	}
		});
		
		
	});
	
	
	//dialogueHash.get()
	
}

/*
	��ȭâ�� ����.
	@param1:Index
	@param2:��ȭâ Index
	@param3 �����»�� ID
	@param4 �޴»��ID
	1.���� ��/��������Ȯ��	
	2.�̹� ������ ��ȭâ���� Ȯ��
*/
function processMakeDialogue(szIndex, szDlgIndex, szSendID, szRecvID)
{
		//alert('processMakeDialogue');
		if(szDlgIndex == -1)
		{
				updateBuddy(szRecvID, '-1', '');
				return;
		}
		
		if(!js_isExistDialogue(szDlgIndex))
		{			
			var buddyinfo = getBuddyInfo(szRecvID);	
			//��ȭâ�ε���, �����ȭ��,	������̵�
			makeDialogue(szDlgIndex, buddyinfo[3], buddyinfo[8]);
		} else
		{			
			js_switch_dialogue_main(szDlgIndex);
		}
		
}

/*
	��ȭâ ���̵� �ش��ϴ� ��ȭâ�� �����ϴ��� üũ.
*/
function js_isExistDialogue(dialogueID)
{
	var check_id = 'mlMsg_window_'+dialogueID;
	
	var obj = parent.frames[0].$(check_id);
	if(obj == null)
	{
		return false;	
	}
	return true;
}

/* �̹� �����ִ� ��ȭâ���� üũ �Ѵ�.
* @param args : ��ȭâ���̵�
*/
function js_isNewDialogue(dialogueID)
{
	var new_id = 'mlMsg_window_'+dialogueID;
	var obj = parent.frames[0].$(new_id);	
		
	if(obj.style.display == '' || obj.style.display =='block')
	{
		return false;			
	} else
	{
		obj.style.display = 'block';
	}
	
}

/* ������ ��ȭ �޼����� ������.
//  value : dindex      - Index
//          userid      - �����»�� ID
//          username    - �����»�� Display Name
//          recvusers   - �޴»����. ','�� ����
//          strfont     - ȭ�� Font
//          strTime     - ������ �ð�
//          msg         - ��ȭ �޼���
*/
function js_sendmsg(dialogueID, recvID)
{	
	
	
	var msg = '';
	if(parent.frames[0].event.keyCode == 13)
	{
		msg = parent.frames[0].$F('msg_'+dialogueID);
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).innerHTML = parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).innerHTML + "<li><b>"+uaconfArr[1]+": </b>"+msg+"</li>";		
		parent.frames[0].$('msg_form_'+dialogueID).reset();		
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).scrollTop = parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).scrollTop + 500;
		

		DialogSend(dialogueID,uaconfArr[3],uaconfArr[1],'',recvID, msg);
	}
}

/*�������� ���޵� �޼����� ó���Ѵ�.
// ��ȭâ Index, ������ ��� ID, ������ ��� ��ȭ��, Font, �ð�, ����, ȭ�鿡 �������� ID
*/
function js_receivemsg(szIndex, szSendID, szSendName, szFont, szDate, szCont, szDisplayID)
{
		//alert('receive');
		if(!js_isExistDialogue(szIndex))
		{
			//��ȭâ�ε���, �����ȭ��,	������̵�
			makeDialogue(szIndex, szSendName, szSendID);
		} else
		{			
			js_switch_dialogue_main(szIndex);
			
			js_switch_dialogue2(szIndex, 'block');
		}
		
		
		parent.frames[0].$('mlMsg_window_cntnt_'+szIndex).innerHTML = parent.frames[0].$('mlMsg_window_cntnt_'+szIndex).innerHTML + "<li><b>"+szSendName+": </b>"+szCont+"</li>";		
		parent.frames[0].$('msg_form_'+szIndex).reset();		
		parent.frames[0].$('mlMsg_window_cntnt_'+szIndex).scrollTop = parent.frames[0].$('mlMsg_window_cntnt_'+szIndex).scrollTop + 500;
}
