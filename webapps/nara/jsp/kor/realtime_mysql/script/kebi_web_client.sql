----------------------------------------------------------
-- Export file for user KEBIIM                          --
-- Created by Administrator on 2009-06-03, 오후 4:00:09 --
----------------------------------------------------------

spool kebi_new.log

prompt
prompt Creating table MSG_BANNER_INFO
prompt ==============================
prompt
create table KEBIIM.MSG_BANNER_INFO
(
  B_SEQ_NO       NUMBER not null,
  ORGN_FILE_NM   VARCHAR2(100) not null,
  SERV_FILE_NM   VARCHAR2(100) not null,
  SERV_FILE_PATH VARCHAR2(100) not null,
  FILE_SIZE      INTEGER,
  LINK_URL       VARCHAR2(100),
  REG_DT         VARCHAR2(8),
  BANNER_NM      VARCHAR2(50),
  B_USER_TYPE    CHAR(1)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_BANNER_INFO.B_SEQ_NO
  is '파일번호';
comment on column KEBIIM.MSG_BANNER_INFO.ORGN_FILE_NM
  is '파일명';
comment on column KEBIIM.MSG_BANNER_INFO.SERV_FILE_NM
  is '서버에저장된파일명';
comment on column KEBIIM.MSG_BANNER_INFO.SERV_FILE_PATH
  is '서버에저장된경로';
comment on column KEBIIM.MSG_BANNER_INFO.FILE_SIZE
  is '파일사이즈';
comment on column KEBIIM.MSG_BANNER_INFO.LINK_URL
  is '링크주소';
comment on column KEBIIM.MSG_BANNER_INFO.REG_DT
  is '등록일';
comment on column KEBIIM.MSG_BANNER_INFO.BANNER_NM
  is '배너이름';
comment on column KEBIIM.MSG_BANNER_INFO.B_USER_TYPE
  is '배너타입(0-고객용, 1-직원용)';
alter table KEBIIM.MSG_BANNER_INFO
  add constraint MSG_BANNER_INFO primary key (B_SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_BATCH_ITEM
prompt =============================
prompt
create table KEBIIM.MSG_BATCH_ITEM
(
  ITEM_CD      VARCHAR2(20),
  ITEM_NM      VARCHAR2(20),
  ITEM_MASS    VARCHAR2(100),
  ITEM_MACHINE VARCHAR2(100),
  ITEM_TERM    VARCHAR2(100)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_BATCH_ITEM.ITEM_CD
  is '배치코드';
comment on column KEBIIM.MSG_BATCH_ITEM.ITEM_NM
  is '배치명';
comment on column KEBIIM.MSG_BATCH_ITEM.ITEM_MASS
  is '배치방법';
comment on column KEBIIM.MSG_BATCH_ITEM.ITEM_MACHINE
  is '배치실행서버';
comment on column KEBIIM.MSG_BATCH_ITEM.ITEM_TERM
  is '배치주기';

prompt
prompt Creating table MSG_BATCH_LOG
prompt ============================
prompt
create table KEBIIM.MSG_BATCH_LOG
(
  ITEM_CD       VARCHAR2(20),
  RESULT_CD     VARCHAR2(20),
  RESULT_DETAIL VARCHAR2(2000),
  START_TIME    DATE,
  END_TIME      DATE,
  SEQ_NO        NUMBER not null
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_BATCH_LOG
  add constraint PK_MSG_BATCH_LOG primary key (SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX_MSG_BATCH_LOG on KEBIIM.MSG_BATCH_LOG (START_TIME)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_BUDDY_GROUP
prompt ==============================
prompt
create table KEBIIM.MSG_BUDDY_GROUP
(
  GROUP_IDX  NUMBER not null,
  GROUP_NAME VARCHAR2(100) not null,
  ISEDITABLE CHAR(1) default 'Y' not null,
  ISDEFAULT  CHAR(1) default 'N' not null,
  USERS_ID   VARCHAR2(30) not null,
  DOMAIN     VARCHAR2(20) not null,
  ETC        VARCHAR2(100)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_BUDDY_GROUP.GROUP_IDX
  is '그룹번호';
comment on column KEBIIM.MSG_BUDDY_GROUP.GROUP_NAME
  is '그룹명';
comment on column KEBIIM.MSG_BUDDY_GROUP.ISEDITABLE
  is '수정가능여부';
comment on column KEBIIM.MSG_BUDDY_GROUP.ISDEFAULT
  is '디폴트여부';
comment on column KEBIIM.MSG_BUDDY_GROUP.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_BUDDY_GROUP.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_BUDDY_GROUP.ETC
  is '기타';
alter table KEBIIM.MSG_BUDDY_GROUP
  add constraint PK_MSG_BUDDY_GROUP primary key (GROUP_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_BUDDY_GROUP on KEBIIM.MSG_BUDDY_GROUP (USERS_ID, DOMAIN)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_BUDDY_LIST
prompt =============================
prompt
create table KEBIIM.MSG_BUDDY_LIST
(
  BUDDY_IDX    NUMBER not null,
  GROUP_IDX    NUMBER not null,
  BUDDY_ID     VARCHAR2(30) not null,
  BUDDY_DOMAIN VARCHAR2(20) not null,
  OWNER_ID     VARCHAR2(30) not null,
  OWNER_DOMAIN VARCHAR2(20) not null,
  ISBLOCKED    CHAR(1) default 'N',
  BUDDYMEMO    VARCHAR2(1024),
  BUDDY_STATUS VARCHAR2(3)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_BUDDY_LIST.BUDDY_IDX
  is '버디번호';
comment on column KEBIIM.MSG_BUDDY_LIST.GROUP_IDX
  is '그룹번호';
comment on column KEBIIM.MSG_BUDDY_LIST.BUDDY_ID
  is '버디계정(사번)';
comment on column KEBIIM.MSG_BUDDY_LIST.BUDDY_DOMAIN
  is '버디도메인';
comment on column KEBIIM.MSG_BUDDY_LIST.OWNER_ID
  is '버디소유자계정';
comment on column KEBIIM.MSG_BUDDY_LIST.OWNER_DOMAIN
  is '버디소유자도메인';
comment on column KEBIIM.MSG_BUDDY_LIST.ISBLOCKED
  is '차단여부(Y:차단, N:정상)';
comment on column KEBIIM.MSG_BUDDY_LIST.BUDDYMEMO
  is '버디메모';
comment on column KEBIIM.MSG_BUDDY_LIST.BUDDY_STATUS
  is '버디상태(0:알수없음.1:승인신청발신, 2:승인신청수신, 3:승인 -1:거절, -2:거절및 차단  -3:삭제, -4:삭제및 차단 -5:차단)';
alter table KEBIIM.MSG_BUDDY_LIST
  add constraint PK_MSG_BUDDY_LIST primary key (BUDDY_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_BUDDY_LIST
  add constraint UK1_MSG_BUDDY_LIST unique (GROUP_IDX, BUDDY_ID, BUDDY_DOMAIN)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_BUDDY_LIST on KEBIIM.MSG_BUDDY_LIST (GROUP_IDX)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX2_MSG_BUDDY_LIST on KEBIIM.MSG_BUDDY_LIST (OWNER_ID, OWNER_DOMAIN)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX3_MSG_BUDDY_LIST on KEBIIM.MSG_BUDDY_LIST (BUDDY_ID, BUDDY_DOMAIN)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_BUDDY_LIST_DEL_BACK
prompt ======================================
prompt
create table KEBIIM.MSG_BUDDY_LIST_DEL_BACK
(
  BUDDY_IDX    NUMBER not null,
  GROUP_IDX    NUMBER not null,
  BUDDY_ID     VARCHAR2(30) not null,
  BUDDY_DOMAIN VARCHAR2(20) not null,
  OWNER_ID     VARCHAR2(30) not null,
  OWNER_DOMAIN VARCHAR2(20) not null,
  ISBLOCKED    CHAR(1),
  BUDDYMEMO    VARCHAR2(1024),
  BUDDY_STATUS VARCHAR2(3)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_BUDDY_REQ_MSG
prompt ================================
prompt
create table KEBIIM.MSG_BUDDY_REQ_MSG
(
  BUDDY_IDX  NUMBER not null,
  MSG        VARCHAR2(300),
  REQ_USR_NM VARCHAR2(30)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_BUDDY_REQ_MSG
  add constraint PK_MSG_BUDDY_REQ_MSG primary key (BUDDY_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_CHAT_CHNL
prompt ============================
prompt
create table KEBIIM.MSG_CHAT_CHNL
(
  CHNL_SEQ_NO        NUMBER not null,
  DOMAIN             VARCHAR2(20) not null,
  CHNL_NM            VARCHAR2(128),
  CHNL_ROOM_MAX_CNT  NUMBER,
  CHNL_ROOM_USER_CNT NUMBER
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_CHAT_CHNL.CHNL_ROOM_MAX_CNT
  is '채널의 채팅방 Max Count';
comment on column KEBIIM.MSG_CHAT_CHNL.CHNL_ROOM_USER_CNT
  is '채팅방의 사용자 Max Count';
alter table KEBIIM.MSG_CHAT_CHNL
  add constraint PK_MSG_CHAG_CHNL primary key (CHNL_SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_DIALOGUE
prompt ===========================
prompt
create table KEBIIM.MSG_DIALOGUE
(
  SEQ_NO       NUMBER not null,
  SESSIONID    VARCHAR2(100) not null,
  SEND_ID      VARCHAR2(30) not null,
  SEND_DOMAIN  VARCHAR2(20) not null,
  CONTENT      CLOB,
  REG_DT       DATE,
  RECV_ID      VARCHAR2(30),
  RECV_DOMAIN  VARCHAR2(20),
  RECV_USER_NM VARCHAR2(50)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_DIALOGUE
  add constraint PK_MSG_DIALOGUE primary key (SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_DIALOGUE on KEBIIM.MSG_DIALOGUE (SEND_ID, SEND_DOMAIN, SEQ_NO)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_DOMAIN
prompt =========================
prompt
create table KEBIIM.MSG_DOMAIN
(
  DOMAIN              VARCHAR2(20) not null,
  DOMAINTYPE          CHAR(1),
  DOMANISERVICESTATUS CHAR(1) default '1',
  NOTE_TERM           NUMBER default 10,
  ATTCH_FILE_SIZE     NUMBER default 30720,
  FILEROOM_SIZE       NUMBER default 10240
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_DOMAIN.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_DOMAIN.DOMAINTYPE
  is '사용자타입(1:개인(기업)고객,
3:기업형고객 ,
4:호스팅고객)';
comment on column KEBIIM.MSG_DOMAIN.DOMANISERVICESTATUS
  is '도메인상태
(0:사용정지
1:사용중 2:사용대기)';
comment on column KEBIIM.MSG_DOMAIN.NOTE_TERM
  is '쪽지 보관일(일수)';
comment on column KEBIIM.MSG_DOMAIN.ATTCH_FILE_SIZE
  is '첨부파일전송제한사이즈(Kbytes)';
comment on column KEBIIM.MSG_DOMAIN.FILEROOM_SIZE
  is '파일방 파일 보관 제한사이즈(Kbytes)';
alter table KEBIIM.MSG_DOMAIN
  add constraint PK_MSG_DOMAIN primary key (DOMAIN)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_EXT_NOTEINFO
prompt ===============================
prompt
create table KEBIIM.MSG_EXT_NOTEINFO
(
  SEQ_NO        NUMBER not null,
  RECV_USER_KEY VARCHAR2(200),
  MSG_TYPE      VARCHAR2(10),
  CNTNT         VARCHAR2(2000),
  RECV_DT       DATE default sysdate,
  SEND_YN       CHAR(1) default 'N',
  SEND_DT       DATE,
  NOTE_IDX      NUMBER
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_EXT_NOTEINFO.SEQ_NO
  is '외부메세지일련번호';
comment on column KEBIIM.MSG_EXT_NOTEINFO.RECV_USER_KEY
  is '수신자주민번호';
comment on column KEBIIM.MSG_EXT_NOTEINFO.MSG_TYPE
  is '메세지종류
001:입출금내역';
comment on column KEBIIM.MSG_EXT_NOTEINFO.CNTNT
  is '내용';
comment on column KEBIIM.MSG_EXT_NOTEINFO.RECV_DT
  is '접수일시';
comment on column KEBIIM.MSG_EXT_NOTEINFO.SEND_YN
  is '전송여부';
comment on column KEBIIM.MSG_EXT_NOTEINFO.SEND_DT
  is '전송일시';
comment on column KEBIIM.MSG_EXT_NOTEINFO.NOTE_IDX
  is '쪽지테이블pk';

prompt
prompt Creating table MSG_FILEROOM_DIR
prompt ===============================
prompt
create table KEBIIM.MSG_FILEROOM_DIR
(
  DIR_SEQ_NO      NUMBER not null,
  DIR_NM          VARCHAR2(30) not null,
  DOMAIN          VARCHAR2(20) not null,
  USERS_ID        VARCHAR2(30) not null,
  PRNT_DIR_SEQ_NO NUMBER
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_FILEROOM_DIR.DIR_SEQ_NO
  is '디렉토리번호';
comment on column KEBIIM.MSG_FILEROOM_DIR.DIR_NM
  is '디렉토리명';
comment on column KEBIIM.MSG_FILEROOM_DIR.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_FILEROOM_DIR.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_FILEROOM_DIR.PRNT_DIR_SEQ_NO
  is '부모디렉토리번호';
alter table KEBIIM.MSG_FILEROOM_DIR
  add constraint PK_MSG_FILEROOM_DIR primary key (DIR_SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_FILEROOM_DIR on KEBIIM.MSG_FILEROOM_DIR (USERS_ID, DOMAIN)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX2_MSG_FILEROOM_DIR on KEBIIM.MSG_FILEROOM_DIR (USERS_ID, DOMAIN, DIR_SEQ_NO)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_FILEROOM_FILE
prompt ================================
prompt
create table KEBIIM.MSG_FILEROOM_FILE
(
  F_SEQ_NO       NUMBER not null,
  DIR_SEQ_NO     NUMBER not null,
  USERS_ID       VARCHAR2(30) not null,
  DOMAIN         VARCHAR2(20) not null,
  ORGN_FILE_NM   NVARCHAR2(100) not null,
  SERV_FILE_NM   VARCHAR2(100) not null,
  SERV_FILE_PATH VARCHAR2(100) not null,
  FILE_SIZE      INTEGER,
  REG_DT         VARCHAR2(8) default to_char(sysdate,'yyyymmdd')
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_FILEROOM_FILE.F_SEQ_NO
  is '파일번호';
comment on column KEBIIM.MSG_FILEROOM_FILE.DIR_SEQ_NO
  is '디렉토리번호';
comment on column KEBIIM.MSG_FILEROOM_FILE.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_FILEROOM_FILE.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_FILEROOM_FILE.ORGN_FILE_NM
  is '파일명';
comment on column KEBIIM.MSG_FILEROOM_FILE.SERV_FILE_NM
  is '서버에저장된파일명';
comment on column KEBIIM.MSG_FILEROOM_FILE.SERV_FILE_PATH
  is '서버에저장된경로';
comment on column KEBIIM.MSG_FILEROOM_FILE.FILE_SIZE
  is '파일사이지';
comment on column KEBIIM.MSG_FILEROOM_FILE.REG_DT
  is '등록일';
alter table KEBIIM.MSG_FILEROOM_FILE
  add constraint PK_MSG_FILEROOM_FILE primary key (F_SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_FILEROOM_FILE
  add constraint FK_MSG_FILEROOM_FILE foreign key (DIR_SEQ_NO)
  references KEBIIM.MSG_FILEROOM_DIR (DIR_SEQ_NO) on delete cascade
  disable;
create index KEBIIM.IX1_MSG_FILEROOM_FILE on KEBIIM.MSG_FILEROOM_FILE (DIR_SEQ_NO)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX2_MSG_FILEROOM_FILE on KEBIIM.MSG_FILEROOM_FILE (USERS_ID, DOMAIN)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_FILEROOM_PSN_SHARE
prompt =====================================
prompt
create table KEBIIM.MSG_FILEROOM_PSN_SHARE
(
  DIR_SEQ_NO NUMBER not null,
  DOMAIN     VARCHAR2(20) not null,
  USERS_ID   VARCHAR2(30) not null,
  PMSN       CHAR(1) default 'A'
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_FILEROOM_PSN_SHARE.DIR_SEQ_NO
  is '디렉토리번호';
comment on column KEBIIM.MSG_FILEROOM_PSN_SHARE.PMSN
  is 'A(모든권한)R(읽기)W(쓰기)';
alter table KEBIIM.MSG_FILEROOM_PSN_SHARE
  add constraint PK_MSG_FILEROOM_PSN_SHARE primary key (DIR_SEQ_NO, USERS_ID, DOMAIN)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_FILEROOM_PSN_SHARE
  add constraint FK_MSG_FILEROOM_PSN_SHARE foreign key (DIR_SEQ_NO)
  references KEBIIM.MSG_FILEROOM_DIR (DIR_SEQ_NO) on delete cascade
  disable;

prompt
prompt Creating table MSG_FRBD_WORD
prompt ============================
prompt
create table KEBIIM.MSG_FRBD_WORD
(
  SEQ_NO  NUMBER not null,
  KEYWORD VARCHAR2(100),
  DOMAIN  VARCHAR2(20)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_FRBD_WORD.SEQ_NO
  is '금칙어번호';
comment on column KEBIIM.MSG_FRBD_WORD.KEYWORD
  is '금칙어';
comment on column KEBIIM.MSG_FRBD_WORD.DOMAIN
  is '적용도메인(common:전체적용,특정도메인:특정도메인에만적용)
';

prompt
prompt Creating table MSG_LOGIN_HSTR
prompt =============================
prompt
create table KEBIIM.MSG_LOGIN_HSTR
(
  USERS_ID  VARCHAR2(30),
  DOMAIN    VARCHAR2(20),
  LOCAL_IP  VARCHAR2(30),
  LOGIN_DT  DATE default sysdate,
  GUBUN     CHAR(1) default 'L',
  USER_TYPE CHAR(1)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_LOGIN_HSTR.GUBUN
  is 'L-login R-register';
comment on column KEBIIM.MSG_LOGIN_HSTR.USER_TYPE
  is '사용자타입
(1:일반_개인고객,
2:일반_기업고객,
3:기업은행직원,
4:호스팅고객)';

prompt
prompt Creating table MSG_MENU_INFO
prompt ============================
prompt
create table KEBIIM.MSG_MENU_INFO
(
  MENU_ID VARCHAR2(20) not null,
  MENU_NM VARCHAR2(50) not null
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_MENU_INFO.MENU_ID
  is '메뉴ID';
comment on column KEBIIM.MSG_MENU_INFO.MENU_NM
  is '메뉴명';
alter table KEBIIM.MSG_MENU_INFO
  add constraint PK_MSG_MENU_INFO primary key (MENU_ID)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_MENU_INFO_DOMAIN
prompt ===================================
prompt
create table KEBIIM.MSG_MENU_INFO_DOMAIN
(
  MENU_ID VARCHAR2(20) not null,
  DOMAIN  VARCHAR2(20) not null
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_MENU_INFO_DOMAIN.MENU_ID
  is '메뉴ID';
comment on column KEBIIM.MSG_MENU_INFO_DOMAIN.DOMAIN
  is '도메인';
alter table KEBIIM.MSG_MENU_INFO_DOMAIN
  add constraint PK_MSG_MENU_INFO_DOMAIN primary key (MENU_ID, DOMAIN)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_NOTEFILE
prompt ===========================
prompt
create table KEBIIM.MSG_NOTEFILE
(
  FILE_IDX         NUMBER not null,
  FILENAME         VARCHAR2(128) not null,
  SERVER_FILEPATH  VARCHAR2(128) not null,
  LOCAL_FILEPATH   VARCHAR2(128),
  FILESIZE         NUMBER(9),
  FILE_SERVER_IP   VARCHAR2(16),
  FILE_SERVER_PORT VARCHAR2(5),
  FILE_DEL_DT      VARCHAR2(8)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_NOTEFILE.FILE_IDX
  is '파일일련번호';
comment on column KEBIIM.MSG_NOTEFILE.FILENAME
  is '파일명';
comment on column KEBIIM.MSG_NOTEFILE.SERVER_FILEPATH
  is '서버에저장된파일명';
comment on column KEBIIM.MSG_NOTEFILE.LOCAL_FILEPATH
  is '로컬파일경로';
comment on column KEBIIM.MSG_NOTEFILE.FILESIZE
  is '파일사이즈';
comment on column KEBIIM.MSG_NOTEFILE.FILE_SERVER_IP
  is '파일서버IP';
comment on column KEBIIM.MSG_NOTEFILE.FILE_SERVER_PORT
  is '파일서버PORT';
comment on column KEBIIM.MSG_NOTEFILE.FILE_DEL_DT
  is '파일삭제예정일';
alter table KEBIIM.MSG_NOTEFILE
  add constraint PK_MSG_NOTEFILE primary key (FILE_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_NOTEINFO
prompt ===========================
prompt
create table KEBIIM.MSG_NOTEINFO
(
  NOTE_IDX        NUMBER not null,
  SND_USERS_ID    VARCHAR2(30) not null,
  SND_DOMAIN      VARCHAR2(20) not null,
  SND_USER_NM     VARCHAR2(30) not null,
  NOTE_CONTENTS   CLOB not null,
  NOTE_FONT       VARCHAR2(128),
  MSG_TYPE        VARCHAR2(10),
  GROUPID         VARCHAR2(20),
  SEND_DT         DATE,
  SECU_TIME       NUMBER,
  NOTE_DEL_DT     VARCHAR2(8),
  FILE_YN         CHAR(1) default 'N',
  MSG_GROUP       CHAR(1) default '0',
  BG_IMG_IDX      VARCHAR2(30) default '-1',
  CLIENT_NOTE_IDX VARCHAR2(50)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_NOTEINFO.NOTE_IDX
  is '쪽지일련번호';
comment on column KEBIIM.MSG_NOTEINFO.SND_USERS_ID
  is '송신자계정(사번)';
comment on column KEBIIM.MSG_NOTEINFO.SND_DOMAIN
  is '송신자도메인';
comment on column KEBIIM.MSG_NOTEINFO.SND_USER_NM
  is '송신자명';
comment on column KEBIIM.MSG_NOTEINFO.NOTE_CONTENTS
  is '쪽지내용';
comment on column KEBIIM.MSG_NOTEINFO.NOTE_FONT
  is '쪽지폰트';
comment on column KEBIIM.MSG_NOTEINFO.MSG_TYPE
  is '(메시지구분
(C01 - 일반 대화,
N01 - 일반 쪽지(그룹정보보내기 포함),
N02 - 사용자 공지,
N03 - 시스템 공지,
E01 - 메일,
E02 - 결재,
E03 - 설문관리, BLS100 - 거래내역알림,
SMS200 - 문자대화송신,
SMS300 - 문자대화수신)';
comment on column KEBIIM.MSG_NOTEINFO.GROUPID
  is '버디그룹번호';
comment on column KEBIIM.MSG_NOTEINFO.SEND_DT
  is '발송일시';
comment on column KEBIIM.MSG_NOTEINFO.SECU_TIME
  is '보안시간';
comment on column KEBIIM.MSG_NOTEINFO.NOTE_DEL_DT
  is '쪽지삭제예정일';
comment on column KEBIIM.MSG_NOTEINFO.FILE_YN
  is '첨부파일유무';
comment on column KEBIIM.MSG_NOTEINFO.MSG_GROUP
  is '쪽지 구분 (0:쪽지, 1:대화)';
comment on column KEBIIM.MSG_NOTEINFO.BG_IMG_IDX
  is '쪽지의 바탕 이미지 Index';
comment on column KEBIIM.MSG_NOTEINFO.CLIENT_NOTE_IDX
  is '사용자의 쪽지 저장 Index';
alter table KEBIIM.MSG_NOTEINFO
  add constraint PK_MSG_NOTEINFO primary key (NOTE_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_NOTEINFO on KEBIIM.MSG_NOTEINFO (SEND_DT)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_NOTEINFO_FILE
prompt ================================
prompt
create table KEBIIM.MSG_NOTEINFO_FILE
(
  NOTE_IDX     NUMBER not null,
  FILE_IDX     NUMBER not null,
  FILE_RECV_YN CHAR(1) default 'N'
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_NOTEINFO_FILE.NOTE_IDX
  is '쪽지일련번호';
comment on column KEBIIM.MSG_NOTEINFO_FILE.FILE_IDX
  is '파일일련번호';
comment on column KEBIIM.MSG_NOTEINFO_FILE.FILE_RECV_YN
  is '파일수신여부';
alter table KEBIIM.MSG_NOTEINFO_FILE
  add constraint PK_MSG_NOTEINFO_FILE primary key (NOTE_IDX, FILE_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_NOTE_RECVERS
prompt ===============================
prompt
create table KEBIIM.MSG_NOTE_RECVERS
(
  NOTE_RECV_IDX   NUMBER not null,
  NOTE_IDX        NUMBER not null,
  RECV_USERS_ID   VARCHAR2(30) not null,
  RECV_DOMAIN     VARCHAR2(20) not null,
  RECV_USER_NM    VARCHAR2(30),
  RECV_CONFIRM_YN CHAR(1) default 'N',
  RECV_YN         CHAR(1) default 'N',
  RECV_DT         DATE
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_NOTE_RECVERS.NOTE_RECV_IDX
  is '일련번호';
comment on column KEBIIM.MSG_NOTE_RECVERS.NOTE_IDX
  is '메세지일련변호';
comment on column KEBIIM.MSG_NOTE_RECVERS.RECV_USERS_ID
  is '수신자아이디';
comment on column KEBIIM.MSG_NOTE_RECVERS.RECV_DOMAIN
  is '수신자도메인';
comment on column KEBIIM.MSG_NOTE_RECVERS.RECV_USER_NM
  is '수신자이름';
comment on column KEBIIM.MSG_NOTE_RECVERS.RECV_CONFIRM_YN
  is '수신확인체크여부';
comment on column KEBIIM.MSG_NOTE_RECVERS.RECV_YN
  is '수신자수신여부';
comment on column KEBIIM.MSG_NOTE_RECVERS.RECV_DT
  is '수신자_수신일시';
alter table KEBIIM.MSG_NOTE_RECVERS
  add constraint PK_MSG_NOTE_RECVERS primary key (NOTE_RECV_IDX)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_NOTE_RECVERS on KEBIIM.MSG_NOTE_RECVERS (NOTE_IDX)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX2_MSG_NOTE_RECVERS on KEBIIM.MSG_NOTE_RECVERS (RECV_USERS_ID, RECV_DOMAIN, NOTE_RECV_IDX)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_SERVERLIST
prompt =============================
prompt
create table KEBIIM.MSG_SERVERLIST
(
  S_IDX  NUMBER,
  IP     VARCHAR2(30),
  PORT   VARCHAR2(10),
  STATUS CHAR(1) default '0',
  KIND   VARCHAR2(10)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_SERVERLIST.STATUS
  is '''0'':데몬비활성화, ''1'':데몬활성화';
comment on column KEBIIM.MSG_SERVERLIST.KIND
  is 'ims.imbs,frs,chat,hb,rcs';

prompt
prompt Creating table MSG_STAFF_DEPT_INFO
prompt ==================================
prompt
create table KEBIIM.MSG_STAFF_DEPT_INFO
(
  ORG_CD      VARCHAR2(10) not null,
  PRNT_ORG_CD VARCHAR2(10) not null,
  ORG_NM      VARCHAR2(100),
  SORT_NO     NUMBER
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_STAFF_DEPT_INFO.ORG_CD
  is '부서코드';
comment on column KEBIIM.MSG_STAFF_DEPT_INFO.PRNT_ORG_CD
  is '상위부서코드';
comment on column KEBIIM.MSG_STAFF_DEPT_INFO.ORG_NM
  is '부서명';
alter table KEBIIM.MSG_STAFF_DEPT_INFO
  add constraint PK_MSG_STAFF_DEPT_INFO primary key (ORG_CD)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_DEPT_INFO on KEBIIM.MSG_STAFF_DEPT_INFO (PRNT_ORG_CD)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_STAFF_INFO
prompt =============================
prompt
create table KEBIIM.MSG_STAFF_INFO
(
  USERS_ID     VARCHAR2(30) not null,
  DOMAIN       VARCHAR2(20) not null,
  ORG_CD       VARCHAR2(10) not null,
  SORT_NO      NUMBER not null,
  ABRV_POSI_NM VARCHAR2(100),
  LVL          VARCHAR2(100),
  CORP_TENO    VARCHAR2(100),
  HM_TENO      VARCHAR2(100),
  FAX_NO       VARCHAR2(100),
  TEAM_NM      VARCHAR2(50),
  DUCD         CHAR(4),
  POSI_CD      VARCHAR2(4),
  JOIN_YMD     VARCHAR2(8),
  RMK          VARCHAR2(40),
  FILLER1      VARCHAR2(10)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_STAFF_INFO.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_STAFF_INFO.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_STAFF_INFO.ORG_CD
  is '부서코드';
comment on column KEBIIM.MSG_STAFF_INFO.SORT_NO
  is '소팅순서';
comment on column KEBIIM.MSG_STAFF_INFO.ABRV_POSI_NM
  is '직위명';
comment on column KEBIIM.MSG_STAFF_INFO.LVL
  is '직급명';
comment on column KEBIIM.MSG_STAFF_INFO.CORP_TENO
  is '사내전화';
comment on column KEBIIM.MSG_STAFF_INFO.HM_TENO
  is '집전화';
comment on column KEBIIM.MSG_STAFF_INFO.FAX_NO
  is '팩스번호';
comment on column KEBIIM.MSG_STAFF_INFO.TEAM_NM
  is '팀명';
comment on column KEBIIM.MSG_STAFF_INFO.DUCD
  is '직책코드';
comment on column KEBIIM.MSG_STAFF_INFO.POSI_CD
  is '직위코드';
comment on column KEBIIM.MSG_STAFF_INFO.JOIN_YMD
  is '입사일';
comment on column KEBIIM.MSG_STAFF_INFO.RMK
  is '비고';
alter table KEBIIM.MSG_STAFF_INFO
  add constraint PK_MSG_STAFF_INFO primary key (USERS_ID, DOMAIN, ORG_CD)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_STAFF_INFO on KEBIIM.MSG_STAFF_INFO (ORG_CD, SORT_NO)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_STAFF_ORG_FAV
prompt ================================
prompt
create table KEBIIM.MSG_STAFF_ORG_FAV
(
  USERS_ID VARCHAR2(30) not null,
  DOMAIN   VARCHAR2(20) not null,
  ORG_CD   VARCHAR2(30) not null,
  SEQ_NO   NUMBER not null
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_STAFF_ORG_FAV.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_STAFF_ORG_FAV.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_STAFF_ORG_FAV.ORG_CD
  is '부서코드';
comment on column KEBIIM.MSG_STAFF_ORG_FAV.SEQ_NO
  is '일련번호';
alter table KEBIIM.MSG_STAFF_ORG_FAV
  add constraint PK_MSG_STAFF_ORG_FAV primary key (SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.UK1_MSG_STAFF_ORG_FAV on KEBIIM.MSG_STAFF_ORG_FAV (USERS_ID, DOMAIN, ORG_CD)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_STATISTICS_YYYYMMDD
prompt ======================================
prompt
create table KEBIIM.MSG_STATISTICS_YYYYMMDD
(
  YYYYMMDD          VARCHAR2(8),
  USER_TYPE         VARCHAR2(10),
  VALID_USER_CNT    NUMBER,
  NOTVALID_USER_CNT NUMBER,
  TOT_USER_CNT      NUMBER,
  JOIN_CNT          NUMBER,
  LOGIN_CNT         NUMBER
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_USER_INFO
prompt ============================
prompt
create table KEBIIM.MSG_USER_INFO
(
  USERS_ID          VARCHAR2(30) not null,
  DOMAIN            VARCHAR2(20) not null,
  DISPLAYNAME       VARCHAR2(300) not null,
  USERCURRENTSTATUS NUMBER(2) default '-1',
  USER_LOCAL_IP     VARCHAR2(16),
  USER_LOCAL_PORT   VARCHAR2(5),
  SERVER_IP         VARCHAR2(16),
  SERVER_PORT       VARCHAR2(5),
  CLIENT_TYPE       CHAR(1),
  PWDFAIL_COUNT     NUMBER default 0,
  OLD_USER_LVL      CHAR(1)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_USER_INFO.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_USER_INFO.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_USER_INFO.DISPLAYNAME
  is '대화명';
comment on column KEBIIM.MSG_USER_INFO.USERCURRENTSTATUS
  is '메신저사용상태';
comment on column KEBIIM.MSG_USER_INFO.USER_LOCAL_IP
  is '접속한사용자IP';
comment on column KEBIIM.MSG_USER_INFO.USER_LOCAL_PORT
  is '접속한사용자PORT';
comment on column KEBIIM.MSG_USER_INFO.SERVER_IP
  is '접속된서버IP';
comment on column KEBIIM.MSG_USER_INFO.SERVER_PORT
  is '접속된서버PORT';
comment on column KEBIIM.MSG_USER_INFO.CLIENT_TYPE
  is '접속매체(W:웹, A:어플리케이션)';
comment on column KEBIIM.MSG_USER_INFO.PWDFAIL_COUNT
  is '암호입력 실패 Count';
alter table KEBIIM.MSG_USER_INFO
  add constraint PK_MSG_USER_INFO primary key (USERS_ID, DOMAIN)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_USER_INFO on KEBIIM.MSG_USER_INFO (SERVER_IP, SERVER_PORT)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_USER_MASTER
prompt ==============================
prompt
create table KEBIIM.MSG_USER_MASTER
(
  USERS_ID     VARCHAR2(30) not null,
  DOMAIN       VARCHAR2(20) not null,
  USER_NM      VARCHAR2(30) not null,
  RSN_NO       VARCHAR2(20),
  PASSWD       VARCHAR2(40) not null,
  USER_TYPE    CHAR(1) not null,
  MOBILE_PHONE VARCHAR2(50),
  PASSWORD_QST VARCHAR2(100),
  PASSWORD_ASW VARCHAR2(100),
  VALID_YN     CHAR(1),
  SMS_QT       NUMBER default 20,
  USER_LVL     CHAR(1) default '1',
  FILLER1      VARCHAR2(100),
  FILLER2      VARCHAR2(100),
  FILLER3      VARCHAR2(100),
  FILLER4      VARCHAR2(100),
  FILLER5      VARCHAR2(100)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_USER_MASTER.USERS_ID
  is '사용자계정(사번)';
comment on column KEBIIM.MSG_USER_MASTER.DOMAIN
  is '도메인';
comment on column KEBIIM.MSG_USER_MASTER.USER_NM
  is '이름';
comment on column KEBIIM.MSG_USER_MASTER.RSN_NO
  is '주민(사업자등록)번호';
comment on column KEBIIM.MSG_USER_MASTER.PASSWD
  is '비밀번호';
comment on column KEBIIM.MSG_USER_MASTER.USER_TYPE
  is '사용자타입
(1:일반_개인고객,
2:일반_기업고객,
3:기업고객,
4:호스팅고객)';
comment on column KEBIIM.MSG_USER_MASTER.MOBILE_PHONE
  is '핸드폰번호';
comment on column KEBIIM.MSG_USER_MASTER.PASSWORD_QST
  is '비밀번호질문';
comment on column KEBIIM.MSG_USER_MASTER.PASSWORD_ASW
  is '비밀번호답';
comment on column KEBIIM.MSG_USER_MASTER.VALID_YN
  is '인증회원여부(Y:공인인증 N:실명인증)';
comment on column KEBIIM.MSG_USER_MASTER.SMS_QT
  is 'sms발송가능수량(9999:발송제한없음.)';
comment on column KEBIIM.MSG_USER_MASTER.USER_LVL
  is '사용자레벨(
0:사용정지,
1:일반회원
2:도메인관리자
3:시스템관리자,9:암호입력오류횟수초과정지)';
comment on column KEBIIM.MSG_USER_MASTER.FILLER1
  is '담당업무';
comment on column KEBIIM.MSG_USER_MASTER.FILLER2
  is '이메일';
comment on column KEBIIM.MSG_USER_MASTER.FILLER3
  is '회사전화번호';
alter table KEBIIM.MSG_USER_MASTER
  add constraint PK_MSG_USER_MASTER primary key (USERS_ID, DOMAIN)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_USER_MASTER on KEBIIM.MSG_USER_MASTER (DOMAIN)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX2_MSG_USER_MASTER on KEBIIM.MSG_USER_MASTER (RSN_NO, USER_TYPE)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX3_MSG_USER_MASTER on KEBIIM.MSG_USER_MASTER (USER_NM)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX4_MSG_USER_MASTER on KEBIIM.MSG_USER_MASTER (USERS_ID, DOMAIN, USER_NM)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_USER_MASTER_DEL_USERS
prompt ========================================
prompt
create table KEBIIM.MSG_USER_MASTER_DEL_USERS
(
  USERS_ID     VARCHAR2(30) not null,
  DOMAIN       VARCHAR2(20) not null,
  USER_NM      VARCHAR2(30) not null,
  RSN_NO       VARCHAR2(20) not null,
  PASSWD       VARCHAR2(40) not null,
  USER_TYPE    CHAR(1) not null,
  MOBILE_PHONE VARCHAR2(50),
  PASSWORD_QST VARCHAR2(100),
  PASSWORD_ASW VARCHAR2(100),
  VALID_YN     CHAR(1),
  SMS_QT       NUMBER,
  USER_LVL     CHAR(1)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_WEATHER_AREA
prompt ===============================
prompt
create table KEBIIM.MSG_WEATHER_AREA
(
  AREA_CD VARCHAR2(10) not null,
  AREA_NM VARCHAR2(100)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_WEATHER_AREA.AREA_CD
  is '지역코드';
comment on column KEBIIM.MSG_WEATHER_AREA.AREA_NM
  is '지역명';
alter table KEBIIM.MSG_WEATHER_AREA
  add constraint PK_MSG_WEATHER_AREA primary key (AREA_CD)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_WEATHER_FORECAST
prompt ===================================
prompt
create table KEBIIM.MSG_WEATHER_FORECAST
(
  SEQ_NO                 NUMBER not null,
  WORK_DT                VARCHAR2(8),
  WORK_TM                VARCHAR2(8),
  TDY_MIN_TMPR           VARCHAR2(20),
  TMRW_MIN_TMPR          VARCHAR2(20),
  AFTR_TMRW_MIN_TMPR     VARCHAR2(20),
  TDY_MAX_TMPR           VARCHAR2(20),
  TMRW_MAX_TMPR          VARCHAR2(20),
  AFTR_TMRW_MAX_TMPR     VARCHAR2(20),
  TDY_CD                 VARCHAR2(20),
  TMRW_CD                VARCHAR2(20),
  AFTR_TMRW_CD           VARCHAR2(20),
  TDY_DETAIL             VARCHAR2(300),
  TMRW_DETAIL            VARCHAR2(300),
  AFTR_TMRW_DETAIL       VARCHAR2(300),
  TDY_AM_RAIN_PRBL       VARCHAR2(20),
  TMRW_AM_RAIN_PRBL      VARCHAR2(20),
  AFTR_TMRW_AM_RAIN_PRBL VARCHAR2(20),
  TDY_PM_RAIN_PRBL       VARCHAR2(20),
  TMRW_PM_RAIN_PRBL      VARCHAR2(20),
  AFTR_TMRW_PM_RAIN_PRBL VARCHAR2(20),
  AREA_CD                VARCHAR2(20) not null
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_WEATHER_FORECAST.SEQ_NO
  is '일련번호';
comment on column KEBIIM.MSG_WEATHER_FORECAST.WORK_DT
  is '발표일자';
comment on column KEBIIM.MSG_WEATHER_FORECAST.WORK_TM
  is '발표시각';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TDY_MIN_TMPR
  is '오늘최저온도';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TMRW_MIN_TMPR
  is '내일최저온도';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AFTR_TMRW_MIN_TMPR
  is '모레최저온도';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TDY_MAX_TMPR
  is '오늘최고온도';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TMRW_MAX_TMPR
  is '내일최고온도';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AFTR_TMRW_MAX_TMPR
  is '모레최고온도';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TDY_CD
  is '오늘날씨코드';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TMRW_CD
  is '내일날씨코드';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AFTR_TMRW_CD
  is '모레날씨코드';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TDY_DETAIL
  is '오늘날씨상세';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TMRW_DETAIL
  is '내일날씨상세';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AFTR_TMRW_DETAIL
  is '모레날씨상세';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TDY_AM_RAIN_PRBL
  is '오늘오전강수확률';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TMRW_AM_RAIN_PRBL
  is '내일오전강수확률';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AFTR_TMRW_AM_RAIN_PRBL
  is '모레오전강수확률';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TDY_PM_RAIN_PRBL
  is '오늘오후강수확률';
comment on column KEBIIM.MSG_WEATHER_FORECAST.TMRW_PM_RAIN_PRBL
  is '내일오후강수확률';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AFTR_TMRW_PM_RAIN_PRBL
  is '모레오후강수확률';
comment on column KEBIIM.MSG_WEATHER_FORECAST.AREA_CD
  is '지역코드';
alter table KEBIIM.MSG_WEATHER_FORECAST
  add constraint PK_MSG_WEATHER_FORECAST primary key (SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_WEATHER_FORECAST
  add constraint UK_MSG_WEATHER_FORECAST unique (WORK_DT, WORK_TM, AREA_CD)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MSG_WEATHER_REALTIME
prompt ===================================
prompt
create table KEBIIM.MSG_WEATHER_REALTIME
(
  SEQ_NO  NUMBER not null,
  WORK_DT VARCHAR2(8),
  WORK_TM VARCHAR2(8),
  TMPR    NUMBER,
  AREA_CD VARCHAR2(10) not null
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
comment on column KEBIIM.MSG_WEATHER_REALTIME.SEQ_NO
  is '일련번호';
comment on column KEBIIM.MSG_WEATHER_REALTIME.WORK_DT
  is '발표일자';
comment on column KEBIIM.MSG_WEATHER_REALTIME.WORK_TM
  is '발표일시';
comment on column KEBIIM.MSG_WEATHER_REALTIME.TMPR
  is '온도';
comment on column KEBIIM.MSG_WEATHER_REALTIME.AREA_CD
  is '지역코드';
alter table KEBIIM.MSG_WEATHER_REALTIME
  add constraint MSG_WEATHER_REALTIME primary key (SEQ_NO)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
alter table KEBIIM.MSG_WEATHER_REALTIME
  add constraint UK_MSG_WEATHER_REALTIME unique (WORK_DT, WORK_TM, AREA_CD)
  using index 
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_MSG_WEATHER_REALTIME on KEBIIM.MSG_WEATHER_REALTIME (AREA_CD, SEQ_NO)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PLAN_TABLE
prompt =========================
prompt
create table KEBIIM.PLAN_TABLE
(
  STATEMENT_ID      VARCHAR2(30),
  PLAN_ID           NUMBER,
  TIMESTAMP         DATE,
  REMARKS           VARCHAR2(4000),
  OPERATION         VARCHAR2(30),
  OPTIONS           VARCHAR2(255),
  OBJECT_NODE       VARCHAR2(128),
  OBJECT_OWNER      VARCHAR2(30),
  OBJECT_NAME       VARCHAR2(30),
  OBJECT_ALIAS      VARCHAR2(65),
  OBJECT_INSTANCE   INTEGER,
  OBJECT_TYPE       VARCHAR2(30),
  OPTIMIZER         VARCHAR2(255),
  SEARCH_COLUMNS    NUMBER,
  ID                INTEGER,
  PARENT_ID         INTEGER,
  DEPTH             INTEGER,
  POSITION          INTEGER,
  COST              INTEGER,
  CARDINALITY       INTEGER,
  BYTES             INTEGER,
  OTHER_TAG         VARCHAR2(255),
  PARTITION_START   VARCHAR2(255),
  PARTITION_STOP    VARCHAR2(255),
  PARTITION_ID      INTEGER,
  OTHER             LONG,
  DISTRIBUTION      VARCHAR2(30),
  CPU_COST          INTEGER,
  IO_COST           INTEGER,
  TEMP_SPACE        INTEGER,
  ACCESS_PREDICATES VARCHAR2(4000),
  FILTER_PREDICATES VARCHAR2(4000),
  PROJECTION        VARCHAR2(4000),
  TIME              INTEGER,
  QBLOCK_NAME       VARCHAR2(30)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TB_DEBUG
prompt =======================
prompt
create table KEBIIM.TB_DEBUG
(
  VAL    VARCHAR2(2000),
  REG_DT DATE default sysdate
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMP_SSOV_DEPT
prompt =============================
prompt
create table KEBIIM.TEMP_SSOV_DEPT
(
  DEPT_ID       VARCHAR2(15),
  BASE_SYS      CHAR(1),
  DEPT_NAME     VARCHAR2(300),
  DEPT_FULLNAME VARCHAR2(300),
  UPPER_DEPT_ID VARCHAR2(15),
  TOP_DEPT_ID   VARCHAR2(15),
  ORG_DIV_ID    VARCHAR2(15),
  DEPT_ORDER    VARCHAR2(4),
  DEPT_RANK     VARCHAR2(5),
  DEPT_TEL      VARCHAR2(50),
  DEPT_FAX      VARCHAR2(50),
  DEPT_SE       VARCHAR2(5),
  ACTION_TYPE   CHAR(1),
  IS_APPLY      CHAR(1),
  APPLY_DAY     CHAR(14),
  REG_DAY       CHAR(14),
  UPDATE_DAY    CHAR(14),
  START_DD      CHAR(8),
  END_DD        CHAR(8),
  BEF_DEPT_ID   VARCHAR2(32)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMP_SSOX_USER
prompt =============================
prompt
create table KEBIIM.TEMP_SSOX_USER
(
  USER_ID        VARCHAR2(20) not null,
  USER_NAME      VARCHAR2(500),
  USER_SN        VARCHAR2(500),
  USER_STAT      VARCHAR2(10),
  USER_STAT_NAME VARCHAR2(100),
  REGULARITY     CHAR(1),
  ORG_ID         VARCHAR2(20),
  ORG_NAME       VARCHAR2(300),
  DEPT_ID        VARCHAR2(20),
  DEPT_NAME      VARCHAR2(300),
  DEPT_FULLNAME  VARCHAR2(300),
  CLASS_ID       VARCHAR2(20),
  CLASS_NAME     VARCHAR2(100),
  POSITION_ID    VARCHAR2(20),
  POSITION_NAME  VARCHAR2(100),
  GRADE_ID       CHAR(3),
  GRADE_NAME     VARCHAR2(100),
  EMAIL          VARCHAR2(100),
  TEL            VARCHAR2(20),
  MOBILE         VARCHAR2(20),
  JOIN_DAY       VARCHAR2(8),
  RETIRE_DAY     VARCHAR2(8),
  ADD_INFO1      VARCHAR2(500),
  ADD_INFO2      VARCHAR2(500),
  ADD_INFO3      VARCHAR2(500),
  ADD_INFO4      VARCHAR2(500),
  ADD_INFO5      VARCHAR2(500),
  ADD_INFO6      VARCHAR2(500),
  ADD_INFO7      VARCHAR2(500),
  BASE_SYS       CHAR(1),
  REG_DAY        CHAR(14),
  UPDATE_DAY     CHAR(14),
  USE_YN         CHAR(1) default '1',
  RDUTY_NAME     VARCHAR2(40)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TEMP_STAFF_INFO
prompt ==============================
prompt
create table KEBIIM.TEMP_STAFF_INFO
(
  USERS_ID VARCHAR2(30) not null,
  DOMAIN   VARCHAR2(20) not null,
  ORG_CD   VARCHAR2(10) not null,
  USER_NM  VARCHAR2(30) not null,
  TEAM_NM  VARCHAR2(50),
  ORG_NM   VARCHAR2(100)
)
tablespace KEBIMSG
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );
create index KEBIIM.IX1_TEMP_STAFF_INFO on KEBIIM.TEMP_STAFF_INFO (ORG_CD)
  tablespace KEBIMSG
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence SEQ_MSG_BANNER_INFO
prompt =====================================
prompt
create sequence KEBIIM.SEQ_MSG_BANNER_INFO
minvalue 1
maxvalue 99999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_BATCH_LOG
prompt ===================================
prompt
create sequence KEBIIM.SEQ_MSG_BATCH_LOG
minvalue 1
maxvalue 999999999999999999
start with 5281
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_BUDDY_GROUP
prompt =====================================
prompt
create sequence KEBIIM.SEQ_MSG_BUDDY_GROUP
minvalue 1
maxvalue 999999999999999999
start with 31323
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_BUDDY_LIST
prompt ====================================
prompt
create sequence KEBIIM.SEQ_MSG_BUDDY_LIST
minvalue 1
maxvalue 999999999999999999
start with 484031
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_CHAT_CHNL
prompt ===================================
prompt
create sequence KEBIIM.SEQ_MSG_CHAT_CHNL
minvalue 1
maxvalue 999999999999999999999999999
start with 87
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_MSG_DIALOGUE
prompt ==================================
prompt
create sequence KEBIIM.SEQ_MSG_DIALOGUE
minvalue 1
maxvalue 9999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_EXT_NOTEINFO
prompt ======================================
prompt
create sequence KEBIIM.SEQ_MSG_EXT_NOTEINFO
minvalue 1
maxvalue 999999999999999999
start with 34182
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence SEQ_MSG_FILEROOM_DIR
prompt ======================================
prompt
create sequence KEBIIM.SEQ_MSG_FILEROOM_DIR
minvalue 1
maxvalue 99999999999999999999
start with 571
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_FILEROOM_FILE
prompt =======================================
prompt
create sequence KEBIIM.SEQ_MSG_FILEROOM_FILE
minvalue 1
maxvalue 99999999999999999999
start with 1076
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_NOTEFILE
prompt ==================================
prompt
create sequence KEBIIM.SEQ_MSG_NOTEFILE
minvalue 1
maxvalue 999999999999999999999999999
start with 570
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MSG_NOTEINFO
prompt ==================================
prompt
create sequence KEBIIM.SEQ_MSG_NOTEINFO
minvalue 0
maxvalue 999999999999999999999999999
start with 46425
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_MSG_NOTE_RECV
prompt ===================================
prompt
create sequence KEBIIM.SEQ_MSG_NOTE_RECV
minvalue 1
maxvalue 9999999999999999999
start with 43380
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_NOTEINFORMATION
prompt =====================================
prompt
create sequence KEBIIM.SEQ_NOTEINFORMATION
minvalue 1
maxvalue 99999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SMS
prompt =========================
prompt
create sequence KEBIIM.SEQ_SMS
minvalue 1
maxvalue 99999999
start with 525
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence SEQ_TB_IBK_DEPT_INFO
prompt ======================================
prompt
create sequence KEBIIM.SEQ_TB_IBK_DEPT_INFO
minvalue 1
maxvalue 999999999999999999
start with 239
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_WEATHER_FORECAST
prompt =========================================
prompt
create sequence KEBIIM.SEQ_TB_WEATHER_FORECAST
minvalue 1
maxvalue 999999999999999999999
start with 18001
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TB_WEATHER_REALTIME
prompt =========================================
prompt
create sequence KEBIIM.SEQ_TB_WEATHER_REALTIME
minvalue 1
maxvalue 999999999999999999
start with 90361
increment by 1
cache 20;

prompt
prompt Creating package PKG_ADMIN_INFO
prompt ===============================
prompt
create or replace package kebiim.PKG_ADMIN_INFO is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

    --------------------------------------------------------------------
    -- 사용자 정보(고객,기업회원
    --------------------------------------------------------------------
    FUNCTION sf_get_user_info(p_domainname in varchar2,
                              p_users_id in varchar2)
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 사용자 정보(직원
    --------------------------------------------------------------------
    FUNCTION sf_get_emp_info(p_domainname in varchar2,
                              p_users_id in varchar2)
    RETURN CursorType;


    ---------------------------------------------------------------------
    -- 사용자정보 수정(superadmin관리자)
    ---------------------------------------------------------------------
     procedure sp_upt_user_by_admin( p_domain in varchar2,
                                   p_users_id in varchar2,
                                   p_mobile_phone in varchar2,
                                   p_user_lvl in varchar2);

    --------------------------------------------------------------------
    -- 호스팅 회원가입 여부
    --------------------------------------------------------------------
    FUNCTION sf_get_admin_confirm_pwd(p_domain in varchar2
                                      ,p_users_id in varchar2
                                      ,p_passwd in varchar2
                                      ,p_level in varchar2)
    RETURN number;

    --------------------------------------------------------------------
    -- 슈퍼관리자 (실시간 공지 조직명)
    --------------------------------------------------------------------
    FUNCTION sf_org_nm_list
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 슈퍼관리자 (실시간 공지 부서명)
    --------------------------------------------------------------------
      FUNCTION sf_posi_nm_list
      RETURN CursorType;

    ---------------------------------------------------------------------
    -- 사용자 삭제(일반/기업/호스팅고객)
    ---------------------------------------------------------------------
      procedure sp_del_user( p_domain in varchar2, p_users_id in varchar2);

    ---------------------------------------------------------------------
     -- 사용자 정지 / 활성화
    ---------------------------------------------------------------------
      procedure sp_upt_users_alive_stop( p_user_lvl in varchar2, p_domain in varchar2, p_users_id in varchar2);

    --------------------------------------------------------------------
    -- 서버목록 정보를 삭제한다 (superadmin)
    --------------------------------------------------------------------
    PROCEDURE sp_del_server_info(p_idx in int,
                                 p_ip in varchar2);

    --------------------------------------------------------------------
    -- 서버목록 정보를 수정한다 (superadmin)
    --------------------------------------------------------------------
    PROCEDURE sp_upt_server_info(p_s_idx in number,
                                 p_ip in varchar2,
                                 p_port in varchar2,
                                 p_status in varchar2,
                                 p_kind in varchar2);
    --------------------------------------------------------------------
    -- 서버목록 정보를 입력한다 (superadmin)
    --------------------------------------------------------------------
    PROCEDURE sp_ins_server_info(p_ip in varchar2,
                                 p_port in varchar2,
                                 p_status in varchar2,
                                 p_kind in varchar2);
    ---------------------------------------------------------------------
    -- 서버목록 정보를 축력한다 (superadmin)
    ---------------------------------------------------------------------
    FUNCTION sf_get_server_info(p_sch_type in varchar2,
                                p_keyword in varchar2,
                                p_start_num in number,
                                p_range in number)
    RETURN CursorType;

    ---------------------------------------------------------------------
    -- 채널 리스트 정보를 출력한다 (superadmin)
    ---------------------------------------------------------------------

    FUNCTION sf_get_chnl_info(p_sch_type in varchar2,
                              p_keyword in varchar2,
                              p_start_num in number,
                              p_range in number)
    RETURN CursorType;

    ---------------------------------------------------------------------
    -- 채널 리스트 정보를 입력한다 (superadmin)
    ---------------------------------------------------------------------

    PROCEDURE sp_ins_chnl_info(p_domain in varchar2,
                               p_chnl_nm in varchar2,
                               p_chnl_room_max_cnt in varchar2,
                               p_chnl_room_user_cnt in varchar2);
    --------------------------------------------------------------------
    -- 채널 리스트 정보를 삭제한다 (superadmin)
    --------------------------------------------------------------------
    PROCEDURE sp_del_chnl_info(p_chnl_seq_no in number,
                               p_domain in varchar2);

    --------------------------------------------------------------------
    -- 채널 리스트 정보를 수정한다 (superadmin)
    --------------------------------------------------------------------
    PROCEDURE sp_upt_chnl_info(p_chnl_seq_no in number,
                               p_domain in varchar2,
                               p_chnl_nm in varchar2,
                               p_chnl_room_max_cnt in varchar2,
                               p_chnl_room_user_cnt in varchar2);
    --------------------------------------------------------------------
    -- 채널 리스트 정보를 수정한다 (superadmin) -all
    -- PARAM1 : p_chnl_seq_no
    -- PARAM2 : p_domain
    -- PARAM3 : p_chnl_nm
    -- PARAM4 : p_chnl_room_max_cnt
    -- PARAM5 : p_chnl_room_user_cnt
    --------------------------------------------------------------------

    PROCEDURE sp_upt_chnl_info_all(p_chnl_seq_no in number,
                               p_chnl_room_max_cnt in varchar2,
                               p_chnl_room_user_cnt in varchar2,
                               p_ch in varchar2);
    ---------------------------------------------------------------------
    -- 채널 리스트 정보 가져오기 (superadmin)
    ---------------------------------------------------------------------
    FUNCTION sf_get_chat_by_update(p_chnl_seq_no in number)
    RETURN CursorType;

    ---------------------------------------------------------------------
    -- 서버 정보 가져오기 (superadmin)
    ---------------------------------------------------------------------
    FUNCTION sf_get_server_by_update(p_s_idx in number)
    RETURN CursorType;


    ---------------------------------------------------------------------
    -- 사용자 정보 가져오기 (superadmin)
    ---------------------------------------------------------------------
    function sf_all_user_info(p_sch_type in varchar2,
                              p_keyword in varchar2,
                              p_start_num in number,
                              p_range in number,
                              p_userType in varchar2,
                              p_domain in varchar2)
    return CursorType;



    ---------------------------------------------------------------------
    -- 회원 탈퇴
    ---------------------------------------------------------------------
    PROCEDURE sp_del_user_info(p_users_id in varchar2,
                               p_passwd in varchar2,
                               p_user_nm in varchar2,
                               p_rsn_no in varchar2,
                               p_domain in varchar2);

    ---------------------------------------------------------------------
    -- 회원 탈퇴전 비교
    ---------------------------------------------------------------------
    FUNCTION sp_get_del_user_info(p_users_id in varchar2,
                                   p_passwd in varchar2,
                                   p_user_nm in varchar2,
                                   p_rsn_no in varchar2,
                                   p_domain in varchar2)
    RETURN varchar2;

    -----------------------------------------------------------------
    -- 회원정보수정 (준회원->정회원)
    -----------------------------------------------------------------

    procedure sp_upt_valid_by_user( p_rsn_no in varchar2);

    --------------------------------------------------------------------
    -- 사용자 정보(개인고객,기업고객)-직원전용
    --------------------------------------------------------------------
    FUNCTION sf_user_info(p_rsn_no in varchar2)
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 사용자 정보(직원)
    --------------------------------------------------------------------
    FUNCTION sf_emp_info(p_domainname in varchar2,
                              p_users_id in varchar2)
    RETURN CursorType;

    function sf_get_sysnotify_user_list(p_gubun in varchar2,
                          p_buso in varchar2,
                          p_gikwi in varchar2,
                          p_domainonly in varchar2) return CursorType;
end PKG_ADMIN_INFO;
/

prompt
prompt Creating package PKG_BATCH_LOG
prompt ==============================
prompt
create or replace package kebiim.PKG_BATCH_LOG is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  function sf_start_batch(p_item_cd in varchar2) return number;

  procedure sp_start_batch(p_item_cd in varchar2);

  procedure sp_end_batch(p_seq_no in number,
                          p_result_cd in varchar2,
                          p_result_detail in varchar2);

   procedure sp_end_batch2(p_item_cd in varchar2,
                          p_result_cd in varchar2,
                          p_result_detail in varchar2);
end PKG_BATCH_LOG;
/

prompt
prompt Creating package PKG_FILEROOM_INFO
prompt ==================================
prompt
create or replace package kebiim.PKG_FILEROOM_INFO is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

    ---------------------------------------------------------------------
    --  폴더 생성
    ---------------------------------------------------------------------
    FUNCTION sf_ins_fileroom_dir(p_userid in varchar2,
                               p_domainname in varchar2,
                               p_dirname in varchar2)
    RETURN NUMBER;

   ---------------------------------------------------------------------
    --  파일 생성
    ---------------------------------------------------------------------
    FUNCTION sf_ins_file(p_dirseqno in number,
                         p_userid in varchar2,
                         p_domainname in varchar2,
                         p_orgfilenm in varchar2,
                         p_servfilenm in varchar2,
                         p_servfilepath in varchar2,
                         p_filesize in number)
     RETURN NUMBER;
    ---------------------------------------------------------------------
    --  권한  생성
    ---------------------------------------------------------------------
     PROCEDURE sp_ins_fileroom_share(p_userid in varchar2,
                                    p_domainname in varchar2,
                                    p_seqno in varchar2,
                                    p_pmsn in varchar2);
    ---------------------------------------------------------------------
    --  권한 수정
    ---------------------------------------------------------------------
     PROCEDURE sp_upd_fileroom_share(p_userid in varchar2,
                                    p_domainname in varchar2,
                                    p_seqno in varchar2,
                                    p_pmsn in varchar2);

    ---------------------------------------------------------------------
    --  권한 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_share(p_userid in varchar2,
                                    p_domainname in varchar2,
                                    p_seqno in varchar2);
    ---------------------------------------------------------------------
    --  폴더 수정
    ---------------------------------------------------------------------
    procedure sp_update_fileroom_dir(p_dirseqno in varchar2 ,
                                    p_dirname in varchar2
                                    );

    ---------------------------------------------------------------------
    --  폴더 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_dir(p_dirseqno in varchar2  );

   ---------------------------------------------------------------------
    --  파일 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_file(p_dirseqno in varchar2,
                                   p_fseqno in varchar2);

    ---------------------------------------------------------------------
    --  권한 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_psn_share(p_dirseqno in varchar2,
                                  p_userid in varchar2,
                                  p_domainname in varchar2);

    ---------------------------------------------------------------------
    -- 사용자의 버디 그룹과 리스트를 가져 온다.(전부 가져온다)
      ---------------------------------------------------------------------
    FUNCTION sf_get_buddy_All_list(p_userid in varchar2,
                                   p_domainname in varchar2)
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 삭제할 파일 정보를 가져온다.
    --------------------------------------------------------------------
    FUNCTION sf_get_del_fileInfo(p_dirseqno in varchar2,
                                     p_fseqno in varchar2)
    RETURN CursorType;
    --------------------------------------------------------------------
    -- 파일방 , 목록을 가져 온다.
     --------------------------------------------------------------------
    FUNCTION sf_get_fileinfo(p_userid in varchar2,
                             p_domainname in varchar2)
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 폴더별 권한 목록을 가져 온다.
     --------------------------------------------------------------------
    FUNCTION sf_get_fileroom_share(p_dirseqno in number)
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 친구 파일방 , 목록을 가져 온다.
     --------------------------------------------------------------------
    FUNCTION sf_get_friends_fileinfo(p_userid in varchar2,
                             p_domainname in varchar2)
    RETURN CursorType;

    --------------------------------------------------------------------
    -- 도메인별 파일사이즈 용량을 가져온다.
     --------------------------------------------------------------------
    FUNCTION sf_get_fileSize(p_domainname in varchar2)
    RETURN number;

    --------------------------------------------------------------------
    -- 파일 생성 ( superadmin)
    --------------------------------------------------------------------
    FUNCTION sf_banner_ins_uploadFile(p_orgn_file_nm in varchar2,
                                p_serv_file_nm in varchar2,
                                p_serv_file_path in varchar2,
                                p_file_size in number,
                                p_link_url in varchar2,
                                p_banner_nm in varchar2,
                                p_b_user_type in varchar2)
    RETURN NUMBER;

    --------------------------------------------------------------------
    -- 부가서비스 배너리스트 정보 (superamin)
    --------------------------------------------------------------------
    function sf_banner_list_info(p_sch_type in varchar2,
                                 p_keyword in varchar2,
                                 p_start_num in number,
                                 p_range in number)
    return CursorType;

    --------------------------------------------------------------------
    -- 부가서비스 배너 정보 가져오기 (superamin)
    --------------------------------------------------------------------
    function sf_get_banner_File_info(p_b_seq_no in varchar2)

    return CursorType;

    --------------------------------------------------------------------
    -- 부가서비스 배너 다운로드 정보 가져오기 (superamin)
    --------------------------------------------------------------------
    function sf_get_banner_File_down(p_b_seq_no in varchar2)

    return CursorType;

    ---------------------------------------------------------------------
    --  배너 정보 수정(file X)
    ---------------------------------------------------------------------
     PROCEDURE sp_banner_upt_uploadFile(p_b_seq_no in varchar2,
                                        p_link_url in varchar2,
                                        p_banner_nm in varchar2,
                                        p_b_user_type in varchar2);

     ---------------------------------------------------------------------
     --  배너 정보 수정(file O)
     ---------------------------------------------------------------------
      PROCEDURE sp_upt_uploadFile(p_b_seq_no in varchar2,
                                  p_orgn_file_nm in varchar2,
                                  p_serv_file_nm in varchar2,
                                  p_serv_file_path in varchar2);


    ---------------------------------------------------------------------
    --  배너 목록 삭제(superadmin)
    ---------------------------------------------------------------------
    PROCEDURE sp_del_banner_info(p_b_seq_no in varchar2);

     function sf_get_banner_List(p_b_user_type in varchar2)
      return CursorType ;


    --------------------------------------------------------------------
    -- 회원 패스워드 확인
    --------------------------------------------------------------------
    FUNCTION sf_get_confirm_pwd(p_domainname in varchar2
                                      ,p_usersid in varchar2
                                      ,p_passwd in varchar2)
    RETURN number;


end PKG_FILEROOM_INFO;
/

prompt
prompt Creating package PKG_MSG_BATCH
prompt ==============================
prompt
create or replace package kebiim.PKG_MSG_BATCH is

    ---------------------------------------------------------------------
    -- 부서추가
    ---------------------------------------------------------------------
    PROCEDURE sp_dept_insert(v_org_cd      in varchar2,
                             v_prnt_org_cd in varchar2,
                             v_org_nm      in varchar2,
                             v_sort_no     in int);

    ---------------------------------------------------------------------
    -- 부서수정
    ---------------------------------------------------------------------
    PROCEDURE sp_dept_update(v_org_cd       in varchar2,
                             v_prnt_org_cd  in varchar2,
                             v_org_nm       in varchar2,
                             v_sort_no      in int);

    ---------------------------------------------------------------------
    -- 부서삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_dept_delete(v_org_cd       in varchar2);



---------------------------------------------------------------------
    -- 직원추가
    ---------------------------------------------------------------------
    PROCEDURE sp_staff_insert(v_users_id  in varchar2,
                              v_domain    in varchar2,
                              v_org_cd    in varchar2,
                              v_user_lvl  in int);


    ---------------------------------------------------------------------
    -- 직원수정
    ---------------------------------------------------------------------
    PROCEDURE sp_staff_update(v_users_id  in varchar2,
                              v_domain    in varchar2,
                              v_org_cd    in varchar2,
                              v_user_lvl  in int);

    ---------------------------------------------------------------------
    -- 직원수정
    ---------------------------------------------------------------------
    PROCEDURE sp_staff_delete(v_users_id in varchar2,
                              v_domain   in varchar2,
                              v_org_cd   in varchar2);



    ---------------------------------------------------------------------
    -- 사용자추가
    ---------------------------------------------------------------------
    PROCEDURE sp_user_insert(v_users_id      in varchar2,
                             v_domain        in varchar2,
                             v_user_nm       in varchar2,
                             v_pass          in varchar2,
                             v_lvl           in varchar2,
                             v_wire_phone    in varchar2,
                             v_mobile_phone  in varchar2,
                             v_email         in varchar2);


    ---------------------------------------------------------------------
    -- 사용자수정
    ---------------------------------------------------------------------
    PROCEDURE sp_user_update(v_users_id     in varchar2,
                             v_domain       in varchar2,
                             v_user_nm      in varchar2,
                             v_pass         in varchar2,
                             v_lvl          in varchar2,
                             v_wire_phone   in varchar2,
                             v_mobile_phone in varchar2,
                             v_email        in varchar2);

    ---------------------------------------------------------------------
    -- 사용자수정
    ---------------------------------------------------------------------
    PROCEDURE sp_user_delete(v_users_id  in varchar2,
                             v_domain    in varchar2);
    
end PKG_MSG_BATCH;
/

prompt
prompt Creating package PKG_MSG_BUDDY
prompt ==============================
prompt
create or replace package kebiim.PKG_MSG_BUDDY is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  ---------------------------------------------------------------------
  -- 버디 그룹 생성 한다.  (msg_group)
  -- TRCode :
  FUNCTION sf_ins_buddy_group(p_userid in varchar2,
                             p_domainname in varchar2,
                             p_groupname in varchar2,
                             p_isdefault in varchar2,
                             p_iseditable in varchar2) RETURN NUMBER;

  ---------------------------------------------------------------------
  -- 사용자의 버디 리스트를 가져 온다.
  -- PARAM1 : p_userid
  -- PARAM2 : p_domain
  FUNCTION sf_get_buddy_lst( p_userid in varchar2,
                             p_domainname in varchar2) RETURN CursorType;

  function sf_get_unique_buddygroupinfo(p_seq_no in number) RETURN CursorType;

  function sf_set_buddy_grp_info(p_group_idx in number,
                                  p_groupname in varchar2) RETURN NUMBER;

  function sf_del_buddy_grp_info(p_group_idx in number) RETURN NUMBER;

  function sf_get_grp_buddy_lst(p_group_idx in number) RETURN CursorType;

  function sf_delete_buddy(p_buddy_idx in number) RETURN NUMBER;

  function sf_move_buddy(p_buddy_idx in number,
                          p_group_idx in number) RETURN NUMBER;

  function sf_copy_buddy(p_userid in varchar2,
                         p_userdomain in varchar2,
                         p_buddyid in varchar2,
                         p_buddydomain in varchar2,
                         p_group_idx in number) Return CursorType;

  function sf_ins_buddy_nonauth(p_buddydomain in varchar2,
                                   p_buddyid in varchar2,
                                   p_buddy_group_idx in number) Return CursorType;

  function sf_ins_buddy_auth(p_userdomain in varchar2,
                              p_userid in varchar2,
                              p_group_idx in number,
                              p_buddydomain in varchar2,
                              p_buddyid in varchar2,
                              p_owner_nm in varchar2,
                              p_reqmsg in varchar2
                             ) return CursorType;

  function sf_ins_buddy_auth_not(p_userdomain in varchar2,
                              p_userid in varchar2,
                              p_group_idx in number,
                              p_buddydomain in varchar2,
                              p_buddyid in varchar2,
                              p_owner_nm in varchar2,
                              p_reqmsg in varchar2
                             ) return CursorType;

  procedure sp_ins_buddy_memo(p_buddy_idx in number,
                              p_buddy_memo in varchar2);

  function sf_upd_buddy_status(p_userdomain in varchar2,
                                p_userid in varchar2,
                                p_buddydomain in varchar2,
                                p_buddyid in varchar2,
								p_buddy_idx in number,
                                p_buddy_auth in number) RETURN CursorType;

  FUNCTION sf_get_buddy_All_list( p_userid in varchar2,
                                  p_domainname in varchar2)  RETURN CursorType;

  FUNCTION sf_get_block_list( p_domainname in varchar2,
                              p_userid in varchar2)  RETURN CursorType;


  function sf_get_buddy_info(p_userdomain in varchar2,
                             p_userid in varchar2,
                             p_buddydomain in varchar2,
                             p_buddyid in varchar2) return CursorType;

  function sf_get_buddy_one_info(p_userdomain in varchar2,
                                 p_userid in varchar2,
                                 p_buddydomain in varchar2,
                                 p_buddyid in varchar2) return CursorType;

   function sf_get_buddy_group_list(p_group_id in number) return CursorType;

   function sf_ins_org_buddy(p_domain in varchar2,
                             p_users_id in varchar2,
                            p_org_cd in varchar2,
                            p_org_nm in varchar2) RETURN CursorType;
end PKG_MSG_BUDDY;
/

prompt
prompt Creating package PKG_MSG_CHAT
prompt =============================
prompt
create or replace package kebiim.PKG_MSG_CHAT is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  function sf_get_domain_list RETURN CursorType;

  function sf_get_domain_list2(p_domainname in varchar2) RETURN CursorType;

  function sf_get_channel_list(p_domainname in varchar2) RETURN CursorType;

  function sf_get_channel_list2(p_domainname in varchar2,
                                p_channelname in varchar2) RETURN CursorType;

  function sf_ins_domain(p_domainname in varchar2) RETURN CursorType;

  function sf_ins_channel(p_domainname in varchar2,
                          p_channelname in varchar2,
                          p_max_channel in number,
                          p_max_user in number)  RETURN CursorType;

  function sf_ins_channel_old(p_domainname in varchar2,
                          p_channelname in varchar2,
                          p_max_channel in number,
                          p_max_user in number)  RETURN NUMBER;


  procedure sp_ins_channel(p_domainname in varchar2,
                          p_channelname in varchar2,
                          p_max_channel in number,
                          p_max_user in number) ;
end PKG_MSG_CHAT;
/

prompt
prompt Creating package PKG_MSG_DIALOGUE
prompt =================================
prompt
create or replace package kebiim.PKG_MSG_DIALOGUE is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  function sf_save_dialogue(p_sessionid in varchar2,
                            p_send_id in varchar2,
                            p_send_domain in varchar2,
                            p_recv_id in varchar2,
                            p_recv_domain in varchar2,
                            p_recv_user_nm in varchar2) return cursorType;

  function sf_get_dialouge(p_user_id in varchar2,
                           p_domain in varchar2,
                           p_cur_pg in number,
                           p_row_cnt in number) return cursorType;

end PKG_MSG_DIALOGUE;
/

prompt
prompt Creating package PKG_MSG_JOIN
prompt =============================
prompt
create or replace package kebiim.PKG_MSG_JOIN is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;


  procedure sp_ins_user_master(p_users_id in varchar2,
                                 p_domain in varchar2,
                                 p_passwd in varchar2,
                                 p_user_nm in varchar2,
                                 p_rsn_no in varchar2,
                                 p_user_type in varchar2,
                                 p_mobile_phone in varchar2,
                                 p_password_qst in varchar2,
                                 p_password_asw in varchar2,
                                 p_sms_qt in varchar2,
                                 p_user_lvl in varchar2,
                                 p_valid_yn in varchar2);




  PROCEDURE sp_ins_default_info(p_users_id in varchar2,
                                  p_domain in varchar2,
                                  p_dispalyname in varchar2);

   ---------------------------------------------------------------------
    -- 도메인을 신청한다.
    procedure sp_ins_domain(p_domain in varchar2,
                            p_domaintype in varchar2,
                            p_domaniservicestatus in varchar2);

    --------------------------------------------------------------------
    -- 고객 회원가입 여부
    --------------------------------------------------------------------
    FUNCTION sf_get_nm_rsn_by_users(p_domainname in varchar2,
                                       p_rsn_no in varchar2,
                                       p_user_nm in varchar2)
    RETURN varchar2;

    --------------------------------------------------------------------
    -- 고객 회원가입 여부(ID - 이름 - 주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_id_nm_rsn_by_users(p_domainname in varchar2,
                                       p_users_id in varchar2,
                                       p_rsn_no in varchar2,
                                       p_user_nm in varchar2)
    RETURN varchar2;

    --------------------------------------------------------------------
    -- 패스워드 찾기(ID - PASSWORD - 이름 - 주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_pwd_rsn_by_users(p_rsn_no in varchar2,
                                     p_users_id in varchar2,
                                     p_user_nm in varchar2)
    RETURN varchar2;

    --------------------------------------------------------------------
    -- 패스워드 찾기(ID - PASSWORD - 이름 - 주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_pwd_by_users(  p_rsn_no in varchar2,
                                       p_users_id in varchar2)
    RETURN varchar2;

    --------------------------------------------------------------------
    -- PASSWROD 찾기 (이름 - 주민번호 - PASSWORD - ID)
    --------------------------------------------------------------------
    /*FUNCTION sf_get_pwd_rsn_by_users(  p_rsn_no in varchar2,
                                       p_users_id in varchar2,
                                       p_user_nm in varchar2)
    RETURN CursorType;*/

    --------------------------------------------------------------------
    -- 패스워드 찾기(도메인 - 본인확인질문 - 본인확인답변)
    --------------------------------------------------------------------
    FUNCTION sf_get_pwd_sear_by_users(p_domainname in varchar2,
                                      p_password_qst in varchar2,
                                      p_password_asw in varchar2,
                                      p_users_id in varchar2)
    RETURN varchar2;

    --------------------------------------------------------------------
    -- 패스워드 변경(패스워드 찾기)
    --------------------------------------------------------------------
    procedure sp_upd_passwd_change(p_passwd in varchar2,
                                   p_users_id in varchar2,
                                   p_domain in varchar2);

    --------------------------------------------------------------------
    -- 패스워드 변경
    --------------------------------------------------------------------
    PROCEDURE sp_upd_pwd_change(p_passwd in varchar2,
                                p_users_id in varchar2,
                                p_user_lvl in varchar2,
                                p_user_type in varchar2);


    --------------------------------------------------------------------
    -- 사용자 정보 가져오기 (주민등록번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_rsn_type_by_users(p_domainname in varchar2,
                                      p_users_id in varchar2)
    RETURN CursorType;


    --------------------------------------------------------------------
    -- 사용자 정보 가져오기 (아이디 - 사용자이름)
    --------------------------------------------------------------------
    FUNCTION sf_get_ep_nm_rsn_by_users(p_domainname in varchar2,
                                      p_rsn_no in varchar2)
    RETURN CursorType;


    --------------------------------------------------------------------
    -- 사용자 정보 가져오기 (핸드폰번호 - 비밀번호 - 사용자이름)
    --------------------------------------------------------------------
    FUNCTION sf_get_nm_phone_by_users(p_domainname in varchar2,
                                      p_users_id in varchar2)
    RETURN CursorType;


    --------------------------------------------------------------------
    -- 전화번호 변경(회원정보 수정)
    --------------------------------------------------------------------
    procedure sp_upd_mobile_change(p_mobile_phone in varchar2,
                                   p_users_id in varchar2,
                                   p_domain in varchar2,
                                   p_password_qst in varchar2,
                                   p_password_asw in varchar2);

    --------------------------------------------------------------------
    -- PASSWROD 찾기 (도메인 - 아이디 - PASSWORD)
    --------------------------------------------------------------------
    FUNCTION sf_get_passwd_by_users(  p_domain in varchar2,
                                      p_users_id in varchar2,
                                      p_passwd in varchar2)
    RETURN varchar2;

    --------------------------------------------------------------------
    -- 아이디 중복 여부
    --------------------------------------------------------------------
    FUNCTION sf_get_id_by_users(p_domainname in varchar2
                                ,p_usersid in varchar2)
    RETURN number;

    --------------------------------------------------------------------
    -- 회원가입 여부 (주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_rsn_by_users(p_domainname in varchar2
                                ,p_rsnno in varchar2)     RETURN number;

  --------------------------------------------------------------------
    --  준회원 정회원으로  승격
    --------------------------------------------------------------------
    FUNCTION sf_get_by_rsnno(  p_rsn_no in varchar2,
                               p_flag in varchar2)
    RETURN number;

    ---------------------------------------------------------------------
    -- 암호입력실패 count 초기화
    ---------------------------------------------------------------------

    PROCEDURE sp_udt_count(p_users_id in varchar2,
                           p_domain in varchar2);



   end PKG_MSG_JOIN;
/

prompt
prompt Creating package PKG_MSG_LOGIN
prompt ==============================
prompt
create or replace package kebiim.pkg_msg_login is

  TYPE CursorType IS REF CURSOR;
  type LoginRec is record
    (
     users_id msg_user_master.users_id%type,
     domain msg_user_master.domain%type,
     displayname msg_user_info.domain%type,
     --server_ip msg_user_info.server_ip%type,
     --server_port msg_user_info.server_port%type,
     usercurrentstatus msg_user_info.usercurrentstatus%type,
     user_nm msg_user_master.user_nm%type,
     jumin_no msg_user_master.rsn_no%type,
     mobile_phone msg_user_master.mobile_phone%type
    );


  type LoginInfoArray is varray(1) of LoginRec;

  not_found EXCEPTION;

  FUNCTION sf_login(p_userid in varchar2 ,
                       p_domain in varchar2,
                       p_serverIP in varchar2,
                       p_serverPort in varchar2,
                       p_user_local_ip in varchar2 ,
                       p_user_local_port in varchar2,
                       p_client_type in varchar2,
                       p_passwd in varchar2,
                       p_is_sso in varchar2,
                       p_user_type in out varchar2) return CursorType;

  function sf_pwdfailcount_inc(p_userid in varchar2 ,
                                p_domain in varchar2) return number;

  function sf_get_psnl_cust_info(p_userid in varchar2,
                                 p_domain in varchar2,
                                 p_note_term in varchar2,
                                 p_attch_file_size in varchar2) return CursorType;

  function sf_get_comp_cust_info(p_userid in varchar2,
                                 p_domain in varchar2,
                                 p_note_term in varchar2,
                                 p_attch_file_size in varchar2) return CursorType;

  function sf_get_staff_emp_info(p_userid in varchar2,
                               p_domain in varchar2,
                               p_note_term in varchar2,
                               p_attch_file_size in varchar2) return CursorType;

  FUNCTION sf_get_LoginPasswd(p_userid in varchar2 ,
                               p_domainname in varchar2,
                               p_serverIP in varchar2,
                               p_serverPort in varchar2,
                               p_user_local_ip in varchar2 ,
                               p_user_local_port in varchar2,
                               p_client_type in varchar2
                               ) RETURN varchar2;


  procedure sp_ins_lgn_hstr(p_userid in varchar2 ,
                             p_domainname in varchar2,
                             p_user_local_ip in varchar2,
                             p_user_type in varchar2,
                             p_gubun in varchar2);

  function sf_get_user_menu_id(p_domainname in varchar2) RETURN CursorType;

  function sf_get_users_inf(p_domainname in varchar2,
                            p_users_id in varchar2) RETURN CursorType;

  function sf_get_frbd_word(p_domain in varchar2) Return CursorType;

  function sf_get_user_info_rsn_no(p_rsn_nos in varchar2) return CursorType;
end pkg_msg_login;
/

prompt
prompt Creating package PKG_MSG_MESSAGE
prompt ================================
prompt
create or replace package kebiim.PKG_MSG_MESSAGE is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

    --쪽지보기
    function sf_get_serverflag_count(p_domainname in varchar2,
                                    p_userid in varchar2) RETURN NUMBER;



    function sf_ins_msg_noteinfo(p_snd_domain in varchar2,
                                p_snd_users_id in varchar2,
                                p_snd_users_nm in varchar2,
                                p_notefont in varchar2,
                                p_secu_time in number,
                                p_groupid in varchar2,
                                p_msgtype in varchar2,
                                p_file_yn in varchar2,
                                p_msggroup in varchar2,
                                p_bgimage in varchar2,
                                p_client_msg_idx in varchar2) RETURN CursorType;

    function sf_del_msg_noteinfo(p_note_idx in number,
                                p_send_users_id in varchar2,
                                p_send_domain in varchar2,
                                p_recv_users_id in varchar2,
                                p_recv_domain in varchar2) RETURN NUMBER;

    procedure sp_ins_msg_note_recv(p_note_idx in number,
                                   p_recv_users_id in varchar2,
                                   p_recv_domain in varchar2,
                                   p_recv_confirm_yn in varchar2,
                                   p_recv_flag in varchar2);

    procedure sp_ins_msg_note_recv_by_rsnno(p_note_idx in number,
                                           p_rsn_no in varchar2,
                                           p_recv_confirm_yn in varchar2,
                                           p_recv_flag in varchar2);


    function sp_ins_noteAppendFile_inf(p_filename in varchar2,
                                       p_filePhysicalName in varchar2,
                                       p_filePath in varchar2,
                                       p_filesize in varchar2,
                                       p_fileip in varchar2,
                                       p_fileport in varchar2,
                                       p_file_del_dt in number
                                       ) RETURN NUMBER ;

    procedure sp_ins_msg_noteinfo_file_inf(p_note_idx in number ,
                                  p_file_idx in number);

    ---------------------------------------------------------------------
    -- 쪽지에  수신자별 파일정보를  select한후 쪽지 읽음으로 바꿈
    -- PARAM1 : p_domainname (도메인네임)
    -- PARAM2 : p_userid (사용자 이름)
    ---------------------------------------------------------------------
    procedure sf_set_information_hit(p_note_recv_idxes in varchar2);

    function sf_get_note_list(p_domainname in varchar2,
                                  p_userid in varchar2) RETURN CursorType;

    function sf_get_file_info(p_note_idx in number) return CursorType;


    function sf_get_del_note_file_info(p_serverip in varchar2, p_serverport in varchar2) return CursorType;

    function sf_get_del_note_file_info2 return CursorType;

    procedure sp_batch_del_memo;

end PKG_MSG_MESSAGE;
/

prompt
prompt Creating package PKG_MSG_SERVER_INFO
prompt ====================================
prompt
create or replace package kebiim.PKG_MSG_SERVER_INFO is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  procedure sp_upd_server_status(p_kind in varchar2,
                                 p_serverip in varchar2,
                                 p_port in varchar2,
							     p_status in char);

  procedure sp_upd_server_down(p_serverip in varchar2,
                               p_port in varchar2,
							   p_status in number);


end PKG_MSG_SERVER_INFO;
/

prompt
prompt Creating package PKG_MSG_STATUS
prompt ===============================
prompt
create or replace package kebiim.PKG_MSG_STATUS is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  function sf_get_watcher_list_non_auth
           (p_domainname in varchar2, p_userid in varchar2)
  RETURN CursorType;

  function sf_get_watcher_list_auth(p_domainname in varchar2,
                               p_userid in varchar2) RETURN CursorType;


  function sf_get_watcher_list_all(p_domain in varchar2,
                                  p_users_id in varchar2) return CursorType;

  function sf_upd_displyanme(p_domainname in varchar2,
                           p_userid in varchar2,
                           p_displayname in varchar2) RETURN NUMBER;

  procedure sp_set_user_status_inf(p_domainname in varchar2,
                                p_userid in varchar2,
                                p_userstats in varchar2
                              );

  procedure sp_set_user_status_inf2(p_domainname in varchar2,
                                p_userid in varchar2,
                                p_userstats in varchar2,
                                p_server_ip in varchar2,
                                p_server_port in varchar2
                                );

  function sf_get_bsn_dept_staff(p_org_cd in varchar2) return CursorType;


end PKG_MSG_STATUS;
/

prompt
prompt Creating package PKG_MSG_WEB_NOTE
prompt =================================
prompt
create or replace package kebiim.PKG_MSG_WEB_NOTE is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  function sf_get_note_list_all(p_domainname in varchar2,
                            p_userid in varchar2,
                            p_start_dt in varchar2,
                            p_end_dt in varchar2,
                            p_msg_flag in varchar2,
                            p_snd_rcv_flag in varchar2,
                            p_keyword in varchar2,
                            p_cur_pg in number,
                            p_row_cnt in number) RETURN CursorType;

  function sf_get_note_list_non_read(p_domainname in varchar2,
                                      p_userid in varchar2,
                                      p_cur_pg in number,
                                      p_row_cnt in number) RETURN CursorType;

  function sf_get_file_info(p_note_idx in number) return CursorType;

  procedure sf_set_information_hit(p_note_recv_idxes in varchar2);
end PKG_MSG_WEB_NOTE;
/

prompt
prompt Creating package PKG_SEARCH
prompt ===========================
prompt
create or replace package kebiim.PKG_SEARCH is

  TYPE CursorType IS REF CURSOR;
  function sf_get_sch(p_user_id in varchar2,
                      p_domain in varchar2,
                      p_usr_tp in varchar2,
                      p_org_code in varchar2,
                      p_sch_type in varchar2,
                      p_keyword in varchar2,
                      p_start_num in number,
                      p_range in number) return CursorType;

  function sf_get_cust_sch(p_sch_type in varchar2,
                          p_keyword in varchar2,
                          p_start_num in number,
                          p_range in number) return CursorType;


  function sf_get_emp_sch_by_name(p_org_code in varchar2,
                                  p_keyword in varchar2,
                                  p_start_num in number,
                                  p_range in number) return CursorType;

  function sf_get_emp_sch_by_id(p_org_code in varchar2,
                                  p_keyword in varchar2,
                                  p_start_num in number,
                                  p_range in number) return CursorType;

  /*function sf_get_emp_sch(p_org_code in varchar2,
                          p_sch_type in varchar2,
                          p_keyword in varchar2,
                          p_start_num in number,
                          p_range in number) return CursorType;*/
end PKG_SEARCH;
/

prompt
prompt Creating package PKG_STAFF_ORG_INFO
prompt ===================================
prompt
create or replace package kebiim.PKG_STAFF_ORG_INFO is

  TYPE CursorType IS REF CURSOR;
  not_found EXCEPTION;

  function sf_get_org_list(p_org_cd in varchar2,
                          p_cur_lev in number) return CursorType;

  function sf_get_org_list_all return cursorType;

  function sf_get_emp_info(p_domain in varchar2,
                           p_users_id in varchar2,
                           p_org_cd in varchar2) return CursorType;

  function sf_get_org_emp_list(p_org_cd in varchar2) return CursorType;


end PKG_STAFF_ORG_INFO;
/

prompt
prompt Creating type LISTITEMTYPE
prompt ==========================
prompt
create or replace type kebiim.ListItemType AS TABLE OF varchar2(32767)
/

prompt
prompt Creating function IN_LIST
prompt =========================
prompt
create or replace function kebiim.IN_LIST(p_str IN NVARCHAR2) Return ListItemType AS
v_str LONG DEFAULT p_str || ',';
v_data ListItemType := ListItemType();
v_n number;
BEGIN
	LOOP EXIT WHEN v_str IS NULL;
		v_n := INSTR(v_str, ',');
		v_data.extend;
		v_data(v_data.count) := LTRIM(RTRIM(SUBSTR(v_str, 1, v_n-1)));
		v_str := SUBSTR(v_str, v_n+1);
	END LOOP;
	RETURN v_data;
END;
/

prompt
prompt Creating function SF_GET_USER_NM
prompt ================================
prompt
CREATE OR REPLACE FUNCTION KEBIIM.SF_GET_USER_NM(p_domainname in varchar2, p_userid in varchar2) RETURN VARCHAR2 IS
/******************************************************************************
   NAME:       SF_GET_USER_NM
   PURPOSE:    사용자의 이름을 가져온다

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2007-11-28          1. Created this function.
******************************************************************************/
v_result msg_user_master.user_nm%type;  --varchar2(100);
BEGIN
   BEGIN
      SELECT
             a.user_nm into v_result
        FROM msg_user_master a
       where a.users_id = p_userid
         AND a.domain   = p_domainname;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       v_result := '';
   END;
   RETURN v_result;


END sf_get_user_nm;
/

prompt
prompt Creating procedure SP_BACKUP_NOTE
prompt =================================
prompt
create or replace procedure kebiim.SP_BACKUP_NOTE is
c_i number;
c_x number;
v_sql varchar2(300);
v_cur_dt varchar2(10);
v_tbl_suffix varchar2(20);
type idx_cur_type is ref cursor;
idx_cur idx_cur_type;

v_file_idx msg_noteinfo_file.file_idx%type;
v_note_idx msg_noteinfo_file.note_idx%type;

v_note_idxs varchar2(12000) := '';
v_file_idxs varchar2(12000) := '';

v_batch_cd varchar2(4) := '0001';
v_batch_pk number := 0;
v_err_code number;
v_err_msg varchar2(4000);
begin

  v_batch_pk := pkg_batch_log.sf_start_batch(v_batch_cd);
  --v_batch_pk := 22;
  select to_char(sysdate, 'yyyymmdd') into v_cur_dt from dual;
  v_tbl_suffix := substr(v_cur_dt, 3, 4);
  if substr(v_cur_dt, 7) = '10' then
    --create msg_noteinfo_yymm
    begin
      c_i := DBMS_SQL.OPEN_CURSOR;
      v_sql := 'create table msg_noteinfo_'||v_tbl_suffix || ' as ' ||
              ' select * from msg_noteinfo where 0 = 1';
      DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
      c_x := DBMS_SQL.EXECUTE( c_i );
      DBMS_SQL.close_cursor(c_i);
    exception when others then
    dbms_output.put_line('[warn] msg_noteinfo_'||to_char(sysdate, 'yymm')|| ' aleady exist.');
    end;

    --create msg_note_recvers_yymm
    begin
      c_i := DBMS_SQL.OPEN_CURSOR;
      v_sql := 'create table msg_note_recvers_'||v_tbl_suffix || ' as ' ||
              ' select * from msg_note_recvers where 0 = 1';
      DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
      c_x := DBMS_SQL.EXECUTE( c_i );
      DBMS_SQL.close_cursor(c_i);
    exception when others then
    dbms_output.put_line('[warn] msg_note_recvers_'||to_char(sysdate, 'yymm')|| ' aleady exist.');
    end;

    --create msg_notefile_yymm
    begin
      c_i := DBMS_SQL.OPEN_CURSOR;
      v_sql := 'create table msg_notefile_'||v_tbl_suffix || ' as ' ||
              ' select * from msg_notefile where 0 = 1';
      DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
      c_x := DBMS_SQL.EXECUTE( c_i );
      DBMS_SQL.close_cursor(c_i);
    exception when others then
    dbms_output.put_line('[warn] msg_notefile_'||to_char(sysdate, 'yymm')|| ' aleady exist.');
    end;

    --create msg_noteinfo_file_yymm
    begin
      c_i := DBMS_SQL.OPEN_CURSOR;
      v_sql := 'create table msg_noteinfo_file_'||v_tbl_suffix || ' as ' ||
              ' select * from msg_noteinfo_file where 0 = 1';
      DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
      c_x := DBMS_SQL.EXECUTE( c_i );
      DBMS_SQL.close_cursor(c_i);
    exception when others then
    dbms_output.put_line('[warn] msg_noteinfo_file_'||to_char(sysdate, 'yymm')|| ' aleady exist.');
    end;
  end if;

  open idx_cur for
  select
   a.note_idx, b.file_idx
  from msg_noteinfo a, msg_noteinfo_file b
  where a.note_idx = b.note_idx
  and a.send_dt between to_date(v_cur_dt||' 000000', 'yyyymmdd hh24miss') and to_date(v_cur_dt||' 235959', 'yyyymmdd hh24miss');

  begin
    loop
     fetch idx_cur into v_note_idx, v_file_idx;
     exit when idx_cur%notfound;

       v_note_idxs :=  v_note_idx || ',' || v_note_idxs;
       v_file_idxs :=  v_file_idx || ',' || v_file_idxs;
    end loop;
    close idx_cur;

    v_note_idxs := substr(v_note_idxs, 0, length(v_note_idxs)-1);
    v_file_idxs := substr(v_file_idxs, 0, length(v_file_idxs)-1);
    dbms_output.put_line('v_note_idxs:'||v_note_idxs);
    dbms_output.put_line('v_file_idxs:'||v_file_idxs);
    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := ' insert into msg_noteinfo_'||v_tbl_suffix ||
             ' select * from msg_noteinfo where note_idx in (SELECT * FROM table (SELECT cast(IN_LIST('||chr(39)||v_note_idxs||chr(39)||') as listitemtype) FROM dual))';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);

    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := ' insert into msg_note_recvers_'||v_tbl_suffix ||
             ' select * from msg_note_recvers where note_idx in (SELECT * FROM table (SELECT cast(IN_LIST('||chr(39)||v_note_idxs||chr(39)||') as listitemtype) FROM dual))';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);

    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := ' insert into msg_notefile_'||v_tbl_suffix ||
             ' select * from msg_notefile where file_idx in (SELECT * FROM table (SELECT cast(IN_LIST('||chr(39)||v_file_idxs||chr(39)||') as listitemtype) FROM dual))';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);

    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := ' insert into msg_noteinfo_file_'||v_tbl_suffix ||
             ' select * from msg_noteinfo_file where note_idx in (SELECT * FROM table (SELECT cast(IN_LIST('||chr(39)||v_note_idxs||chr(39)||') as listitemtype) FROM dual))';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);


    pkg_batch_log.sp_end_batch(v_batch_pk, '200', 'SUCCESS');
 exception when others then
    v_err_code := sqlcode;
    v_err_msg := sqlerrm;
    pkg_batch_log.sp_end_batch(v_batch_pk, v_err_code||'', v_err_msg);
 end;

end SP_BACKUP_NOTE;
/

prompt
prompt Creating procedure SP_DATA_CLEAN
prompt ================================
prompt
create or replace procedure kebiim.SP_DATA_CLEAN is
v_batch_cd varchar2(100) := '0008';
v_batch_pk number := 0;
v_err_code number;
v_err_msg varchar2(4000);
begin
      v_batch_pk := pkg_batch_log.sf_start_batch(v_batch_cd);

      delete from msg_user_info
      where (users_id, domain) in
      (
        select users_id, domain from msg_user_info
        minus
        select users_id, domain from msg_user_master
      );

      delete from msg_buddy_group
      where (users_id, domain) in
      (
        select users_id, domain from msg_buddy_group
        minus
        select users_id, domain from msg_user_master
      );

      delete from msg_buddy_list
      where (buddy_id, buddy_domain) in
      (
        select buddy_id, buddy_domain from msg_buddy_list
        minus
        select users_id, domain from msg_user_master
      );

      delete from msg_buddy_list
      where (owner_id, owner_domain) in
      (
        select owner_id, owner_domain from msg_buddy_list
        minus
        select users_id, domain from msg_user_master
      );

      delete from msg_buddy_req_msg
      where buddy_idx in
      (
        select buddy_idx from msg_buddy_req_msg
        minus
        select buddy_idx from msg_buddy_list
      );


      delete from msg_staff_info
      where (users_id, domain) in
      (
        select users_id, domain from msg_staff_info
        minus
        select users_id, domain from msg_user_master
      );

      pkg_batch_log.sp_end_batch(v_batch_pk, '200', 'SUCCESS');
exception when others then
  v_err_code := sqlcode;
  v_err_msg := sqlerrm;
  pkg_batch_log.sp_end_batch(v_batch_pk, v_err_code||'', v_err_msg);
end SP_DATA_CLEAN;
/

prompt
prompt Creating procedure SP_INS_BATCH_LOG
prompt ===================================
prompt
create or replace procedure kebiim.SP_INS_BATCH_LOG(p_item_cd in varchar2, p_result_cd in varchar2,
                                             p_result_detail in varchar2) is
begin
  INSERT INTO msg_batch_log
  (item_cd, result_cd, result_detail)
  values
  (p_item_cd, p_result_cd, p_result_detail);
end SP_INS_BATCH_LOG;
/

prompt
prompt Creating procedure SP_LOAD_DEPT_INFO
prompt ====================================
prompt
create or replace procedure kebiim.SP_LOAD_DEPT_INFO(p_dept_file_line number) is
c_i number;
c_x number;
v_sql varchar2(300);
v_cnt number;

v_batch_cd varchar2(100) := '0002';
v_err_code number;
v_err_msg varchar2(4000);

begin
  /*insert into tb_debug
  (val) values (p_dept_file_line);*/

  select count(*) into v_cnt from temp_tb_ibk_dept_info;

  IF p_dept_file_line = v_cnt THEN
    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := 'truncate table tb_ibk_dept_info';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );

    DBMS_SQL.close_cursor(c_i);

    insert into tb_ibk_dept_info
    select decode(length(org_cd), 1, '000'||org_cd,
                              2, '00'||org_cd,
                              3, '0'||org_cd,
                              org_cd) org_cd,
           decode(length(prnt_org_cd), 1, '000'||prnt_org_cd,
                              2, '00'||prnt_org_cd,
                              3, '0'||prnt_org_cd,
                              prnt_org_cd) prnt_org_cd,
           org_nm, to_number(sort_no) from temp_tb_ibk_dept_info;

    pkg_batch_log.sp_end_batch2(v_batch_cd, '200', 'SUCCESS');
  ELSE
    pkg_batch_log.sp_end_batch2(v_batch_cd, '500', 'gcamp_dept.dat 파일과 temp_tb_ibk_dept_info 테이블의 로우수가 맞지 않습니다.');
    --dbms_output.put_line('error');
  END IF;
exception when others then
   v_err_code := sqlcode;
   v_err_msg := sqlerrm;
   pkg_batch_log.sp_end_batch2(v_batch_cd, v_err_code||'', v_err_msg);
end SP_LOAD_DEPT_INFO;
/

prompt
prompt Creating procedure SP_LOAD_EMP_INFO
prompt ===================================
prompt
create or replace procedure kebiim.SP_LOAD_EMP_INFO(p_emp_file_line number) is
c_i number;
c_x number;
v_sql varchar2(300);
v_cnt number;
--cursor user_info_cur := null;
type user_info_cur_type is ref cursor;
user_info_cur user_info_cur_type;

v_users_id tb_user_master.users_id%type;
v_domain tb_user_master.domain%type;
v_user_nm tb_user_master.user_nm%type;
v_errmsg tb_debug.val%type;

v_batch_cd varchar2(100) := '0003';
v_err_code number;
v_err_msg varchar2(4000);

cursor branch_info_cur is
select
users_id
from tb_ibk_emp_info
where branch_yn = 'N';

type users_id_type is table of tb_ibk_emp_info.users_id%type;

tp_users_id users_id_type;

begin
  select count(*) into v_cnt from temp_tb_ibk_emp_info;
  IF p_emp_file_line = v_cnt THEN

    delete from tb_user_master
    where domain = 'ibk.com';

    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := 'alter trigger trg_tb_user_master disable';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);

    begin

    insert into tb_user_master
    (users_id, domain, user_nm, rsn_no,
     passwd, user_type, mobile_phone, password_qst, password_asw,
     valid_yn, sms_qt, user_lvl)
    (
      select
       emno usesr_id, 'ibk.com' domain, emp_name user_nm, rsno rsn_no,
       substr(rsno, 7) passwd, '3' user_type, hpno mobile_phone, '' password_qst, '' password_asw,
       'Y' valid_yn, 999999 sms_qt, '1' user_lvl
      from temp_tb_ibk_emp_info
      where hoof_yn = '01'
      and abrv_posi_nm <> '현지행원'
    );
    exception when others then
      c_i := DBMS_SQL.OPEN_CURSOR;
      v_sql := 'alter trigger trg_tb_user_master enable';
      DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
      c_x := DBMS_SQL.EXECUTE( c_i );
      DBMS_SQL.close_cursor(c_i);
    end;

    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := 'alter trigger trg_tb_user_master enable';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);

    open branch_info_cur;
    fetch branch_info_cur bulk collect into tp_users_id;
    close branch_info_cur;

    c_i := DBMS_SQL.OPEN_CURSOR;
    v_sql := 'truncate table tb_ibk_emp_info';
    DBMS_SQL.PARSE( c_i, v_sql, DBMS_SQL.V7 );
    c_x := DBMS_SQL.EXECUTE( c_i );
    DBMS_SQL.close_cursor(c_i);

    insert into tb_ibk_emp_info
    (users_id, domain, org_cd, sort_no,
    abrv_posi_nm, lvl, team_nm, ducd,
    fxcnt_clcd,  posi_cd, join_ymd,
    reti_ymd, hoof_yn,
    rmk, branch_yn)
    (
      select
       emno usesr_id, 'ibk.com' domain, juris_brcd org_cd,  lst_seq sort_no,
       abrv_posi_nm, lev lvl, benm team_nm, ducd,
       fxcnt_clcd, posi_cd, enbk_ymd join_ymd,
       reti_ymd, hoof_yn, rmk, 'Y'
      from temp_tb_ibk_emp_info
      where hoof_yn = '01'
      and abrv_posi_nm <> '현지행원'
    );

    --주거래점 고객 상담 가능여부 데이터 보존.
    forall x in tp_users_id.first..tp_users_id.last
    update tb_ibk_emp_info
      set branch_yn = 'N'
    where users_id = tp_users_id(x);

    open user_info_cur for
    select
      a.users_id, a.domain, a.user_nm
    from tb_user_master a, msg_user_info b
    where a.users_id = b.users_id(+)
    and a.domain = b.domain(+)
    and b.users_id is null;

    loop
     fetch user_info_cur into v_users_id, v_domain, v_user_nm;
     exit when user_info_cur%notfound;

     insert into msg_user_info
     (users_id, domain, displayname)
     values
     (v_users_id, v_domain, v_user_nm);
    end loop;
    close user_info_cur;

    INSERT INTO msg_buddy_group
    (group_idx,
     group_name,
     isdefault,
     iseditable,
     users_id,
     domain)
     (select
        seq_msg_buddy_group.NEXTVAL,
        '기본그룹',
        'Y',
        'N',
        b.users_id,
        b.domain
      from msg_user_info b, msg_buddy_group a
      where a.users_id(+) = b.users_id
      and a.domain(+) = b.domain
      and b.users_id > ' '
      and b.domain > ' '
      and a.users_id is null
      and a.domain is null
     );


    pkg_batch_log.sp_end_batch2(v_batch_cd, '200', 'SUCCESS');

 ELSE
    pkg_batch_log.sp_end_batch2(v_batch_cd, '500', 'TMSEMPLM.dat 파일과 temp_tb_ibk_emp_info 테이블의 로우수가 맞지 않습니다.');
    --dbms_output.put_line('error');
 END IF;
exception when others then
  v_err_code := sqlcode;
  v_err_msg := sqlerrm;
  pkg_batch_log.sp_end_batch2(v_batch_cd, v_err_code||'', v_err_msg);
end SP_LOAD_EMP_INFO;
/

prompt
prompt Creating procedure SP_SET_ADMIN
prompt ===============================
prompt
create or replace procedure kebiim.sp_set_admin is
begin

  update msg_user_master set user_lvl ='3'
  where users_id in ('052352') and domain = 'ibk.com';

end sp_set_admin;
/

prompt
prompt Creating package body PKG_ADMIN_INFO
prompt ====================================
prompt
create or replace package body kebiim.PKG_ADMIN_INFO is


    --------------------------------------------------------------------
    -- 사용자 정보(개인고객,기업고객)
    --------------------------------------------------------------------
    FUNCTION sf_get_user_info(p_domainname in varchar2,
                              p_users_id in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN

         OPEN ref_csr for
               SELECT /*+index(a, ix3_tb_user_master)*/
              a.user_type,
              a.users_id,
              a.domain,
              a.user_nm,
              a.rsn_no,
              a.user_lvl,
              decode(user_lvl,'0','사용정지','1','일반회원','2','도메인관리자','3','시스템관리자') user_lvl_text,
              a.mobile_phone,
              a.password_qst,
              a.password_asw,
              b.server_ip ,
              b.server_port,
              b.usercurrentstatus,
              decode(sign(b.usercurrentstatus),'-1','off','on') usercurrentstatus_text,
              b.displayname
         FROM msg_user_info b, msg_user_master a
         WHERE a.domain = p_domainname
         AND a.users_id = p_users_id
         AND a.users_id = b.users_id
         AND a.domain = b.domain;
       RETURN ref_csr;

    END sf_get_user_info;

    --------------------------------------------------------------------
    -- 사용자 정보(직원)
    --------------------------------------------------------------------
    FUNCTION sf_get_emp_info(p_domainname in varchar2,
                              p_users_id in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN

         OPEN ref_csr for
               SELECT /*+index(a, ix3_tb_user_master)*/
              a.user_type,
              a.users_id,
              a.domain,
              a.user_nm,
              a.rsn_no,
              a.user_lvl,
              decode(user_lvl,'0','사용정지','1','일반회원','2','도메인관리자','3','시스템관리자') user_lvl_text,
              a.mobile_phone,
              b.server_ip ,
              b.server_port,
              b.usercurrentstatus,
              decode(sign(b.usercurrentstatus),'-1','off','on') usercurrentstatus_text,
              b.displayname,
              c.org_cd,
              c.team_nm,
              c.corp_teno,
              c.hm_teno
         FROM msg_user_master a, msg_user_info b, msg_staff_info c
         WHERE a.domain = p_domainname
         AND a.users_id = p_users_id
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND a.domain = c.domain
         AND a.users_id = c.users_id;
       RETURN ref_csr;

    END sf_get_emp_info;



    --------------------------------------------------------------------
    -- 호스팅 회원가입 여부
    --------------------------------------------------------------------
    FUNCTION sf_get_admin_confirm_pwd(p_domain in varchar2
                                      ,p_users_id in varchar2
                                      ,p_passwd in varchar2
                                      ,p_level in varchar2)
    RETURN number
    IS
      cnt number;
    BEGIN


               select decode(a.users_id,'',0,1)  into cnt
                      from(select users_id, domain
                           from msg_user_master
                           where domain = p_domain
                           AND users_id = p_users_id
                           AND user_lvl = p_level
                           AND passwd = p_passwd
                           )a ,
                               (select domain from msg_domain
                               where domain = p_domain
                               AND domaniservicestatus ='1') b
               where a.domain = b.domain;

        RETURN cnt;
        EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END sf_get_admin_confirm_pwd;


  --------------------------------------------------------------------
  -- 슈퍼관리자 (실시간 공지 조직명)
  --------------------------------------------------------------------
  FUNCTION sf_org_nm_list
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for
          select org_nm from msg_staff_dept_info
          group by org_nm;
       RETURN ref_csr;

  END sf_org_nm_list;

 --------------------------------------------------------------------
  -- 슈퍼관리자 (실시간 공지 부서명)
  --------------------------------------------------------------------
  FUNCTION sf_posi_nm_list
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for
         select abrv_posi_nm from msg_staff_info
         group by abrv_posi_nm;
       RETURN ref_csr;

  END sf_posi_nm_list;

  ---------------------------------------------------------------------
  -- 사용자 삭제(일반/기업/호스팅고객)
  ---------------------------------------------------------------------
    procedure sp_del_user( p_domain in varchar2, p_users_id in varchar2)
     IS
    BEGIN

         --0.bakup(delete)
        /*insert into msg_user_master_del_users
        select * from msg_user_master
        where domain = p_domain and users_id = p_users_id;*/

        --1.회원 기본 정보
        delete  from msg_user_master
        where domain = p_domain and users_id = p_users_id;

        --3.메신저 기본정보
        delete  from msg_user_info
        where domain = p_domain and users_id = p_users_id;

        --2.직원 기본 정보
        delete  from msg_staff_info
        where domain = p_domain and users_id = p_users_id;

        --4.메신저 버디 그룹
        delete  from msg_buddy_group
        where domain = p_domain and users_id = p_users_id;

        --5.메신저 버디 요청 메시지
        delete  from msg_buddy_req_msg
        where buddy_idx in  (select buddy_idx from msg_buddy_list where owner_domain = p_domain and owner_id=p_users_id);

        --6.메신저 버디 리스트
        delete  from msg_buddy_list
        where owner_domain = p_domain and owner_id=p_users_id;

        --7.파일방 - 디렉토리
        delete  from msg_fileroom_dir
        where domain = p_domain and users_id = p_users_id;

        --8.파일방 -  파일
        delete  from msg_fileroom_file
        where domain = p_domain and users_id = p_users_id;

        --9.파일방 -  권한
        delete  from msg_fileroom_psn_share
        where domain = p_domain and users_id = p_users_id;

        --10.파일방 - 권한 친구 목록 삭제
        delete  from msg_fileroom_psn_share
        where domain = p_domain and users_id = p_users_id;

        --11.파일방 -  권한
        delete  from msg_fileroom_psn_share
        where domain = p_domain and users_id = p_users_id;

     END sp_del_user;


    ---------------------------------------------------------------------
    -- 사용자 정지 / 활성화
    ---------------------------------------------------------------------
    procedure sp_upt_users_alive_stop( p_user_lvl in varchar2, p_domain in varchar2, p_users_id in varchar2)
     IS
    BEGIN

        update  msg_user_master
        set user_lvl = p_user_lvl
        where domain = p_domain and users_id = p_users_id;


     END sp_upt_users_alive_stop;

      ---------------------------------------------------------------------
      -- 서버목록 정보를 입력한다. (superadmin)
      -- PARAM1 : p_ip
      -- PARAM2 : p_port
      -- PARAM3 : p_status
      -- PARAM4 : p_kind
      ---------------------------------------------------------------------
      PROCEDURE sp_ins_server_info(p_ip in varchar2,
                                   p_port in varchar2,
                                   p_status in varchar2,
                                   p_kind in varchar2)
      IS
      BEGIN
           INSERT INTO msg_serverlist
           (s_idx, ip, port, status, kind)
           VALUES
           ((select max(s_idx)+1 from msg_serverlist),p_ip, p_port, p_status, p_kind);
      END sp_ins_server_info;

      --------------------------------------------------------------------
      -- 서버목록 정보를 삭제한다 (superadmin)
      -- PARAM1 : p_idx
      -- PARAM2 : p_ip
      --------------------------------------------------------------------

      PROCEDURE sp_del_server_info(p_idx in int,
                                   p_ip in varchar2)
      IS
      BEGIN
           DELETE FROM msg_serverlist
           WHERE s_idx = p_idx
           AND   ip = p_ip;
      END sp_del_server_info;


      --------------------------------------------------------------------
      -- 서버목록 정보를 수정한다 (superadmin)
      -- PARAM1 : p_idx
      -- PARAM2 : p_ip
      -- PARAM3 : p_port
      -- PARAM4 : p_status
      -- PARAM5 : p_kind
      --------------------------------------------------------------------

      PROCEDURE sp_upt_server_info(p_s_idx in number,
                                   p_ip in varchar2,
                                   p_port in varchar2,
                                   p_status in varchar2,
                                   p_kind in varchar2)
      IS
      BEGIN
           UPDATE msg_serverlist set
           ip = p_ip,
           port = p_port,
           status = p_status,
           kind = p_kind
           WHERE s_idx = p_s_idx;
      END sp_upt_server_info;


      --------------------------------------------------------------------
      -- 서버목록 정보를 출력한다(superadmin)
      --------------------------------------------------------------------
      FUNCTION sf_get_server_info(p_sch_type in varchar2,
                            p_keyword in varchar2,
                            p_start_num in number,
                            p_range in number)
      RETURN CursorType
      IS
        ref_csr CursorType;
      BEGIN

          OPEN ref_csr for
           SELECT
                  s_idx, ip, port, status, kind, tot_cnt, rnum
           FROM
           (
              SELECT
                  s_idx, ip, port, status, kind, count(*) over() tot_cnt, rownum rnum
              FROM    msg_serverlist
              WHERE p_sch_type = 'ip'
              AND ip like '%'||p_keyword||'%'
              UNION ALL

              SELECT
                      s_idx, ip, port, status, kind, count(*) over() tot_cnt, rownum rnum
              FROM    msg_serverlist
              WHERE p_sch_type = 'port'
              AND port like '%'||p_keyword||'%'
              UNION ALL

              SELECT
                      s_idx, ip, port, status, kind, count(*) over() tot_cnt, rownum rnum
              FROM    msg_serverlist
              WHERE p_sch_type = 'all'

           )T
           WHERE T.rnum >= p_start_num  and rownum<=p_range order by kind;
         RETURN ref_csr;

      END sf_get_server_info;

      --------------------------------------------------------------------
      -- 채널리스트 정보를 출력한다(superadmin)
      --------------------------------------------------------------------
      FUNCTION sf_get_chnl_info(p_sch_type in varchar2,
                                p_keyword in varchar2,
                                p_start_num in number,
                                p_range in number)
      RETURN CursorType
      IS
        ref_csr CursorType;
      BEGIN

          OPEN ref_csr for
           SELECT
                  chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt, tot_cnt, rnum
           FROM
           (
              SELECT
                  chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt, count(*) over() tot_cnt, rownum rnum
              FROM    msg_chat_chnl
              WHERE p_sch_type = 'domain'
              AND domain like '%'||p_keyword||'%'
              UNION ALL

              SELECT
                      chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt, count(*) over() tot_cnt, rownum rnum
              FROM    msg_chat_chnl
              WHERE p_sch_type = 'chnl_nm'
              AND chnl_nm like '%'||p_keyword||'%'
              UNION ALL

              SELECT
                      chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt, count(*) over() tot_cnt, rownum rnum
              FROM    msg_chat_chnl
              WHERE p_sch_type = 'chnl_room_max_cnt'
              AND chnl_room_max_cnt like '%'||p_keyword||'%'
              UNION ALL

              SELECT
                      chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt, count(*) over() tot_cnt, rownum rnum
              FROM    msg_chat_chnl
              WHERE p_sch_type = 'chnl_room_user_cnt'
              AND chnl_room_user_cnt like '%'||p_keyword||'%'
              UNION ALL

              SELECT
                      chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt, count(*) over() tot_cnt, rownum rnum
              FROM    msg_chat_chnl
              WHERE p_sch_type = 'all'

           )T
           WHERE T.rnum >= p_start_num  and rownum<=p_range order by domain;
         RETURN ref_csr;

      END sf_get_chnl_info;


      ---------------------------------------------------------------------
      -- 채널 리스트 정보를 입력한다. (superadmin)
      -- PARAM1 : p_domain
      -- PARAM2 : p_chnl_nm
      -- PARAM3 : p_chnl_room_max_cnt
      -- PARAM4 : p_chnl_room_user_cnt
      ---------------------------------------------------------------------
      PROCEDURE sp_ins_chnl_info(p_domain in varchar2,
                                 p_chnl_nm in varchar2,
                                 p_chnl_room_max_cnt in varchar2,
                                 p_chnl_room_user_cnt in varchar2)
      IS
      BEGIN
           INSERT INTO msg_chat_chnl
           (chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt)
           VALUES
           ((select max(chnl_seq_no)+1 from msg_chat_chnl),p_domain, p_chnl_nm, p_chnl_room_max_cnt, p_chnl_room_user_cnt);
      END sp_ins_chnl_info;


      --------------------------------------------------------------------
      -- 채널 리스트 정보를 삭제한다 (superadmin)
      -- PARAM1 : p_chnl_seq_no
      -- PARAM2 : p_domain
      --------------------------------------------------------------------

      PROCEDURE sp_del_chnl_info(p_chnl_seq_no in number,
                                 p_domain in varchar2)
      IS
      BEGIN
           DELETE FROM msg_chat_chnl
           WHERE chnl_seq_no = p_chnl_seq_no
           AND   domain = p_domain;
      END sp_del_chnl_info;


      --------------------------------------------------------------------
      -- 채널 리스트 정보를 수정한다 (superadmin)
      -- PARAM1 : p_chnl_seq_no
      -- PARAM2 : p_domain
      -- PARAM3 : p_chnl_nm
      -- PARAM4 : p_chnl_room_max_cnt
      -- PARAM5 : p_chnl_room_user_cnt
      --------------------------------------------------------------------

      PROCEDURE sp_upt_chnl_info(p_chnl_seq_no in number,
                                 p_domain in varchar2,
                                 p_chnl_nm in varchar2,
                                 p_chnl_room_max_cnt in varchar2,
                                 p_chnl_room_user_cnt in varchar2)
      IS
      BEGIN
           UPDATE msg_chat_chnl set
           domain = p_domain,
           chnl_nm = p_chnl_nm,
           chnl_room_max_cnt = p_chnl_room_max_cnt,
           chnl_room_user_cnt = p_chnl_room_user_cnt
           WHERE chnl_seq_no= p_chnl_seq_no;
      END sp_upt_chnl_info;

      --------------------------------------------------------------------
      -- 채널 리스트 정보를 수정한다 (superadmin)-all
      -- PARAM1 : p_chnl_seq_no
      -- PARAM2 : p_domain
      -- PARAM3 : p_chnl_nm
      -- PARAM4 : p_chnl_room_max_cnt
      -- PARAM5 : p_chnl_room_user_cnt
      --------------------------------------------------------------------

      PROCEDURE sp_upt_chnl_info_all(p_chnl_seq_no in number,
                                 p_chnl_room_max_cnt in varchar2,
                                 p_chnl_room_user_cnt in varchar2,
                                 p_ch in varchar2)
      IS
      BEGIN
           UPDATE msg_chat_chnl set
           chnl_room_max_cnt = p_chnl_room_max_cnt,
           chnl_room_user_cnt = p_chnl_room_user_cnt
           WHERE decode(p_ch, 'on','0', chnl_seq_no)=  decode(p_ch,'on' , '0', p_chnl_seq_no );
      END sp_upt_chnl_info_all;

      ---------------------------------------------------------------------
      -- 채널 리스트 정보 가져오기 (superadmin)
      -- PARAM1 : p_chnl_seq_no
      ---------------------------------------------------------------------
      FUNCTION sf_get_chat_by_update(p_chnl_seq_no in number)
      RETURN CursorType
      IS
        ref_csr CursorType;
      BEGIN

           OPEN ref_csr for
              select chnl_seq_no, domain, chnl_nm, chnl_room_max_cnt, chnl_room_user_cnt from msg_chat_chnl
              where chnl_seq_no = p_chnl_seq_no;
              RETURN ref_csr;
      END sf_get_chat_by_update;

      ---------------------------------------------------------------------
      -- 서버 정보 가져오기 (superadmin)
      -- PARAM1 : p_s_idx
      ---------------------------------------------------------------------
      FUNCTION sf_get_server_by_update(p_s_idx in number)
      RETURN CursorType
      IS
        ref_csr CursorType;
      BEGIN

           OPEN ref_csr for
              select s_idx,ip,port,status,kind from msg_serverlist
              where s_idx = p_s_idx;
              RETURN ref_csr;
      END sf_get_server_by_update;

      --------------------------------------------------------------------
      -- 사용자 정보 (superamin)
      --------------------------------------------------------------------
      function sf_all_user_info(p_sch_type in varchar2,
                                p_keyword in varchar2,
                                p_start_num in number,
                                p_range in number,
                                p_userType in varchar2,
                                p_domain in varchar2)
      return CursorType
      is
        ref_csr CursorType;
      begin
       open ref_csr for
       select
            user_type, rnum, users_id||'@'||domain users_id, user_nm, mobile_phone
            ,decode(sign(usercurrentstatus),'-1','off','on')usercurrentstatus ,tot_cnt ,
             decode(user_lvl,'0','사용정지','1','일반회원','2','도메인관리자','3','시스템관리자') user_lvl_text,
             user_lvl, valid_yn
       from
       (
         SELECT
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, b.usercurrentstatus, count(*) over() tot_cnt, rownum rnum
             ,a.user_lvl, a.valid_yn
         FROM  msg_user_info b, msg_user_master a
         WHERE p_userType = '1'
         AND user_type = '1'
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND decode(p_sch_type,'all','all', 'user_nm', user_nm , 'users_id', a.users_id, 'rsn_no', a.rsn_no) like decode(p_keyword,'','all', p_keyword||'%')
        UNION ALL
         SELECT
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, b.usercurrentstatus, count(*) over() tot_cnt, rownum rnum
             ,a.user_lvl, a.valid_yn
         FROM  msg_user_info b ,msg_user_master a
         WHERE p_userType = '2'
         AND user_type = '2'
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND decode(p_sch_type,'all','all', 'user_nm', user_nm , 'users_id', a.users_id, 'rsn_no', a.rsn_no) like decode(p_keyword,'','all', p_keyword||'%')
        UNION ALL
         SELECT
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, b.usercurrentstatus, count(*) over() tot_cnt, rownum rnum
             ,a.user_lvl, a.valid_yn
         FROM  msg_user_info b ,msg_user_master a
         WHERE p_userType = '4'
         AND user_type = '4'
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND decode(p_sch_type,'all','all', 'user_nm', user_nm , 'users_id', a.users_id, 'rsn_no', a.rsn_no) like decode(p_keyword,'','all', p_keyword||'%')
         AND decode(p_domain,'','all', a.domain) like decode(p_domain,'','all', p_domain||'%')
        UNION ALL
         SELECT
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, b.usercurrentstatus, count(*) over() tot_cnt, rownum rnum
             ,a.user_lvl, a.valid_yn
         FROM  msg_user_info b ,msg_user_master a
         WHERE p_userType = '3'
         AND user_type = '3'
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND decode(p_sch_type,'all','all', 'user_nm', user_nm , 'users_id', a.users_id, 'rsn_no', a.rsn_no) like decode(p_keyword,'','all', p_keyword||'%')
        UNION ALL
         SELECT
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, b.usercurrentstatus, count(*) over() tot_cnt, rownum rnum
             ,a.user_lvl, a.valid_yn
         FROM  msg_user_info b ,msg_user_master a
         WHERE p_userType = 'all'
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND decode(p_sch_type,'all','all', 'user_nm', a.user_nm , 'users_id', a.users_id, 'rsn_no', a.rsn_no) like decode(p_keyword,'','all', p_keyword||'%')


       )T
       WHERE T.rnum >= p_start_num  and rownum<=p_range;
       return ref_csr;

  end sf_all_user_info;


    ---------------------------------------------------------------------
    -- 사용자정보 수정(superadmin 관리자) - 개인,기업고객
    ---------------------------------------------------------------------
    procedure sp_upt_user_by_admin( p_domain in varchar2,
                                p_users_id in varchar2,
                                p_mobile_phone in varchar2,
                                p_user_lvl in varchar2)
     IS
    BEGIN

         UPDATE msg_user_master
         SET mobile_phone = p_mobile_phone,
         user_lvl = p_user_lvl
         WHERE domain = p_domain
         AND users_id = p_users_id;
   END sp_upt_user_by_admin;


    ---------------------------------------------------------------------
    -- 회원 탈퇴
    ---------------------------------------------------------------------
    PROCEDURE sp_del_user_info(p_users_id in varchar2,
                               p_passwd in varchar2,
                               p_user_nm in varchar2,
                               p_rsn_no in varchar2,
                               p_domain in varchar2)
    IS
    BEGIN
         DELETE
               msg_user_master
         WHERE
               users_id = p_users_id
           AND passwd = p_passwd
           AND user_nm = p_user_nm
           AND rsn_no = p_rsn_no
           AND domain = p_domain;
    END sp_del_user_info;

    ---------------------------------------------------------------------
    -- 회원 탈퇴전 비교
    ---------------------------------------------------------------------
    FUNCTION sp_get_del_user_info(p_users_id in varchar2,
                                   p_passwd in varchar2,
                                   p_user_nm in varchar2,
                                   p_rsn_no in varchar2,
                                   p_domain in varchar2)
    RETURN varchar2
    IS
      user_type varchar2(50);
    BEGIN
         SELECT 'abcd' into user_type
         FROM msg_user_master
         WHERE users_id = p_users_id
           AND passwd = p_passwd
           AND user_nm = p_user_nm
           AND rsn_no = p_rsn_no
           AND domain = p_domain;
         RETURN user_type;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_user_type';
    END sp_get_del_user_info;

    -----------------------------------------------------------------
    -- 회원정보수정 (준회원->정회원)
    -----------------------------------------------------------------

    procedure sp_upt_valid_by_user( p_rsn_no in varchar2)
     IS
    BEGIN

         UPDATE msg_user_master
         SET valid_yn = 'Y'
         WHERE user_type = '1'
         AND rsn_no = p_rsn_no;
   END sp_upt_valid_by_user;

    --------------------------------------------------------------------
    -- 사용자 정보(개인고객,기업고객)-직원전용
    --------------------------------------------------------------------
    FUNCTION sf_user_info(p_rsn_no in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN

         OPEN ref_csr for
               SELECT /*+index(a, ix3_tb_user_master)*/
              a.user_type,
              a.users_id,
              a.domain,
              a.user_nm,
              a.rsn_no,
              a.user_lvl,
              decode(user_lvl,'0','사용정지','1','일반회원','2','도메인관리자','3','시스템관리자') user_lvl_text,
              a.mobile_phone,
              a.password_qst,
              a.password_asw,
              decode(valid_yn,'Y','정회원','준회원') valid_yn_text ,
              a.sms_qt,
              b.server_ip ,
              b.server_port,
              b.usercurrentstatus,
              decode(sign(b.usercurrentstatus),'-1','off','on') usercurrentstatus_text,
              b.displayname
         FROM msg_user_info b, msg_user_master a
         WHERE a.rsn_no = p_rsn_no
         AND a.users_id = b.users_id
         AND a.domain = b.domain;
       RETURN ref_csr;

    END sf_user_info;

    --------------------------------------------------------------------
    -- 사용자 정보(직원)
    --------------------------------------------------------------------
    FUNCTION sf_emp_info(p_domainname in varchar2,
                              p_users_id in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN

         OPEN ref_csr for
               SELECT /*+index(a, ix3_tb_user_master)*/
              a.user_type,
              a.users_id,
              a.domain,
              a.user_nm,
              a.rsn_no,
              a.user_lvl,
              decode(user_lvl,'0','사용정지','1','일반회원','2','도메인관리자','3','시스템관리자') user_lvl_text,
              a.mobile_phone,
              b.server_ip ,
              b.server_port,
              b.usercurrentstatus,
              decode(sign(b.usercurrentstatus),'-1','off','on') usercurrentstatus_text,
              b.displayname,
              c.org_cd,
              c.team_nm,
              c.corp_teno,
              c.hm_teno
         FROM msg_user_master a, msg_user_info b, msg_staff_info c
         WHERE a.domain = p_domainname
         AND a.users_id = p_users_id
         AND a.users_id = b.users_id
         AND a.domain = b.domain
         AND a.domain = c.domain
         AND a.users_id = c.users_id;
       RETURN ref_csr;

    END sf_emp_info;

    function sf_get_sysnotify_user_list(p_gubun in varchar2,
                          p_buso in varchar2,
                          p_gikwi in varchar2,
                          p_domainonly in varchar2) return CursorType is
  ref_csr CursorType;
  begin
       open ref_csr for

       ----------------1.직원 (0)----------------------------------------------------
      select users_id || '@' || domain  as users_id      -- 직원 (전체)
       from msg_user_master
       where p_gubun = '0'
       and p_buso = '0'
       and p_gikwi = '0'
       and user_type ='3'

     UNION ALL
       select users_id || '@' || domain   as users_id    -- 직원 (조건)
        from msg_staff_info
        where  p_gubun = '0'
        and abrv_posi_nm in (SELECT * FROM table (SELECT cast(in_list(p_gikwi) as listitemtype) FROM dual ) X)
        and org_cd in (SELECT * FROM table (SELECT cast(in_list(p_buso) as listitemtype) FROM dual ) X)

    ----------------2.고객  (1)----------------------------------------------------
     UNION ALL
       select users_id || '@' || domain  as users_id    -- 고객 (개인)
       from msg_user_master
       where  p_gubun = '1'
       and     p_buso = '1'
       and  user_type ='1'

     UNION ALL
       select users_id || '@' || domain  as users_id    -- 고객 (기업)
       from msg_user_master
       where p_gubun = '1'
       and    p_buso = '2'
       and  user_type ='2'

     UNION ALL
       select users_id || '@' || domain  as users_id    -- 고객 (개인, 기업)
       from msg_user_master
       where p_gubun = '1'
       and    p_buso = '3'
       and  user_type in ('1','2')

     ----------------3.호스팅 고객 (2)----------------------------------------------------
     UNION ALL
       select users_id || '@' || domain  as users_id    -- 호스팅 고객 (전체)
       from msg_user_master
       where p_gubun = '2'
       and     p_buso = '0'
       and p_domainonly = '0'
       and user_type ='4'

     UNION ALL
       select users_id || '@' || domain  as users_id   -- 호스팅 고객 (전체 - 관리자)
       from msg_user_master
       where p_gubun = '2'
       and     p_buso = '0'
       and p_domainonly = '1'
       and user_type ='4' and user_lvl ='2'

     UNION ALL
       select users_id || '@' || domain  as users_id    -- 호스팅 고객 (선별)
       from msg_user_master
       where p_gubun = '2'
       and domain in (SELECT * FROM table (SELECT cast(in_list(p_buso) as listitemtype) FROM dual ) X)
       and p_domainonly = '0'
       and user_type ='4'

     UNION ALL
       select users_id || '@' || domain  as users_id   -- 호스팅 고객 (선별 - 관리자 )
       from msg_user_master
       where p_gubun = '2'
       and domain in (SELECT * FROM table (SELECT cast(in_list(p_buso) as listitemtype) FROM dual ) X)
       and p_domainonly = '1'
       and user_type ='4' and user_lvl ='2';

       return ref_csr;
  end sf_get_sysnotify_user_list;

end PKG_ADMIN_INFO;
/

prompt
prompt Creating package body PKG_BATCH_LOG
prompt ===================================
prompt
create or replace package body kebiim.PKG_BATCH_LOG is


   function sf_start_batch(p_item_cd in varchar2) return number is
   v_seq_no number;
   begin
        INSERT INTO msg_batch_log
        (seq_no, item_cd, start_time)
        VALUES
        (seq_msg_batch_log.nextval, p_item_cd, sysdate)
        RETURNING seq_no into v_seq_no;
        RETURN v_seq_no;
   end sf_start_batch;


   procedure sp_start_batch(p_item_cd in varchar2) is
   v_seq_no number;
   begin
        INSERT INTO msg_batch_log
        (seq_no, item_cd, start_time)
        VALUES
        (seq_msg_batch_log.nextval, p_item_cd, sysdate);
   end sp_start_batch;

   procedure sp_end_batch(p_seq_no in number,
                          p_result_cd in varchar2,
                          p_result_detail in varchar2) is
   begin

        UPDATE msg_batch_log SET
           result_cd = p_result_cd,
           result_detail = p_result_detail,
           end_time = sysdate
        WHERE seq_no = p_seq_no;
   end sp_end_batch;

   procedure sp_end_batch2(p_item_cd in varchar2,
                          p_result_cd in varchar2,
                          p_result_detail in varchar2) is
   begin

       UPDATE msg_batch_log SET
           result_cd = p_result_cd,
           result_detail = p_result_detail,
           end_time = sysdate
        WHERE seq_no =
        (
           select /*+index_desc(msg_batch_log, pk_msg_batch_log)*/
              seq_no
           from msg_batch_log
           where item_cd = p_item_cd and rownum <= 1
        );
   end sp_end_batch2;

end PKG_BATCH_LOG;
/

prompt
prompt Creating package body PKG_FILEROOM_INFO
prompt =======================================
prompt
create or replace package body kebiim.PKG_FILEROOM_INFO is

    ---------------------------------------------------------------------
    --  폴더 생성
    ---------------------------------------------------------------------
    FUNCTION sf_ins_fileroom_dir(p_userid in varchar2,
                               p_domainname in varchar2,
                               p_dirname in varchar2)
     RETURN NUMBER
     IS
      v_index msg_fileroom_dir.dir_seq_no%TYPE;
     BEGIN
          INSERT INTO msg_fileroom_dir
          (dir_seq_no,
           dir_nm,
           users_id,
           domain)
           VALUES
           (seq_msg_fileroom_dir.NEXTVAL,
            p_dirname,
            p_userid,
            p_domainname
           )
           RETURNING dir_seq_no INTO v_index;
           RETURN v_index;

     END sf_ins_fileroom_dir;


    ---------------------------------------------------------------------
    --  파일 생성
    ---------------------------------------------------------------------
    FUNCTION sf_ins_file(p_dirseqno in number,
                         p_userid in varchar2,
                         p_domainname in varchar2,
                         p_orgfilenm in varchar2,
                         p_servfilenm in varchar2,
                         p_servfilepath in varchar2,
                         p_filesize in number)
     RETURN NUMBER
     IS
      v_index msg_fileroom_file.f_seq_no%TYPE;
     BEGIN
           INSERT INTO msg_fileroom_file
          (f_seq_no,
           dir_seq_no,
           users_id,
           domain ,
           orgn_file_nm,
           serv_file_nm,
           serv_file_path,
           file_size
           )
           VALUES
           (seq_msg_fileroom_file.NEXTVAL,
            p_dirseqno,
            p_userid,
            p_domainname,
            p_orgfilenm,
            p_servfilenm,
            p_servfilepath,
            p_filesize
           )
           RETURNING f_seq_no INTO v_index;
           RETURN v_index;

     END sf_ins_file;

    ---------------------------------------------------------------------
    --  권한  생성
    ---------------------------------------------------------------------
     PROCEDURE sp_ins_fileroom_share(p_userid in varchar2,
                                    p_domainname in varchar2,
                                    p_seqno in varchar2,
                                    p_pmsn in varchar2)
     IS
     BEGIN
          INSERT INTO msg_fileroom_psn_share
          (dir_seq_no,
           users_id,
           domain,
           pmsn)
          VALUES
           (p_seqno,
           p_userid,
           p_domainname,
           p_pmsn
           );

    END sp_ins_fileroom_share;


    ---------------------------------------------------------------------
    --  권한 수정
    ---------------------------------------------------------------------
     PROCEDURE sp_upd_fileroom_share(p_userid in varchar2,
                                    p_domainname in varchar2,
                                    p_seqno in varchar2,
                                    p_pmsn in varchar2)
     IS
    BEGIN
          UPDATE msg_fileroom_psn_share
          SET pmsn = p_pmsn
          WHERE dir_seq_no = p_seqno
          AND domain = p_domainname
          AND users_id = p_userid;

     END sp_upd_fileroom_share;

    ---------------------------------------------------------------------
    --  권한 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_share(p_userid in varchar2,
                                    p_domainname in varchar2,
                                    p_seqno in varchar2)
    IS
    BEGIN
          DELETE msg_fileroom_psn_share
          WHERE dir_seq_no = p_seqno
          AND domain = p_domainname
          AND users_id = p_userid;

    END sp_del_fileroom_share;

    ---------------------------------------------------------------------
    --  폴더 수정
    ---------------------------------------------------------------------
    procedure sp_update_fileroom_dir(p_dirseqno in varchar2 ,
                                    p_dirname in varchar2
                                    )
     IS
    BEGIN
          UPDATE msg_fileroom_dir
          SET dir_nm = p_dirname
          WHERE dir_seq_no = p_dirseqno ;

     END sp_update_fileroom_dir;


    ---------------------------------------------------------------------
    --  폴더 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_dir(p_dirseqno in varchar2)
    IS
    BEGIN
          DELETE msg_fileroom_dir
          WHERE dir_seq_no = p_dirseqno ;

          DELETE msg_fileroom_psn_share
          WHERE dir_seq_no = p_dirseqno;

    END sp_del_fileroom_dir;


   ---------------------------------------------------------------------
    --  파일 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_file(p_dirseqno in varchar2,
                                   p_fseqno in varchar2)
    IS
    BEGIN
          DELETE msg_fileroom_file
          WHERE dir_seq_no = p_dirseqno
          and f_seq_no = p_fseqno ;

    END sp_del_fileroom_file;

    ---------------------------------------------------------------------
    --  권한 삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_del_fileroom_psn_share(p_dirseqno in varchar2,
                                  p_userid in varchar2,
                                  p_domainname in varchar2)
    IS
    BEGIN
          DELETE msg_fileroom_dir
          WHERE dir_seq_no = p_dirseqno
          AND users_id = p_userid
          AND domain = p_domainname ;

    END sp_del_fileroom_psn_share;

 ---------------------------------------------------------------------
  -- 사용자의 버디 그룹과 리스트를 가져 온다.(전부 가져온다)
  -- PARAM1 : p_userid
  -- PARAM2 : p_domain
  FUNCTION sf_get_buddy_All_list(p_userid in varchar2,
                                 p_domainname in varchar2)
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for

            SELECT
              decode(b.group_name, '기본그룹', 1,
                       decode(b.isdefault, 'N', 2)) as  sortingnum,
              b.users_id,  b.domain, b.group_idx, b.group_name,
              b.iseditable, b.isdefault, a.buddy_idx,
              a.buddy_id, a.buddy_domain, a.isblocked,
              a.buddymemo, a.buddy_status, c.displayname,
              decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus) usercurrentstatus,
              c.server_ip, c.server_port,
              d.user_nm buddyname,
              decode(a.buddy_idx, null, '2', '1') flag,
              e.msg req_msg, e.req_usr_nm, d.user_type, d.mobile_phone
            FROM msg_buddy_list a, msg_buddy_group b, msg_user_info c,
                 msg_user_master d, msg_buddy_req_msg e
            WHERE b.users_id=  p_userid
            AND b.domain = p_domainname
            AND b.group_idx = a.group_idx(+)
            AND a.buddy_id = c.users_id(+)
            AND a.buddy_domain = c.domain(+)
            AND a.buddy_id = d.users_id(+)
            AND a.buddy_domain= d.domain(+)
            AND a.buddy_idx = e.buddy_idx(+)
            ORDER BY sortingnum, group_name, displayname;
       /*
       SELECT
            decode(b.group_name, '친구들', 1,
                     decode(b.isdefault, '0', 2))as  sortingnum,
            b.users_id users_id,
            b.domain,
            b.group_idx,
            b.group_name,
            b.iseditable,
            b.isdefault,
            a.buddy_idx,
            a.buddy_id,
            a.buddy_domain,
            a.isblocked,
            a.buddymemo,
            a.buddy_status,
            c.displayname,
            c.usercurrentstatus,
            c.server_ip,
            c.server_port,
            d.user_nm buddyname,
            decode(a.buddy_idx, null, '2', '1') flag,
            e.msg req_msg,
            e.req_usr_nm
          FROM msg_buddy_list a, msg_buddy_group b, msg_user_info c, tb_user_master d, msg_buddy_req_msg e
          WHERE b.users_id=  p_userid
          AND b.domain = p_domainname
          AND a.group_idx(+) = b.group_idx
          AND a.buddy_id = c.users_id(+)
          AND a.buddy_domain = c.domain(+)
          AND a.buddy_id = d.users_id(+)
          AND a.buddy_domain= d.domain(+)
          AND a.buddy_idx = e.buddy_idx(+)
          AND a.buddy_domain= p_domainname  --추가 (정책) -- 직원은 직원끼리, 고객은 고객끼리.
          AND d.user_type != '0'   --사용자 레벨 (0:사용정지)
          ORDER BY sortingnum, group_name, displayname;
          */

       RETURN ref_csr;
  END sf_get_buddy_All_list;


  --------------------------------------------------------------------
  -- 삭제할 파일 정보를 가져온다.
  --------------------------------------------------------------------
  FUNCTION sf_get_del_fileInfo(p_dirseqno in varchar2,
                               p_fseqno in varchar2)
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for

          SELECT serv_file_path , serv_file_nm
          FROM msg_fileroom_file
          WHERE dir_seq_no = p_dirseqno
          and f_seq_no = p_fseqno ;

          /*DELETE msg_fileroom_file
          WHERE dir_seq_no = p_dirseqno
          and f_seq_no = p_fseqno ;
          commit;
          */
       RETURN ref_csr;

  END sf_get_del_fileInfo;
  --------------------------------------------------------------------
  -- 파일방 , 목록을 가져 온다.
   --------------------------------------------------------------------
  FUNCTION sf_get_fileinfo(p_userid in varchar2,
                           p_domainname in varchar2)
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for

         SELECT /*+index(a, IX2_MSG_FILEROOM_DIR)*/ a.dir_seq_no
                  , dir_nm
                  , decode(f_seq_no ,  '' , 0 , f_seq_no) f_seq_no
                  , orgn_file_nm
                  , serv_file_nm
                  , serv_file_path
                  , file_size
                  , reg_dt
          FROM msg_fileroom_dir a, msg_fileroom_file b
          WHERE a.users_id = p_userid and a.domain = p_domainname
          AND a.dir_seq_no = b.dir_seq_no(+)
          /*나중에 반드시 없앨것.....test용  */
          order by  a.dir_seq_no ,b.f_seq_no asc ;
       RETURN ref_csr;
  END sf_get_fileinfo;


  --------------------------------------------------------------------
  -- 폴더별 권한 목록을 가져 온다.
   --------------------------------------------------------------------
  FUNCTION sf_get_fileroom_share(p_dirseqno in number)
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for

          SELECT users_id , domain , pmsn ,sf_get_user_nm(domain , users_id) AS owner_name
          FROM msg_fileroom_psn_share
          WHERE dir_seq_no = p_dirseqno;
       RETURN ref_csr;

  END sf_get_fileroom_share;

  --------------------------------------------------------------------
  -- 친구 파일방 , 목록을 가져 온다.
   --------------------------------------------------------------------
  FUNCTION sf_get_friends_fileinfo(p_userid in varchar2,
                           p_domainname in varchar2)
  RETURN CursorType
  IS
    ref_csr CursorType;
  BEGIN

       OPEN ref_csr for

         SELECT
                    AA.dir_seq_no  dir_seq_no
                  , AA.dir_nm as dir_nm
                  , AA.f_seq_no AS f_seq_no
                  , AA.orgn_file_nm AS orgn_file_nm
                  , AA.serv_file_nm  AS serv_file_nm
                  , AA.serv_file_path AS serv_file_path
                  , AA.file_size AS file_size
                  , AA.reg_dt AS reg_dt
                  , AA.users_id AS users_id
                  , AA.domain AS domain
                  , BB.pmsn AS pmsn
                  , sf_get_user_nm(AA.domain , AA.users_id) AS owner_name
          FROM
                   (SELECT /*+index(a, IX2_MSG_FILEROOM_DIR)*/
                  a.dir_seq_no
                  , dir_nm
                  , decode(f_seq_no ,  '' , 0 , f_seq_no) f_seq_no
                  , orgn_file_nm
                  , serv_file_nm
                  , serv_file_path
                  , file_size
                  , reg_dt
                  , a.users_id
                  , a.domain
                  FROM msg_fileroom_dir a, msg_fileroom_file b
                  WHERE a.dir_seq_no = b.dir_seq_no(+) ) AA ,
                       (
                        SELECT dir_seq_no, pmsn
                        FROM  msg_fileroom_psn_share
                        WHERE users_id = p_userid  and domain = p_domainname) BB
          WHERE AA.dir_seq_no = BB.dir_seq_no
           /*나중에 반드시 없앨것.....test용  */
          order by  dir_seq_no, f_seq_no asc ;


       RETURN ref_csr;
  END sf_get_friends_fileinfo;

  --------------------------------------------------------------------
  -- 도메인별 파일사이즈 용량을 가져온다.
   --------------------------------------------------------------------
  FUNCTION sf_get_fileSize(p_domainname in varchar2)
  RETURN number
  IS
    file_kb_size number;
  BEGIN

       SELECT fileroom_size into file_kb_size from msg_domain
         where domain = p_domainname;
       RETURN file_kb_size;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;

  END sf_get_fileSize;

  ---------------------------------------------------------------------
  --  파일 생성 ( superadmin)
  ---------------------------------------------------------------------
  FUNCTION sf_banner_ins_uploadFile(p_orgn_file_nm in varchar2,
                              p_serv_file_nm in varchar2,
                              p_serv_file_path in varchar2,
                              p_file_size in number,
                              p_link_url in varchar2,
                              p_banner_nm in varchar2,
                              p_b_user_type in varchar2)
   RETURN NUMBER
   IS
    v_index msg_banner_info.b_seq_no%TYPE;
   BEGIN
         INSERT INTO msg_banner_info
        (b_seq_no,
         orgn_file_nm,
         serv_file_nm,
         serv_file_path,
         file_size,
         link_url,
         banner_nm,
         b_user_type
         )
         VALUES
         (seq_msg_banner_info.NEXTVAL,
          p_orgn_file_nm,
          p_serv_file_nm,
          p_serv_file_path,
          p_file_size,
          p_link_url,
          p_banner_nm,
          p_b_user_type
         )
         RETURNING b_seq_no INTO v_index;
         RETURN v_index;

   END sf_banner_ins_uploadFile;


      --------------------------------------------------------------------
      -- 부가서비스 배너리스트 정보 (superamin)
      --------------------------------------------------------------------
      function sf_banner_list_info(p_sch_type in varchar2,
                                   p_keyword in varchar2,
                                   p_start_num in number,
                                   p_range in number)
      return CursorType
      is
        ref_csr CursorType;
      begin
       open ref_csr for
       select
            orgn_file_nm, serv_file_nm, serv_file_path, file_size, link_url
            ,reg_dt ,tot_cnt , rnum, banner_nm, b_user_type
       from
       (
         SELECT /*+index(a, ix3_tb_user_master)*/
              orgn_file_nm, serv_file_nm, serv_file_path, file_size, link_url, reg_dt,
              count(*) over() tot_cnt, b_seq_no rnum, banner_nm, b_user_type
         FROM msg_banner_info
         WHERE p_sch_type = 'orgn_file_nm'
         AND orgn_file_nm like p_keyword||'%'
         UNION ALL
         SELECT /*+index(a, ix4_tb_user_master)*/
             orgn_file_nm, serv_file_nm, serv_file_path, file_size, link_url, reg_dt,
              count(*) over() tot_cnt, b_seq_no rnum, banner_nm, b_user_type
         FROM msg_banner_info
         WHERE p_sch_type = 'link_url'
         AND link_url like p_keyword||'%'
         UNION ALL
         SELECT /*+index(a, ix3_tb_user_master)*/
             orgn_file_nm, serv_file_nm, serv_file_path, file_size, link_url, reg_dt,
              count(*) over() tot_cnt, b_seq_no rnum, banner_nm, b_user_type
         FROM msg_banner_info
         WHERE p_sch_type = 'reg_dt'
         AND reg_dt like p_keyword||'%'
         UNION ALL
         SELECT /*+index(a, ix3_tb_user_master)*/
              orgn_file_nm, serv_file_nm, serv_file_path, file_size, link_url, reg_dt,
              count(*) over() tot_cnt, b_seq_no rnum, banner_nm, b_user_type
         FROM msg_banner_info
         WHERE p_sch_type = 'banner_nm'
         AND banner_nm like p_keyword||'%'
        UNION ALL
         SELECT /*+index(a, ix3_tb_user_master)*/
             orgn_file_nm, serv_file_nm, serv_file_path, file_size, link_url, reg_dt,
              count(*) over() tot_cnt, b_seq_no rnum, banner_nm, b_user_type
         FROM msg_banner_info
         WHERE p_sch_type = 'all'

       )T
       WHERE T.rnum >= p_start_num  and rownum<=p_range;
       return ref_csr;

  end sf_banner_list_info;

  --------------------------------------------------------------------
  -- 부가서비스 배너 정보 가져오기 (superamin)
  --------------------------------------------------------------------
  function sf_get_banner_File_info(p_b_seq_no in varchar2)
      return CursorType
      is
        ref_csr CursorType;
      begin
        open ref_csr for
         SELECT b_seq_no, orgn_file_nm, banner_nm, link_url, b_user_type
         from msg_banner_info
         where b_seq_no = p_b_seq_no;
         RETURN ref_csr;

  END sf_get_banner_File_info;

  --------------------------------------------------------------------
  -- 부가서비스 배너 다운로드 정보 가져오기 (superamin)
  --------------------------------------------------------------------
  function sf_get_banner_file_down(p_b_seq_no in varchar2)
      return CursorType
      is
        ref_csr CursorType;
      begin
        open ref_csr for
         SELECT b_seq_no, orgn_file_nm, banner_nm, link_url, b_user_type, serv_file_nm, serv_file_path
         from msg_banner_info
         where b_seq_no = p_b_seq_no;

         RETURN ref_csr;

  END sf_get_banner_file_down;

  ---------------------------------------------------------------------
  --  배너 정보 수정(file X)-superadmin
  ---------------------------------------------------------------------
   PROCEDURE sp_banner_upt_uploadFile(p_b_seq_no in varchar2,
                                      p_link_url in varchar2,
                                      p_banner_nm in varchar2,
                                      p_b_user_type in varchar2)
   IS
   BEGIN
        UPDATE msg_banner_info
        SET link_url = p_link_url, banner_nm = p_banner_nm, b_user_type = p_b_user_type
        WHERE b_seq_no = p_b_seq_no;

   END sp_banner_upt_uploadFile;

   ---------------------------------------------------------------------
   --  배너 정보 수정(file O)-superadmin
   ---------------------------------------------------------------------
    PROCEDURE sp_upt_uploadFile(p_b_seq_no in varchar2,
                                p_orgn_file_nm in varchar2,
                                p_serv_file_nm in varchar2,
                                p_serv_file_path in varchar2)
    IS
    BEGIN
         UPDATE msg_banner_info
         SET orgn_file_nm = p_orgn_file_nm, serv_file_nm = p_serv_file_nm, serv_file_path = p_serv_file_path
         WHERE b_seq_no = p_b_seq_no;

    END sp_upt_uploadFile;

    ---------------------------------------------------------------------
    --  배너 목록 삭제(superadmin)
    ---------------------------------------------------------------------
    PROCEDURE sp_del_banner_info(p_b_seq_no in varchar2)
    IS
    BEGIN
          DELETE msg_banner_info
          WHERE b_seq_no = p_b_seq_no;

    END sp_del_banner_info;

 function sf_get_banner_List(p_b_user_type in varchar2)
      return CursorType
      is
        ref_csr CursorType;
      begin
        open ref_csr for
         SELECT b_seq_no, orgn_file_nm, banner_nm, link_url, b_user_type ,serv_file_nm
         from msg_banner_info
         where b_user_type = p_b_user_type;
         RETURN ref_csr;

  END sf_get_banner_List;

      --------------------------------------------------------------------
    -- 회원 패스워드 확인
    --------------------------------------------------------------------
    FUNCTION sf_get_confirm_pwd(p_domainname in varchar2
                                      ,p_usersid in varchar2
                                      ,p_passwd in varchar2)
    RETURN number
    IS
      cnt number;
    BEGIN


               select decode(a.users_id,'',0,1)  into cnt
                      from(select users_id, domain
                           from msg_user_master
                           where domain = p_domainname
                           AND users_id = p_usersid
                           AND passwd = p_passwd
                           )a ,
                               (select domain from msg_domain
                               where domain = p_domainname
                               AND domaniservicestatus ='1') b
               where a.domain = b.domain;

        RETURN cnt;
        EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END sf_get_confirm_pwd;



end PKG_FILEROOM_INFO;
/

prompt
prompt Creating package body PKG_MSG_BATCH
prompt ===================================
prompt
create or replace package body kebiim.PKG_MSG_BATCH is


    ---------------------------------------------------------------------
    -- 부서추가
    ---------------------------------------------------------------------
    PROCEDURE sp_dept_insert(v_org_cd      in varchar2,
                             v_prnt_org_cd in varchar2,
                             v_org_nm      in varchar2,
                             v_sort_no     in int) is
    BEGIN

        INSERT INTO MSG_STAFF_DEPT_INFO (ORG_CD,PRNT_ORG_CD,ORG_NM,SORT_NO)
	           VALUES(v_org_cd, -- ORG_CD,
	                  v_prnt_org_cd, -- PRNT_ORG_CD
	                  v_org_nm, -- ORG_NM
	                  v_sort_no -- SORT_NO
	                  );
              
    END sp_dept_insert;


    ---------------------------------------------------------------------
    -- 부서수정
    ---------------------------------------------------------------------
    PROCEDURE sp_dept_update(v_org_cd       in varchar2,
                             v_prnt_org_cd  in varchar2,
                             v_org_nm       in varchar2,
                             v_sort_no      in int) is
    BEGIN

        UPDATE MSG_STAFF_DEPT_INFO
		       SET PRNT_ORG_CD = v_prnt_org_cd,
		           ORG_NM = v_org_nm,
		           SORT_NO = v_sort_no
	       WHERE ORG_CD = v_org_cd;	              
  
    END sp_dept_update;


    ---------------------------------------------------------------------
    -- 부서삭제
    ---------------------------------------------------------------------
    PROCEDURE sp_dept_delete(v_org_cd      in  varchar2) is
    BEGIN

        DELETE FROM MSG_STAFF_DEPT_INFO
         WHERE ORG_CD = v_org_cd;

    END sp_dept_delete;


    ---------------------------------------------------------------------
    -- 직원추가
    ---------------------------------------------------------------------
    PROCEDURE sp_staff_insert(v_users_id  in varchar2,
                              v_domain    in varchar2,
                              v_org_cd    in varchar2,
                              v_user_lvl  in int) is
    BEGIN

        INSERT INTO MSG_STAFF_INFO (USERS_ID,DOMAIN,ORG_CD,SORT_NO,ABRV_POSI_NM,LVL,
                                    CORP_TENO,HM_TENO,FAX_NO,TEAM_NM,DUCD,POSI_CD,
                                    JOIN_YMD,RMK,FILLER1)
        VALUES(v_users_id, -- USERS_ID
               v_domain, -- DOMAIN
               v_org_cd, -- ORG_CD
               0, -- SORT_NO
               '', -- ABRV_POSI_NM
               v_user_lvl, -- LVL
               '', -- CORP_TENO
               '', -- HM_TENO
               '', -- FAX_NO
               '', -- TEAM_NM
               '', -- DUCD
               '', -- POSI_CD
               '', -- JOIN_YMD
               '', -- RMK
               '' -- FILLER1
               );
              
    END sp_staff_insert;


    ---------------------------------------------------------------------
    -- 직원수정
    ---------------------------------------------------------------------
    PROCEDURE sp_staff_update(v_users_id  in varchar2,
                              v_domain    in varchar2,
                              v_org_cd    in varchar2,
                              v_user_lvl  in int) is
    BEGIN

        UPDATE MSG_STAFF_INFO
		       SET LVL = v_user_lvl
         WHERE USERS_ID = v_users_id
           AND DOMAIN = v_domain
           AND ORG_CD = v_org_cd;
  
    END sp_staff_update;

    ---------------------------------------------------------------------
    -- 직원수정
    ---------------------------------------------------------------------
    PROCEDURE sp_staff_delete(v_users_id in varchar2,
                              v_domain   in varchar2,
                              v_org_cd   in varchar2) is
    BEGIN

        DELETE FROM MSG_STAFF_INFO
	       WHERE USERS_ID = v_users_id
           AND DOMAIN = v_domain
           AND ORG_CD = v_org_cd;
    END;




    ---------------------------------------------------------------------
    -- 사용자추가
    ---------------------------------------------------------------------
    PROCEDURE sp_user_insert(v_users_id      in varchar2,
                             v_domain        in varchar2,
                             v_user_nm       in varchar2,
                             v_pass          in varchar2,
                             v_lvl           in varchar2,
                             v_wire_phone    in varchar2,
                             v_mobile_phone  in varchar2,
                             v_email         in varchar2) is
    BEGIN
        INSERT INTO MSG_USER_MASTER(USERS_ID,DOMAIN,USER_NM,RSN_NO,PASSWD,
	                                  USER_TYPE,MOBILE_PHONE,PASSWORD_QST,PASSWORD_ASW,VALID_YN,SMS_QT,USER_LVL,
	                                  FILLER1,FILLER2,FILLER3,FILLER4,FILLER5)
        VALUES(v_users_id, -- USERS_ID,
	             v_domain, -- DOMAIN
	             v_user_nm, -- USER_NM
	             null, -- RSN_NO
	             v_pass, -- PASSWD
	             '3', -- USER_TYPE
	             v_mobile_phone, -- MOBILE_PHONE
	             null, -- PASSWORD_QST
	             null, -- PASSWORD_ASW
	             'N', -- VALID_YN
	             30, -- SMS_QT
	             v_lvl, -- USER_LVL
	             null, -- FILLER1
	             v_email, -- FILLER2
	             v_wire_phone, -- FILLER3
	             null, -- FILLER4
	             null -- FILLER5
	              );
              
        INSERT INTO MSG_USER_INFO(USERS_ID,DOMAIN,DISPLAYNAME,USERCURRENTSTATUS,
	                                USER_LOCAL_IP,USER_LOCAL_PORT,SERVER_IP,SERVER_PORT,CLIENT_TYPE,
	                                PWDFAIL_COUNT,OLD_USER_LVL)
        VALUES(v_users_id, 
  		         v_domain, -- DOMAIN
		       	   v_users_id,  -- DISPLAYNAME
		      	   '-1', -- USERCURRENTSTATUS
		      	   null, -- USER_LOCAL_IP
		      	   null, -- USER_LOCAL_PORT
		      	   null, -- SERVER_IP
		      	   null, -- SERVER_PORT
		      	   null, -- CLIENT_TYPE
		      	   0, -- PWDFAIL_COUNT
		      	   null -- OLD_USER_LVL
               );

        INSERT INTO MSG_BUDDY_GROUP(GROUP_IDX,GROUP_NAME,ISEDITABLE,ISDEFAULT,USERS_ID,DOMAIN,ETC)
	      VALUES(SEQ_MSG_BUDDY_GROUP.nextval,
               '기본그룹', -- group_name
	             'N', -- iseditable
	             'Y', -- isdefault
	             v_users_id, -- users_id
	             v_domain, -- DOMAIN
	             null -- etc
	             );

    END sp_user_insert;


    ---------------------------------------------------------------------
    -- 사용자수정
    ---------------------------------------------------------------------
    PROCEDURE sp_user_update(v_users_id     in varchar2,
                             v_domain       in varchar2,
                             v_user_nm      in varchar2,
                             v_pass         in varchar2,
                             v_lvl          in varchar2,
                             v_wire_phone   in varchar2,
                             v_mobile_phone in varchar2,
                             v_email        in varchar2) is
    BEGIN

        UPDATE MSG_USER_MASTER
    		   SET USER_NM = v_user_nm,
    		   	   PASSWD = v_pass,
    		   	   USER_LVL = v_lvl,
    		       MOBILE_PHONE = v_mobile_phone,              
    		       FILLER2 = v_email,
    		       FILLER3 = v_wire_phone
    	     WHERE USERS_ID = v_users_id
    	       AND DOMAIN = v_domain;	              
  
    END sp_user_update;

    ---------------------------------------------------------------------
    -- 사용자수정
    ---------------------------------------------------------------------
    PROCEDURE sp_user_delete(v_users_id  in varchar2,
                             v_domain    in varchar2) is
    BEGIN

        DELETE FROM MSG_USER_MASTER
    	   WHERE USERS_ID = v_users_id
    	     AND DOMAIN = v_domain;
                  
        DELETE FROM MSG_USER_INFO
    	   WHERE USERS_ID = v_users_id
    	     AND DOMAIN = v_domain;
    
        DELETE FROM MSG_BUDDY_GROUP
    	   WHERE USERS_ID = v_users_id
           AND DOMAIN = v_domain;
    	      
        DELETE FROM MSG_BUDDY_LIST
         WHERE OWNER_ID = v_users_id
    	     AND OWNER_DOMAIN = v_domain;

    END sp_user_delete;



end PKG_MSG_BATCH;
/

prompt
prompt Creating package body PKG_MSG_BUDDY
prompt ===================================
prompt
create or replace package body kebiim.PKG_MSG_BUDDY is

    ---------------------------------------------------------------------
    -- 버디 그룹 생성 한다.  (msg_group)
    -- TRCode :
    FUNCTION sf_ins_buddy_group(p_userid in varchar2,
                               p_domainname in varchar2,
                               p_groupname in varchar2,
                               p_isdefault in varchar2,
                               p_iseditable in varchar2)
     RETURN NUMBER
     IS
      v_index msg_buddy_group.group_idx%TYPE;
	  v_default varchar2(10);
	  v_edit varchar2(10);
     BEGIN
	 if p_isdefault = '0' then
	     v_default := 'N';
	 elsif p_isdefault = '1' then
	     v_default := 'Y';
     else
	     v_default := p_isdefault;
	 end if;

	 if p_iseditable = '0' then
	     v_edit := 'N';
	 elsif p_iseditable = '1' then
	     v_edit := 'Y';
     else
	     v_edit := p_iseditable;
	 end if;

          INSERT INTO msg_buddy_group
          (group_idx,
           group_name,
           isdefault,
           iseditable,
           users_id,
           domain)
           VALUES
           (seq_msg_buddy_group.NEXTVAL,
            p_groupname,
            v_default,
            v_edit,
            p_userid,
            p_domainname)
           RETURNING group_idx INTO v_index;
           RETURN v_index;

     END sf_ins_buddy_group;

    ---------------------------------------------------------------------
    -- 사용자의 버디 리스트를 가져 온다.
    -- PARAM1 : p_userid
    -- PARAM2 : p_domain
    FUNCTION sf_get_buddy_lst( p_userid in varchar2,
                               p_domainname in varchar2)
    RETURN CursorType
    IS
     ref_csr CursorType;
    BEGIN
         OPEN ref_csr for
          SELECT
            buddy_idx,
            group_idx,
            buddy_id,
            buddy_domain,
            isblocked,
            buddymemo,
            buddy_status
          FROM  msg_buddy_list
          WHERE owner_domain = p_domainname
          AND owner_id = p_userid;
         RETURN ref_csr;
    END  sf_get_buddy_lst;


    function sf_get_unique_buddygroupinfo(p_seq_no in number) RETURN CursorType IS
    ref_csr CursorType;
    BEGIN
       OPEN ref_csr FOR
            SELECT
             users_id,
             domain,
             group_name
            FROM msg_buddy_group
            WHERE group_idx = p_seq_no;
       RETURN ref_csr;
    END sf_get_unique_buddygroupinfo;


  ---------------------------------------------------------------------
  -- 사용자의 버디 그룹 정보를 변경 한다
  -- 3-000-3-1-03
  -- PARAM1 : p_group_index (그룹인덱스)
  -- PARAM2 : p_groupname (그룹이름)
  ---------------------------------------------------------------------
  function sf_set_buddy_grp_info(p_group_idx in number,
                                  p_groupname in varchar2) RETURN NUMBER IS
  BEGIN
    UPDATE msg_buddy_group SET
        group_name = p_groupname
    WHERE group_idx = p_group_idx;
    RETURN sql%rowcount;
  END sf_set_buddy_grp_info;

  ---------------------------------------------------------------------
  -- 사용자의 버디 그룹을 삭제 한다.
  --3-000-3-1-04
  -- PARAM1 : p_group_index (인덱스)
  ---------------------------------------------------------------------
  function sf_del_buddy_grp_info(p_group_idx in number) RETURN NUMBER IS
  BEGIN
         DELETE FROM msg_buddy_group WHERE group_idx = p_group_idx;
         RETURN sql%rowcount;
  END sf_del_buddy_grp_info;

  ---------------------------------------------------------------------
  -- 특정 버디그룹의 정보를 가지고 온다.
  --2-000-2-3-32
  -- PARAM1 : p_group_index (그룹인덱스)
  ---------------------------------------------------------------------
  /*function sf_get_grp_buddy_lst(p_group_idx in number) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
       select users_id,
              domain,
              group_name
         from msg_buddy_group
        where group_idx = p_group_idx;
        RETURN ref_csr;
  END sf_get_grp_buddy_lst;*/


  function sf_get_grp_buddy_lst(p_group_idx in number) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
       select buddy_id,
              buddy_domain
         from msg_buddy_list
        where group_idx = p_group_idx;
        RETURN ref_csr;
  END sf_get_grp_buddy_lst;

  ---------------------------------------------------------------------
  -- 특정 사용자의 특정 버디를 삭제한다.
  -- 3-000-3-1-07
  ---------------------------------------------------------------------
  function sf_delete_buddy(p_buddy_idx in number) RETURN NUMBER IS
  BEGIN
         DELETE FROM msg_buddy_list where buddy_idx = p_buddy_idx;
       RETURN sql%rowcount;
  END sf_delete_buddy;

  ---------------------------------------------------------------------
  -- 특정 사용자의 특정 버디를 이동한다.
  -- 3-000-3-1-08
  ---------------------------------------------------------------------
   function sf_move_buddy(p_buddy_idx in number,
                          p_group_idx in number) RETURN NUMBER IS

   BEGIN
        UPDATE msg_buddy_list SET
             group_idx = p_group_idx
        WHERE buddy_idx = p_buddy_idx;
        RETURN sql%rowcount;
   END sf_move_buddy;


  ---------------------------------------------------------------------
  -- 버디를 특정 그룹에 복사한다.
  ---------------------------------------------------------------------
  function sf_copy_buddy(p_userid in varchar2,
                         p_userdomain in varchar2,
                         p_buddyid in varchar2,
                         p_buddydomain in varchar2,
                         p_group_idx in number) Return CursorType IS
  ref_csr CursorType;
  v_index number;
  BEGIN

  select SEQ_MSG_BUDDY_LIST.nextval
   into v_index
   from dual;

    INSERT INTO msg_buddy_list
    (buddy_idx,
    group_idx,
    owner_id,
    owner_domain,
    buddy_id,
    buddy_domain,
    buddy_status,
    isblocked)
	select v_index ,
	      p_group_idx,
	      users_id,
	      domain ,
	      p_buddyid,
	      p_buddydomain,
	      (select distinct buddy_status
			  from msg_buddy_list
			 where buddy_id = p_buddyid
			   and buddy_domain = p_buddydomain
			   and buddy_status <> '-3'
			   and owner_id = p_userid
			   and owner_domain = p_userdomain	) buddy_status,
	      'N'
	    from msg_buddy_group
	    where group_idx = p_group_idx;

	  open ref_csr for
      select
        a.buddy_idx, a.buddy_id, a.buddy_domain, a.buddymemo, a.isblocked,
        a.buddy_status, b.group_idx, b.group_name, b.isdefault, b.iseditable,
        c.displayname, decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus) usercurrentstatus,
        c.server_ip, c.server_port,
        d.user_nm buddyname, e.msg req_msg, e.req_usr_nm, d.user_type, d.mobile_phone
      from msg_buddy_list a, msg_buddy_group b, msg_user_info c, msg_user_master d, msg_buddy_req_msg e
      where a.group_idx = b.group_idx
      and a.buddy_id = c.users_id
      and a.buddy_domain = c.domain
      and a.buddy_id = d.users_id
      and a.buddy_domain = d.domain
      AND a.buddy_idx = e.buddy_idx(+)
      and a.buddy_idx = v_index
      and a.owner_id = p_userid
      and a.owner_domain = p_userdomain
      and a.buddy_id = p_buddyid
      and a.buddy_domain = p_buddydomain;
    return ref_csr;

 END sf_copy_buddy;

  ---------------------------------------------------------------------
  -- 버디를 특정 그룹에 추가한다.(NON_AUTH)
  ---------------------------------------------------------------------
  function sf_ins_buddy_nonauth(p_buddydomain in varchar2,
                             p_buddyid in varchar2,
                             p_buddy_group_idx in number) Return CursorType IS
  ref_csr CursorType;
  BEGIN
    INSERT INTO msg_buddy_list
    (buddy_idx,
    group_idx,
    owner_id,
    owner_domain,
    buddy_id,
    buddy_domain,
    buddy_status,
    isblocked)
    select
      SEQ_MSG_BUDDY_LIST.nextval ,
      p_buddy_group_idx ,
      users_id,
      domain ,
      p_buddyid,
      p_buddydomain,
      decode((select buddy_status from msg_buddy_list
       where group_idx = p_buddy_group_idx
       and buddy_id = p_buddyid
       and buddy_domain = p_buddydomain), null, '0'),
      'N'
     from msg_buddy_group
     where group_idx = p_buddy_group_idx;


     OPEN ref_csr FOR
     SELECT
            BB.owner_id owner_id,
            BB.owner_domain owner_domain,
            BB.group_idx group_idx,
            BB.group_name group_name,
            BB.buddy_idx buddy_idx,
            BB.buddy_id buddy_id,
            CC.displayname displayname,
            BB.buddy_domain buddy_domain,
            CC.usercurrentstatus usercurrentstatus,
            BB.isblocked isblocked,
            BB.iseditable iseditable,
            BB.buddymemo buddymemo,
            AA.user_nm buddyname,
            BB.buddy_status buddy_status,
            CC.server_ip server_ip,
            CC.server_port server_port,
            AA.mobile_phone
       FROM msg_user_master AA, msg_user_info CC, (
                                           SELECT
                                              a.owner_id,
                                              a.owner_domain,
                                              b.group_idx,
                                              b.group_name,
                                              a.buddy_idx,
                                              a.buddy_id,
                                              a.buddy_domain,
                                              a.isblocked,
                                              b.iseditable,
                                              a.buddymemo,
                                              a.buddy_status
                                            FROM msg_buddy_list a, msg_buddy_group b
                                            WHERE b.group_idx = p_buddy_group_idx
                                            AND a.group_idx = b.group_idx
                                            AND a.buddy_id = p_buddyid
                                            AND a.buddy_domain = p_buddydomain
                                            ) BB
      WHERE BB.buddy_id = AA.users_id
        AND BB.buddy_domain = AA.domain
        AND BB.buddy_id = CC.users_id
        AND BB.buddy_domain = CC.domain;
     RETURN ref_csr;
  END sf_ins_buddy_nonauth;

  ---------------------------------------------------------------------
  -- 버디를 특정 그룹에 추가한다.(AUTH)
  ---------------------------------------------------------------------
 function sf_ins_buddy_auth(p_userdomain in varchar2,
                              p_userid in varchar2,
                              p_group_idx in number,
                              p_buddydomain in varchar2,
                              p_buddyid in varchar2,
                              p_owner_nm in varchar2,
                              p_reqmsg in varchar2
                             ) return CursorType is
  v_idx number := 0;
  v_buddy_status msg_buddy_list.buddy_status%type;
  v_mybuddy_status msg_buddy_list.buddy_status%type;
  v_newbuddy_status msg_buddy_list.buddy_status%type;
  v_flag char(1) := '0';
  begin

   begin
     select
       max(to_number(buddy_status))||'' into v_mybuddy_status
     from msg_buddy_list
     where group_idx = p_group_idx
     and buddy_id = p_buddyid
     and buddy_domain = p_buddydomain;
     --group by buddy_status;
   exception
     when no_data_found then
     v_flag := '1';
     when others then
      --자신의 버디그룹에 여러건 들어있을 경우등등
      RAISE_APPLICATION_ERROR(-20501, sqlcode||sqlerrm);
   end;

   if v_mybuddy_status <> '-1' and v_mybuddy_status <> '-7' then
      -- 자신의 버디에 거절한 버디AUTH 이외의 다른 AUTH가 들어 있을 경우
      RAISE_APPLICATION_ERROR(-20502, sqlcode||sqlerrm);
   end if;

   v_flag := '0';
   begin
     select max(to_number(a.buddy_status))||''
       into v_buddy_status
       from msg_buddy_list a
      where a.owner_id = p_buddyid
        and a.owner_domain = p_buddydomain
        and a.buddy_id = p_userid
        and a.buddy_domain = p_userdomain;
      -- group by buddy_status;
   exception
     when no_data_found then
     v_flag := '1';
	   v_buddy_status := '1';
     when others then
      --상다방의 버디에 내가 여러건 들어있을 경우등등
      RAISE_APPLICATION_ERROR(-20503, sqlcode||sqlerrm);
   end;

   if v_buddy_status is null then
     v_flag := '1';
	   v_buddy_status := '1';
   end if;

   if v_mybuddy_status = '-1' or v_mybuddy_status = '-7' then
     update msg_buddy_list
        set buddy_status = '1'
      where group_idx = p_group_idx
        and buddy_id = p_buddyid
        and buddy_domain = p_buddydomain;
   else
     -- 나의 버디에 추가한다.
     select decode(v_buddy_status,'2','1',     -- 상대방의 입장에 따라 나의 상태를 결정
                  '-1','1',    -- 상대방이 나를 거절, 아래에서 추가 상태로 진행
                  '-3','1',    -- 내가 거절, 추가상태로 진행 될것.
                  '-7','-2',   -- 상대방이 나를 거절 차단
                  '-2','-7',   -- 내가 거절 차단
                  '-4','-5',   -- 내가 삭제 차단
                  '-5','-6',   -- 상대방이 나를 차단
                  '-6','-5',   -- 내가 차단
                  v_buddy_status)
       into v_newbuddy_status
       from dual;

     INSERT INTO msg_buddy_list
      (buddy_idx,
      group_idx,
      owner_id,
      owner_domain,
      buddy_id,
      buddy_domain,
      buddy_status,
      isblocked)
      (select
        SEQ_MSG_BUDDY_LIST.nextval,
        p_group_idx,
        users_id,
        domain ,
        p_buddyid,
        p_buddydomain,
        v_newbuddy_status,
        'N'
      from msg_buddy_group
      where group_idx = p_group_idx
      );

    end if;

  	  if v_flag = '1' then
	      --상대방의 버디에 추가한다.
	      select SEQ_MSG_BUDDY_LIST.nextval into v_idx from dual;
	      INSERT INTO msg_buddy_list
	      (buddy_idx,
	      group_idx,
	      owner_id,
	      owner_domain,
	      buddy_id,
	      buddy_domain,
	      buddy_status,
	      isblocked)
	      (select
	       v_idx,
	        a.group_idx,
	        a.users_id,
	        a.domain,
	        p_userid,
	        p_userdomain,
	        '2',
	        'N'
	      from msg_buddy_group a
	      where a.users_id = p_buddyid
	      and a.domain = p_buddydomain
	      and a.isdefault = 'Y');

        INSERT INTO msg_buddy_req_msg
        (buddy_idx, req_usr_nm, msg)
        values
        (v_idx, p_owner_nm, p_reqmsg);
    else
        if ((v_mybuddy_status = '-1' or v_mybuddy_status = '-7') or
            (v_buddy_status = '-1'  or v_buddy_status = '-3')) then
            update msg_buddy_list
               set buddy_status = '2'
             where owner_id = p_buddyid
             and owner_domain = p_buddydomain
             and buddy_id = p_userid
             and buddy_domain = p_userdomain;
        end if;
	  end if;

      return sf_get_buddy_info(p_userdomain, p_userid, p_buddydomain, p_buddyid);
  end sf_ins_buddy_auth;


 ---------------------------------------------------------------------
  -- 버디를 특정 그룹에 추가한다.(NOT AUTH)
  ---------------------------------------------------------------------
 function sf_ins_buddy_auth_not(p_userdomain in varchar2,
                              p_userid in varchar2,
                              p_group_idx in number,
                              p_buddydomain in varchar2,
                              p_buddyid in varchar2,
                              p_owner_nm in varchar2,
                              p_reqmsg in varchar2
                             ) return CursorType is
  v_idx number := 0;
  v_mybuddy_status msg_buddy_list.buddy_status%type;
  begin

   begin
     select
       max(to_number(buddy_status))||'' into v_mybuddy_status
     from msg_buddy_list
     where group_idx = p_group_idx
     and buddy_id = p_buddyid
     and buddy_domain = p_buddydomain;
     --group by buddy_status;
   exception
     when others then
      --자신의 버디그룹에 여러건 들어있을 경우등등
      RAISE_APPLICATION_ERROR(-20501, sqlcode||sqlerrm);
   end;

   if v_mybuddy_status <> '-1' and v_mybuddy_status <> '-7' then
      -- 자신의 버디에 거절한 버디AUTH 이외의 다른 AUTH가 들어 있을 경우
      RAISE_APPLICATION_ERROR(-20502, sqlcode||sqlerrm);
   end if;

   if v_mybuddy_status = '-1' or v_mybuddy_status = '-7' then
     update msg_buddy_list
        set buddy_status = '1'
      where group_idx = p_group_idx
        and buddy_id = p_buddyid
        and buddy_domain = p_buddydomain;
   else

     INSERT INTO msg_buddy_list
      (buddy_idx,
      group_idx,
      owner_id,
      owner_domain,
      buddy_id,
      buddy_domain,
      buddy_status,
      isblocked)
      (select
        SEQ_MSG_BUDDY_LIST.nextval,
        p_group_idx,
        users_id,
        domain ,
        p_buddyid,
        p_buddydomain,
        '3',
        'N'
      from msg_buddy_group
      where group_idx = p_group_idx
      );

    end if;

      return sf_get_buddy_info(p_userdomain, p_userid, p_buddydomain, p_buddyid);
  end sf_ins_buddy_auth_not;

  procedure sp_ins_buddy_memo(p_buddy_idx in number,
                              p_buddy_memo in varchar2) is
  begin
       update msg_buddy_list set buddymemo = p_buddy_memo where buddy_idx = p_buddy_idx;
  end sp_ins_buddy_memo;


  /*
    p_userid@p_userdomain이 p_buddyid@p_buddydomain에 대한 버디상태를
    p_buddy_auth로 변경한다.
    p_buddy_auth로 :  (1: 버디수락
                       2: 버디거절
                       3: 버디거절 및 차단
                       4: 버디삭제
                       5: 버디 삭제 및 차단
                       6: 차단)
  */
  function sf_upd_buddy_status(p_userdomain in varchar2,
                                p_userid in varchar2,
                                p_buddydomain in varchar2,
                                p_buddyid in varchar2,
								                p_buddy_idx in number,
                                p_buddy_auth in number) return CursorType is

  v_buddy_status msg_buddy_list.buddy_status%type;
  begin

   begin
     select max(to_number(a.buddy_status))||''
       into v_buddy_status
       from msg_buddy_list a
      where a.owner_id = p_userid
        and a.owner_domain = p_userdomain
        and a.buddy_id = p_buddyid
        and a.buddy_domain = p_buddydomain;
      -- group by buddy_status;
   exception
     when no_data_found then
	   v_buddy_status := '1';
   end;

   if v_buddy_status is null then
	   v_buddy_status := '1';
   end if;

     IF p_buddy_auth = 1 THEN                  -- 버디수락

       if v_buddy_status = '-7' then
         UPDATE msg_buddy_list set buddy_status = '-1'
         WHERE owner_id = p_userid
         AND owner_domain = p_userdomain
         AND buddy_id = p_buddyid
         AND buddy_domain = p_buddydomain;
       else
         UPDATE msg_buddy_list set buddy_status = '3'
         WHERE owner_id = p_userid
         AND owner_domain = p_userdomain
         AND buddy_id = p_buddyid
         AND buddy_domain = p_buddydomain;
       end if;

       UPDATE msg_buddy_list set buddy_status = '3'
       WHERE owner_id = p_buddyid
       AND owner_domain = p_buddydomain
       AND buddy_id = p_userid
       AND buddy_domain = p_userdomain;

     ELSIF p_buddy_auth = 2 THEN                -- 버디거절
       --자신에 속한 버디상태를 삭제한다.
       UPDATE msg_buddy_list set buddy_status = '-1'
       WHERE owner_id = p_userid
       AND owner_domain = p_userdomain
       AND buddy_id = p_buddyid
       AND buddy_domain = p_buddydomain;

       --상대방에 속한 자신(버디) 상태를 거절로 바꾼다.
       UPDATE msg_buddy_list set buddy_status = '-3'
       WHERE owner_id = p_buddyid
       AND owner_domain = p_buddydomain
       AND buddy_id = p_userid
       AND buddy_domain = p_userdomain;

     ELSIF p_buddy_auth = 3 THEN                -- 버디거절 및 차단

       --자신에 속한 버디상태를 거절 및 차단한다.
       UPDATE msg_buddy_list set buddy_status = '-7'
       WHERE owner_id = p_userid
       AND owner_domain = p_userdomain
       AND buddy_id = p_buddyid
       AND buddy_domain = p_buddydomain;

       --상대방에 속한 자신(버디) 상태를 거절로 바꾼다.
       UPDATE msg_buddy_list set buddy_status = '-2'
       WHERE owner_id = p_buddyid
       AND owner_domain = p_buddydomain
       AND buddy_id = p_userid
       AND buddy_domain = p_userdomain;

     ELSIF p_buddy_auth = 4 THEN                 -- 버디삭제

       --자신에 속한 버디상태를 삭제한다.
       DELETE FROM msg_buddy_list
       WHERE buddy_idx = p_buddy_idx;

       /*UPDATE msg_buddy_list set buddy_status = '-3'
       WHERE owner_id = p_userid
       AND owner_domain = p_userdomain
       AND buddy_idx = p_buddy_idx
       AND buddy_id = p_buddyid
       AND buddy_domain = p_buddydomain;*/

     ELSIF p_buddy_auth = 5 THEN                 -- 버디 삭제 및 차단

       --자신에 속한 버디상태를 삭제한다.
       DELETE FROM msg_buddy_list
       WHERE buddy_idx = p_buddy_idx;

       --자신에 속한 버디상태를 차단으로 바꾼다.
       UPDATE msg_buddy_list set buddy_status = '-5'
       WHERE owner_id = p_userid
       AND owner_domain = p_userdomain
       AND buddy_id = p_buddyid
       AND buddy_domain = p_buddydomain;

       --상대방에 속한 자신(버디) 상태를 삭제 및 차단으로 바꾼다.
       UPDATE msg_buddy_list set buddy_status = '-4'
       WHERE owner_id = p_buddyid
       AND owner_domain = p_buddydomain
       AND buddy_id = p_userid
       AND buddy_domain = p_userdomain;

	 ELSIF p_buddy_auth = 6 THEN                    -- 차단

	   --자신에 속한 버디상태를 차단으로 바꾼다.
       UPDATE msg_buddy_list set buddy_status = '-5'
	     WHERE owner_id = p_userid
       AND owner_domain = p_userdomain
       AND buddy_id = p_buddyid
       AND buddy_domain = p_buddydomain;

	   --상대방에 속한 자신(버디) 상태를 차단으로 바꾼다.
       UPDATE msg_buddy_list set buddy_status = '-6'
       WHERE owner_id = p_buddyid
       AND owner_domain = p_buddydomain
       AND buddy_id = p_userid
       AND buddy_domain = p_userdomain;

     END IF;

     DELETE FROM msg_buddy_req_msg
     WHERE buddy_idx in
     (select buddy_idx from msg_buddy_list
     where owner_id = p_userid
     and owner_domain = p_userdomain
     and buddy_id = p_buddyid
     and buddy_domain=p_buddydomain);

     return sf_get_buddy_info(p_userdomain, p_userid, p_buddydomain, p_buddyid);

  end sf_upd_buddy_status;


  function sf_get_buddy_info(p_userdomain in varchar2,
                             p_userid in varchar2,
                             p_buddydomain in varchar2,
                             p_buddyid in varchar2) return CursorType IS
  ref_csr CursorType;
  begin
    open ref_csr for
      select
        a.buddy_idx, a.buddy_id, a.buddy_domain, a.buddymemo, a.isblocked,
        a.buddy_status, b.group_idx, b.group_name, b.isdefault, b.iseditable,
        c.displayname, decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus) usercurrentstatus,
        c.server_ip, c.server_port, d.user_nm buddyname,
        e.msg req_msg, e.req_usr_nm, d.user_type, d.mobile_phone
      from msg_buddy_list a, msg_buddy_group b, msg_user_info c, msg_user_master d, msg_buddy_req_msg e
      where a.group_idx = b.group_idx
      and a.buddy_id = c.users_id
      and a.buddy_domain = c.domain
      and a.buddy_id = d.users_id
      and a.buddy_domain = d.domain
      AND a.buddy_idx = e.buddy_idx(+)
      and a.owner_id = p_userid
      and a.owner_domain = p_userdomain
      and a.buddy_id = p_buddyid
      and a.buddy_domain = p_buddydomain
      and a.buddy_status <> '-1';
    return ref_csr;
  end sf_get_buddy_info;


  function sf_get_buddy_one_info(p_userdomain in varchar2,
                                 p_userid in varchar2,
                                 p_buddydomain in varchar2,
                                 p_buddyid in varchar2) return CursorType IS
  ref_csr CursorType;
  begin
       open ref_csr for
	   		select
               a.users_id, a.domain, a.user_nm user_nm,
               a.user_type, '' email, '' phone_no,
               a.mobile_phone, b.displayname, decode(b.usercurrentstatus, null, '-1', b.usercurrentstatus) usercurrentstatus,
               b.server_ip, b.server_port, b.client_type, null buddymemo,
               c.buddy_status, decode(substr(a.rsn_no, 7, 1), '1', 'M', '2', 'F', '3', 'M', '4', 'F') sex,
               to_number(to_char(sysdate, 'yyyy')) - to_number(decode(sign(2 - to_number(substr(a.rsn_no, 7, 1))), 1, '19', 0, '19', '20')||substr(a.rsn_no, 0, 2)) + 1 age,
               a.valid_yn
            from msg_user_master a, msg_user_info b,
            ( select
                buddy_id,
                buddy_domain,
                max(buddy_status) buddy_status/*,
                max(buddymemo) buddymemo*/
              from msg_buddy_list
              where owner_id = p_userid
              and owner_domain = p_userdomain
              group by buddy_id, buddy_domain
            ) c
            where a.users_id = b.users_id
            and a.domain = b.domain
            and a.users_id = p_buddyid
            and a.users_id = c.buddy_id
            and a.domain = c.buddy_domain
            and a.domain = p_buddydomain;
       return ref_csr;
  end sf_get_buddy_one_info;



  ---------------------------------------------------------------------
  -- 사용자의 버디 그룹과 리스트를 가져 온다.(전부 가져온다)
  -- PARAM1 : p_userid
  -- PARAM2 : p_domain
  FUNCTION sf_get_buddy_All_list(p_userid in varchar2,
                                 p_domainname in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN

       OPEN ref_csr for
       SELECT
              decode(b.group_name, '기본그룹', 1,
                       decode(b.isdefault, 'N', 2)) as  sortingnum,
              b.users_id,  b.domain, b.group_idx, b.group_name,
              b.iseditable, b.isdefault, a.buddy_idx,
              a.buddy_id, a.buddy_domain, a.isblocked,
              a.buddymemo, a.buddy_status, c.displayname,
              decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus) usercurrentstatus,
              c.server_ip, c.server_port,
              d.user_nm buddyname,
              decode(a.buddy_idx, null, '2', '1') flag,
              e.msg req_msg, e.req_usr_nm, d.user_type, d.mobile_phone
            FROM msg_buddy_list a, msg_buddy_group b, msg_user_info c,
                 msg_user_master d, msg_buddy_req_msg e
            WHERE b.users_id=  p_userid
            AND b.domain = p_domainname
            AND b.group_idx = a.group_idx(+)
            AND a.buddy_id = c.users_id(+)
            AND a.buddy_domain = c.domain(+)
            AND a.buddy_id = d.users_id(+)
            AND a.buddy_domain= d.domain(+)
            AND a.buddy_idx = e.buddy_idx(+)
            ORDER BY sortingnum, group_name, displayname;
          /*SELECT
          *
          FROM
          (
            SELECT
              decode(b.group_name, '기본그룹', 1,
                       decode(b.isdefault, 'N', 2))as  sortingnum,
              b.users_id,  b.domain, b.group_idx, b.group_name,
              b.iseditable, b.isdefault, a.buddy_idx,
              a.buddy_id, a.buddy_domain, a.isblocked,
              a.buddymemo, a.buddy_status, c.displayname,
              decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus) usercurrentstatus,
              c.server_ip, c.server_port,
              d.user_nm buddyname,
              decode(a.buddy_idx, null, '2', '1') flag,
              e.msg req_msg, e.req_usr_nm, d.user_type, d.mobile_phone
            FROM msg_buddy_list a, msg_buddy_group b, msg_user_info c,
                 msg_user_master d, msg_buddy_req_msg e
            WHERE b.users_id=  p_userid
            AND b.domain = p_domainname
            AND b.group_idx = a.group_idx(+)
            AND a.buddy_id = c.users_id(+)
            AND a.buddy_domain = c.domain(+)
            AND a.buddy_id = d.users_id(+)
            AND a.buddy_domain= d.domain(+)
            AND a.buddy_idx = e.buddy_idx(+)
            ORDER BY sortingnum, group_name, displayname
          )
          UNION ALL
          select  use_nl(a, b, c, d) index(a, ix1_msg_staff_info)
            99999 sortingnum,
            '017503' user_id, 'ibk.com' domain, 0 group_idx, b.org_nm group_name,
            'N' iseditable, 'N' isdefault, 0 buddy_idx,
             a.users_id buddy_id, a.domain buddy_domain, 'N' isblocked,
            '' buddymemo, '3' buddy_status, a.team_nm|| ' ' ||d.user_nm as displayname,
            decode(a.branch_yn, 'Y', decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus), -9) usercurrentstatus,
            --decode(c.usercurrentstatus, null, -1, c.usercurrentstatus) usercurrentstatus,
            c.server_ip, c.server_port, d.user_nm buddyname, '10' flag, '' req_msg, '' req_usr_nm, '3' user_type, '' grade,
            d.mobile_phone
          from msg_staff_info a, msg_staff_dept_info b, msg_user_info c, msg_user_master d
          where p_usr_tp in ('1', '2')
          and a.org_cd in (select org_cd from tb_cust_bsn_dept where users_id = p_userid and domain = p_domainname)
          and a.org_cd = b.org_cd(+)
          and a.users_id = c.users_id
          and a.domain = c.domain
          and a.users_id = d.users_id
          and a.domain = d.domain;
          --ORDER BY sortingnum, group_name, displayname;*/


       RETURN ref_csr;
  END sf_get_buddy_All_list;

  ---------------------------------------------------------------------
  -- 사용자의 차단 리스트를 가져온다
  -- PARAM1 : p_userid
  -- PARAM2 : p_domain
  FUNCTION sf_get_block_list( p_domainname in varchar2,
                              p_userid in varchar2)  RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
	      select aa.user_nm, bb.buddyidx, bb.userid, bb.userdomain, bb.userauth
		    from msg_user_master aa,
			     (select 0 buddyidx, a.owner_id userid, a.owner_domain userdomain, a.buddy_status userauth
		            from msg_buddy_list a
		           where a.buddy_id = p_userid
		             and a.buddy_domain = p_domainname
		             and a.buddy_status in ('-4','-6')
		          union
		          /*select b.buddy_idx buddyidx, a.owner_id userid, a.owner_domain userdomain, a.buddy_status userauth
		            from msg_buddy_list a,
      					     (select buddy_idx, buddy_id, buddy_domain
      						    from msg_buddy_list
      						   where owner_id = p_userid
      		                     and owner_domain = p_domainname
      		                     and buddy_status = '-1') b
      		           where a.owner_id = b.buddy_id
      					       and a.owner_domain = b.buddy_domain
      					       and a.buddy_id = p_userid
      		             and a.buddy_domain = p_domainname
      		             and a.buddy_status = '-2'
		          union   */
		          select buddy_idx buddyidx, buddy_id userid, buddy_domain userdomain , buddy_status  userauth
		            from msg_buddy_list
		           where owner_id = p_userid
		             and owner_domain = p_domainname
		             and buddy_status in ('-5','-7')) bb
			 where aa.domain = bb.userdomain
			   and aa.users_id = bb.userid;
          RETURN ref_csr;
  END sf_get_block_list;

  function sf_get_cust_bsn_dept(p_org_cd in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  begin
       OPEN ref_csr FOR
          SELECT
          org_cd, org_nm
          FROM msg_staff_dept_info
          WHERE org_cd in
          (SELECT * FROM table (SELECT cast(in_list(p_org_cd) as listitemtype) FROM dual));
       RETURN ref_csr;
  end sf_get_cust_bsn_dept;



  function sf_get_buddy_group_list(p_group_id in number) return CursorType IS
  ref_csr CursorType;
  begin
    open ref_csr for
      select
        a.buddy_idx, a.buddy_id, a.buddy_domain, a.buddymemo, a.isblocked,
        a.buddy_status, b.group_idx, b.group_name, b.isdefault, b.iseditable,
        c.displayname, decode(c.usercurrentstatus, null, '-1', c.usercurrentstatus) usercurrentstatus,
        c.server_ip, c.server_port,
        d.user_nm buddyname,
        e.msg req_msg, e.req_usr_nm, d.user_type, d.mobile_phone,
        decode(a.buddy_idx, null, '2', '1') flag
      from msg_buddy_list a, msg_buddy_group b, msg_user_info c, msg_user_master d, msg_buddy_req_msg e
      where a.group_idx = b.group_idx
      and a.buddy_id = c.users_id
      and a.buddy_domain = c.domain
      and a.buddy_id = d.users_id
      and a.buddy_domain = d.domain
      AND a.buddy_idx = e.buddy_idx(+)
      and a.group_idx = p_group_id;
    return ref_csr;
  end sf_get_buddy_group_list;

  function sf_ins_org_buddy(p_domain in varchar2,
                            p_users_id in varchar2,
                            p_org_cd in varchar2,
                            p_org_nm in varchar2) RETURN CursorType IS
  v_group_idx number;
  begin
    INSERT INTO msg_buddy_group
    (group_idx, group_name, iseditable, isdefault, users_id, domain)
    values
    (seq_msg_buddy_group.nextval, p_org_nm, 'Y', 'N', p_users_id, p_domain)
    RETURNING group_idx INTO v_group_idx;

    insert into msg_buddy_list
    select
      seq_msg_buddy_list.nextval,
      v_group_idx,
      a.users_id buddy_id,
      a.domain buddy_domain,
      p_users_id,
      p_domain,
      'N' isblocked,
      null buddy_memo,
      decode(b.buddy_status||c.buddy_status, null, '3',
                                             b.buddy_status, b.buddy_status,
                                             c.buddy_status, c.buddy_status,
                                             b.buddy_status) buddy_status
    from msg_staff_info a, (
                         select
                             buddy_id,
                             buddy_domain,
                             max(buddy_status) buddy_status
                         from msg_buddy_list
                         where owner_id = p_users_id
                         and owner_domain = p_domain
                         group by buddy_id, buddy_domain--, buddy_status
                         ) b, (
                           select
                            owner_id,
                            owner_domain,
                            max(decode(buddy_status,'2','1',
                                                '-2','-1',
                                                 '-3','-1',
                                                 '-4','-5',
                                                 '-5','-6',
                                                 '-6','-5',
                                                 buddy_status)) buddy_status
                          from msg_buddy_list
                          where buddy_id = p_users_id
                          and buddy_domain = p_domain
                          group by owner_id, owner_domain--, buddy_status
                         ) c
    where a.users_id = b.buddy_id(+)
    and a.domain = b.buddy_domain(+)
    and a.users_id = c.owner_id(+)
    and a.domain = c.owner_domain(+)
    and a.org_cd = p_org_cd;
    return sf_get_buddy_group_list(v_group_idx);
  end sf_ins_org_buddy;

end PKG_MSG_BUDDY;
/

prompt
prompt Creating package body PKG_MSG_CHAT
prompt ==================================
prompt
create or replace package body kebiim.PKG_MSG_CHAT is

  function sf_get_domain_list RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
        select rownum as DOMAININDEX, DT.DOMAIN, DT.DOMAINTYPE, DT.DOMANISERVICESTATUS
          from (select DOMAIN, DOMAINTYPE, DOMANISERVICESTATUS
                  from MSG_DOMAIN
                 order by domain asc) DT;

       RETURN ref_csr;

  END sf_get_domain_list;

  function sf_get_domain_list2(p_domainname in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
        select rownum as DOMAININDEX, DT.DOMAIN, DT.DOMAINTYPE, DT.DOMANISERVICESTATUS
          from (select DOMAIN, DOMAINTYPE, DOMANISERVICESTATUS
                  from MSG_DOMAIN
				 where DOMAIN = p_domainname
                 order by domain asc) DT;

       RETURN ref_csr;

  END sf_get_domain_list2;

  function sf_get_channel_list(p_domainname in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  begin
       OPEN ref_csr FOR
        select CHNL_SEQ_NO,CHNL_NM,CHNL_ROOM_MAX_CNT,CHNL_ROOM_USER_CNT,DOMAIN
          from MSG_CHAT_CHNL
         where DOMAIN = p_domainname
         order by domain asc, CHNL_SEQ_NO asc;

       return ref_csr;
  end  sf_get_channel_list;

  function sf_get_channel_list2(p_domainname in varchar2,
                               p_channelname in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  begin
       OPEN ref_csr FOR
        select CHNL_SEQ_NO,CHNL_NM,CHNL_ROOM_MAX_CNT,CHNL_ROOM_USER_CNT,DOMAIN
          from MSG_CHAT_CHNL
         where DOMAIN = p_domainname and
               CHNL_NM = p_channelname
         order by domain asc, CHNL_SEQ_NO asc;

       return ref_csr;
  end  sf_get_channel_list2;

  function sf_ins_domain(p_domainname in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  begin
    INSERT INTO MSG_DOMAIN
      ( DOMAIN,DOMAINTYPE)
      VALUES(p_domainname, '4');

      OPEN ref_csr FOR
      select rownum as DOMAININDEX, DT.DOMAIN, DT.DOMAINTYPE, DT.DOMANISERVICESTATUS
        from (select DOMAIN, DOMAINTYPE, DOMANISERVICESTATUS
                from MSG_DOMAIN
               where DOMAIN = p_domainname
               order by domain asc) DT;

       return ref_csr;

  end  sf_ins_domain;

  function sf_ins_channel(p_domainname in varchar2,
                          p_channelname in varchar2,
                          p_max_channel in number,
                          p_max_user in number)  RETURN CursorType is
  ref_csr CursorType;
  begin
      INSERT INTO MSG_CHAT_CHNL
      ( CHNL_SEQ_NO,CHNL_NM,CHNL_ROOM_MAX_CNT,CHNL_ROOM_USER_CNT,DOMAIN )
      VALUES(SEQ_MSG_CHAT_CHNL.nextval, p_channelname,p_max_channel,p_max_user,p_domainname );

      OPEN ref_csr FOR
      select CHNL_SEQ_NO,CHNL_NM,CHNL_ROOM_MAX_CNT,CHNL_ROOM_USER_CNT,DOMAIN
        from MSG_CHAT_CHNL
       where DOMAIN = p_domainname and CHNL_NM = p_channelname
       order by CHNL_NM asc;

       return ref_csr;

  end  sf_ins_channel;

  function sf_ins_channel_old(p_domainname in varchar2,
                          p_channelname in varchar2,
                          p_max_channel in number,
                          p_max_user in number)  RETURN NUMBER is

  v_cnt number;
  begin
      Select count(*)
        into v_cnt
        from MSG_DOMAIN
       where DOMAIN = p_domainname;

      if v_cnt < 1 then
        return -1;
      end if;

      INSERT INTO MSG_CHAT_CHNL
      ( CHNL_SEQ_NO,CHNL_NM,CHNL_ROOM_MAX_CNT,CHNL_ROOM_USER_CNT,DOMAIN )
      VALUES(SEQ_MSG_CHAT_CHNL.nextval, p_channelname,p_max_channel,p_max_user,p_domainname );

    RETURN sql%rowcount;

  end  sf_ins_channel_old;



  procedure sp_ins_channel(p_domainname in varchar2,
                          p_channelname in varchar2,
                          p_max_channel in number,
                          p_max_user in number)   is
  begin

      INSERT INTO MSG_CHAT_CHNL
      ( CHNL_SEQ_NO,CHNL_NM,CHNL_ROOM_MAX_CNT,CHNL_ROOM_USER_CNT,DOMAIN )
      VALUES(SEQ_MSG_CHAT_CHNL.nextval, p_channelname,p_max_channel,p_max_user,p_domainname );

  end  sp_ins_channel;

end PKG_MSG_CHAT;
/

prompt
prompt Creating package body PKG_MSG_DIALOGUE
prompt ======================================
prompt
create or replace package body kebiim.PKG_MSG_DIALOGUE is

  function sf_save_dialogue(p_sessionid in varchar2,
                            p_send_id in varchar2,
                            p_send_domain in varchar2,
                            p_recv_id in varchar2,
                            p_recv_domain in varchar2,
                            p_recv_user_nm in varchar2) return cursorType is
  ref_csr cursorType;
  v_seq_no number;
  begin

       INSERT INTO msg_dialogue
       (seq_no, sessionid, send_id, send_domain,
       content, reg_dt, recv_id, recv_domain, recv_user_nm)
       values
       (seq_msg_dialogue.nextval, p_sessionid, p_send_id, p_send_domain,
       empty_clob(), sysdate, p_recv_id, p_recv_domain, p_recv_user_nm)
       RETURNING seq_no into v_seq_no;

       OPEN ref_csr FOR
          SELECT  v_seq_no,  content
          FROM  msg_dialogue
          WHERE seq_no = v_seq_no
          FOR UPDATE;
        RETURN ref_csr;

  end sf_save_dialogue;

  function sf_get_dialouge(p_user_id in varchar2,
                           p_domain in varchar2,
                           p_cur_pg in number,
                           p_row_cnt in number) return cursorType is
  ref_csr cursorType;
  begin
       open ref_csr for
       select
        seq_no,
        sessionid,
        send_id,
        send_domain,
        content,
        to_char(reg_dt, 'yyyy.mm.dd hh24:mi:ss') reg_dt,
        recv_id,
        recv_domain,
        recv_user_nm,
        rnum,
        snd_user_nm,
        tot_cnt
       from
       (
       select /*+index_desc(a, ix1_msg_dialogue)*/
            a.seq_no,
            a.sessionid,
            a.send_id,
            a.send_domain,
            a.content,
            a.reg_dt,
            a.recv_id,
            a.recv_domain,
            a.recv_user_nm,
            b.user_nm snd_user_nm,
            rownum rnum,
            count(seq_no) over() tot_cnt
       from msg_dialogue a, msg_user_master b
       where a.send_id = b.users_id
       and a.send_domain  = b.domain
       and a.send_id = p_user_id
       and a.send_domain = p_domain
       )
       WHERE rnum > ( p_cur_pg -1 ) * p_row_cnt
       AND ROWNUM <= p_row_cnt;
       return ref_csr;

  end sf_get_dialouge;
end PKG_MSG_DIALOGUE;
/

prompt
prompt Creating package body PKG_MSG_JOIN
prompt ==================================
prompt
create or replace package body kebiim.PKG_MSG_JOIN is

  ---------------------------------------------------------------------
  -- 사용자 기본정보를 입력한다.
  procedure sp_ins_user_master(p_users_id in varchar2,
                                 p_domain in varchar2,
                                 p_passwd in varchar2,
                                 p_user_nm in varchar2,
                                 p_rsn_no in varchar2,
                                 p_user_type in varchar2,
                                 p_mobile_phone in varchar2,
                                 p_password_qst in varchar2,
                                 p_password_asw in varchar2,
                                 p_sms_qt in varchar2,
                                 p_user_lvl in varchar2,
                                 p_valid_yn in varchar2) is
  begin
     INSERT INTO msg_user_master
     (users_id, domain, user_nm, rsn_no, passwd,
     user_type, mobile_phone, password_qst, password_asw,
     sms_qt, user_lvl, valid_yn)
     values
     (p_users_id, p_domain, p_user_nm, p_rsn_no, p_passwd,
     p_user_type, p_mobile_phone, p_password_qst, p_password_asw,
     p_sms_qt, p_user_lvl, p_valid_yn);

        begin
         pkg_msg_login.sp_ins_lgn_hstr(p_users_id, p_domain, '', p_user_type, 'R');
         exception when others then
         dbms_output.put('ins lgn hstr error.');
        end;

  end sp_ins_user_master;


  ---------------------------------------------------------------------
  -- 메신저 기본 정보를 입력한다. (messenger)
  -- PARAM1 : p_userid
  -- PARAM2 : p_domain
  -- PARAM4 : p_dispalyname

  PROCEDURE sp_ins_default_info(p_users_id in varchar2,
                                p_domain in varchar2,
                                p_dispalyname in varchar2) IS
  BEGIN
       INSERT INTO msg_user_info
       (users_id, domain, displayname)
       VALUES
       (p_users_id, p_domain, p_dispalyname);
  END sp_ins_default_info;

  ---------------------------------------------------------------------
  -- 도메인을 신청한다.
  procedure sp_ins_domain(p_domain in varchar2,
                          p_domaintype in varchar2,
                          p_domaniservicestatus in varchar2) is
  begin
    insert into msg_domain
    (domain, domaintype, domaniservicestatus)
    values
    (p_domain, p_domaintype, p_domaniservicestatus);
  end sp_ins_domain;


    --------------------------------------------------------------------
    -- 고객 회원가입 여부(이름 - 주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_nm_rsn_by_users(p_domainname in varchar2,
                                       p_rsn_no in varchar2,
                                       p_user_nm in varchar2)
    RETURN varchar2
    IS
      user_id varchar2(50);
    BEGIN
            select users_id into user_id from msg_user_master
            where domain = p_domainname
            and rsn_no = p_rsn_no
            and user_nm = p_user_nm
            and rownum <= 1;
            RETURN user_id;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_users';

    END sf_get_nm_rsn_by_users;

    --------------------------------------------------------------------
    -- 고객 회원가입 여부(ID - 이름 - 주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_id_nm_rsn_by_users(p_domainname in varchar2,
                                       p_users_id in varchar2,
                                       p_rsn_no in varchar2,
                                       p_user_nm in varchar2)
    RETURN varchar2
    IS
      passwd varchar2(50);
    BEGIN
            select passwd into passwd from msg_user_master
            where domain = p_domainname
            and users_id = p_users_id
            and rsn_no = p_rsn_no
            and user_nm = p_user_nm
            and rownum <= 1;
            RETURN passwd;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_passwd';

    END sf_get_id_nm_rsn_by_users;


    --------------------------------------------------------------------
    -- PASSWROD 찾기 (이름 - 주민번호 - PASSWORD - ID)
    --------------------------------------------------------------------
    FUNCTION sf_get_pwd_rsn_by_users(  p_rsn_no in varchar2,
                                       p_users_id in varchar2,
                                       p_user_nm in varchar2)
    RETURN varchar2
    IS
      passwd varchar2(50);
    BEGIN
            select passwd into passwd from msg_user_master
            where rsn_no = p_rsn_no
            and users_id = p_users_id
            and user_nm = p_user_nm
            and rownum <= 1;
            RETURN passwd;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_passwd';

    END sf_get_pwd_rsn_by_users;

    --------------------------------------------------------------------
    -- PASSWROD 찾기 (이름 - 주민번호 - PASSWORD - ID) sf_get_passwd_by_users
    --------------------------------------------------------------------
    FUNCTION sf_get_pwd_by_users(  p_rsn_no in varchar2,
                                   p_users_id in varchar2)
    RETURN varchar2
    IS
      passwd varchar2(50);
    BEGIN
            select passwd into passwd from msg_user_master
            where rsn_no = p_rsn_no
            and users_id = p_users_id
            and rownum <= 1;
            RETURN passwd;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_passwd';

    END sf_get_pwd_by_users;

    --------------------------------------------------------------------
    -- PASSWROD 찾기 (이름 - 주민번호 - PASSWORD - ID)
    --------------------------------------------------------------------
   /*
    FUNCTION sf_get_pwd_rsn_by_users(  p_rsn_no in varchar2,
                                       p_users_id in varchar2,
                                       p_user_nm in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN

         OPEN ref_csr for
           select passwd, domain  from tb_user_master
              where rsn_no = p_rsn_no
              and users_id = p_users_id
              and user_nm = p_user_nm
              and rownum <= 1;
         RETURN ref_csr;

    END sf_get_pwd_rsn_by_users;
    */

    --------------------------------------------------------------------
    -- passwd_qst 찾기 두번째 (이름 - PASSWORD - ID)
    --------------------------------------------------------------------
    FUNCTION sf_get_pwd_sear_by_users(p_domainname in varchar2,
                                       p_password_qst in varchar2,
                                       p_password_asw in varchar2,
                                       p_users_id in varchar2)
    RETURN varchar2
    IS
      passwd varchar2(50);
    BEGIN
            select passwd into passwd from msg_user_master
            where domain = p_domainname
            and password_qst = p_password_qst
            and password_asw = p_password_asw
            and users_id = p_users_id
            and rownum <= 1;
            RETURN passwd;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_passwd';

    END sf_get_pwd_sear_by_users;


    ---------------------------------------------------------------------
    -- password 찾기 비밀번호 변경
    ---------------------------------------------------------------------

    PROCEDURE sp_upd_passwd_change(p_passwd in varchar2,
                                   p_users_id in varchar2,
                                   p_domain in varchar2)
    IS
    BEGIN
         UPDATE msg_user_master set
         passwd = p_passwd
         where users_id = p_users_id
         and domain = p_domain;

    END sp_upd_passwd_change;

    ---------------------------------------------------------------------
    -- 비밀번호 변경 - 5회 이상 로그인 오류 초기화
    ---------------------------------------------------------------------

    PROCEDURE sp_upd_pwd_change(p_passwd in varchar2,
                                p_users_id in varchar2,
                                p_user_lvl in varchar2,
                                p_user_type in varchar2)
    IS
    BEGIN
         UPDATE msg_user_master set
         passwd = p_passwd,
         user_lvl = p_user_lvl
         where users_id = p_users_id
         AND user_type = p_user_type;

    END sp_upd_pwd_change;

    ---------------------------------------------------------------------
    -- 사용자 정보 가져오기 (주민등록번호)
    ---------------------------------------------------------------------

    FUNCTION sf_get_rsn_type_by_users(p_domainname in varchar2,
                                      p_users_id in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN
         OPEN ref_csr for
              select rsn_no, user_type from msg_user_master
              where domain = p_domainname
              and users_id = p_users_id;
              RETURN ref_csr;
    END sf_get_rsn_type_by_users;

    ---------------------------------------------------------------------
    -- 사용자 정보 가져오기 (아이디 - 사용자 이름)
    ---------------------------------------------------------------------

    FUNCTION sf_get_ep_nm_rsn_by_users(p_domainname in varchar2,
                                      p_rsn_no in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN
         OPEN ref_csr for
              select users_id, user_nm from msg_user_master
              where domain = p_domainname
              and rsn_no = p_rsn_no;
              RETURN ref_csr;
    END sf_get_ep_nm_rsn_by_users;


    ---------------------------------------------------------------------
    -- 사용자 정보 가져오기 (핸드폰번호 - 비밀번호 - 사용자 이름)
    ---------------------------------------------------------------------

    FUNCTION sf_get_nm_phone_by_users(p_domainname in varchar2,
                                      p_users_id in varchar2)
    RETURN CursorType
    IS
      ref_csr CursorType;
    BEGIN
         OPEN ref_csr for
              select mobile_phone, passwd, user_nm, user_type, password_qst, password_asw, rsn_no from msg_user_master
              where domain = p_domainname
              and users_id = p_users_id;
              RETURN ref_csr;
    END sf_get_nm_phone_by_users;


    ---------------------------------------------------------------------
    -- 전화번호변경 회원정보수정
    ---------------------------------------------------------------------

    PROCEDURE sp_upd_mobile_change(p_mobile_phone in varchar2,
                                   p_users_id in varchar2,
                                   p_domain in varchar2,
                                   p_password_qst in varchar2,
                                   p_password_asw in varchar2)
    IS
    BEGIN
         UPDATE msg_user_master set
         mobile_phone = p_mobile_phone,
         password_qst = p_password_qst,
         password_asw = p_password_asw
         where users_id = p_users_id
         and domain = p_domain;

    END sp_upd_mobile_change;

    --------------------------------------------------------------------
    -- PASSWROD 찾기 (도메인 - 아이디 - PASSWORD)
    --------------------------------------------------------------------
    FUNCTION sf_get_passwd_by_users(  p_domain in varchar2,
                                      p_users_id in varchar2,
                                      p_passwd in varchar2)
    RETURN varchar2
    IS
      passwd varchar2(50);
    BEGIN
            select passwd into passwd from msg_user_master
            where domain = p_domain
            and users_id = p_users_id
            and passwd = p_passwd;
            RETURN passwd;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 'no_passwd';

    END sf_get_passwd_by_users;


    --------------------------------------------------------------------
    -- 아이디 중복 여부
    --------------------------------------------------------------------
    FUNCTION sf_get_id_by_users(p_domainname in varchar2
                                ,p_usersid in varchar2)
    RETURN number
    IS
      cnt number;
    BEGIN


               select decode(users_id,'',0,1)  into cnt
               from msg_user_master
               where domain = p_domainname
               and users_id = p_usersid;

        RETURN cnt;
        EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END sf_get_id_by_users;


   --------------------------------------------------------------------
    -- 회원가입 여부 (주민번호)
    --------------------------------------------------------------------
    FUNCTION sf_get_rsn_by_users(p_domainname in varchar2
                                ,p_rsnno in varchar2)
    RETURN number
    IS
      cnt number;
    BEGIN


               select decode(users_id,'',0,1)  into cnt
               from msg_user_master
                where domain = p_domainname
               and rsn_no = p_rsnno;

        RETURN cnt;
        EXCEPTION
        WHEN OTHERS THEN
        RETURN 0;
    END sf_get_rsn_by_users;



  --------------------------------------------------------------------
    --  준회원 정회원으로  승격
    --------------------------------------------------------------------
    FUNCTION sf_get_by_rsnno(  p_rsn_no in varchar2,
                               p_flag in varchar2)
    RETURN number
    IS
      cnt number;
    BEGIN


          SELECT  decode(users_id, '',0,1) into cnt
          FROM msg_user_master
          WHERE rsn_no = p_rsn_no
          AND rownum <= 1;

         IF p_flag = 2 AND cnt = 1 then
           UPDATE msg_user_master
           SET  valid_yn ='Y'
           WHERE rsn_no = p_rsn_no ;
         END IF;

    RETURN cnt;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;

    END sf_get_by_rsnno;

    ---------------------------------------------------------------------
    -- 암호입력실패 count 초기화
    ---------------------------------------------------------------------

    PROCEDURE sp_udt_count(p_users_id in varchar2,
                           p_domain in varchar2)
    IS
    v_old_user_lvl msg_user_info.old_user_lvl%type;
    BEGIN
         UPDATE msg_user_info
            set pwdfail_count  = 0
          where users_id = p_users_id
          and domain = p_domain;

         begin
           select old_user_lvl
             into v_old_user_lvl
             from msg_user_info
            where users_id = p_users_id
              and domain = p_domain;
         exception
           when NO_DATA_FOUND then
             v_old_user_lvl := '1';
         end;

         if v_old_user_lvl is null or v_old_user_lvl = ' ' then
           v_old_user_lvl := '1';
         end if;

         UPDATE msg_user_master
            set user_lvl = v_old_user_lvl
          where users_id = p_users_id
          and domain = p_domain;

         commit;

    END sp_udt_count;


end PKG_MSG_JOIN;
/

prompt
prompt Creating package body PKG_MSG_LOGIN
prompt ===================================
prompt
create or replace package body kebiim.pkg_msg_login is

  ---------------------------------------------------------------------
  -- 통합 로그인
  ---------------------------------------------------------------------
    FUNCTION sf_login( p_userid in varchar2 ,
                       p_domain in varchar2,
                       p_serverIP in varchar2,
                       p_serverPort in varchar2,
                       p_user_local_ip in varchar2 ,
                       p_user_local_port in varchar2,
                       p_client_type in varchar2,
                       p_passwd in varchar2,
                       p_is_sso in varchar2,
                       p_user_type in out varchar2
                       ) return CursorType is
    v_valid_yn msg_user_master.valid_yn%type;
    v_passwd msg_user_master.passwd%type;
    v_user_lvl msg_user_master.user_lvl%type;
    v_user_type msg_user_master.user_type%type;
    v_domaintype msg_domain.domaintype%type;
    v_note_term msg_domain.note_term%type;
    v_attch_file_size msg_domain.attch_file_size%type;
    v_user_nm msg_user_master.user_nm%type;
    v_domain_status msg_domain.domaniservicestatus%type;
    v_failcount msg_user_info.PWDFAIL_COUNT%type;
    v_retcur   SYS_REFCURSOR;
    begin

         begin
           select
             a.valid_yn,
             a.passwd,
             a.user_lvl,
             c.domaintype,
             a.user_type,
             c.note_term,
             c.attch_file_size,
             a.user_nm,
             c.domaniservicestatus,
             b.pwdfail_count
             into v_valid_yn, v_passwd, v_user_lvl, v_domaintype, v_user_type, v_note_term, v_attch_file_size, v_user_nm, v_domain_status, v_failcount
           from msg_user_master a, msg_user_info b, msg_domain c
           where a.users_id = b.users_id
           and a.domain = b.domain
           and a.domain = c.domain
           and a.users_id = p_userid
           and a.domain = p_domain;
         exception
           -- 가입되지 않음.
           when NO_DATA_FOUND then
             RAISE_APPLICATION_ERROR(-20404, sqlcode||sqlerrm);
         end;

         --패스워드 에러
         /*
           1.직원이 아닌경우 패스워드 체크를 한다.
           2.직원인 경우
             2-1.sso 모드인 경우 패스워드 자리에 들어온 이름과 디비에 들어있는 이름을 체크한다.
             2-2.sso 모드가 아닌경우 패스워드를 체크한다.
         */
         --insert into tb_debug (val) values (p_passwd);
         if v_passwd <> p_passwd then
              RAISE_APPLICATION_ERROR(-20409, sqlcode||sqlerrm);
         end if;


          /*if v_user_type != '3' then
            if v_passwd <> p_passwd then
              RAISE_APPLICATION_ERROR(-20409, sqlcode||sqlerrm);
            end if;
          else
            if p_is_sso <> '1' then
              if v_passwd <> p_passwd then
                RAISE_APPLICATION_ERROR(-20409, sqlcode||sqlerrm);
              end if;
            else
              if v_user_nm <> p_passwd then
                RAISE_APPLICATION_ERROR(-20409, sqlcode||sqlerrm);
              end if;
            end if;
          end if;*/

          -- 암호가 5회 이상 틀렸을때
          if v_failcount >= 5 then
             RAISE_APPLICATION_ERROR(-20405, sqlcode||sqlerrm);
          end if;

         -- 사용정지중
         if v_domain_status <> '1' then
            RAISE_APPLICATION_ERROR(-20401, sqlcode||sqlerrm);
         end if;
         if v_user_lvl = '0' or v_user_lvl = '9' then
            RAISE_APPLICATION_ERROR(-20401, sqlcode||sqlerrm);
         end if;

         if v_user_type = '1' then
           v_retcur := sf_get_psnl_cust_info(p_userid, p_domain, v_note_term, v_attch_file_size);
         elsif v_user_type ='2' then
           v_retcur := sf_get_comp_cust_info(p_userid, p_domain, v_note_term, v_attch_file_size);
         elsif v_user_type = '3' then
           v_retcur := sf_get_staff_emp_info(p_userid, p_domain, v_note_term, v_attch_file_size);
         end if;

         UPDATE msg_user_info
         SET server_ip = p_serverIP ,
             server_port = p_serverPort,
             user_local_ip = p_user_local_ip ,
             user_local_port = p_user_local_port,
             client_type = p_client_type,
             PWDFAIL_COUNT = 0
         WHERE users_id = p_userid AND domain = p_domain;

         p_user_type := v_user_type;

         commit;

         begin
         sp_ins_lgn_hstr(p_userid, p_domain, p_user_local_ip, v_user_type, 'L');
         exception when others then
         dbms_output.put('ins lgn hstr error.');
         end;

         return v_retcur;
    end sf_login;

  function sf_pwdfailcount_inc(p_userid in varchar2 ,
                             p_domain in varchar2) return number is
  v_count number;
  v_old_user_lvl msg_user_master.user_lvl%type;
  begin
       begin
         select a.PWDFAIL_COUNT, b.user_lvl
           into v_count, v_old_user_lvl
           from msg_user_info a, msg_user_master b
          where b.users_id = a.users_id
           and b.domain = a.domain
           and a.users_id = p_userid
           and a.domain = p_domain;
       exception
         when NO_DATA_FOUND then
           return -1;
       end;

       if v_count is null or v_count < 0 then
           v_count := 0;
       end if;

       /*if v_count >= 5 then
           update msg_user_master
              set user_lvl = '9'
            where users_id = p_userid AND domain = p_domain;
       end if;

       v_count := v_count + 1;

       if v_old_user_lvl <> '9' then
         UPDATE msg_user_info
            SET PWDFAIL_COUNT = v_count, old_user_lvl = v_old_user_lvl
          WHERE users_id = p_userid AND domain = p_domain;
       else
         UPDATE msg_user_info
            SET PWDFAIL_COUNT = v_count
          WHERE users_id = p_userid AND domain = p_domain;
       end if;

       commit;*/

       return v_count;

  end sf_pwdfailcount_inc;


    ---------------------------------------------------------------------
    -- 일반개인고객 정보 가지고 온다.(로그인용)
    ---------------------------------------------------------------------
    function sf_get_psnl_cust_info(p_userid in varchar2,
                                   p_domain in varchar2,
                                   p_note_term in varchar2,
                                   p_attch_file_size in varchar2) return CursorType is
    ref_csr CursorType;
    begin
      open ref_csr FOR
      select
        a.users_id, a.domain, b.displayname,
        b.usercurrentstatus, a.user_nm, a.rsn_no, a.mobile_phone,
        a.valid_yn, c.menu_id, p_note_term note_term, p_attch_file_size attch_file_size,
        a.user_lvl, a.sms_qt, a.passwd
      from msg_user_master a, msg_user_info b, msg_menu_info_domain c
      where a.users_id = p_userid
      and a.domain = p_domain
      and a.users_id = b.users_id
      and a.domain = b.domain
      and a.domain = c.domain(+);
      return ref_csr;
    end sf_get_psnl_cust_info;

    ---------------------------------------------------------------------
    -- 일반기업객 정보 가지고 온다.(로그인용)
    ---------------------------------------------------------------------
    function sf_get_comp_cust_info(p_userid in varchar2,
                                   p_domain in varchar2,
                                   p_note_term in varchar2,
                                   p_attch_file_size in varchar2) return CursorType is
    ref_csr CursorType;
    begin
      open ref_csr FOR
         select
          a.users_id, a.domain, b.displayname,
          b.usercurrentstatus, a.user_nm comp_nm, a.rsn_no bsn_no,
          a.valid_yn, d.menu_id, p_note_term note_term, p_attch_file_size attch_file_size,
          a.user_lvl, a.sms_qt, a.passwd
         from msg_user_master a, msg_user_info b, msg_menu_info_domain d
         where a.users_id = b.users_id
         and a.domain = b.domain
         and a.users_id = p_userid
         and a.domain = p_domain
         and a.domain = d.domain(+);
      return ref_csr;
    end sf_get_comp_cust_info;

    ---------------------------------------------------------------------
    -- 직원 정보 가지고 온다.(로그인용)
    ---------------------------------------------------------------------
    function sf_get_staff_emp_info(p_userid in varchar2,
                                   p_domain in varchar2,
                                   p_note_term in varchar2,
                                   p_attch_file_size in varchar2) return CursorType is
    ref_csr CursorType;
    begin
      open ref_csr FOR
      select
        a.users_id, a.domain, b.displayname,
        b.usercurrentstatus, a.user_nm, a.rsn_no, a.mobile_phone,
        a.valid_yn, c.abrv_posi_nm pos_nm, c.lvl, c.org_nm, c.org_cd, d.menu_id,
        p_note_term note_term, p_attch_file_size attch_file_size,
        a.user_lvl, a.sms_qt, a.passwd
      from (
            select
              x.users_id, x.domain, x.abrv_posi_nm, x.lvl, y.org_nm, x.org_cd
            from msg_staff_info x, msg_staff_dept_info y
            where x.org_cd = y.org_cd
           ) c, msg_user_master a, msg_user_info b, msg_menu_info_domain d
      where a.users_id = p_userid
      and a.domain = p_domain
      and a.users_id = b.users_id
      and a.domain = b.domain
      and a.users_id = c.users_id
      and a.domain = c.domain
      and a.domain = d.domain(+);
      return ref_csr;
    end sf_get_staff_emp_info;



    FUNCTION sf_get_LoginPasswd(p_userid in varchar2 ,
                               p_domainname in varchar2,
                               p_serverIP in varchar2,
                               p_serverPort in varchar2,
                               p_user_local_ip in varchar2 ,
                               p_user_local_port in varchar2,
                               p_client_type in varchar2
                               ) RETURN varchar2 IS
    v_userpassword  msg_user_master.passwd%TYPE;
    BEGIN
          SELECT passwd INTO v_userpassword
          FROM msg_user_master
          WHERE users_id = p_userid AND domain = p_domainname
          AND user_lvl <> '0';

          UPDATE msg_user_info
          SET server_ip = p_serverIP ,
              server_port = p_serverPort,
              user_local_ip = p_user_local_ip ,
              user_local_port = p_user_local_port,
              client_type = p_client_type
          WHERE users_id = p_userid AND domain = p_domainname;

          RETURN v_userpassword;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               RETURN NULL;

    END  sf_get_LoginPasswd;


  procedure sp_ins_lgn_hstr(p_userid in varchar2 ,
                             p_domainname in varchar2,
                             p_user_local_ip in varchar2,
                             p_user_type in varchar2,
                             p_gubun in varchar2) is
  begin

       INSERT INTO MSG_LOGIN_HSTR
       (users_id, domain, local_ip,
       user_type, gubun)
       values
       (p_userid, p_domainname, p_user_local_ip, p_user_type,p_gubun);
  end sp_ins_lgn_hstr;


  ---------------------------------------------------------------------
  -- 특정사용자의 접근 가능한 메뉴 아이디 목록을 가지고 온다.
  ---------------------------------------------------------------------
  function sf_get_user_menu_id(p_domainname in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
           SELECT
                  a.menu_id
            FROM msg_menu_info_domain a
            WHERE a.domain = p_domainname;
       RETURN ref_csr;
  END sf_get_user_menu_id;


  /*3-000-1-1-02	1-000-1-1-07 통합사용자정보 */
    -- PARAM1 : p_userid
    -- PARAM2 : p_domain
   function sf_get_users_inf(p_domainname in varchar2,
                             p_users_id in varchar2) RETURN CursorType IS
   ref_csr CursorType;
   BEGIN
        OPEN ref_csr FOR
        	SELECT
						a.users_id, a.domain, b.usercurrentstatus,
						b.displayname, b.server_ip, b.server_port, b.client_type,
						a.user_nm, a.valid_yn, a.user_lvl,
						a.mobile_phone, a.user_type
        	FROM msg_user_master a, msg_user_info b
        	WHERE a.users_id = b.users_id
        	AND a.domain = b.domain
          AND a.users_id = p_users_id
          AND a.domain= p_domainname;
        return ref_csr;
   END sf_get_users_inf;

   /*
    금칙어 리스트를 가지고 온다.
   */
   function sf_get_frbd_word(p_domain in varchar2) Return CursorType IS
   ref_csr CursorType;
   begin
     open ref_csr FOR
       select
         keyword
       from msg_frbd_word
       WHERE domain = p_domain
       union all
       select
         keyword
       from msg_frbd_word
       WHERE domain = 'common';
     return ref_csr;
   end sf_get_frbd_word;

   function sf_get_user_info_rsn_no(p_rsn_nos in varchar2) return CursorType IS
   ref_csr CursorType;
   begin
        open ref_csr FOR
          select
          rsn_no, users_id, domain
          from msg_user_master
          WHERE rsn_no in
          (SELECT * FROM table (SELECT cast(in_list(p_rsn_nos) as listitemtype) FROM dual))
          and valid_yn = 'Y';
        return ref_csr;
   end sf_get_user_info_rsn_no;

end pkg_msg_login;
/

prompt
prompt Creating package body PKG_MSG_MESSAGE
prompt =====================================
prompt
create or replace package body kebiim.PKG_MSG_MESSAGE is

   function sf_get_serverflag_count(p_domainname in varchar2,
                                    p_userid in varchar2) RETURN NUMBER IS
   v_rtn number := 0;
   begin
        select
           count(recv_users_id) into v_rtn
        from msg_note_recvers
        where recv_users_id = p_userid
        and recv_domain = p_domainname
        and recv_yn = 'N';
        return v_rtn;
   end sf_get_serverflag_count;


   ---------------------------------------------------------------------
    -- 쪽지에 기본 정보를 insert (CLOB)
    -- PARAM1 : p_domainname (도메인네임)
    -- PARAM2 : p_userid (사용자계정)
    -- PARAM3 : p_noteFont (쪽지정보)
    -- PARAM4 : p_noteTime (보안Time)
    -- PARAM5 : p_GroupID (그룹ID)
    -- PARAM6 : p_msgType (메세지구분)
    -- PARAM7 : p_note_limit_date (쪽지보관일수)
    ---------------------------------------------------------------------
    function sf_ins_msg_noteinfo(p_snd_domain in varchar2,
                                p_snd_users_id in varchar2,
                                p_snd_users_nm in varchar2,
                                p_notefont in varchar2,
                                p_secu_time in number,
                                p_groupid in varchar2,
                                p_msgtype in varchar2,
                                p_file_yn in varchar2,
                                p_msggroup in varchar2,
                                p_bgimage in varchar2,
                                p_client_msg_idx in varchar2
                                ) RETURN CursorType IS
     v_noteIdx msg_noteinfo.note_idx%TYPE;
     ref_csr CursorType;
     begin

          INSERT INTO msg_noteinfo
          (note_idx, snd_users_id, snd_domain, snd_user_nm,
          note_contents, note_font, msg_type, msg_group, bg_img_idx, groupid, send_dt,
          secu_time, note_del_dt, file_yn, client_note_idx)
          values
          (SEQ_MSG_NOTEINFO.nextval, p_snd_users_id, p_snd_domain, p_snd_users_nm,
          EMPTY_CLOB(), p_noteFont, p_msgType, p_msggroup, p_bgimage, p_GroupID, sysdate,
          p_secu_time, to_char(sysdate+(select note_term from msg_domain where domain=p_snd_domain), 'yyyymmdd'), p_file_yn, p_client_msg_idx)

          RETURNING note_idx into v_noteIdx;

          OPEN ref_csr FOR
            SELECT  note_idx,  note_contents
            FROM  msg_noteinfo
            WHERE note_idx = v_noteIdx
            FOR UPDATE;
          RETURN ref_csr;
     end sf_ins_msg_noteinfo;

     procedure sp_ins_msg_note_recv(p_note_idx in number,
                                   p_recv_users_id in varchar2,
                                   p_recv_domain in varchar2,
                                   p_recv_confirm_yn in varchar2,
                                   p_recv_flag in varchar2) is
     begin

        insert into msg_note_recvers
        (note_recv_idx, note_idx, recv_users_id, recv_domain, recv_user_nm,
        recv_confirm_yn, recv_yn, recv_dt)
        values
        (seq_msg_note_recv.nextval, p_note_idx, p_recv_users_id, p_recv_domain, sf_get_user_nm(p_recv_domain, p_recv_users_id),
        p_recv_confirm_yn, p_recv_flag, decode(p_recv_flag, 'Y', sysdate, null));
     end sp_ins_msg_note_recv;


    function sf_del_msg_noteinfo(p_note_idx in number,
                                p_send_users_id in varchar2,
                                p_send_domain in varchar2,
                                p_recv_users_id in varchar2,
                                p_recv_domain in varchar2) RETURN NUMBER IS
   v_rtn number := 1;

   begin

        begin
          delete from msg_note_recvers
          where note_idx in (select note_idx
                               from msg_noteinfo
                              where CLIENT_NOTE_IDX = p_note_idx
                                and SND_USERS_ID = p_send_users_id
                                and SND_DOMAIN = p_send_domain)
            and RECV_USERS_ID = p_recv_users_id
            and RECV_DOMAIN = p_recv_domain;

         exception
           when NO_DATA_FOUND then
           v_rtn := 1;
           when others then
           v_rtn := -1;
         end;

        return v_rtn;

   end sf_del_msg_noteinfo;

     procedure sp_ins_msg_note_recv_by_rsnno(p_note_idx in number,
                                             p_rsn_no in varchar2,
                                             p_recv_confirm_yn in varchar2,
                                             p_recv_flag in varchar2) is
     cursor cur is
     select
        users_id, domain, user_nm
     from msg_user_master
     where rsn_no = p_rsn_no
     and valid_yn = 'Y';
     begin
       for cur_rec in cur loop
         insert into msg_note_recvers
        (note_recv_idx, note_idx, recv_users_id, recv_domain, recv_user_nm,
        recv_confirm_yn, recv_yn, recv_dt)
        values
        (seq_msg_note_recv.nextval, p_note_idx, cur_rec.users_id, cur_rec.domain, cur_rec.user_nm,
        p_recv_confirm_yn, p_recv_flag, decode(p_recv_flag, 'Y', sysdate, null));
       end loop;

     end sp_ins_msg_note_recv_by_rsnno;



   -------------------------------------------------------------------
   --쪽지에  수신자별 파일정보를  insert
   --PARAM1 : p_noteIndex (쪽지 pk)
   --X PARAM2 : p_domainname (도메인네임)
   --X PARAM3 : p_userid (사용자 이름)
   --PARAM4 : p_filename (파일이름)
   --PARAM5 : p_filePhysicalName (물리적 파일이름)
   --PARAM6 : p_filePath (파일경로)
   --PARAM7 : p_filesize (파일size)
   --PARAM8 : p_s_idx (파일 pk)
   --PARAM9 : p_fileip (파일서버 ip)
   --PARAM10 : p_fileport (파일 서버port)
    -------------------------------------------------------------------
    function sp_ins_noteAppendFile_inf(p_filename in varchar2,
                                       p_filePhysicalName in varchar2,
                                       p_filePath in varchar2,
                                       p_filesize in varchar2,
                                       p_fileip in varchar2,
                                       p_fileport in varchar2,
                                       p_file_del_dt in number) RETURN NUMBER IS
     v_fileIdx msg_notefile.file_idx%TYPE;
     BEGIN

        BEGIN
           INSERT INTO msg_notefile (
            file_idx, --note_idx, domain, users_id,
            filename,
            server_filepath ,
            local_filepath ,
            filesize,
            file_server_ip ,
            file_server_port,
            file_del_dt)
           VALUES(
           SEQ_MSG_NOTEFILE.nextval,
           p_filename,
           p_filePhysicalName,
           p_filePath,
           p_filesize,
           p_fileip,
           p_fileport,
           to_char(sysdate+p_file_del_dt, 'yyyymmdd'))

           RETURNING file_idx into v_fileIdx;
           return v_fileIdx;
        END;

     END sp_ins_noteAppendFile_inf;


    procedure sp_ins_msg_noteinfo_file_inf(p_note_idx in number ,
                                          p_file_idx in number
                                          ) IS
    BEGIN
      insert into msg_noteinfo_file( note_idx , file_idx )
      values ( p_note_idx ,p_file_idx);
    END sp_ins_msg_noteinfo_file_inf;


    ---------------------------------------------------------------------
    -- 쪽지에  수신자별 파일정보를  select한후 쪽지 읽음으로 바꿈
    -- PARAM1 : p_domainname (도메인네임)
    -- PARAM2 : p_userid (사용자 이름)
    ---------------------------------------------------------------------
    procedure sf_set_information_hit(p_note_recv_idxes in varchar2) IS

    BEGIN
        UPDATE msg_note_recvers
          SET recv_yn = 'Y', recv_dt = sysdate
        WHERE note_recv_idx in
        (SELECT * FROM table (SELECT cast(in_list(p_note_recv_idxes) as listitemtype) FROM dual));
        /*UPDATE msg_note_recvers
          SET recv_yn = 'Y', recv_dt = sysdate
        WHERE note_recv_idx in
        (
          select
             note_recv_idx
          from
          (
            select  +index(msg_note_recvers, ix2_msg_note_recvers)
              note_recv_idx, rownum rnum
            from msg_note_recvers
            WHERE recv_domain = p_domainname
            AND recv_users_id = p_userid
            and recv_yn = 'N'
          ) a
          where a.rnum >= 1 and rownum<=5
        );*/
    END sf_set_information_hit;


    ---------------------------------------------------------------------
    -- 쪽지에  수신자별 파일정보를  select
    -- PARAM1 : p_domainname (도메인네임)
    -- PARAM2 : p_userid (사용자 이름)
    ---------------------------------------------------------------------
    function sf_get_note_list(p_domainname in varchar2,
                                  p_userid in varchar2) RETURN CursorType IS
    ref_csr CursorType;
    begin
         open ref_csr for
          select
            note_recv_idx, note_idx, recv_users_id, recv_domain,
            recv_user_nm, recv_confirm_yn, recv_yn, recv_dt, snd_users_id,
            snd_domain, snd_user_nm, note_contents, note_font,
            msg_type, msg_group, bg_img_idx, groupid, send_dt, secu_time, note_del_dt,
            file_yn, rnum, tot_cnt
          from
          (
            select /*+use_nl(a,b) index(a, ix2_msg_note_recvers)*/
              a.note_recv_idx, a.note_idx, a.recv_users_id, a.recv_domain,
              a.recv_user_nm, a.recv_confirm_yn, a.recv_yn, a.recv_dt, b.snd_users_id,
              b.snd_domain, b.snd_user_nm, b.note_contents, b.note_font,
              b.msg_type, b.msg_group, b.bg_img_idx, b.groupid, to_char(b.send_dt, 'yyyymmddhh24miss') send_dt, b.secu_time, b.note_del_dt,
              b.file_yn, rownum rnum,
              count(note_recv_idx) over() tot_cnt
            from msg_note_recvers a, msg_noteinfo b
            where a.note_idx = b.note_idx
            and a.recv_users_id = p_userid
            and a.recv_domain = p_domainname
            and a.recv_yn = 'N'
          )
          where rnum >= 1  and rownum<=5;
         return ref_csr;
    end sf_get_note_list;

    function sf_get_file_info(p_note_idx in number) return CursorType is
    ref_csr CursorType;
    begin
         open ref_csr for
            select
              b.file_idx, b.filename, b.server_filepath, b.local_filepath,
              b.filesize, b.file_server_ip, b.file_server_port,
              b.file_del_dt, a.file_recv_yn
             from msg_noteinfo_file a, msg_notefile b
             where a.file_idx = b.file_idx
             and a.note_idx = p_note_idx;
         return ref_csr;
    end sf_get_file_info;


    function sf_get_del_note_file_info(p_serverip in varchar2, p_serverport in varchar2) return CursorType is
    ref_csr CursorType;
    begin
       open ref_csr for
        select
           x.server_filepath, x.file_server_ip, x.file_server_port
        from msg_notefile x, (select b.file_idx, b.note_idx from msg_noteinfo a, msg_noteinfo_file b
        where a.note_idx = b.note_idx
        and a.note_del_dt < to_char(sysdate, 'yyyymmdd')) y
        where x.file_idx = y.file_idx
        and x.file_server_ip = p_serverip
        and x.file_server_port = p_serverport;
        return ref_csr;
    end sf_get_del_note_file_info;

    function sf_get_del_note_file_info2 return CursorType is
    ref_csr CursorType;
    begin
       open ref_csr for
        select
           x.server_filepath
        from msg_notefile x, (select b.file_idx, b.note_idx from msg_noteinfo a, msg_noteinfo_file b
        where a.note_idx = b.note_idx
        and a.note_del_dt < to_char(sysdate, 'yyyymmdd')) y
        where x.file_idx = y.file_idx;
        return ref_csr;
    end sf_get_del_note_file_info2;


    procedure sp_batch_del_memo is
    begin

        delete from msg_notefile
        where file_idx in (select b.file_idx from msg_noteinfo a, msg_noteinfo_file b
        where a.note_idx = b.note_idx
        and a.note_del_dt <= to_char(sysdate, 'yyyymmdd'));

        delete from msg_noteinfo_file
        where note_idx in (select note_idx from msg_noteinfo where note_del_dt <= to_char(sysdate, 'yyyymmdd'));

        delete from msg_note_recvers
        where note_idx in (select note_idx from msg_noteinfo where note_del_dt <= to_char(sysdate, 'yyyymmdd'));

        delete from msg_noteinfo
        where note_del_dt <= to_char(sysdate, 'yyyymmdd');
    end sp_batch_del_memo;

    /*function sf_get_file_info(p_note_idx in number) return varchar2 is
    type file_info_cur_type is ref cursor;
    file_info_cur file_info_cur_type;
    v_file_idx msg_noteinfo_file.file_idx%type;
    v_filename msg_notefile.filename%type;
    v_server_filepath msg_notefile.server_filepath%type;
    v_local_filepath msg_notefile.local_filepath%type;
    v_filesize msg_notefile.filesize%type;
    v_file_server_ip msg_notefile.file_server_ip%type;
    v_file_server_port msg_notefile.server_port%type;
    v_file_del_dt msg_notefile.file_del_dt%type;
    v_file_recv_yn msg_noteinfo_file.file_recv_yn%type;

    v_rtn_str varchar2(4000) =: '';
    begin

      open file_info_cur for
      select
            b.file_idx, b.filename, b.server_filepath, b.local_filepath,
            b.filesize, b.file_server_ip, b.file_server_port,
            b.file_del_dt, a.file_recv_yn
           from msg_noteinfo_file a, msg_notefile b
           where a.file_idx = b.file_idx
           and a.note_idx = p_note_idx;


      loop
       fetch file_info_cur into v_users_id, v_domain, v_user_nm;
       exit when user_info_cur%notfound;

      end loop;
      close user_info_cur;

    end sf_get_file_info;*/

end PKG_MSG_MESSAGE;
/

prompt
prompt Creating package body PKG_MSG_SERVER_INFO
prompt =========================================
prompt
create or replace package body kebiim.PKG_MSG_SERVER_INFO is

  procedure sp_upd_server_status(p_kind in varchar2,
                                 p_serverip in varchar2,
                                 p_port in varchar2,
							     p_status in char) is
  begin
	update msg_serverlist
	   set status = p_status
	 where kind = p_kind
	   and ip = p_serverip
	   and port = p_port  ;
  end sp_upd_server_status;

  procedure sp_upd_server_down(p_serverip in varchar2,
                               p_port in varchar2,
							   p_status in number) is
  begin
	update msg_user_info
	   set usercurrentstatus = p_status
	 where server_ip = p_serverip
	   and server_port = p_port
	   and usercurrentstatus <> -1;
  end sp_upd_server_down;

end PKG_MSG_SERVER_INFO;
/

prompt
prompt Creating package body PKG_MSG_STATUS
prompt ====================================
prompt
create or replace package body kebiim.PKG_MSG_STATUS is

  function sf_get_watcher_list_non_auth(p_domainname in varchar2,
                                        p_userid in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
         SELECT
           A.owner_id as watcher_id, A.owner_domain watcher_domain, max(B.server_ip) server_ip, max(B.server_port) server_port
         FROM msg_buddy_list A , msg_user_info B
         WHERE A.buddy_id = p_userid
         AND A.buddy_domain = p_domainname
         AND A.owner_id = B.users_id
         AND A.owner_domain = B.domain
         AND A.buddy_status <> '-5' --확인 요망
         AND B.usercurrentstatus <> '-1'
         GROUP BY A.owner_id, A.owner_domain;--확인요망
       RETURN ref_csr;
  END sf_get_watcher_list_non_auth;

  function sf_get_watcher_list_auth(p_domainname in varchar2,
                                    p_userid in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  begin
       OPEN ref_csr FOR
         select /*+rule*/
           A.owner_id watcher_id, A.owner_domain watcher_domain,
           max(B.server_ip) server_ip, max(B.server_port) server_port,
           '1' flag
         from msg_buddy_list A, msg_user_info B
         where A.owner_id = B.users_id
         and A.owner_domain = B.domain
         and A.buddy_id = p_userid
         and A.buddy_domain = p_domainname
         and A.buddy_status = '3'
         and B.usercurrentstatus <> '-1'
         group by A.owner_id, A.owner_domain;
       return ref_csr;
  end  sf_get_watcher_list_auth;


  function sf_get_watcher_list_all(p_domain in varchar2,
                                  p_users_id in varchar2) return CursorType IS
  ref_csr CursorType;
  begin
     open ref_csr for
         SELECT /*+rule*/
           A.owner_id as watcher_id, A.owner_domain watcher_domain, max(C.user_nm) users_nm
         FROM msg_buddy_list A , msg_user_info B, msg_user_master C
         WHERE A.buddy_id = p_users_id
         AND A.buddy_domain = p_domain
         AND A.owner_id = B.users_id
         AND A.owner_domain = B.domain
         AND A.owner_id = C.users_id
         AND A.owner_domain = C.domain
         AND A.buddy_status <> '-5' --확인 요망
         --AND B.usercurrentstatus <> '-1'
         GROUP BY A.owner_id, A.owner_domain;--확인요망
     return ref_csr;
  end sf_get_watcher_list_all;

 ---------------------------------------------------------------------
  -- userpresenceinformation UPDATE
  -- 3-000-2-1-02
  -- PARAM1 : p_userid (사용자id)
  -- PARAM2 : p_domainname (도메인)
  -- PARAM3 : p_displayname (displayname)
  ---------------------------------------------------------------------
  function sf_upd_displyanme(p_domainname in varchar2,
                             p_userid in varchar2,
                             p_displayname in varchar2) RETURN NUMBER IS
  BEGIN

      UPDATE msg_user_info SET
        displayname = p_displayname
      WHERE domain = p_domainname
      AND users_id = p_userid;
    RETURN sql%rowcount;

  END sf_upd_displyanme;



  ---------------------------------------------------------------------
  -- userpresenceinformation을 UPDATE 한다.(IMS관련)
  --3-000-2-1-03
  -- PARAM1 : p_domainname (도메인네임)
  -- PARAM2 : p_userid (사용자계정)
  -- PARAM3 : p_userstats (현재상태)
  -- PARAM4 : p_server_ip (서버 IP)
  -- PARAM5 : p_server_port(서버 port)
  ---------------------------------------------------------------------
  procedure sp_set_user_status_inf(p_domainname in varchar2,
                                p_userid in varchar2,
                                p_userstats in varchar2
                              ) IS
  begin


        UPDATE msg_user_info SET
           usercurrentstatus = p_userstats
        WHERE domain = p_domainname
        AND users_id = p_userid;
  end sp_set_user_status_inf;


  procedure sp_set_user_status_inf2(p_domainname in varchar2,
                                p_userid in varchar2,
                                p_userstats in varchar2,
                                p_server_ip in varchar2,
                                p_server_port in varchar2
                                ) IS
  begin
        UPDATE msg_user_info SET
           usercurrentstatus = p_userstats,
           server_ip = p_server_ip,
           server_port = p_server_port
        WHERE domain = p_domainname
        AND users_id = p_userid;
  end sp_set_user_status_inf2;

  /* 특정 부서내의 직원의 아이디와, 접속 서버 아이피를 알아온다.
  *  특정 고객의 영업점 부서를 등록하면 해당 영업점의 직원들은 고객의 버디로 등록이 되고
  *  영업점 직원들의 와처에는 고객이 추가된다.
  *
  */
  function sf_get_bsn_dept_staff(p_org_cd in varchar2) return CursorType IS
  ref_csr CursorType;
  begin
      OPEN ref_csr FOR
      select
        a.users_id watcher_id,
        a.domain watcher_domain,
        b.server_ip,
        b.server_port,
        '0' flag
      from msg_staff_info a, msg_user_info b
      where a.users_id = b.users_id
      and a.domain = b.domain
      and a.org_cd = p_org_cd
      and b.usercurrentstatus <> -1 ;
      RETURN ref_csr;
   end sf_get_bsn_dept_staff;



end PKG_MSG_STATUS;
/

prompt
prompt Creating package body PKG_MSG_WEB_NOTE
prompt ======================================
prompt
create or replace package body kebiim.PKG_MSG_WEB_NOTE is

  function sf_get_note_list_all(p_domainname in varchar2,
                            p_userid in varchar2,
                            p_start_dt in varchar2,
                            p_end_dt in varchar2,
                            p_msg_flag in varchar2,
                            p_snd_rcv_flag in varchar2,
                            p_keyword in varchar2,
                            p_cur_pg in number,
                            p_row_cnt in number) RETURN CursorType IS
    ref_csr CursorType;
    begin
         open ref_csr for
            select
            flag, note_recv_idx, note_idx, recv_users_id, recv_domain,
            recv_user_nm, recv_confirm_yn, recv_yn, to_char(recv_dt, 'yyyy.mm.dd hh24:mi:ss') recv_dt,
            snd_users_id,
            snd_domain, snd_user_nm, note_contents, note_font,
            msg_type, groupid, to_char(send_dt,'yyyy.mm.dd hh24:mi:ss') send_dt, secu_time,
            note_del_dt,
            file_yn, tot_cnt
            from
            (
              select
              t.*, rownum rnum
              from
              (
                select
                  flag, note_recv_idx, note_idx, recv_users_id, recv_domain,
                  recv_user_nm, recv_confirm_yn, recv_yn, recv_dt, snd_users_id,
                  snd_domain, snd_user_nm, note_contents, note_font,
                  msg_type, groupid, send_dt, secu_time, note_del_dt,
                  file_yn, count(note_recv_idx) over() tot_cnt
                from
                (
                    select
                      'R' flag, a.note_recv_idx, a.note_idx, a.recv_users_id, a.recv_domain,
                      a.recv_user_nm, a.recv_confirm_yn, a.recv_yn, a.recv_dt, b.snd_users_id,
                      b.snd_domain, b.snd_user_nm, b.note_contents, b.note_font,
                      b.msg_type, b.groupid, b.send_dt, b.secu_time, b.note_del_dt,
                      b.file_yn
                    from msg_note_recvers a, msg_noteinfo b
                    where p_snd_rcv_flag in ('A', 'R')
                    and a.note_idx = b.note_idx
                    and a.recv_users_id = p_userid
                    and a.recv_domain = p_domainname
                    and b.send_dt BETWEEN TO_DATE(p_start_dt||' 000000', 'yyyymmdd hh24miss') AND TO_DATE(p_end_dt||' 235959', 'yyyymmdd hh24miss')
                    and b.note_contents like '%'||p_keyword||'%'
                    union all
                    select
                      'S' flag, a.note_recv_idx, a.note_idx, a.recv_users_id, a.recv_domain,
                      a.recv_user_nm, a.recv_confirm_yn, a.recv_yn, a.recv_dt, b.snd_users_id,
                      b.snd_domain, b.snd_user_nm, b.note_contents, b.note_font,
                      b.msg_type, b.groupid, b.send_dt, b.secu_time, b.note_del_dt,
                      b.file_yn
                    from msg_note_recvers a, msg_noteinfo b
                    where p_snd_rcv_flag in ('A', 'S')
                    and a.note_idx = b.note_idx
                    and b.snd_users_id = p_userid
                    and b.snd_domain = p_domainname
                    and b.send_dt BETWEEN TO_DATE(p_start_dt||' 000000', 'yyyymmdd hh24miss') AND TO_DATE(p_end_dt||' 235959', 'yyyymmdd hh24miss')
                    and b.note_contents like '%'||p_keyword||'%'
                )
                 order by note_idx desc
              ) t
            )
            WHERE rnum > ( p_cur_pg -1 ) * p_row_cnt
            AND ROWNUM <= p_row_cnt;
         return ref_csr;
    end sf_get_note_list_all;

    function sf_get_note_list_non_read(p_domainname in varchar2,
                                      p_userid in varchar2,
                                      p_cur_pg in number,
                                      p_row_cnt in number) RETURN CursorType IS
    ref_csr CursorType;
    begin
         open ref_csr for
         select
            'R' flag, note_recv_idx, note_idx, recv_users_id, recv_domain,
            recv_user_nm, recv_confirm_yn, recv_yn, to_char(recv_dt, 'yyyy.mm.dd hh24:mi:ss') recv_dt,
            snd_users_id,
            snd_domain, snd_user_nm, note_contents, note_font,
            msg_type, groupid, to_char(send_dt, 'yyyy.mm.dd hh24:mi:ss') send_dt, secu_time,
            note_del_dt,
            file_yn, tot_cnt
          from
          (
            select /*+use_nl(a,b) index(a, ix2_msg_note_recvers)*/
              a.note_recv_idx, a.note_idx, a.recv_users_id, a.recv_domain,
              a.recv_user_nm, a.recv_confirm_yn, a.recv_yn, a.recv_dt, b.snd_users_id,
              b.snd_domain, b.snd_user_nm, b.note_contents, b.note_font,
              b.msg_type, b.groupid, b.send_dt, b.secu_time, b.note_del_dt,
              b.file_yn, rownum rnum,
              count(note_recv_idx) over() tot_cnt
            from msg_note_recvers a, msg_noteinfo b
            where a.note_idx = b.note_idx
            and a.recv_users_id = p_userid
            and a.recv_domain = p_domainname
            and a.recv_yn = 'N'
          )
            WHERE rnum > ( p_cur_pg -1 ) * p_row_cnt
            AND ROWNUM <= p_row_cnt;
         return ref_csr;
    end sf_get_note_list_non_read;


    function sf_get_file_info(p_note_idx in number) return CursorType is
    ref_csr CursorType;
    begin
         open ref_csr for
            select
              b.file_idx, b.filename, b.server_filepath, b.local_filepath,
              b.filesize, b.file_server_ip, b.file_server_port,
              b.file_del_dt, a.file_recv_yn
             from msg_noteinfo_file a, msg_notefile b
             where a.file_idx = b.file_idx
             and a.note_idx = p_note_idx;
         return ref_csr;
    end sf_get_file_info;


    procedure sf_set_information_hit(p_note_recv_idxes in varchar2) IS
    BEGIN
        UPDATE msg_note_recvers
          SET recv_yn = 'Y', recv_dt = sysdate
        WHERE note_recv_idx in
        (SELECT * FROM table (SELECT cast(in_list(p_note_recv_idxes) as listitemtype) FROM dual));
    END sf_set_information_hit;

end PKG_MSG_WEB_NOTE;
/

prompt
prompt Creating package body PKG_SEARCH
prompt ================================
prompt
create or replace package body kebiim.PKG_SEARCH is

  function sf_get_sch(p_user_id in varchar2,
                      p_domain in varchar2,
                      p_usr_tp in varchar2,
                      p_org_code in varchar2,
                      p_sch_type in varchar2,
                      p_keyword in varchar2,
                      p_start_num in number,
                      p_range in number) return CursorType is
  ref_csr CursorType;
  begin

       IF p_usr_tp = '1' OR p_usr_tp = '2' THEN
         return sf_get_cust_sch(p_sch_type, p_keyword, p_start_num, p_range);
       ELSIF p_usr_tp = '3' THEN
          IF p_sch_type = 'user_nm' THEN
            return sf_get_emp_sch_by_name(p_org_code, p_keyword, p_start_num, p_range);
          ELSE
            return sf_get_emp_sch_by_id(p_org_code, p_keyword, p_start_num, p_range);
          END IF;
         /*return sf_get_emp_sch(p_org_code, p_sch_type,
                               p_keyword, p_start_num, p_range);*/
       END IF;

  end sf_get_sch;

  /*
  * 고객이 검색(검색대상: 고객(개인고객,기업고객)
  */
  function sf_get_cust_sch(p_sch_type in varchar2,
                          p_keyword in varchar2,
                          p_start_num in number,
                          p_range in number) return CursorType is
  ref_csr CursorType;
  begin
       open ref_csr for
       select
            user_type, rnum, users_id||'@'||domain users_id,  user_nm, mobile_phone, rsn_no,
            tot_cnt
       from
       (
         SELECT /*+index(a, ix3_msg_user_master)*/
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              count(*) over() tot_cnt, rownum rnum
         FROM msg_user_master a
         WHERE p_sch_type = 'user_nm'
         AND a.user_nm like p_keyword||'%'
         AND a.user_type in ('1', '2')
         UNION ALL
         SELECT /*+index(a, ix4_msg_user_master)*/
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              count(*) over() tot_cnt, rownum rnum
         FROM msg_user_master a
         WHERE p_sch_type = 'users_id'
         AND a.users_id like p_keyword||'%'
         AND a.user_type in ('1', '2')
       )
       WHERE rnum >= p_start_num  and rownum<=p_range;
       return ref_csr;

  end  sf_get_cust_sch;


  /*
  * 직원이 이름으로 검색(검색대상:고객, 부서내직원)
  */
  function sf_get_emp_sch_by_name(p_org_code in varchar2,
                                  p_keyword in varchar2,
                                  p_start_num in number,
                                  p_range in number) return CursorType is
  ref_csr CursorType;
  begin
      open ref_csr for
      select
        user_type, users_id, user_nm, mobile_phone, rsn_no,
        org_cd, org_nm, team_nm, lvl, abrv_posi_nm,
        join_ymd, tot_cnt, rnum, rownum
      from
      (
        select
          user_type, users_id, user_nm, mobile_phone, rsn_no,
          org_cd, org_nm, team_nm, lvl, abrv_posi_nm,
          join_ymd, tot_cnt, rownum rnum
        from
        (
          select
            user_type, users_id||'@'||domain users_id, user_nm, mobile_phone, rsn_no,
            org_cd, org_nm, team_nm, lvl, abrv_posi_nm,
            join_ymd, count(*) over() tot_cnt
          from
          (
            select
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              c.org_cd, c.org_nm, b.team_nm, b.lvl,
              b.abrv_posi_nm, b.join_ymd
            from msg_user_master a, msg_staff_info b, msg_staff_dept_info c
            where a.users_id = b.users_id
            and a.domain = b.domain
            and b.org_cd = c.org_cd
            --AND c.org_cd = p_org_code
            AND a.user_nm like p_keyword||'%'
            /*union all
            select
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              '' org_cd, '' org_nm, '' team_nm, '' lvl,
              '' abrv_posi_nm, '' join_ymd
            from msg_user_master a
            where a.user_type in ('1', '2')
            AND a.user_nm like p_keyword||'%'*/
          )
        order by user_type desc, user_nm
        )
      )
      WHERE rnum >= p_start_num  and rownum <= p_range;
      return ref_csr;
  end sf_get_emp_sch_by_name;

  /*
  * 직원이 이름으로 검색(검색대상:고객, 부서내직원)
  */
  function sf_get_emp_sch_by_id(p_org_code in varchar2,
                                  p_keyword in varchar2,
                                  p_start_num in number,
                                  p_range in number) return CursorType is
  ref_csr CursorType;
  begin
      open ref_csr for
      select
        user_type, users_id, user_nm, mobile_phone, rsn_no,
        org_cd, org_nm, team_nm, lvl, abrv_posi_nm,
        join_ymd, tot_cnt, rnum, rownum
      from
      (
        select
          user_type, users_id, user_nm, mobile_phone, rsn_no,
          org_cd, org_nm, team_nm, lvl, abrv_posi_nm,
          join_ymd, tot_cnt, rownum rnum
        from
        (
          select
            user_type, users_id||'@'||domain users_id, user_nm, mobile_phone, rsn_no,
            org_cd, org_nm, team_nm, lvl, abrv_posi_nm,
            join_ymd, count(*) over() tot_cnt
          from
          (
            select
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              c.org_cd, c.org_nm, b.team_nm, b.lvl,
              b.abrv_posi_nm, b.join_ymd
            from msg_user_master a, msg_staff_info b, msg_staff_dept_info c
            where a.users_id = b.users_id
            and a.domain = b.domain
            and b.org_cd = c.org_cd
            --AND c.org_cd = p_org_code
            AND a.users_id like p_keyword||'%'
            /*union all
            select
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              '' org_cd, '' org_nm, '' team_nm, '' lvl,
              '' abrv_posi_nm, '' join_ymd
            from msg_user_master a
            where domain = 'ibk.co.kr'
            AND a.users_id like p_keyword||'%'*/
          )
        order by user_type desc, user_nm
        )
      )
      WHERE rnum >= p_start_num  and rownum <= p_range;
      return ref_csr;
  end sf_get_emp_sch_by_id;


  /*
  * 직원이 검색(검색대상:고객, 부서내직원)
  */
  /*function sf_get_emp_sch(p_org_code in varchar2,
                          p_sch_type in varchar2,
                          p_keyword in varchar2,
                          p_start_num in number,
                          p_range in number) return CursorType is
  ref_csr CursorType;
  begin
       open ref_csr for
       select
            user_type, rnum, users_id||'@'||domain users_id, user_nm, mobile_phone, rsn_no,
            chrg_man_nm, chrg_man_tel, org_nm, team_nm, lvl, abrv_posi_nm,
            join_ymd, tot_cnt
       from
       (
         SELECT --index(a, ix3_msg_user_master)
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              a.chrg_man_nm, a.chrg_man_tel, c.org_nm, b.team_nm, b.lvl,
              b.abrv_posi_nm, b.join_ymd, count(*) over() tot_cnt, rownum rnum
         FROM msg_user_master a, msg_staff_info b, msg_staff_dept_info c
         WHERE p_sch_type = 'user_nm'
         AND a.users_id = b.users_id(+)
         AND a.domain = b.domain(+)
         AND b.org_cd = c.org_cd
         AND c.org_cd = p_org_code
         AND a.user_nm like p_keyword||'%'
         AND a.user_type in ('1', '2', '3')
         UNION ALL
         SELECT --use_nl(a, b, c) index(a, ix4_msg_user_master)
              a.user_type, a.users_id, a.domain, a.user_nm, a.mobile_phone, a.rsn_no,
              a.chrg_man_nm, a.chrg_man_tel, c.org_nm, b.team_nm, b.lvl,
              b.abrv_posi_nm, b.join_ymd, count(*) over() tot_cnt, rownum rnum
         FROM msg_user_master a, msg_staff_info b, msg_staff_dept_info c
         WHERE p_sch_type = 'users_id'
         AND a.users_id = b.users_id(+)
         AND a.domain = b.domain(+)
         AND b.org_cd = c.org_cd
         AND c.org_cd = p_org_code
         AND a.users_id like p_keyword||'%'
         AND b.org_cd = to_number(p_org_code)
         AND a.user_type in ('1', '2', '3')
       )
       WHERE rnum >= p_start_num  and rownum<=p_range;
       return ref_csr;
  end sf_get_emp_sch;*/

end PKG_SEARCH;
/

prompt
prompt Creating package body PKG_STAFF_ORG_INFO
prompt ========================================
prompt
create or replace package body kebiim.PKG_STAFF_ORG_INFO is

  /* 자기 부서 이하의 부서와 구성원 정보를 가지고 온다.
  *
  */
  function sf_get_org_list(p_org_cd in varchar2,
                           p_cur_lev in number) return CursorType is
  ref_csr CursorType;
  pp_org_cd varchar2(50);
  begin

       IF p_org_cd is null or p_org_cd = ' ' THEN
         pp_org_cd := '_TOP';
       ELSE
         pp_org_cd := p_org_cd;
       END IF;
       open ref_csr for
       select
           '0' flag, org_cd, prnt_org_cd, org_nm, lev,
           '' domain, cast('' as VARCHAR2(100)) abrv_posi_nm, cast('' as VARCHAR2(100)) lvl, sort_no, '' mobile_phone
      from
      (
        select /*+rule*/
              a.org_cd, a.prnt_org_cd, a.org_nm, a.sort_no, level lev
        from msg_staff_dept_info a
        start with a.prnt_org_cd = pp_org_cd  and sort_no > 0 and a.org_nm > ' '
        connect by prior a.prnt_org_cd = a.org_cd and sort_no > 0 and a.org_nm > ' '
        order by sort_no
      ) a
      where a.lev <= p_cur_lev + 1
      and a.lev > p_cur_lev
      union all
      select
        '1'  flag,  b.users_id org_cd, b.org_cd prnt_org_cd, c.user_nm org_nm, 0 lev,
        b.domain, b.team_nm||' '||b.abrv_posi_nm, b.lvl, b.sort_no, c.mobile_phone
      from msg_staff_dept_info a, msg_staff_info b, msg_user_master c
      where a.org_cd = b.org_cd
      and b.users_id = c.users_id
      and b.domain = c.domain
      and a.org_cd = pp_org_cd;
        /*select
             '0' flag, org_cd, prnt_org_cd, org_nm, lev,
             '' domain, '' abrv_posi_nm, '' lvl, 0 sort_no, '' mobile_phone
        from
        (
          select
             a.org_cd, a.prnt_org_cd, a.org_nm, level lev
          from msg_staff_dept_info a
          start with a.org_cd = p_org_cd
          connect by prior a.org_cd = a.prnt_org_cd
        ) a
        where a.lev <= p_cur_lev + 1
        and a.lev > p_cur_lev
        union all
        select
          '1'  flag,  b.users_id org_cd, b.org_cd prnt_org_cd, c.user_nm org_nm, 0 lev,
          b.domain, b.abrv_posi_nm, b.lvl, b.sort_no, c.mobile_phone
        from msg_staff_dept_info a, msg_staff_info b, msg_user_master c
        where a.org_cd = b.org_cd
        and b.users_id = c.users_id
        and b.domain = c.domain
        and a.org_cd = p_org_cd;*/
       return ref_csr;
  end sf_get_org_list;

  function sf_get_org_list_all return cursorType is
  ref_csr CursorType;
  begin
    open ref_csr for

    select
           '0' flag, org_cd, prnt_org_cd, org_nm, lev,
           '' domain, cast('' as VARCHAR2(100)) abrv_posi_nm, cast('' as VARCHAR2(100)) lvl, sort_no, '' mobile_phone
   from
   (
    SELECT /*+rule*/
      org_cd, prnt_org_cd, org_nm, sort_no, level lev
    FROM msg_staff_dept_info
    START WITH prnt_org_cd = '_TOP' and sort_no > 0 and org_nm > ' '
    CONNECT BY PRIOR org_cd = prnt_org_cd and sort_no > 0 and org_nm > ' '
    ORDER BY lev, sort_no
   )
   union all
   select /*+index(a, ix1_msg_staff_info)*/
     '1'  flag,  b.users_id org_cd, b.org_cd prnt_org_cd, c.user_nm org_nm, 0 lev,
     b.domain, b.team_nm||' '||b.abrv_posi_nm, b.lvl, b.sort_no, c.mobile_phone
   from msg_staff_dept_info a, msg_staff_info b, msg_user_master c
   where a.org_cd = b.org_cd
   and b.users_id = c.users_id
   and b.domain = c.domain
   and b.org_cd > ' ';
   return ref_csr;
  end sf_get_org_list_all;



  function sf_get_emp_info(p_domain in varchar2,
                           p_users_id in varchar2,
                           p_org_cd in varchar2) return CursorType is
  ref_csr CursorType;
  begin
       open ref_csr for

            select
              '' pic_path, a.users_id, a.domain, c.user_nm, decode(substr(rsn_no, 7, 1), '1', 'M', '2', 'F', '3', 'M', '4', 'F') sex,
              to_number(to_char(sysdate, 'yyyy')) - to_number(decode(sign(2 - to_number(substr(rsn_no, 7, 1))), 1, '19', 0, '19', '20')||substr(rsn_no, 0, 2)) + 1 age,
              b.org_nm, a.team_nm, a.abrv_posi_nm, a.lvl, '' email, a.corp_teno, c.mobile_phone,
              a.join_ymd,
              decode(d.usercurrentstatus, null, '-1', d.usercurrentstatus) usercurrentstatus
            from msg_staff_info a, msg_staff_dept_info b, msg_user_master c, msg_user_info d
            where a.org_cd = b.org_cd
            and a.users_id = c.users_id
            and a.domain = c.domain
            and a.users_id = d.users_id
            and a.domain = d.domain
            and a.users_id = p_users_id
            and a.domain = p_domain
            and a.org_cd = p_org_cd;

       return ref_csr;

  end sf_get_emp_info;

  function sf_get_org_emp_list(p_org_cd in varchar2) RETURN CursorType IS
  ref_csr CursorType;
  BEGIN
       OPEN ref_csr FOR
       select users_id,
              domain
         from msg_staff_info
        where org_cd = p_org_cd;
        RETURN ref_csr;
  END sf_get_org_emp_list;

end PKG_STAFF_ORG_INFO;
/


spool off
