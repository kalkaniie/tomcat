
//==============================================================================================
//  Message : UA_LOGON_RESP
//	�Լ��� : LoginResp
//  ���� : �α��� ���
function LoginResp(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szResult = arr[0];
    //alert('szResult:'+szResult);
    if(szResult == "5")
    {
      Login_Flag = 1;
	    rtnmsg="�α��� ����";
	  }
    else
    {
      Login_Flag = -1;
	    rtnmsg = "�α��� ���� [" + szResult + "]";
    }
    //alert('LoginResp:'+Login_Flag);
    parent.frames[0].window.status = rtnmsg;
}

//==============================================================================================
//  Message : UA_DUP_LOG_RELAY
//	�Լ��� : DupLoginNotify
//  ���� : �ߺ� �α��� �˸�
function DupLoginNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_NAME_NOTI_RELAY
//	�Լ��� : NameNotify
//  ���� : ��ȭ�� ���� �˸�
function NameNotify(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szSendID      = arr[0];     // ������ ��� ID
    var szDialogName  = arr[1];     // ����� ��ȭ��

    alert("��ȭ�� ���� : " + szSendID+"/"+szDialogName);
}

//==============================================================================================
//  Message : UA_STAT_NOTI_RELAY
//	�Լ��� : StatusNotify
//  ���� : ���� ���� �˸�
function StatusNotify(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szSendID      = arr[0];     // ������ ��� ID
    var szStatus      = arr[1];     // ����� ����
    var szTrayStatus  = arr[2];     // ����� Tray ���°� - �����ص� ��
    var szStatusName  = arr[3];     // ����� ���� �̸�
    var szServerIdx   = arr[4];     // ����� ������ �α����� �޽��� ���� Index

    parent.frames[0].window.status="���� ���� : " + szSendID+"/"+szStatus+"/"+szTrayStatus+"/"+szStatusName+"/"+szServerIdx;
    updateBuddy(szSendID, szStatus, szServerIdx);
    
    
}

//==============================================================================================
//  Message : UA_BUDDY_ADD_RELAY
//	�Լ��� : BuddyAddResp
//  ���� : ģ�� �߰� ���濡�� �˸�
function BuddyAddRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_BUDDY_ADD_RESP
//	�Լ��� : BuddyAddResp
//  ���� : ģ�� �߰� ���
function BuddyAddResp(szResultCode,msg)
{
    var arr = msg.split(chField);

    alert("ģ�� �߰� ��� : " + msg);
    
    //���𸮽�Ʈ
    
}

//==============================================================================================
//  Message : UA_BUDDY_DEL_RELAY
//	�Լ��� : BuddyDelResp
//  ���� : ģ�� ���� ���
function BuddyDelResp(szResultCode,msg)
{
    var arr = msg.split(chField);
    
    alert("ģ�� ���� ��� : " + msg);
}

//==============================================================================================
//  Message : UA_DIALOG_INDEX_RELAY
//	�Լ��� : DialogIndexResp
//  ���� : ��ȭ Index �䱸 ���
function DialogIndexResp(szResultCode,msg)
{
    var arr = msg.split(chField);

    var szIndex     = arr[0];  // Index
    var szDlgIndex  = arr[1];  // ��ȭâ Index
    var szSendID    = arr[2];  // ID1
    var szRecvID    = arr[3];  // ID2
		
		//alert("��ȭ Index : " + szIndex+"/"+szDlgIndex+"/"+szSendID+"/"+szRecvID);
		
		processMakeDialogue(szIndex, szDlgIndex, szSendID, szRecvID);
		
		
		//parent.frames[1].$('dialogueid').innerText = arr[1];
		
		//alert(parent.frames[1].$('dialogueid').innerText);
    
}

//==============================================================================================
//  Message : UA_DIALOG_RELAY
//	�Լ��� : DialogRelay
//  ���� : ��ȭ��������
function DialogRelay(szResultCode,msg)
{
		//alert(msg);
    var arr = msg.split(chField);

    var szIndex         = arr[0];     // ��ȭâ Index
    var szSendID        = arr[1];     // ������ ��� ID
    var szSendName      = arr[2];     // ������ ��� ��ȭ��
    var szFont          = arr[3];     // Font
    var szDate          = arr[4];     // �ð�
    var szCont          = arr[5];     // ����
    var szDisplayID     = arr[6];     // ȭ�鿡 �������� ID

    var id_domain = szSendID.split('@');

    var objDate = new Date();
    objDate.setTime(Number(szDate));
    
    //alert(arr);
    js_receivemsg(szIndex, szSendID, szSendName, szFont, szDate, szCont, szDisplayID);
    /*var strMsg = MainForm.dialogstr.value;
    strMsg += id_domain[0] + " : " +szCont + "\r\n" ;
    MainForm.dialogstr.value = strMsg;*/
    
    
    //alert("��ȭ���� : " + szIndex+"/"+szSendID+"/"+szSendName+"/"+szFont+"/"+objDate+"/"+szDisplayID);
}

//==============================================================================================
//  Message : UA_DIALOG_DEL_REQ
//	�Լ��� : DialogLeaveNotify
//  ���� : ��ȭâ ���� �˸�
function DialogLeaveNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_INVITE_RELAY
//	�Լ��� : DialogInviteRelay
//  ���� : ��ȭ �ʴ� ����
function DialogInviteRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_INV_AGR_RELAY
//	�Լ��� : DialogAgreementRelay
//  ���� : ��ȭ �ʴ뿡 ���� ���� ����
function DialogAgreementRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_OFF_NOTE_RESP
//	�Լ��� : OfflineNoteResp
//  ���� : �������� ���� List
function OfflineNoteResp(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_NOTE_RELAY
//	�Լ��� : NoteRelay
//  ���� : ���� ����
function NoteRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_NOTE_REPLY_RELAY
//	�Լ��� : NoteConfirmRelay
//  ���� : ���� Ȯ�� ����
function NoteConfirmRelay(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_TYPE_NOTI
//	�Լ��� : KeyTypeNotify
//  ���� : Ű���� �Է��� �˸�
function KeyTypeNotify(szResultCode,msg)
{
    var arr = msg.split(chField);
}

//==============================================================================================
//  Message : UA_LOGON_RESP
//	�Լ��� : AppleWorkResponse
//  ���� : Apple �۾� ���
function AppleWorkResponse(szResultCode,msg)
{		
    var result_arr = msg.split(chField);
    //alert(result_arr);
    var szTrCode    = result_arr[0];  // TR Code
    var szMsgID     = result_arr[1];  // ���´� �޼��� ID
    var szRtnCode   = result_arr[2];  // �����
    var szResult    = result_arr[3];  // ��� Data
  
    if(szRtnCode == "0200")
    {
        if((szTrCode == "30003101")&&(szMsgID == "GETBUDDY____")) // ���� ����Ʈ ó��
        {
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
    }
    
    Work_Status = "";
}

//=========================================================
// Apple �۾� ����� ���� �� ó�� �Լ�
//=========================================================

//==============================================================================================
//	�Լ��� : GetUserSearch
//  ���� : ����� �˻� ���
function GetUserSearch(msg)
{
    alert("����� �˻� ��� [" + msg + "]");

    var isNextPage = msg.substring(0, 2);             // ���� ������ ����
    var szSearchStr = msg.substring(2, msg.length);
    
    var Record_arr = szSearchStr.split(chRecord_Enter);
    var szRecord;

    var szField1,szField2,szField3,szField4,szField5,szField6,szField7,szField8,szField9,szField10,szField11,szField12,szField13,szField14,szField15;

    for(nLoop = 0; nLoop < Record_arr.length; nLoop++) 
    {
        szRecord = Record_arr[nLoop];
        Field_arr = szRecord.split(chField_Tab);
        
        if(Field_arr.length == 15)
        {
            szField1 = Field_arr[0]; //��ȣ
            szField2 = Field_arr[1]; //�����ID
            szField3 = Field_arr[2]; //����ڻ���
            szField4 = Field_arr[3]; //��ȭ��
            szField5 = Field_arr[4]; //���Ӹ�ü(W:A)
            szField6 = Field_arr[5]; //������̸�
            szField7 = Field_arr[6]; //����
            szField8 = Field_arr[7]; //����
            szField9 = Field_arr[8]; //������
            szField10 = Field_arr[9]; //�ڵ�����ȣ
            szField11 = Field_arr[10]; //�ѽ���ȣ
            szField12 = Field_arr[11]; //��ȭ��ȣ
            szField13 = Field_arr[12]; //ȸ���ȣ
            szField14 = Field_arr[13]; //�μ���ȣ
            szField15 = Field_arr[14]; //��ü����
    
            alert(szField1+"/"+szField2+"/"+szField3+"/"+szField4+"/"+szField5+"/"+szField6+"/"+szField7+"/"+szField8+"/"+szField9+"/"+szField10+"/"+szField11+"/"+szField12+"/"+szField13+"/"+szField14+"/"+szField15);
        }
    }
}

