
// Socket Status =============================================================================
var SOCK_CONNECT            = 100; // 소켓이 연결되었습니다
var SOCK_DISCONNECT         = 999; // 소켓 연결이 끊어졌습니다
var SOCK_NOTCONNECT         = 400; // 소켓에 연결할 수 없습니다.
var SOCK_AUTH_ERROR         = 500; // 보안 문제로 소켓에 연결할 수 없습니다. 

// Request OP Code =============================================================================
var UA_LOGON_REQ            = 1000;
var UA_NAME_NOTI_REQ        = 1404;
var UA_STAT_NOTI_REQ        = 1400;

var UA_BADD_AUTH_REQ       = 1100;
var UA_BADD_ACCEPT_REQ 		=	1102;
var UA_BAUTH_MODIFY_REQ     = 1108;

var UA_GROUP_COPY_REQ				= 1106;

var UA_BUDDY_ADD_REQ        = 39;
var UA_BUDDY_DEL_REQ        = 43;

var UA_DIALOG_INDEX_REQ     = 1200;
var UA_DIALOG_REQ           = 1202;
var UA_ROOM_ENTER_NOTI      = 1208;
var UA_ROOM_LEAVE_NOTI      = 1210;
var UA_TYPE_NOTI            = 1212;
var UA_PHOTO_REQ_REQ        = 1214;
var UA_DIALOG_DEL_REQ       = 51;
var UA_INVITE_REQ           = 1204;
var UA_INV_AGR_SEND         = 1206;
var UA_OFF_NOTE_REQ         = 1304;
var UA_NOTE_REQ             = 1300;
var UA_NOTE_REPLY_REQ       = 1302;
var UA_APPLE_REQ            = 71;
var UA_KEEPALIVE_DUMMY 		= 1098;
var UA_KEEPALIVE_DUMMY_REQ  = 1097;
//real Time
var UA_MAIL_LOGON_REQ  		= 1018;
var UA_RCS_INVITE_REQ  		= 1224;  // 원격제어 요청 ( Client -> IMS )
var UA_RCS_INV_AGR_SEND  	= 1226;  // 원격제어 수락 전달 ( Client -> IMS )
//==============================================================================================

// Response OP Code =============================================================================
var UA_LOGON_RESP           = 1001;
var UA_DUP_LOG_RELAY        = 34;
var UA_NAME_NOTI_RELAY      = 1405;
var UA_STAT_NOTI_RELAY      = 1401;

var UA_BADD_AUTH_RELAY			= 1101;
var UA_BADD_ACCEPT_RELAY		= 1103;
var UA_BAUTH_MODIFY_RESP 		= 1109;

var UA_BUDDY_ADD_RELAY      = 40;
var UA_BUDDY_ADD_RESP       = 42;
var UA_BUDDY_DEL_RELAY      = 44;
var UA_GROUP_COPY_RESP			=1107;
var UA_DIALOG_INDEX_RELAY   = 1201;

var UA_DIALOG_RELAY         = 1203;
var UA_ROOM_ENTER_RELAY     = 1209;
var UA_ROOM_LEAVE_RELAY     = 1211;
var UA_TYPE_RELAY           = 1213;
var UA_PHOTO_REQ_RELAY      = 1215;
var UA_INVITE_RELAY         = 1205;
var UA_INV_AGR_RELAY        = 1207;
var UA_OFF_NOTE_RESP        = 1305;
var UA_NOTE_RELAY           = 1301;
var UA_NOTE_REPLY_RELAY     = 1303;
var UA_APPLE_RESP           = 72;
//var UA_PHOTO_REQ_REQ        = 58;

//real Time
var UA_KEEPALIVE_DUMMY_RELAY = 1096;
var UA_RCS_INVITE_RELAY 	 = 1225;  // 원격제어 요청 받음 ( IMS -> Client )
var UA_RCS_INV_AGR_RELAY 	 = 1227;  // 원격제어 수락 받음 ( IMS -> Client )
//==============================================================================================

// 필드 구분자
var chField                 = '';
var chRecord                = '';

var chField_Tab             = '\t';
var chRecord_Enter          = '\n';
var chRecord_CR             = '\r';

// 로그인 구분
var Socket_Connect  = 0;

// 로그인 구분
var Login_Flag  = 0;

var UAConfig_Flag = 0;
var GETBuddy_Flag = 0;


/*UA CONFIG 정보
@see Flash_Process.js - GetUAConfig()
0.사용자명(mandatory)
1.대화명(mandatory)
2.핸드폰번호(mandatory)
3.사용자계정(id@domain)
4.유저타입(1:일반고객, 2:기업고객, 3:직원 4:호스팅고객)
5.부서코드(optional)
6:부서명(optional)
*/
var uaconfArr = new Array(7);


/* WATCHER LIST 정보
: 멀티 데이터 셋임.
@ see Flash_Response.js - GetWatcherList() 
0.와쳐 사용자ID
1.서버 IP
2.서버 Port
3.Flag - 1:일반 watcher, 0:외부연동 watcher
*/
var watcherlist = new Array();



/* 버디 그룹 정보
: 멀티 데이터 셋임.
@ see Buddy_Process.js - GetBuddyWork() 
0.그룹 Index
1.그룹 이름
2.default구분, '0' OR 'N' 이면 그룹 삭제 불가.

*/
//var groupArray = new Array();


/*버디 정보
: 멀티 데이터 셋임.
@ see Buddy_Process.js - GetBuddyWork() 
0.버디ID
1.버디DOMAIN
2.버디이름
3.버디대화명
4.버디그룹인덱스
5.버디상태값
6.버디로그인서버index
7.버디아이디@도메인
8.버디로그인서버IP
9.버디로그인서버PORT
10.버디인증상태(0:알수없음,1:승인신청발신,2:승인신청수신,3:승인, -1:거절, -2:거절및차단,-3:삭제, -4:삭제및차단, -5:차단)
11.버디사용자타입(1:일반_개인고객,2:일반_기업고객,3:회사직원,4:호스팅고객)
12.버디요청자이름
13.버디요청메세지
14.버디고객등급
*/
var listArray  = new Array();
