CREATE TABLE DOMAIN
(    DOMAIN                     VARCHAR(100) NOT NULL primary key ,       /*회원사 도메인 명*/
     DOMAIN_TYPE                CHAR(1),                        /*가입구분 C:기업 (단체)   P:개인*/
     DOMAIN_NAME                VARCHAR(100),                   /*고객명,회사명,학교명*/
     DOMAIN_JOB                 VARCHAR(4),                     /*직종구분 코드*/
     DOMAIN_TEL                 VARCHAR(20),                    /*연락 가능 전화번호*/
     DOMAIN_ZIPCODE             VARCHAR(10),                    /*우편번호*/
     DOMAIN_ADDRESS1            VARCHAR(100),                   /*주소  연락 가능 주소*/
     DOMAIN_ADDRESS2            VARCHAR(100),                   /*세부주소*/
     DOMAIN_HOMEPAGE            VARCHAR(100),                   /*홈페이지 주소 홈페이지 주소*/
     DOMAIN_AGREEMENT           CHAR(1),                        /*등록약관사용여부 Y: 사용 N : 사용안함 DEFAULT Y*/
     DOMAIN_AGREEMENT_STMT      TEXT,                           /*등록약관 내용 등록약관 내용*/
     DOMAIN_GREETINGS           CHAR(1),                        /*가입인사말 사용여부 Y: 사용 N : 사용안함 DEFAULT Y*/
     DOMAIN_GREETINGS_FROM      VARCHAR(200),                   /*가입인사 발송자 이메일*/
     DOMAIN_GREETINGS_TITLE     TEXT,                           /*가입인사 제목*/
     DOMAIN_GREETINGS_CONTENTTYPE       VARCHAR(20),            /*가입인사말 내용 TYPE*/
     DOMAIN_GREETINGS_CONTENT   TEXT,                           /*가입인사말 내용*/
     DOMAIN_CERTIFY             CHAR(1),                        /*인증Y: 사용가능  N : 사용불가능 DEFAULT N */
     DOMAIN_JOIN_CERTIFY        CHAR(1),                        /*회원가입시 인증키사용여부     Y: 사용 N : 사용안함 DEFAULT N */
     DOMAIN_JOIN_CERTIFY_OPT    CHAR(1),                        /*한개 인증키에 한명만 허용     Y: 사용 N : 사용안함 DEFAULT N */
     DOMAIN_JOIN_WAY            TINYINT unsigned ,              /*사용자 가입방식       1.자유가입 2.인증후 가입 3.가입후 인증 4.가입없슴 (DEFAULT:1)*/
     DOMAIN_GROUP_OPT           TINYINT unsigned ,              /*그룹설정방식  1.가입시 설정 2.가입후 설정(DEFAULT:1)*/
     DOMAIN_JOIN_REQUIRED_ITEM  VARCHAR(100),                   /*가입필수 항목 1.주민번호  2.성별  3.생년월일  4.별명 5.전화번호  6.직업   7.학교/직장명   8.학과/부서명 9.주소  10.학번/사번   11.연락가능 e-mail (DEFAULT="1")*/
     DOMAIN_JOIN_CERTIFY_ITEM   VARCHAR(100),                   /*가입인증항목  1.이름  2.주민번호  3.학번/사번   4학과/부서명 (DEFAULT:1,2)*/
     DOMAIN_JOINDATE            DATETIME,                       /*가입일시*/
     DOMAIN_EXPIREDDATE         DATETIME,                       /* 서비스 만료일자*/
     DOMAIN_LANG                VARCHAR(10),                    /*도메인 언어설정 DEFAULT : CONFIG파일의 언어설정*/
     DOMAIN_FUNCTION_KEY        VARCHAR(20),                    /*도메인별 메뉴사용여부(도메인별 메뉴사용여부(도메인별 메뉴사용여부(웹메일,POP3,일정관리,파일관리,인터넷디스크,게시판,인트라넷,메신져,홈페이지,SMS default:1111111111) */
     DOMAIN_LIMIT_STORAGE       INT,                            /*도메일전체 사용량 제한 DEFAULT = -1(제한없음)*/
     DOMAIN_LIMIT_USERS         INT,                            /*도메인 유저수 제한  DEFAULT = -1(제한없음)*/
     DOMAIM_LIMIT_FORWARD       MEDIUMINT       unsigned ,      /*메일 포워딩설정 개수 제한 DEFAULT = 10*/
     DOMAIN_LIMIT_UPLOAD        MEDIUMINT       unsigned ,      /*첨부파일 용량 제한 DEFAULT = 10*/
     DOMAIN_USER_VOLUME         MEDIUMINT       unsigned ,      /*사용자 기본 용량 DEFAULT=20*/
     DOMAIN_MEMO                TEXT,                           /*메모*/
     DOMAIN_DISPLAY_TOP         CHAR(1),                        /*페이지 상단 표시 여부 Y: 사용 N : 사용안함 DEFAULT Y*/
     DOMAIN_DISPLAY_BOTTOM      CHAR(1),                        /*페이지 하단 표시 여부 Y: 사용 N : 사용안함 DEFAULT Y*/
     DOMAIN_DISPLAY_MENU        CHAR(1),                        /*페이지 메뉴 표시 여부 Y: 사용 N : 사용안함 DEFAULT Y*/
     DOMAIN_DISPLAY_MENU_POSITION       CHAR(1),                /*메뉴 위치     L:좌측메뉴 사용 R:우측메뉴사용 DEFAULT L*/
     DOMAIN_TABLE_PIX           MEDIUMINT       unsigned ,      /*전체테이블크기*/
     DOMAIN_TOP_PIX             MEDIUMINT       unsigned ,      /*상단프레임 */
     DOMAIN_LEFT_SPACE          MEDIUMINT       unsigned ,      /*좌측여백 */
     DOMAIN_BOTTOM_SPACE        MEDIUMINT       unsigned ,      /*하단여백 */
     DOMAIN_DISPLAY_BGIMG       CHAR(1),                        /*배경이미지 사용여부.  Y:사용, N:사용안함.  DEFAULT:N*/
     DOMAIN_BGIMG               VARCHAR(50),                    /*백그라운드 이미지*/
     DOMAIN_BGCOLOR             VARCHAR(10),                    /*백그라운드 COLOR*/
     DOMAIN_TXT_COPY            VARCHAR(200),                   /*Copyright 내용*/
     DOMAIN_COLOR_SKIN          CHAR(1),                        /*칼라톤        DEFAULT G(GRAY)*/
     DOMAIN_COLOR_TXT           VARCHAR(10),                    /*기본 글자색*/
     DOMAIN_COLOR_TOPTXT        VARCHAR(10),                    /*상단 글자색*/
     DOMAIN_BGCOLOR_MENU        VARCHAR(10),                    /*메뉴 배경색*/
     DOMAIN_BGCOLOR_BTN         VARCHAR(10),                    /*하단 배경색*/
     DOMAIN_COLOR_ALINK         VARCHAR(10),                    /*링크된 글자색*/
     DOMAIN_BGCOLOR_TOP         VARCHAR(10),                    /*상단 배경색*/
     DOMAIN_BGCOLOR_TABLE       VARCHAR(10),                    /*테이블 배경색*/
     DOMAIN_COLOR_TABLELINE     VARCHAR(10),                    /*테이블 라인색*/
     DOMAIN_COLOR_COPY          VARCHAR(10),                    /*Copyright 글자색*/
     DOMAIN_TOP_HTML_USE        CHAR(1),                          /*상단프레임 HTML사용여부*/
     DOMAIN_TOP_HTML            VARCHAR(50),                    /*상단프레임 HTML명*/
     DOMAIN_TOP_BGCOLOR         VARCHAR(10),                    /*상단프레임 배경색*/
     DOMAIN_DISPLAY_TOP_BGIMG   CHAR(1),                        /*배경이미지 사용여부.  Y:사용, N:사용안함.  DEFAULT:N*/
     DOMAIN_TOP_BGIMG           VARCHAR(50),                    /*상단프레임 배경이미지*/
     DOMAIN_TOP_BTN             MEDIUMINT,                          /*상단프레임 메뉴형식*/
     DOMAIN_TOP_BTNCOLOR        VARCHAR(10),                    /*상단프레임 메뉴 글자색*/
     DOMAIN_TOP_MENU_POS        TINYINT,                        /*상단프레임 메뉴위치*/
     DOMAIN_DISPLAY_LOGO        CHAR(1),                        /*배경이미지 사용여부.  Y:사용, N:사용안함.  DEFAULT:N*/
     DOMAIN_LOGO                VARCHAR(50),                      /*상단프레임 로고*/
     DOMAIN_LOGO_TXT            VARCHAR(200),                   /*상단프레임 홍보문구*/
     DOMAIN_LOGO_TXTCOLOR       VARCHAR(10),                    /*상단프레임 홍보문구색*/
     DOMAIN_BTN_CNT             TINYINT         unsigned ,      /*상단프레임 버턴 개수*/
     DOMAIN_TABLE_POS           CHAR(1),                        /*전체테이블위치        L:좌측 사용 R:우측 C:중앙 DEFAULT L*/
     DOMAIN_INPUT_TXT           VARCHAR(10),                    /*텍스트박스 라인색 */
     DOMAIN_LOGO_LINK           VARCHAR(255),                   /*로고링크*/
     DOMAIN_MOTO_USE            CHAR(1),                        /*슬로건 사용여부       Y:사용, N:사용안함. DEFAULT N*/
     DOMAIN_MENU_PIX            MEDIUMINT       unsigned ,      /*메뉴픽셀      DEFAULT 146*/
     DOMAIN_BTN1_TITLE          VARCHAR(40),                    /*1번째 버턴이름*/
     DOMAIN_BTN1_LINK           VARCHAR(255),                   /*1번째 버턴링크*/
     DOMAIN_BTN1_TARGET         VARCHAR(40),                    /*1번째 버턴 타켓*/
     DOMAIN_BTN1_ALT            VARCHAR(60),                    /*1번째 버턴 ALT*/
     DOMAIN_BTN2_TITLE          VARCHAR(40),                    /*2번째 버턴이름*/
     DOMAIN_BTN2_LINK           VARCHAR(255),                   /*2번째 버턴링크*/
     DOMAIN_BTN2_TARGET         VARCHAR(40),                    /*2번째 버턴 타켓*/
     DOMAIN_BTN2_ALT            VARCHAR(60),                    /*2번째 버턴 ALT*/
     DOMAIN_BTN3_TITLE          VARCHAR(40),                    /*3번째 버턴이름*/
     DOMAIN_BTN3_LINK           VARCHAR(255),                   /*3번째 버턴링크*/
     DOMAIN_BTN3_TARGET         VARCHAR(40),                    /*3번째 버턴 타켓*/
     DOMAIN_BTN3_ALT            VARCHAR(60),                    /*3번째 버턴 ALT*/
     DOMAIN_BTN4_TITLE          VARCHAR(40),                    /*4번째 버턴이름*/
     DOMAIN_BTN4_LINK           VARCHAR(255),                   /*4번째 버턴링크*/
     DOMAIN_BTN4_TARGET         VARCHAR(40),                    /*4번째 버턴 타켓*/
     DOMAIN_BTN4_ALT            VARCHAR(60),                    /*4번째 버턴 ALT*/
     DOMAIN_BTN5_TITLE          VARCHAR(40),                    /*5번째 버턴이름*/
     DOMAIN_BTN5_LINK           VARCHAR(255),                   /*5번째 버턴링크*/
     DOMAIN_BTN5_TARGET         VARCHAR(40),                    /*5번째 버턴 타켓*/
     DOMAIN_BTN5_ALT            VARCHAR(60),                    /*5번째 버턴 ALT*/
     DOMAIN_BTN6_TITLE          VARCHAR(40),                    /*6번째 버턴이름*/
     DOMAIN_BTN6_LINK           VARCHAR(255),                   /*6번째 버턴링크*/
     DOMAIN_BTN6_TARGET         VARCHAR(40),                    /*6번째 버턴 타켓*/
     DOMAIN_BTN6_ALT            VARCHAR(60),                    /*6번째 버턴 ALT*/
     DOMAIN_BTN7_TITLE          VARCHAR(40),                    /*7번째 버턴이름*/
     DOMAIN_BTN7_LINK           VARCHAR(255),                   /*v7번째 버턴링크*/
     DOMAIN_BTN7_TARGET         VARCHAR(40),                    /*7번째 버턴 타켓*/
     DOMAIN_BTN7_ALT            VARCHAR(60),                    /*7번째 버턴 ALT*/
     DOMAIN_SMS_LIMIT           INT,                                    /*SMS 사용자 발송건수*/
     DOMAIN_MAIL_QUOTA  INT NOT NULL DEFAULT '0', /*메일 발송 쿼터 default = 0,  무제한 : 0*/
     DOMAIN_MAIL_BANNER  TINYINT NOT NULL DEFAULT '0',  /*메일 발송 베너 사용여부 0:사용안함 1:사용함*/
     DOMAIN_MAIL_BANNER_TEXT TEXT,                      /*메일 발송용 베너 내용*/
     DOMAIN_ACCOUNT_LIMIT INT NOT NULL DEFAULT '0',   /*개인당 멀티 계정 최대수*/
     DOMAIN_PAUSE_DAYS  INT NOT NULL DEFAULT '0', /*휴지 기간(일)*/
     DOMAIN_BIGMAIL_QUOTA  		BIGINT(15)  DEFAULT 0		/* 대용량메일 도메인 쿼터*/
)type=InnoDB;

CREATE TABLE CERTIFY
(    CERTIFY_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*인증키 인덱스(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN               	VARCHAR(100)   NOT NULL, 	/*회원사 도메인 명 */
     CERTIFY_ISVALID		CHAR(1),			/*사용가능여부	Y:사용가능 N:사용불가능*/
     CERTIFY_NAME               VARCHAR(200), 			/*사용자이름*/
     CERTIFY_JUMIN1		VARCHAR(6),			/*주민등록번호1*/
     CERTIFY_JUMIN2		VARCHAR(7),			/*주민등록번호2*/
     CERTIFY_DEPARTMENT		VARCHAR(100),			/*학과/부서명*/
     CERTIFY_LICENCENUM		VARCHAR(200)			/*학번/사번*/
)type=InnoDB;

CREATE TABLE RESERVEID
(    RESERVEID_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*예약 ID 인덱스(SEQ) (PK)	예약 ID 인덱스, SERIAL NO(1-99999999)*/
     DOMAIN			VARCHAR(100)    NOT NULL, 	/*도메인명*/   		
     RESERVEID_ID		VARCHAR(100)            /*예약 ID*/
)type=InnoDB;

CREATE TABLE USERS
(   USERS_IDX			VARCHAR(200)	NOT NULL primary key,	/*사용자키(PK)	개인고유키(ID@DOMAIN)*/
    USERS_ID			VARCHAR(100)	NOT NULL,	/*아이디*/
    USERS_PASSWD		VARCHAR(50)	NOT NULL,	/*패스워드*/
    DOMAIN			VARCHAR(100)	NOT NULL,	/*도메인*/
    USERS_HOMEDIR		VARCHAR(100)	NOT NULL,	/*사용자 홈 디렉토리*/
    USERS_PERMIT	        CHAR(1)         NOT NULL,                 	/*서비스 상태	W:대기상태  S:사용허가 N:사용중지*/
    USERS_AUTH			CHAR(1)         NOT NULL,			/*권한	S: 시스템 관리자 A:관리자 U:일반*/
    USERS_NAME			VARCHAR(20),			/*한글이름*/
    USERS_ENGNAME		VARCHAR(50),			/*영문이름*/
    USERS_NICKNAME		VARCHAR(40),			/*별명*/
    USERS_JUMIN1		VARCHAR(6),			/*주민등록번호1*/
    USERS_JUMIN2		VARCHAR(7),			/*주민등록번호2*/ 
    USERS_SEX			CHAR(1),			/*성별	M : 남자  F : 여자*/
    USERS_BIRTH			VARCHAR(10),			/*생년월일*/
    USERS_ISSOLAR		CHAR(1),			/*양/음력	S : 양력  L : 음력*/
    USERS_CELLNO		VARCHAR(30),			/*핸드폰번호*/
    USERS_FAXNO			VARCHAR(30),			/*팩스번호*/
    USERS_TELNO			VARCHAR(30),			/*전화번호*/
    USERS_ZIPCODE		VARCHAR(10),			/*우편번호*/
    USERS_ADDRESS1		VARCHAR(100),			/*주소1*/
    USERS_ADDRESS2		VARCHAR(100),			/*주소2*/
    USERS_JOBCODE		CHAR(4),			/*직업코드*/
    USERS_COMPNAME		VARCHAR(100),			/*학교/회사명*/
    USERS_DEPARTMENT		VARCHAR(100),			/*학과/부서명*/
    USERS_PREVEMAIL		VARCHAR(50),			/*이전이메일*/
    USERS_SCHOOLING		CHAR(4),			/*최종학력 S100,S101…*/
    USERS_INTEREST		CHAR(4),			/*관심사 I100,I101…*/
    USERS_LICENCENUM            VARCHAR(200),			/*학번, 사번*/
    USERS_ISOPEN		VARCHAR(50),			/*정보공개여부	이름/ID/별명,연락처,직업/나이,관심분야/최종학력*/
    USERS_JOINDATE		DATETIME,			/*가입일시*/
    USERS_EXPIREDDATE DATETIME,            /* 사용자 서비스 만료일자 */
    USERS_LOGCOUNT		INT,				/*접속수*/
    USERS_LASTHOST		VARCHAR(40),			/*최종접속호스트*/
    USERS_MAX_VOLUME		INT,				/*최대 허용 용량(MB)*/
    USERS_CUR_VOLUME		INT,				/*현재 사용중인 메일 용량(MB)*/
    USERS_LASTDATE		DATETIME,			/*최종접속시간*/
    USERS_SIGNATURE		CHAR(1),			/*서명파일사용여부	Y:사용함 N:사용안함 DEFAULT N*/ 
    USERS_SIGNATURESTMT		TEXT,				/*서명파일내용*/
    USERS_AUTORE		CHAR(1),			/*자동응답사용여부	Y:사용 N :미사용 DEFAULT N*/
    USERS_AUTORESTMT		TEXT,				/*자동응답내용*/
    USERS_USENAME		CHAR(1),			/*사용할 이름	K : 한글 E : 영문 N: 별명 DEFAULT K*/
    USERS_SENDBOX		CHAR(1),			/*보낸편지 저장함 기본값	Y:보낸 편지 자동으로 보낸 편지함에 저장 N:저장안함 DEFAULT Y*/
    USERS_DELBOX		CHAR(1),			/*지운편지 저장함 기본값	Y:지운 편지가 자동으로 휴지통에 저장 N:저장안함 DEFAULT Y*/
    USERS_AUTO_DEL		CHAR(1),			/*자동삭제시 저장함 기본값	Y:자동삭제시 휴지통에 저장 N:저장안함 DEFAULT Y*/
    USERS_LISTNUM	        MEDIUMINT,			/*편지갯수표시	화면에 표시되는 편지 개수*/
    USERS_ISVOTE		CHAR(1),			/*투표참여여부	Y:참여 N:미참여 DEFAULT N*/
    USERS_ABSENT		CHAR(1),			/*부재중 설정	Y:부재중 N: 재중 DEFAULT : N*/
    USERS_ABSENT_SDATE		DATETIME,			/*부재 시작 날짜*/
    USERS_ABSENT_EDATE		DATETIME,			/*부재 끝 날짜*/
    USERS_ABSENT_RESTMT		TEXT,				/*부재중시 자동답변내용*/
    USERS_OPT_FWD	        CHAR(1),                   	/*자동전달 사용여부	Y: 사용함 N: 미사용*/
    USERS_OPT_FWD_SAVE	        CHAR(1),                	/*자동전달후 저장여부	Y: 저장함 N: 지움*/
    USERS_FWD_LIST	        TEXT,   		      	/*자동전달 주소 목록	자동전달할 주소 목록*/
    USERS_READDR		TEXT,				/*회신용 주소 목록*/
    USERS_SPAM_LEVEL		CHAR(1),			/*스펨메일차단수준	N:차단안함 L:낮음 M:중간 H:높음*/
    USERS_DEL_WASTE 		SMALLINT,			/*휴지통 메일 보관 기간*/
    USERS_DEL_SPAM		SMALLINT,			/*광고성 메일함 보관 기간*/
    USERS_LANG 			VARCHAR(10),			/*사용자 언어설정 DEFAULT:DOMAIN의 언어설정*/
    USERS_MAIL_ALARM            SMALLINT,			/*새편지 확인주기(분) DEFAULT:10*/
    USERS_ALARM_SOUND		SMALLINT,			/*새편지 알람소리 DEFAULT:1,  0:사용안함*/
    USERS_INDEX_PAGE            CHAR(1),			/*첫화면 설정 DEFALUT : 0 (메일) */
    USERS_RECEIVE_INFOMAIL	CHAR(1),	/*정보메일 받기 DEFAULT : Y*/
    USERS_MAIL_VIEW		TINYINT,			  /*메일표시방법	1:1단 2:2단 3:새창*/
    USERS_MAIL_INJURE		CHAR(1),			/*메일 유해성 사용여부	Y:사용 N :미사용 DEFAULT Y */
    USERS_ORGANIZE_IDX		INT,				/*조직도 그룹IDX(조직도) default:0 */
    USERS_AUTHORITY_IDX		INT,				/*직급 IDX(조직도) default : 0*/
    USERS_SMS_QUOTA       INT,	      /*SMS 최대 허용 발송 건수 default = 0,  무제한 : -1*/
    USERS_MAIL_QUOTA      INT NOT NULL DEFAULT '0',  /*메일 발송 쿼터 default = 0,  무제한 : 0*/
    USERS_MEMO            TEXT                /*개인 소개 글*/
)type=InnoDB;

--먼저 users table의 users_id에 인덱스를 건다.(관계를 맺기 위해)
alter table  USERS add index USERS_INDEX2(USERS_ID);


CREATE TABLE USERS_REGIST
(    USERS_REGIST_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*인증키 인덱스(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN               	VARCHAR(100)   NOT NULL, 	/*회원사 도메인 명 */
     USERS_REGIST_ID            VARCHAR(100), 			/*사용자ID*/
     USERS_REGIST_NAME          VARCHAR(200), 			/*사용자이름*/
     USERS_REGIST_PASSWD	VARCHAR(50),			/*패스워드*/
     USERS_REGIST_JUMIN1	VARCHAR(6),			/*주민등록번호1*/
     USERS_REGIST_JUMIN2	VARCHAR(7),			/*주민등록번호2*/
     USERS_REGIST_DEPARTMENT	VARCHAR(100),			/*학과/부서명*/
     USERS_REGIST_LICENCENUM	VARCHAR(200)			/*학번/사번*/
)type=InnoDB;

CREATE TABLE USERS_PAUSE
(    USERS_PAUSE_IDX           INT     unsigned NOT NULL auto_increment primary key,   /*인증키 인덱스(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN                     VARCHAR(100)   NOT NULL,        /*회원사 도메인 명 */
     USERS_PAUSE_ID            VARCHAR(100),                   /*사용자ID*/
     USERS_PAUSE_NAME          VARCHAR(200),                   /*사용자이름*/
     USERS_PAUSE_PASSWD        VARCHAR(50),                    /*패스워드*/
     USERS_PAUSE_JUMIN1        VARCHAR(6),                     /*주민등록번호1*/
     USERS_PAUSE_JUMIN2        VARCHAR(7),                     /*주민등록번호2*/
     USERS_PAUSE_DEPARTMENT    VARCHAR(100),                   /*학과/부서명*/
     USERS_PAUSE_LICENCENUM    VARCHAR(200)                    /*학번/사번*/
)type=InnoDB;

CREATE TABLE USERS_DELETE
(    USERS_DELETE_IDX		INT	unsigned NOT NULL auto_increment primary key,  	/*인증키 인덱스(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN               	VARCHAR(100)   NOT NULL, 	/*회원사 도메인 명 */
     USERS_DELETE_ID            VARCHAR(100), 			/*사용자ID*/
     USERS_DELETE_NAME          VARCHAR(200), 			/*사용자이름*/
     USERS_DELETE_PASSWD	VARCHAR(50),			/*패스워드*/
     USERS_DELETE_JUMIN1	VARCHAR(6),			/*주민등록번호1*/
     USERS_DELETE_JUMIN2	VARCHAR(7),			/*주민등록번호2*/
     USERS_DELETE_DEPARTMENT	VARCHAR(100),			/*학과/부서명*/
     USERS_DELETE_LICENCENUM	VARCHAR(200)			/*학번/사번*/
)type=InnoDB;

CREATE TABLE BASEINFO                                           
(   BASEINFO_TYPE	         CHAR(1),	         	/* P:보호자 관계,H:비밀번호 힌트,J:직업,S:최종학력,I:관심분야 */
    BASEINFO_ID                  CHAR(4),	                /* 기본정보ID */
    BASEINFO_VALUE               VARCHAR(100)	                /* 기본정보내용 */
)type=InnoDB;

CREATE TABLE ZIPCODE
(	ZIPCODE_CD		  VARCHAR(10),		/* 우편번호 */ 
	ZIPCODE_ADDR1		VARCHAR(20),           	/* 시도 */  
 	ZIPCODE_ADDR2		VARCHAR(20),           	/* 시군구 */
	ZIPCODE_ADDR3		VARCHAR(50),           	/* 동 */
	ZIPCODE_ADDR4		VARCHAR(50),
	ZIPCODE_CHANGE 	VARCHAR(20)
)type=InnoDB;

CREATE TABLE MBOX
( MBOX_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*MBOX 인덱스키(PK) SERIAL NO(1-4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,   /*사용자 고유키*/
	MBOX_TYPE		SMALLINT	NOT NULL,		    /*1.받은편지함 2.보낸편지함 3.지운편지함 4.임시보관함 5.광고메일함 6.사용자정의*/
	MBOX_REF    INT NOT NULL DEFAULT '0', /*parent MBOX_IDX */
	MBOX_NAME		VARCHAR(50),				      /*MAILBOX 이름*/
	MBOX_SIZE		INT,				              /*파일크기*/
	MBOX_MAILCOUNT  INT,					        /*MAILBOX내 메일 개수*/
	MBOX_SUBSCRIBE CHAR(1) DEFAULT 'Y',    /*편지함 출력(IMAP)*/
	INDEX MBOX_INDEX_USERS_IDX (USERS_IDX),
	INDEX MBOX_INDEX_MBOX_IDX_MBOX_TYPE (MBOX_IDX, MBOX_TYPE)
)type=InnoDB;


CREATE TABLE AUTODIVISION
(	AUTODIVISION_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*자동분류 인덱스 SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*사용자 IDX*/
	MBOX_IDX		INT,						/*편지함 인덱스 키*/
	AUTODIVISION_TYPE	TINYINT,					/*0:전체, 1: 보내는사람 2,받는사람, 3:제목*/
	AUTODIVISION_KEYWORD	VARCHAR(200),					/*자동분류 키워드*/
	NOTICE INT(1),
	INDEX AUTODIVISION_INDEX (USERS_IDX)
)type=InnoDB;

CREATE TABLE FILTER
(	FILTER_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*필터링 인덱스 SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*사용자 IDX*/
	FILTER_AUTH		TINYINT,					/*1:SYSTEM관리자 2:도메인관리자3:일반유저*/
	FILTER_TYPE		TINYINT,					/*1:수신거부이메일 2:수신거부도메인 3:수신거부제목 4:수신거부IP 5:수신메일주소 6수신도메인*/
	FILTER_KEYWORD		VARCHAR(200),					/*필터링 키워드*/
	INDEX INDEX_FILTER_USERS_IDX (USERS_IDX),
	INDEX INDEX_FILTER_FILTER_AUTH (FILTER_AUTH)
)type=InnoDB;

CREATE TABLE INJURE
(	INJURE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*유해성 키워드 인덱스 SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*사용자 IDX*/
	INJURE_AUTH		TINYINT,					/*1:SYSTEM관리자 2:도메인관리자3:일반유저*/
	INJURE_KEYWORD		VARCHAR(200),					/*유해성 키워드*/
	INDEX INDEX_INJURE_USERS_IDX (USERS_IDX)
)type=InnoDB;

CREATE TABLE POP
(	POP_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*POP 인덱스 SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*사용자 IDX*/
  POP_PROTOCOL		VARCHAR(200),					/*PROTOCOL*/
  POP_SERVER		VARCHAR(200),					/*POP SERVER*/
  POP_ID			VARCHAR(200),					/*POP ID*/
  POP_PASSWD		VARCHAR(200),					/*POP PASSWD*/
  MBOX_IDX		INT,						/*저장할 편지함 IDX*/
  POP_ISDEL		VARCHAR(1),					/*서버에서 삭제여부	Y:삭제 N:남김 DEFAULT : N*/
  POP_MBOX		VARCHAR(100),					/*가져올 편지함	새편지:INBOX*/
  INDEX INDEX_POP_USERS_IDX (USERS_IDX)
)type=InnoDB;

CREATE TABLE RESERVATION
(	RESERVATION_IDX INT unsigned  NOT NULL  auto_increment  primary key,	/*예약발송 인덱스 SEQ(1~4294967295)*/
  USERS_IDX VARCHAR(200)  NOT NULL, /*사용자 IDX*/
  RESERVATION_TO  TEXT,						/*메일 수신 이메일*/
	RESERVATION_FILE  VARCHAR(200),					/*예약발송할 메일 파일 절대경로*/
	RESERVATION_TIME  DATETIME,					/*예약발송시간*/
	MAIL_RECONF_IDX INT   NOT NULL, /*수신확인 인덱스 코드*/
	INDEX INDEX_RESERVATION_USERS_IDX (USERS_IDX),
	INDEX INDEX_RESERVATION_RECONF  (MAIL_RECONF_IDX)
)type=InnoDB;

CREATE TABLE ORGANIZE
(	ORGANIZE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*조직도 그룹 인덱스 PK SEQ(1~4294967295)*/
	DOMAIN                  VARCHAR(100)   NOT NULL,      			/*회원사 도메인 명 */	
	ORGANIZE_REF		INT,						/*부모 그룹 인덱스*/
  ORGANIZE_STEP		INT,						/*그룹 레벨*/
	ORGANIZE_LEVEL		INT,						/*부모 그룹 내 레벨*/
  ORGANIZE_DEF		INT,						/*부모 그룹 내 레벨*/
  ORGANIZE_ADMIN      VARCHAR(200), 				      	/*그룹 관리자 IDX*/
	ORGANIZE_NAME           VARCHAR(100), 				      	/*그룹명(부서명)*/
  ORGANIZE_TITLE          VARCHAR(200), 				      	/*그룹타이틀*/
	ORGANIZE_OPERATION      TEXT,	 	   			   	/*그룹 진행업무*/
	ORGANIZE_STMT      	TEXT, 						/*그룹 설명*/
	ORGANIZE_SCHEDULE       TINYINT,					/*그룹 일정 전체 공개여부	0:비공개 1:공개 DEFAULT :0*/
  ORGANIZE_SCHEDULE_HIGHER      TINYINT,					/*그룹 일정 상위그룹 공개여부	0:비공개 1:공개 DEFAULT :0*/
	ORGANIZE_SCHEDULE_LOWER       TINYINT,					/*그룹 일정 하위그룹 공개여부	0:비공개 1:공개 DEFAULT :0*/
	ORGANIZE_SCHEDULE_EQUALTY     TINYINT 					/*그룹 일정 동급그룹 공개여부	0:비공개 1:공개 DEFAULT :0*/
)type=InnoDB;

CREATE TABLE AUTHORITY
(	AUTHORITY_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*직급 인덱스 (PK)SEQ(1~4294967295)*/	
	DOMAIN                  VARCHAR(100)   NOT NULL,		      	/*회원사 도메인 명 */		
	AUTHORITY_NAME		VARCHAR(100),					/*직급명*/
	AUTHORITY_LEVEL		INT						/*레벨*/
)type=InnoDB;

CREATE TABLE MEMBER
(	MEMBER_IDX		INT	unsigned NOT NULL auto_increment primary key, /*직급 인덱스 (PK)(SEQ : 1~999999999)*/
	DOMAIN                  VARCHAR(100)    NOT NULL,			 	/*회원사 도메인 명 */
	USERS_IDX		VARCHAR(200)	NOT NULL,	/*사용자IDX*/
	ORGANIZE_IDX		INT		NOT NULL,       /*그룹 IDX*/
	AUTHORITY_IDX		INT,		                /*직급 IDX*/
	INDEX MEMBER_INDEX (ORGANIZE_IDX)
)type=InnoDB;


CREATE TABLE ADDRESS_GROUP
(	ADDRESS_GROUP_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*주소록그룹인덱스(pk) (SEQ 1~4294967295)*/
	USERS_IDX		VARCHAR(200)	NOT NULL,			/*사용자IDX*/
	ADDRESS_GROUP_STMT	VARCHAR(255),					/*그룹설명*/
	INDEX ADDRESS_GROUP_USERS_IDX (USERS_IDX)
)type=InnoDB;

CREATE TABLE ADDRESS
( ADDRESS_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*주소록 인덱스(PK) (SEQ 1~4294967295)*/
	USERS_IDX		VARCHAR(200)	NOT NULL,			/*사용자키*/
	ADDRESS_GROUP_IDX	INT,						/*주소록그룹인덱스*/
	ADDRESS_NAME		VARCHAR(100),					/*이름*/
	ADDRESS_EMAIL		VARCHAR(200),					/*이메일*/
	ADDRESS_TEL		VARCHAR(100),					/*집전화 번호*/
	ADDRESS_CELLTEL		VARCHAR(100),					/*휴대폰번호*/
	ADDRESS_HOMEZIP		VARCHAR(100),					/*집우편번호*/
	ADDRESS_HOMEADDR	VARCHAR(100),					/*집주소*/
	ADDRESS_OFFICE		VARCHAR(100),					/*회사명*/
	ADDRESS_DEPT		VARCHAR(100),					/*부서*/
	ADDRESS_DUTY		VARCHAR(100),					/*직책*/
	ADDRESS_OFFICETEL	VARCHAR(100),					/*회사전화번호*/
	ADDRESS_OFFICEZIP	VARCHAR(100),					/*회사우편번호*/
	ADDRESS_OFFICEADDR	VARCHAR(100),					/*회사주소*/
	ADDRESS_BIRTH		VARCHAR(100),					/*생일*/
	ADDRESS_ISSOLAR		CHAR(1),					/*양력:S 음력:L*/
	ADDRESS_HOMEURL		VARCHAR(200),					/*홈페이지주소*/
	ADDRESS_STMT		TEXT,						/*설명*/
	INDEX ADDRESS_INDEX (USERS_IDX,ADDRESS_GROUP_IDX)
)type=InnoDB;

CREATE TABLE BBS_GROUP
(	BBS_GROUP_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*게시판 그룹인덱스(pk) (SEQ 1~4294967295)*/
	DOMAIN          	VARCHAR(100)	NOT NULL,			/*회원사 도메인 명 */
	BBS_GROUP_NAME		VARCHAR(100),					/*게시판 그룹명*/
	BBS_GROUP_LEVEL		INT						/*게시판 레벨*/
)type=InnoDB;

CREATE TABLE BBS
(	BBS_IDX			INT	unsigned NOT NULL auto_increment primary key,		/*게시판 인덱스(PK)(SEQ)*/
	DOMAIN         		VARCHAR(100)	NOT NULL,			  	/*회원사 도메인 명 */
  BBS_ADMIN		VARCHAR(200),  					   	/*게시판 관리자 IDX*/
	BBS_TYPE		TINYINT,						/*게시판 사용 타입	1:도메인 게시판 2:도메인그룹 게시판 3:인트라넷 게시판*/
	BBS_MODE		TINYINT,						/*게시판 종류	1:공지사항 2:게시판 3:자료실*/
	BBS_GROUP_IDX		INT,							/*게시판 그룹인덱스	게시판 그룹인덱스 (-1: 기본그룹, 도메인 그룹일경우:BBS_GROUP_IDX, 인트라넷 그룹일경우:ORGANIZE_IDX)*/
	BBS_NAME		VARCHAR(255),						/*게시판 제목*/
	BBS_USE_REPLY		TINYINT,						/*답변기능사용여부	0:사용안함 1: 사용함*/
	BBS_USE_ATTACHE		TINYINT,						/*파일업로드기능사용여부	0:사용안함 1: 사용함*/
	BBS_USE_APPEND		TINYINT,						/*간단한 답글기능 사용여부	0:사용안함 1: 사용함*/
	BBS_USE_ATTACHE_SIZE	TINYINT,						/*파일업로드 첨부용량	default :10MB*/
	BBS_AUTH_MEMBER		TINYINT,						/*회원(도메인회원 or 그룹 회원)사용권한	0:권한 없음 1: 읽기권한 2:쓰기권한*/
	BBS_AUTH_GUEST		TINYINT,						/*guest권한	0:권한 없음 1: 읽기권한 2:쓰기권한(인트라넷에서는 모든 비그룹 회원에게 적용)*/
	BBS_AUTH_HIGHER		TINYINT,						/*상위그룹 권한	0:권한 없음 1: 읽기권한 2:쓰기권한*/
	BBS_AUTH_LOWER		TINYINT,						/*하위그룹 권한	0:권한 없음 1: 읽기권한 2:쓰기권한*/
	BBS_AUTH_EQUALTY	TINYINT							/*동급그룹 권한	0:권한 없음 1: 읽기권한 2:쓰기권한*/
)type=InnoDB;

CREATE TABLE BBS_USERLOG
(	BBS_USERLOG_IDX		VARCHAR(200)	NOT NULL,				/*로그 인덱스(ID@DOMAIN_B_IDX)(인덱스 사용을 위해 고유키 생성)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,				/*개인고유키(ID@DOMAIN)*/
	BBS_USERLOG_DATE	VARCHAR(20),						        /*게시물 등록일자*/
	INDEX BBS_USERLOG_INDEX (USERS_IDX)
)type=InnoDB;

CREATE TABLE BBS_TOP
(    BBS_IDX  INT unsigned  NOT NULL,
     B_IDX    INT unsigned  NOT NULL,
     primary key BBS_TOP_PK (BBS_IDX,B_IDX)
)type=InnoDB;

CREATE TABLE SCHEDULE
(	SCHEDULE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*일정관리 인덱스(PK)*/
	USERS_IDX		VARCHAR(200)	 NOT NULL,			/*사용자키(PK)	개인고유키(ID@DOMAIN)*/
	USERS_NAME		VARCHAR(100)	 NOT NULL,			/*사용자이름*/
	DOMAIN          	VARCHAR(100)     NOT NULL,     			/*회원사 도메인 명 */
	ORGANIZE_IDX		INT,						/*조직도 그룹 인덱스*/        
	SCHEDULE_SHARE		TINYINT,					/*일정공유	0:개인1:그룹2:회사3:전체*/	
	SCHEDULE_TYPE		TINYINT,					/*일정타입	0:개인일정1:기념일2:업무3휴가4행사5출장6공지7국경일8기타*/
	SCHEDULE_TITLE		VARCHAR(200),					/*일정제목*/
	SCHEDULE_STMT		TEXT,						/*일정내용*/
	SCHEDULE_SDATE		DATETIME, 					/*일정 시작 일시*/
	SCHEDULE_EDATE		DATETIME,					/*일정 마감 일시*/
	SCHEDULE_REPEAT		TINYINT,					/*일정반복	0:반복안함1:일간반복2:주간반복3월간반복4:년간반복*/
	SCHEDULE_DAYLY		TINYINT,					/*하루종일 옵션 설정	DEFAULT:0 1:하루종일 2:하루이상 일정기간*/
	SCHEDULE_ALARM		TINYINT,					/*일정 알림 0:알리지 않음 1:시작시간 2:1시간전 3:1일전 4:2일전 5:3일전 6:1주일전*/
	SCHEDULE_ALARM_DATE	DATETIME,					/*일정알림 시간 	알림시간 default = NOW()*/
	SCHEDULE_ALARM_WAY	TINYINT,						/*일정알림방법	1:메일 2:SMS 3:메일+SMS*/
	SCHEDULE_DDAY     TINYINT NOT NULL DEFAULT '0',   /*D-DAY 0:사용안함 1:사용함*/
	INDEX SCHEDULE_USERS_IDX (USERS_IDX),
	INDEX SCHEDULE_ORGANIZE_IDX (ORGANIZE_IDX)
)type=InnoDB;

CREATE TABLE FILE_SHARE
(   	FILE_SHARE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*파일공유 인덱스(PK)*/
	USERS_IDX			VARCHAR(200),			/*사용자키*/
	FILE_SHARE_FOLDER		TEXT,			/*폴더 경로및 이름*/
	FILE_SHARE_AUTH			CHAR(1)				/*공유 권한 r:읽기 권한 w:쓰기권한*/
)type=InnoDB;

CREATE TABLE POLL
(	POLL_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*설문 인덱스(PK)(SEQ)*/
	USERS_IDX			VARCHAR(200)    NOT NULL,		 	/*설문작성자*/ 
	DOMAIN				VARCHAR(100)	NOT NULL, 			/*도메인*/ 
	POLL_CONTENT			TEXT,						/*설문내용*/
	POLL_SDATE			DATETIME,					/*설문 시작일*/
	POLL_EDATE			DATETIME,					/*설문 종료일*/
	POLL_PROGRESS			CHAR(1)						/*설문 진행 상태 P:진행 S:완료 R:대기*/
)type=InnoDB;

CREATE TABLE POLL_ITEM
(	POLL_IDX			INT,						/*설문 인덱스(PK)(SEQ)*/
	POLL_ITEM_NUM			TINYINT,					/*설문문항 번호*/
	POLL_ITEM_CONTENT		TEXT,						/*설문문항 내용*/
	POLL_ITEM_SUM			INT						/*설문문항 클릭 횟수*/
)type=InnoDB;

CREATE TABLE POLL_LIST
(	POLL_IDX			INT		NOT NULL,			/*설문 인덱스(PK)(SEQ)*/
	USERS_IDX			VARCHAR(100)	NOT NULL			/*사용자키(PK)	개인고유키(ID@DOMAIN)*/
)type=InnoDB;

CREATE TABLE MAIL_REPORT
( MAIL_REPORT_IDX		INT	unsigned NOT NULL auto_increment primary key,		/*불량메일신고 인덱스*/
	DOMAIN                  VARCHAR(100)	NOT NULL,      		/*회원사 도메인 명 */
	USERS_IDX		VARCHAR(200)	NOT NULL,		/*신고자 IDX*/
	USERS_NAME		VARCHAR(20),				/*신고자이름*/
	MAIL_REPORT_DATE	VARCHAR(20),				/*신고일자*/
	MAIL_REPORT_FROM	VARCHAR(200),				/*불량메일 발송자 이메일*/
	MAIL_REPORT_SENDDATE	VARCHAR(20),				/*메일발송일자*/
	MAIL_REPORT_STMT	TEXT,					/*메일신고내용*/
	MAIL_REPORT_STATE	TINYINT					/*처리상태 1:신규 2:처리중 3: 불량메일 4:불량도메인 5:중복 6:미등록*/ 
)type=InnoDB;

CREATE TABLE SYSTEM_INFO
(	SYSTEM_INFO_IDX		VARCHAR(100)	NOT NULL,	/*시스템 정보 키*/
  SYSTEM_INFO_VALUE	TEXT				/*시스템 정보 */
)type=InnoDB;

CREATE TABLE USER_GROUP
(      USER_GROUP_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*그룹 인덱스 SEQ(1~9999999999)(PK)*/
       DOMAIN      	VARCHAR(100)	NOT NULL,		/*도메인*/
       USER_GROUP_DEF	INT	NOT NULL,			/*상위 그룹 IDX*/
       USER_GROUP_REF	INT	NOT NULL,			/*최상위 그룹 IDX*/
       USER_GROUP_NAME	VARCHAR(255)	NOT NULL,		/*개인용량(단위:byte)*/
       USER_GROUP_DEFAULT	TINYINT,			/*가입시 기본 그룹 (0:DEFAULT 1:기본그룹)*/
       USER_GROUP_FUNCTION	VARCHAR(20),			/*모듈 사용권한	그룹별 메뉴사용여부(도메인별 메뉴사용여부(웹메일,POP3,일정관리,파일관리,전자결재,게시판,인트라넷,메신저,홈페이지,SMS default:1111111111)*/
       USER_GROUP_VOLUME	INT,				/*그룹별 사용자 기본 용량	그룹별 사용자 기본 용량 DEFAULT = 도메인 default 용량*/
       USER_GROUP_MAIL	TINYINT,				/*전체메일 발송 가능 여부 0:불가능 1:가능 DEFAULT:0*/
       USER_GROUP_SCHEDULE	TINYINT,			/*전체일정 등록 가능 여부 0:불가능 1:가능 DEFAULT:0*/
       USER_GROUP_ADDRESS	TINYINT,			/*공유주소록 사용 여부 0:불가능 1:가능 DEFAULT:0*/	
       USER_GROUP_STRUCTURE	TINYINT,			/*조직도 사용 여부 0:불가능 1:가능 DEFAULT:0*/	
       USER_GROUP_COMMUNITY	TINYINT,			/*동호회 개설 가능여부 0:불가능 1:가능 DEFAULT:0*/
       USER_GROUP_SMS_QUOTA     INT	                       /*SMS 월별사용건수*/
)type=InnoDB;

CREATE TABLE USER_GROUP_LIST
(      USER_GROUP_LIST_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*그룹 인덱스 SEQ(1~9999999999)(PK)*/
       DOMAIN      	VARCHAR(100)	NOT NULL,		/*도메인*/
       USERS_IDX      	VARCHAR(255)	NOT NULL,		/*개인고유키(ID@DOMAIN)*/
       USER_GROUP_IDX   INT	NOT NULL,		/*그룹 IDX*/
       INDEX USER_GROUP_LIST_INDEX_USERS_IDX (USERS_IDX),
       INDEX USER_GROUP_LIST_INDEX_USER_GROUP_IDX (USER_GROUP_IDX)
)type=InnoDB;

CREATE TABLE SMS
(
  SERIALNO 		INT(10) 	unsigned NOT NULL auto_increment,
  DESTCALLNO 		VARCHAR(8) 	default NULL,
  CALLBACKNO 		VARCHAR(8) 	default NULL,
  DATA 			VARCHAR(100) 	default NULL,
  JEOBSU_TIME 		DATETIME	default NULL,
  YEYAK_TIME 		DATETIME	default NULL,
  USER_NO 		VARCHAR(100) 	default NULL,
  RESULT 		VARCHAR(100) 	default NULL,
  TYPE 			VARCHAR(5) 	default NULL,
  COMPANY_NO 		VARCHAR(100) 	default NULL,
  PRIMARY KEY  (SERIALNO)
) TYPE=InnoDB;

CREATE TABLE SMS_REQUEST
(      SMS_REQUEST_IDX               INT	unsigned NOT NULL auto_increment primary key,      /*SMS전송요청 인덱스(PK)*/
       USERS_IDX                     VARCHAR(255) NOT NULL,   /*사용자키(PK) 개인고유키(ID@DOMAIN)*/
       SMS_REQUEST_DATE              DATETIME NOT NULL,            /*전송요청시간*/
       SMS_REQUEST_SEND_DATE         DATETIME NOT NULL,            /*전송시간*/
       SMS_REQUEST_TYPE              CHAR(1) NOT NULL,         	   /*유형(0-즉시, 1-예약)*/
       SMS_REQUEST_SEND_HP           VARCHAR(20) NOT NULL,    	   /*송신자휴대폰번호*/
       SMS_REQUEST_RECEIVE_HP        VARCHAR(20) NOT NULL,        /*수신자휴대폰번호*/
       SMS_REQUEST_MESSAGE           TEXT NOT NULL 		  /*전송 메세지*/
)type=InnoDB;

CREATE TABLE SMS_RESULT
(      SMS_RESULT_IDX               INT NOT NULL,      /*SMS전송결과 인덱스(PK)*/
       USERS_IDX                    VARCHAR(255) NOT NULL,   /*사용자키(PK) 개인고유키(ID@DOMAIN)*/
       SMS_RESULT_DATE              DATETIME NOT NULL,            /*전송요청시간*/
       SMS_RESULT_SEND_DATE         DATETIME NOT NULL,            /*전송시간*/
       SMS_RESULT_TYPE              CHAR(1) NOT NULL,         /*유형(0-즉시, 1-예약)*/
       SMS_RESULT_SEND_HP           VARCHAR(20) NOT NULL,    /*송신자휴대폰번호*/
       SMS_RESULT_RECEIVE_HP        VARCHAR(20) NOT NULL,    /*수신자휴대폰번호*/
       SMS_RESULT_MESSAGE           TEXT NOT NULL,  /*전송 메세지*/
       SMS_RESULT_SEND_COUNT        INT NOT NULL,       /*분할전송 횟수*/
       SMS_RESULT_CODE              CHAR(1) NOT NULL          /*전송결과코드(0-대기, 1-전송요청, 2-전송완료, 3-실패)*/
)type=InnoDB;

CREATE TABLE SMS_RESULT_SYSTEM
(      SMS_RESULT_SYSTEM_IDX             INT NOT NULL,     /*통계용SMS전송결과 인덱스(PK)*/
       USERS_IDX                         VARCHAR(255) NOT NULL,  /*사용자키(PK) 개인고유키(ID@DOMAIN)*/
       SMS_RESULT_SYSTEM_SEND_DATE       DATETIME NOT NULL,           /*전송시간*/
       SMS_RESULT_SYSTEM_TYPE            CHAR(1) NOT NULL,        /*유형(0-즉시, 1-예약)*/
       SMS_RESULT_SYSTEM_SEND_COUNT      INT NOT NULL,      /*분할전송 횟수*/
       SMS_RESULT_SYSTEM_CODE            CHAR(1) NOT NULL         /*전송결과코드(2-전송완료, 3-실패)*/
)type=InnoDB;

CREATE TABLE MAIL_LOG
(      MAIL_LOG_DATE        DATETIME NOT NULL,			/*로그기록시간(단위:시간)(PK)*/
       MAIL_LOG_DOMAIN      VARCHAR(100) NOT NULL,		/*도메인*/
       MAIL_LOG_RECEIVE_COUNT INT NULL,			/*받은 메일 개수*/
       MAIL_LOG_SEND_COUNT  INT NULL,			/*보낸 메일 개수*/
       MAIL_LOG_RECEIVE_VOLUME INT NULL,			/*받은 메일 용량(단위:byte)*/
       MAIL_LOG_SEND_VOLUME INT NULL,			/*보낸 메일 용량(단위:byte)*/
       MAIL_LOG_ERROR_COUNT INT NULL			/*에러 메일 개수*/
)type=InnoDB;

CREATE TABLE MAIL_RECONF
(      MAIL_RECONF_IDX		INT	unsigned NOT NULL auto_increment primary key,	/* 인덱스 SEQ(1~9999999999)(PK)*/
       MAIL_RECONF_GROUP	DOUBLE	 NOT NULL,	/* GROUP*/
       USERS_IDX      		VARCHAR(200)	NOT NULL,		/*개인고유키(ID@DOMAIN)*/
       MAIL_RECONF_TO		VARCHAR(200)	NOT NULL,		/*받는 사람 이메일*/
       MAIL_RECONF_SUBJECT	VARCHAR(255),				/*제목*/
       MAIL_RECONF_STATE	TINYINT,				/*상태 default 0:읽지않음 1:읽음 2:예약발송 3: 발송실패 4:발송취소*/ 	
       MAIL_RECONF_SDATE	VARCHAR(20),   				/*메일 발송 일시*/
       MAIL_RECONF_RDATE	VARCHAR(20),    			/*메일 읽은 시간 DEFAULT = NULL*/
       MAIL_RECONF_MESSAGE_ID VARCHAR(255),				/*K-Message-ID 헤더 정보 저장*/
       MAIL_RECONF_M_IDX      INT,         /*보낸 편지함의 메일 IDX*/
       INDEX MAIL_RECONF_INDEX (USERS_IDX),
       INDEX INDEX_MAIL_RECONF_M_IDX (MAIL_RECONF_M_IDX),
       INDEX INDEX_MAIL_RECONF_MESSAGE_IDX (MAIL_RECONF_MESSAGE_ID)
)type=InnoDB;

CREATE TABLE PUBLICGROUP
(  	  PUBLICGROUP_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*그룹 인덱스 SEQ(1~9999999999)(PK)*/
    	PUBLICGROUP_DEF		INT	NOT NULL,					/*부모그룹 인덱스(0 : 최상위 그룹)*/			
    	DOMAIN			VARCHAR(100)	NOT NULL,	/*도메인*/
    	PUBLICGROUP_NAME	VARCHAR(255)	NOT NULL,	/*그룹 명*/
    	INDEX PUBLICGROUP_INDEX (PUBLICGROUP_DEF)
)type=InnoDB;

CREATE TABLE PUBLICADDRESS
(   	PUBLICADDRESS_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*공유주소록 인덱스(PK)*/
    	PUBLICGROUP_IDX		INT	NOT NULL,	/*공유주소록그룹인덱스(FK)*/
      DOMAIN			VARCHAR(100)	NOT NULL,	/*도메인*/ 
    	PUBLICADDRESS_NAME	VARCHAR(100),			/*이름*/
    	PUBLICADDRESS_DEPT	VARCHAR(100),			/*부서*/
    	PUBLICADDRESS_DUTY	VARCHAR(100),			/*직책*/
    	PUBLICADDRESS_EMAIL	VARCHAR(200),			/*이메일*/
    	PUBLICADDRESS_TEL	VARCHAR(100),			/*집전화 번호*/
    	PUBLICADDRESS_CELLTEL	VARCHAR(100),			/*휴대폰번호*/
    	PUBLICADDRESS_HOMEZIP	VARCHAR(100),			/*우편번호*/
    	PUBLICADDRESS_HOMEADDR	VARCHAR(100),			/*주소*/
    	INDEX PUBLICADDRESS_INDEX (PUBLICGROUP_IDX)
)type=InnoDB;

CREATE TABLE HBBS 
(         BBS_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*게시판 인덱스(PK)(SEQ)*/
          DOMAIN         		VARCHAR(100)	NOT NULL, 			  	/*회원사 도메인 명 */
          USERS_IDX		VARCHAR(200),   					   	/*게시판 관리자 IDX*/
          BBS_NAME		VARCHAR(255), 						/*게시판 제목*/
          BBS_USE_REPLY		TINYINT, 						/*답변기능사용여부	0:사용안함 1: 사용함*/
          BBS_USE_ATTACHE		TINYINT, 						/*파일업로드기능사용여부	0:사용안함 1: 사용함*/
          BBS_USE_APPEND		TINYINT,  						/*간단한 답글기능 사용여부	0:사용안함 1: 사용함*/
          USE_ATTACHE_SIZE	TINYINT, 							/*파일업로드 첨부용량	default :10MB*/
          BBS_AUTH		TINYINT,							/*사용권한	0:권한 없음 1: 읽기권한 2:쓰기권한*/
          BBS_LISTNUM	MEDIUMINT,						/*게시판 글리스트 개수*/
          INDEX HBBS_INDEX (USERS_IDX)
)type=InnoDB;

CREATE TABLE ECARD
(    ECARD_IDX INT  unsigned NOT NULL auto_increment primary key,
     ECARD_THEME   VARCHAR(200)  NOT NULL,  /*카드 테마*/
     ECARD_TITLE   VARCHAR(200),             /*카드 제목*/
     ECARD_DATE    DATETIME,                 /*카드 등록일시*/
     ECARD_SENDNUM INT      			           /*발송횟수*/
)type=InnoDB;

CREATE TABLE PASSWD_HINT( 
     USERS_IDX	VARCHAR(200) NOT NULL primary key,      /*사용자 IDX*/
     PASSWD_HINT_QUESTION	INT NOT NULL,  /*비밀번호 질문*/
     PASSWD_HINT_ANSWER		VARCHAR(200) NOT NULL  /*비밀번호 답*/
)type=InnoDB;

CREATE TABLE ACCOUNT
(    ACCOUNT_IDX    VARCHAR(200)  NOT NULL primary key,	/*멀티계정*/
     USERS_IDX      VARCHAR(200)  NOT NULL ,
     DOMAIN         VARCHAR(100)   NOT NULL, 	/*회원사 도메인 명 */
     MBOX_IDX       INT unsigned  NOT NULL  DEFAULT '0',	/*메일이 저장될 MBOX 인덱스키 DEFAULT '0' 0:일 경우 받은 편지함 */
     ACCOUNT_ISVALID  TINYINT   NOT NULL  DEFAULT '0', 	/*사용여부  NOT NULL DEFAULT '0' 0:사용안함 1:사용함*/
     ACCOUNT_ISDATED  TINYINT   NOT NULL  DEFAULT '0', 	/*날짜 적용여부  NOT NULL DEFAULT '0' 0:사용안함 1:사용함*/
     ACCOUNT_SDATE  DATETIME, 			/*사용시작일시*/
     ACCOUNT_EDATE  DATETIME,  			/*사용종료일시*/
     INDEX INDEX_ACCOUNT_USERS_IDX (USERS_IDX),
     INDEX INDEX_ACCOUNT_DOMAIN (DOMAIN),
     FOREIGN KEY(USERS_IDX) REFERENCES USERS(USERS_IDX) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY(DOMAIN) REFERENCES DOMAIN(DOMAIN) ON DELETE CASCADE ON UPDATE CASCADE
)type=InnoDB;


ALTER TABLE DOMAIN TYPE=InnoDB;


--#####################################여기부터 CLUB
--동회회 분류 정보
CREATE TABLE CLUB_GROUP_MASTER
(
    group_idx INT UNSIGNED NOT NULL AUTO_INCREMENT,    
    group_name VARCHAR(100),
    ref_idx INT UNSIGNED,
    depth int unsigned,
    domain varchar(100),    
    PRIMARY KEY CLUB_GROUP_MASTER_PK (group_idx,domain),
    INDEX CLUB_GROUP_MASTER_IX1 (group_idx, ref_idx),
    INDEX CLUB_GROUP_MASTER_IX2 (ref_idx),    
    INDEX CLUB_GROUP_MASTER_IX4 (group_idx),
    INDEX CLUB_GROUP_MASTER_IX3 (domain),
    FOREIGN KEY CLUB_GROUP_MASTER_FK1 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE ON UPDATE CASCADE
) TYPE=INNODB;

CREATE TABLE CLUB_INFO
(    
    club_idx INT UNSIGNED NOT NULL AUTO_INCREMENT,
    group_idx INT UNSIGNED NOT NULL, 
    domain varchar(100),
    club_name VARCHAR(100),
    check_yn CHAR(1), 
    auto_join_yn char(1),       
    join_auth char(1),
    limit_cap INT UNSIGNED,    
    club_explain varchar(255),
    key1 varchar(50),
    key2 varchar(50),
    key3 varchar(50),    
    url varchar(80),
    title_img varchar(50),
    info_img varchar(50),
    info_bgimg varchar(50),    
    notice_img varchar(50),    
    recent_img varchar(50),    
    reg_dt DATETIME,
    ack_dt DATETIME,
    primary key CLUB_INFO_PK (club_idx),
    INDEX CLUB_INFO_IX1 (group_idx),    
    INDEX CLUB_INFO_IX2 (domain),
    FOREIGN KEY CLUB_INFO_FK1 (group_idx) REFERENCES CLUB_GROUP_MASTER(group_idx) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY CLUB_INFO_FK2 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE ON UPDATE CASCADE
) TYPE=INNODB;

CREATE TABLE CLUB_PRIDE
(
    seq_no INT UNSIGNED NOT NULL AUTO_INCREMENT,    
    users_idx varchar(100),
    title VARCHAR(255),
    content TEXT,   
    reg_dt DATETIME,
    club_idx INT UNSIGNED NOT NULL, 
    domain varchar(100) not null,
    primary key CLUB_PRIDE_PK (seq_no),    
    INDEX CLUB_PRIDE_IX1 (club_idx),
    INDEX CLUB_PRIDE_IX2 (domain),
    FOREIGN KEY CLUB_PRIDE_FK1 (club_idx) REFERENCES CLUB_INFO(club_idx) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY CLUB_PRIDE_FK2 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE ON UPDATE CASCADE
) TYPE=INNODB;

CREATE TABLE CLUB_USER
(    
    club_idx INT UNSIGNED NOT NULL,    
    users_idx varchar(100) NOT NULL,
    auth char(1),
    reg_dt DATETIME,
    primary key CLUB_USER_PK (users_idx, club_idx),        
    INDEX CLUB_USER_IX1 (club_idx),
    FOREIGN KEY CLUB_USER_FK1 (club_idx) REFERENCES CLUB_INFO(club_idx) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX CLUB_USER_IX2 (users_idx),
    FOREIGN KEY CLUB_USER_FK2 (users_idx) REFERENCES USERS(users_idx) ON DELETE CASCADE ON UPDATE CASCADE
) TYPE=INNODB;

--게시판기본정보
CREATE TABLE CLUB_BBS_MASTER
(
    bbs_idx INT UNSIGNED NOT NULL AUTO_INCREMENT,    
    club_idx INT UNSIGNED NOT NULL,    
    bbs_mode CHAR(2), 
    bbs_name VARCHAR(100),
    write_auth CHAR(1), 
    read_auth CHAR(1), 
    info_yn CHAR(1),
    multi_re_yn CHAR(1),
    simple_re_yn CHAR(1),
    attach_yn CHAR(1),
    bbs_explain VARCHAR(255),
    primary key CLUB_BBS_MASTER_PK (bbs_idx),    
    INDEX CLUB_BBS_MASTER_IX1 (club_idx),
    FOREIGN KEY CLUB_BBS_MASTER_FK1 (club_idx) REFERENCES CLUB_INFO(club_idx) ON DELETE CASCADE    ON UPDATE CASCADE
) TYPE=INNODB;


--게시판 실체 정보
CREATE TABLE CLUB_BBS
(
    seq_no INT UNSIGNED NOT NULL,            
    bbs_idx INT UNSIGNED NOT NULL,       
    ref_seq_no INT UNSIGNED NOT NULL, 
    re_depth VARCHAR(50),
    users_idx VARCHAR(100),
    title VARCHAR(255),
    content TEXT,
    hit_cnt SMALLINT UNSIGNED,
    rcmd_cnt SMALLINT UNSIGNED,
    pwd VARCHAR(50),
    server_file VARCHAR(50),
    client_file VARCHAR(50),
    file_size SMALLINT UNSIGNED,
    vw_yn CHAR(1),
    reg_dt DATETIME,
    primary key CLUB_BBS_PK (seq_no,bbs_idx),
    INDEX CLUB_BBS_IX1 (seq_no),
    INDEX CLUB_BBS_IX2  (ref_seq_no),
    INDEX CLUB_BBS_IX3 (seq_no, ref_seq_no),
    INDEX CLUB_BBS_IX4 (bbs_idx),
    FOREIGN KEY CLUB_BBS_FK1 (bbs_idx) REFERENCES CLUB_BBS_MASTER(bbs_idx) ON DELETE CASCADE ON UPDATE CASCADE   
) TYPE=INNODB;

--한줄 답변
CREATE TABLE CLUB_SIMPLE_REPLY
(
    seq_no INT UNSIGNED NOT NULL AUTO_INCREMENT,
    bbs_seq_no INT UNSIGNED NOT NULL,
    bbs_idx INT UNSIGNED NOT NULL,      
    users_idx VARCHAR(100),
    content VARCHAR(255),   
    reg_dt DATETIME,
    primary key CLUB_SIMPLE_REPLY_PK (seq_no),    
    INDEX CLUB_SIMPLE_REPLY_IX1 (bbs_seq_no, bbs_idx),
    FOREIGN KEY CLUB_SIMPLE_REPLY_FK1 (bbs_seq_no, bbs_idx) REFERENCES CLUB_BBS(seq_no, bbs_idx) ON DELETE CASCADE   ON UPDATE CASCADE
) TYPE=INNODB;


CREATE TABLE CLUB_CONF
(
    domain VARCHAR(100) not null,
    photo_image VARCHAR(50),
    root_dir varchar(50),
    site_image VARCHAR(50), 
    attachdir  VARCHAR(50),
    rownum  INT UNSIGNED,
    bbs_size INT UNSIGNED,    
    attachsize  INT UNSIGNED,
    autocommit  VARCHAR(50),
    photo_rownum INT UNSIGNED,
    blocknum  INT UNSIGNED,
    middlecategory  INT UNSIGNED,
    title_img varchar(50),
    info_img varchar(50),
    info_bgimg varchar(50),
    notice_img varchar(50),
    recent_img varchar(50),  
    last_modified  varchar(20),  
    INDEX CLUB_CONF_IX1 (domain),
    FOREIGN KEY CLUB_CONF_FK1 (domain) REFERENCES DOMAIN(domain) on DELETE CASCADE ON UPDATE CASCADE
) TYPE=INNODB;


--#####################################여기까지 CLUB


--#####################################여기부터 SMS
#drop table SMS_EMOTICON;
#drop table SMS_EMOTI_FLAG;


CREATE TABLE SMS_EMOTI_FLAG
(flag_no INT UNSIGNED not null AUTO_INCREMENT,
flag varchar(100),
primary key sms_emoti_flag_pk (flag_no)
) TYPE=INNODB;

CREATE TABLE SMS_EMOTICON
(seq_no INT UNSIGNED not null AUTO_INCREMENT,
title varchar(50),
content text,
reg_dt varchar(8),
flag_no INT UNSIGNED not null,
cnt SMALLINT UNSIGNED  default 0,
primary key sms_emoti_flag_pk (seq_no),
INDEX SMS_EMOTICON_IX1 (flag_no),
FOREIGN KEY sms_emoticon_fk1 (flag_no) REFERENCES SMS_EMOTI_FLAG(flag_no) on DELETE CASCADE ON UPDATE CASCADE
) TYPE=INNODB;


LOAD DATA INFILE '/usr/local/kebi/jakarta-tomcat/webapps/nara/properties/database/mysql/sms_emoti_flag.txt' INTO TABLE SMS_EMOTI_FLAG;
LOAD DATA INFILE '/usr/local/kebi/jakarta-tomcat/webapps/nara/properties/database/mysql/sms_emoticon.txt' INTO TABLE SMS_EMOTICON;
LOAD DATA INFILE '/usr/local/kebi/jakarta-tomcat/webapps/nara/properties/database/mysql/zipcode.txt' INTO TABLE ZIPCODE;
LOAD DATA INFILE '/usr/local/kebi/jakarta-tomcat/webapps/nara/properties/database/mysql/ecard.txt' INTO TABLE ECARD;

--#####################################여기까지 SMS

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J100','컴퓨터/인터넷');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J101','금융/증권');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J102','서비스/유통');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J103','건축/제조업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J104','언론');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J105','전문직일반');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J106','의료');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J107','법률');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J108','문화/예술');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J109','교육');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J110','공무원');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J111','군인/경찰');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J112','농/수/축산업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J113','가사/주부');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J114','초등학생');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J115','중학생');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J116','고등학생');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J117','대학/대학원생');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J118','자영업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J119','무직');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J120','기타');

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S100','초등학교 재학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S101','초등학교 졸업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S102','중학교 재학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S103','중학교 졸업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S104','고등학교 재학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S105','고등학교 졸업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S106','대학교 재학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S107','대학교 졸업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S108','대학원 재학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S109','대학원 졸업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S199','기타');

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I100','영화/비디오');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I101','음악');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I102','게임/만화');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I103','컴퓨터/인터넷');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I104','자격증/취업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I105','패선/미용');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I106','쇼핑/경매');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I107','문화/예술/문학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I108','연예/오락');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I109','스포츠/레져');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I110','증권/금융');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I111','부동산');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I112','여행');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I113','요리/육아/가정');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I114','자동차/드라이브');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I115','건축/인테리어');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I116','건강/의학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I117','뉴스/미디어');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I199','기타');

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C100','인터넷서비스');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C101','금융');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C102','전자/정보통신');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C103','무역/유통/물류');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C104','건설/인테리어');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C105','기계/금속광물');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C106','농/수/축/임업');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C107','의료/건강');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C108','석유/화학');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C109','섬유/패션');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C110','음식료');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C111','출판/음반/방송');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C112','여행/레져/자동차');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C113','용역');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C114','광고/이벤트');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C115','교육기관');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C116','기타기관');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C117','단체');

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'신정','','2002-1-1 0:0:0',
'2002-1-1 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'삼일절','','2002-3-1 0:0:0',
'2002-3-1 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'식목일','','2002-4-5 0:0:0',
'2002-4-5 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'어린이날','','2002-5-5 0:0:0',
'2002-5-5 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,9,'어버이날','','2002-5-8 0:0:0',
'2002-5-8 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,9,'스승의날','','2002-5-15 0:0:0',
'2002-5-15 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'현충일','','2002-6-6 0:0:0',
'2002-6-6 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'제헌절','','2002-7-17 0:0:0',
'2002-7-17 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'광복절','','2002-8-15 0:0:0',
'2002-8-15 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,9,'국군의날','','2002-10-1 0:0:0',
'2002-10-1 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'개천절','','2002-10-3 0:0:0',
'2002-10-3 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,9,'한글날','','2002-10-9 0:0:0',
'2002-10-9 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','관리자','tft.kebi.com',3,7,'성탄절','','2002-12-25 0:0:0',
'2002-8-15 23:59:59',4,1,0,NOW(),0);

INSERT INTO SYSTEM_INFO(SYSTEM_INFO_IDX,SYSTEM_INFO_VALUE) VALUES('SYSTEM_USE_AGREEMENT','N');
INSERT INTO SYSTEM_INFO(SYSTEM_INFO_IDX,SYSTEM_INFO_VALUE) VALUES('SYSTEM_AGREEMENT_STMT','');

INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'광고');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'광?고');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'성인');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'성?인');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'홍보');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'무제');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'비아그라');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'변강쇠');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'포르노');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'섹스');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'누드');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'몰카');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'성행위');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'러브호텔');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'사춘기*소녀');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'해외사이트');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'노모자이크');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'따먹기');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'동영상');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'인터넷방송');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'포루노');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'흥분');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'딸딸이');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'팬티');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'몰래');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'자위');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'거시기');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'홍등가');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'화질짱');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'원조교제');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'고화질');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'미성년자');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'무삭제');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'뽀르노');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'에로틱');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'생쇼');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'쌩쑈');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'흥분제');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'맛사지');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'패니스');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'오르가즘');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'보지');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'조루');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'빠구리');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'야애니');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'항문');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'스와핑');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'19세*이상');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'성기');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'고스톱');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'세일');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'카지노');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'무료');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'공짜');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'발신전용');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'연체금');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'카드대금');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'카드대납');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'장기상환');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'장기분할');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'대출');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'금융');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'무료신비체험');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'penis');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'viagra');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'fuck');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'sale');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'Re:Details');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'Approved');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'Resume');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'hottest');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'[ad]');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'erotic');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'sex');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'zazi');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'Erosbada');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'porn');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'NUDE');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'nude');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#44305;&#44256;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49457;&#51064;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54861;&#48372;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#51088;&#51648;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48372;&#51648;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47924;&#51228;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48708;&#50500;&#44536;&#46972;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48320;&#44053;&#49632;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54252;&#47476;&#45432;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49465;&#49828;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#45572;&#46300;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47792;&#52852;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49457;&#54665;&#50948;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47084;&#48652;&#54840;&#53588;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49324;&#52632;&#44592;&#49548;&#45376;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54644;&#50808;&#49324;&#51060;&#53944;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#45432;&#47784;&#51088;&#51060;&#53356;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#46384;&#47673;&#44592;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#46041;&#50689;&#49345;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#51064;&#53552;&#45367;&#48169;&#49569;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54252;&#47336;&#45432;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#55141;&#48516;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#46392;&#46392;&#51060;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54060;&#54000;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47792;&#47000;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#51088;&#50948;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#44144;&#49884;&#44592;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54861;&#46321;&#44032;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54868;&#51656;&#51697;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#50896;&#51312;&#44368;&#51228;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#44256;&#54868;&#51656;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48120;&#49457;&#45380;&#51088;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47924;&#49325;&#51228;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48960;&#47476;&#45432;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#50640;&#47196;&#54001;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49373;&#49660;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49961;&#50248;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#55141;&#48516;&#51228;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47579;&#49324;&#51648;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54056;&#45768;&#49828;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#50724;&#47476;&#44032;&#51608;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48372;&#51648;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#51312;&#47336;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48736;&#44396;&#47532;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#50556;&#50528;&#45768;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#54637;&#47928;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49828;&#50752;&#54609;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'19&#49464;&#51060;&#49345;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49457;&#44592;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#44256;&#49828;&#53681;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#49464;&#51068;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#52852;&#51648;&#45432;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47924;&#47308;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#44277;&#51676;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#48156;&#49888;&#51204;&#50857;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#50672;&#52404;&#44552;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#52852;&#46300;&#45824;&#44552;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#52852;&#46300;&#45824;&#45225;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#51109;&#44592;&#49345;&#54872;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#51109;&#44592;&#48516;&#54624;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#45824;&#52636;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#44552;&#50997;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'&#47924;&#47308;&#49888;&#48708;&#52404;&#54744;');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'www.xxxxx.ca');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'dayvod.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'sseng10tv.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'k-pussy.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'qoo.2u.com.tw');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'mini-booksmail');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'yadvd.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'892king.org');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'ddari.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'qweer.ne.kg');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'xxxtv.tv');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'ohmyx.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'ok-girl.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'verotel.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'xxxdol.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'bojalivetv.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'pagury.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'ssanbozi.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'love.pchome.com.tw');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'deepclub.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'www.notwehr.co.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'notwehr.co.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'nembi.tv');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'nicegood.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'hibozi.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'kavmodel.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'capyasisi.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'sexoio.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'billmon.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'xxmolca.co.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'discreetvaluepills.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'xjopd.ce.ro');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'bestprices4soft.biz');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'chinacoly.com.ne.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'nosnap.ce.ro');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'realityofdating.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'cam-nara.ce.ro');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'japanjubu.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'members.lycos.co.uk');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'t988.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'mpo.co.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'mindao.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'najer.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'gulemana.jp');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'108girl.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'okbody.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'zozic.nm.ru');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'blasterz.biz');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'manurabog.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'69cc.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'pjseries.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'geocities.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'erosdaum.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'nicevetcom.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'Bill.loozksd.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'cialagenius.biz');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'boa69.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'aas2a.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'livejapantv.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'uszazi.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'sssa.co.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'yabamtv.net');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'namsan.lib.seoul.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'blueweb.co.kr');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'live10x.com');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,2,'69showgirl.com');


CREATE TABLE FORMLETTER
(    FORMLETTER_IDX   INT  unsigned NOT NULL auto_increment primary key,
     DOMAIN                     VARCHAR(100)   NOT NULL,
     FORMLETTER_TYPE            INT,
     FORMLETTER_SUBJECT         VARCHAR(200),
     CONTENT               TEXT
)type=InnoDB;


CREATE TABLE ANACONDA_FILE
(
  FILE_KEY 			INT(10) 		UNSIGNED NOT NULL AUTO_INCREMENT,
  FILE_SEQ 			INT(10) 		NOT NULL DEFAULT '0',
  USERS_IDX 		VARCHAR(200) 	NOT NULL DEFAULT '',
  MAIL_SEQ 			VARCHAR(200),
  FILE_NAME 		VARCHAR(255) ,
  FILE_SUCCESS 		CHAR(3) ,
  FILE_DIR 			CHAR(1) ,
  FILE_SIZE 		INT(15) ,
  DOWN_CNT 			INT(10) 	DEFAULT 0,
  DOWN_CNT_PERMIT	INT(10) 	DEFAULT 0,
  FILE_EXPIRE 		VARCHAR(8) ,
  FILE_CREATE 		VARCHAR(8) ,
  FILE_DEL 			CHAR(1) ,
  FILE_CNT 			INT(5) DEFAULT '0',
  MAIL_YN 			CHAR(1) ,
  SHARE_YN 			CHAR(1) ,
  FILE_CLIENT_DATE 	VARCHAR(12) ,
  FILE_ATTRIBUTE    VARCHAR(10),
 PRIMARY KEY  (FILE_KEY),
 KEY INDEX_ANA_FILE_NAME (FILE_NAME)
);


CREATE TABLE ANACONDA_FILE_DEL
(
  FILE_KEY 			INT(10) 		UNSIGNED NOT NULL ,
  FILE_SEQ 			INT(10) 		NOT NULL DEFAULT '0',
  USERS_IDX 		VARCHAR(200) 	NOT NULL DEFAULT '',
  MAIL_SEQ 			VARCHAR(128) ,
  FILE_NAME 		VARCHAR(255) ,
  FILE_SUCCESS 		CHAR(3) ,
  FILE_DIR 			CHAR(1) ,
  FILE_SIZE 		INT(15) ,
  DOWN_CNT 			INT(10) DEFAULT 0,
  DOWN_CNT_PERMIT	INT(10) DEFAULT 0,
  FILE_EXPIRE 		VARCHAR(8) ,
  FILE_CREATE 		VARCHAR(8) ,
  FILE_DEL 			CHAR(1) ,
  FILE_CNT 			INT(5) 	DEFAULT '0',
  MAIL_YN 			CHAR(1) ,
  SHARE_YN 			CHAR(1) ,
  FILE_CLIENT_DATE 	VARCHAR(12),
  FILE_ATTRIBUTE    VARCHAR(10) 
);


CREATE TABLE ANACONDA_USERS
(
  USERS_IDX        VARCHAR(200)      NOT NULL,
  USERS_PERMIT     CHAR(1)           NOT NULL,
  FILE_HOMEDIR     VARCHAR(255)		 NOT NULL,	
  PERIOD_LIMIT_YN  CHAR(1),
  DOWN_LIMIT_YN    CHAR(1),
  DOWN_CNT         INT(10),
  USERS_MAXQUOTA   BIGINT(15),
  USERS_PERIOD     INT(10),
  EXPIRE_DEL_YN    CHAR(1),
  FILE_WRITE_MODE  CHAR(1)			default '0',
  FILE_USE_MODE    CHAR(1)			default '0',
  PRIMARY KEY  (USERS_IDX)
);


CREATE TABLE ANACONDA_MAIL
(
  MAIL_KEY     INT(10)            UNSIGNED NOT NULL  AUTO_INCREMENT,
  MAIL_SEQ     VARCHAR(128)       NOT NULL,
  USERS_IDX    VARCHAR(200)       NOT NULL,
  M_SENDER     VARCHAR(100),
  M_TO         TEXT,
  M_CC         TEXT,
  M_BCC        TEXT,
  MAIL_EXPIRE  VARCHAR(8),
  MAIL_CREATE  VARCHAR(8),
  PRIMARY KEY  (MAIL_KEY)
);

CREATE TABLE ANACONDA_USERGROUP
(
  USER_GROUP_IDX      INT(9)         UNSIGNED  NOT NULL,
  SERVICE_YN          CHAR(1),
  PERIOD_LIMIT_YN     CHAR(1),
  DOWN_LIMIT_YN       CHAR(1),
  DOWN_CNT            INT(10),
  USERGROUP_MAXQUOTA  INT(15),
  USERGROUP_PERIOD    INT(10),
  EXPIRE_DEL_YN       VARCHAR(1),
  APPLYALL_YN         VARCHAR(1),
  PRIMARY KEY  (USER_GROUP_IDX)
);


CREATE TABLE ANACONDA_SHARE (
       FILE_KEY             INT 			NOT NULL,
       USERS_IDX            VARCHAR(200) 	NOT NULL,
       DIR_PERMISSION       CHAR(1) 		NULL,
       CREATE_DATE          DATE 			NULL,
       UPDATE_DATE          DATE 			NULL,
       PRIMARY KEY (FILE_KEY) 
);




CREATE TABLE SHARE_GROUP
(      SHARE_GROUP_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*그룹 인덱스 SEQ(1~9999999999)(PK)*/
       DOMAIN      					VARCHAR(100)	NOT NULL,			/*도메인*/
       SHARE_GROUP_DEF			INT	NOT NULL,								/*상위 그룹 IDX*/
       SHARE_GROUP_REF			INT	NOT NULL,								/*최상위 그룹 IDX*/
       SHARE_GROUP_NAME			VARCHAR(255)	NOT NULL,			/*개인용량(단위:byte)*/
       SHARE_GROUP_DEFAULT	TINYINT,										/*가입시 기본 그룹 (0:DEFAULT 1:기본그룹)*/
       SHARE_GROUP_HOMEDIR	VARCHAR(255)	NOT NULL,			/* 공유폴더 디렉토리*/
       SHARE_GROUP_QUOTA 		BIGINT(20),									/* 공유폴더 사이즈*/
       SHARE_GROUP_STATUS 	CHAR(1)  DEFAULT 'S'										/* 공유그룹 상태 S:사용 N :미사용 */
)type=InnoDB;

CREATE TABLE SHARE_GROUP_LIST
(      SHARE_GROUP_LIST_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*그룹 인덱스 SEQ(1~9999999999)(PK)*/
       DOMAIN      	     VARCHAR(100)	NOT NULL,		/*도메인*/
       USERS_IDX      	 VARCHAR(255)	NOT NULL,		/*개인고유키(ID@DOMAIN)*/
       SHARE_GROUP_IDX   INT	NOT NULL,						/*그룹 IDX*/
       SHARE_STATUS   		 CHAR(1) DEFAULT 'S',									/* 공유그룹 상태 Y:사용 N :미사용 */
       SHARE_AUTH   		 VARCHAR(2)	NOT NULL DEFAULT '10',		/* 공유파일 권한 1:일기 2:쓰기 10:읽기/쓰기*/
       INDEX SHARE_GROUP_LIST_INDEX_USERS_IDX (USERS_IDX),
       INDEX SHARE_GROUP_LIST_INDEX_SHARE_GROUP_IDX (SHARE_GROUP_IDX)
)type=InnoDB;
