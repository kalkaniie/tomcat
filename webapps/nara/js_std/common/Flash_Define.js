
// Socket Status =============================================================================
var SOCK_CONNECT            = 100; // ������ ����Ǿ����ϴ�
var SOCK_DISCONNECT         = 999; // ���� ������ ���������ϴ�
var SOCK_NOTCONNECT         = 400; // ���Ͽ� ������ �� �����ϴ�.
var SOCK_AUTH_ERROR         = 500; // ���� ������ ���Ͽ� ������ �� �����ϴ�. 

// Request OP Code =============================================================================
var UA_LOGON_REQ            = 11;
var UA_NAME_NOTI_REQ        = 35;
var UA_STAT_NOTI_REQ        = 37;
var UA_BUDDY_ADD_REQ        = 39;
var UA_BUDDY_DEL_REQ        = 43;
var UA_DIALOG_INDEX_REQ     = 49;
var UA_DIALOG_REQ           = 23;
var UA_DIALOG_DEL_REQ       = 51;
var UA_INVITE_REQ           = 25;
var UA_INV_AGR_SEND         = 27;
var UA_OFF_NOTE_REQ         = 47;
var UA_NOTE_REQ             = 15;
var UA_NOTE_REPLY_REQ       = 45;
var UA_APPLE_REQ            = 71;
//==============================================================================================

// Response OP Code =============================================================================
var UA_TYPE_NOTI            = 3;
var UA_LOGON_RESP           = 12;
var UA_DUP_LOG_RELAY        = 34;
var UA_NAME_NOTI_RELAY      = 36;
var UA_STAT_NOTI_RELAY      = 38;
var UA_BUDDY_ADD_RELAY      = 40;
var UA_BUDDY_ADD_RESP       = 42;
var UA_BUDDY_DEL_RELAY      = 44;
var UA_DIALOG_INDEX_RELAY   = 50;
var UA_DIALOG_RELAY         = 24;
var UA_DIALOG_DEL_REQ       = 51;
var UA_INVITE_RELAY         = 26;
var UA_INV_AGR_RELAY        = 28;
var UA_OFF_NOTE_RESP        = 48;
var UA_NOTE_RELAY           = 16;
var UA_NOTE_REPLY_RELAY     = 46;
var UA_APPLE_RESP           = 72;
var UA_PHOTO_REQ_REQ        = 58;
//==============================================================================================

// �ʵ� ������
var chField                 = '';
var chRecord                = '';

var chField_Tab             = '\t';
var chRecord_Enter          = '\n';
var chRecord_CR             = '\r';

// �α��� ����
var Socket_Connect  = 0;

// �α��� ����
var Login_Flag  = 0;

