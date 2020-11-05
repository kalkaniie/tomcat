

//==============================================================================================
//	�Լ��� : LoginReq
//  ���� : �α���
function LoginReq(userid,userpass)
{
    var op_code = UA_LOGON_REQ;
 		var strSendData = "";
		
		strSendData = userid + chField +
		              userpass + chField + 
		              "W";

		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : NameModifySend
//  ���� : ��ȭ�� ���� �˸�
//  value : userid      - �����»�� ID
//          recvusers   - �޴»����. ','�� ����
//          changename  - �ٲ��ȭ��
function NameModifySend(userid,recvusers,changename)
{
    var op_code = UA_NAME_NOTI_REQ;
		var strSendData = "";
		
		strSendData = userid + chField +
		              recvusers + chField + 
		              changename;
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : StatusSend
//  ���� : ���� ���� �˸�
//  value : userid    - �����»�� ID
//          recvusers - �޴»����. ','�� ����
//          status1   - ����� ����
//          status2   - Tray ���� ����
//          strstatus - �����̸�
		              
function StatusSend(userid,recvusers,status1,status2,strstatus)
{
    var op_code = UA_STAT_NOTI_REQ;
		var strSendData = "";
		
		strSendData = userid + chField + 
		              recvusers + chField + 
		              status1 + chField + 
		              status2 + chField + 
		              strstatus;
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : BuddyAddReq
//  ���� : ģ�� �߰� ��û
//  value : userid    - �����»�� ID
//          groupidx  - �߰��� �׷� Index
//          buddyid   - �߰��� ģ�� ID
function BuddyAddReq(userid,groupidx,buddyid)
{
    var op_code = UA_BUDDY_ADD_REQ;
		var strSendData = "";
		
		strSendData = userid + chField + 
		              groupidx + chField + 
		              buddyid;
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : BuddyDelReq
//  ���� : ģ�� ���� ��û
//  value : userid    - �����»�� ID
//          buddyidx  - ������ ģ�� Index
//          buddyid   - ������ ģ�� ID
function BuddyDelReq(userid,buddyidx,buddyid)
{
    var op_code = UA_BUDDY_DEL_REQ;
		var strSendData = "";
		
		strSendData = userid + chField + 
		              buddyidx + chField + 
		              buddyid;
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : DialogIndexReq
//  ���� : ��ȭ Index �䱸
//  value : userid    - �����»�� ID
//          recvid    - ���� ID
function DialogIndexReq(userid,recvid)
{
    var op_code = UA_DIALOG_INDEX_REQ ;
		var strSendData = "";
		
    var objDate = new Date();
    var nTime = objDate.getTime();
		
		strSendData = nTime + chField + 
		              userid + chField + 
		              recvid + chField + 
		              "";
		              
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : DialogSend
//  ���� : ��ȭ��������
//  value : dindex      - Index
//          userid      - �����»�� ID
//          username    - �����»�� Display Name
//          recvusers   - �޴»����. ','�� ����
//          strfont     - ȭ�� Font
//          strTime     - ������ �ð�
//          msg         - ��ȭ �޼���
function DialogSend(dindex,userid,username,strfont,recvusers,msg)
{
    var op_code = UA_DIALOG_REQ ;
		var strSendData = "";

    var objDate = new Date();
    var nTime = objDate.getTime();

		strSendData = dindex + chField + 
		              userid + chField + 
		              username + chField + 
		              recvusers + chField + 
		              "����,9,128,0,0,0,0,0"  + chField + 
		              nTime + chField + 
		              msg;

		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : DialogLeaveSend
//  ���� : ��ȭâ ���� �˸�
function DialogLeaveSend()
{
    var op_code = UA_DIALOG_DEL_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : DialogInviteRelay
//  ���� : ��ȭ �ʴ�
function DialogInvite()
{
    var op_code = UA_INVITE_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : DialogInviteAgreement
//  ���� : ��ȭ �ʴ뿡 ���� ����
function DialogInviteAgreement()
{
    var op_code = UA_INV_AGR_SEND;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : OfflineNoteReq
//  ���� : �������� ���� List �䱸
function OfflineNoteReq()
{
    var op_code = UA_LOGON_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : NoteSend
//  ���� : ���� ����
function NoteSend()
{
    var op_code = UA_NOTE_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : NoteConfirmSend
//  ���� : ���� Ȯ��
function NoteConfirmSend()
{
    var op_code = UA_NOTE_REPLY_REQ;
		var strSendData = "";
		
		Send_Msg(op_code,strSendData);
}

//==============================================================================================
//	�Լ��� : AppleWorkRequest
//  ���� : Apple �۾� ��û
//  value : strSendData        - TR CODE
//          strdata            - ó�� Data
function AppleWorkRequest(trcode, strdata)
{
    var op_code = UA_APPLE_REQ;
		var strSendData = "";

    var szMsgID = ""; // 12�ڸ��� ������ ������ ���� �� �ٽ� �޴� ���̴�.
    //if(trcode == "10001102")
    if(trcode == "30003101")
    {
        szMsgID = "GETBUDDY____";
    }
    //else if(trcode == "10001107")
    else if(trcode == "30001102")
    {    	
    	szMsgID = "GETUACONF___";
    }
    else if(trcode == "30003105")
    {
    	szMsgID = "GETUSERSEARC";
    }
    
		strSendData = trcode + chField +
		              szMsgID + chField +
		              strdata;
		              		
		Send_Msg(op_code,strSendData);
}

