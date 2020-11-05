###################################################################################################
# 주의> 스크립트를 수행하기 전에 $DOMAIN 변수명을 DB에 생성하는 도메인명으로 교체한 후 실행하세요.#
#       ex) :%s/$DOMAIN/sookmyungackr/g                                                           #
###################################################################################################

#발송 취소 기능
ALTER TABLE MAIL_RECONF ADD  MAIL_RECONF_MESSAGE_ID varchar(255);
CREATE INDEX INDEX_MAIL_RECONF_MESSAGE_ID ON MAIL_RECONF(MAIL_RECONF_MESSAGE_ID);


#수신확인 기능에서 메일원본 확인/재발송 기능
ALTER TABLE MAIL_RECONF ADD MAIL_RECONF_M_IDX INT;
CREATE INDEX INDEX_MAIL_RECONF_M_IDX ON MAIL_RECONF(MAIL_RECONF_M_IDX);


#Tree구조 메일박스 지원
ALTER TABLE MBOX ADD  MBOX_REF INT NOT NULL DEFAULT '0';


#멀티계정
ALTER TABLE USERS TYPE=InnoDB;

ALTER TABLE DOMAIN TYPE=InnoDB;

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
     FOREIGN KEY(USERS_IDX) REFERENCES USERS(USERS_IDX) ON DELETE CASCADE,
     FOREIGN KEY(DOMAIN) REFERENCES DOMAIN(DOMAIN) ON DELETE CASCADE
)type=InnoDB;

ALTER TABLE DOMAIN ADD DOMAIN_ACCOUNT_LIMIT INT NOT NULL DEFAULT '0'; /*개인당 멀티 계정 최대수*/


#하루 발송할 수 있는 최대 편지 수 제한
ALTER TABLE DOMAIN ADD  DOMAIN_MAIL_QUOTA INT NOT NULL DEFAULT '0';
ALTER TABLE USERS  ADD  USERS_MAIL_QUOTA INT NOT NULL DEFAULT '0';


#메일 발송 베너
ALTER TABLE DOMAIN ADD DOMAIN_MAIL_BANNER  TINYINT NOT NULL DEFAULT '0';  /*메일 발송 베너 사용여부 0:사용안함 1:사용함*/
ALTER TABLE DOMAIN ADD DOMAIN_MAIL_BANNER_TEXT TEXT;			/*메일 발송용 베너 내용*/

#D-DAY 기능
ALTER TABLE SCHEDULE ADD SCHEDULE_DDAY  TINYINT NOT NULL DEFAULT '0';  /*D-DAY 0:사용안함 1:사용함*/


#게시판 복수 첨부파일 지원 
ALTER TABLE B_$DOMAIN MODIFY B_ATTACHE VARCHAR(255);


#게시판 교체
	CREATE TABLE B_$DOMAIN_TEMP 
	 (B_IDX INT unsigned NOT NULL auto_increment primary key,
	  BBS_IDX					INT,
	  B_REF						INT,
	  B_STEP					MEDIUMINT	unsigned,
	  B_LEVEL					MEDIUMINT	unsigned,
	  USERS_IDX 			VARCHAR(200),
	  B_PASSWD				VARCHAR(100),
	  B_NAME					VARCHAR(100),
	  B_EMAIL					VARCHAR(200),
	  B_TITLE					VARCHAR(255),
	  B_CONTENT				TEXT,
	  B_CONTENT_TYPE	CHAR(1),
	  B_DATE					VARCHAR(20),
	  B_ATTACHE 			VARCHAR(200),
	  B_ATTACHE_SIZE	INT,
	  B_READ_NUM 			INT,
	  B_DOWNLOAD_NUM 	INT,
	  B_APPEND_NUM 		INT,
	  INDEX B_$DOMAIN_TEMP_INDEX (BBS_IDX,B_REF,B_STEP));
                      
  INSERT INTO B_$DOMAIN_TEMP(
    SELECT 
    B_IDX,
    BBS_IDX, 
    B_REF,
    B_STEP,
    B_LEVEL,
    USERS_IDX, 
    B_PASSWD, 
    B_NAME,
    B_EMAIL,
    B_TITLE,
    B_CONTENT,
    B_CONTENT_TYPE,
    B_DATE, 
    B_ATTACHE,
    B_ATTACHE_SIZE,
    B_READ_NUM,
    B_DOWNLOAD_NUM, 
    B_APPEND_NUM 
    FROM B_$DOMAIN
  );
  
  ALTER TABLE B_$DOMAIN RENAME B_$DOMAIN_BACK;
  
  ALTER TABLE B_$DOMAIN_TEMP RENAME B_$DOMAIN;
  
  
#홈페이지 게시판 변환
	CREATE TABLE H_$DOMAIN_TEMP 
	 (B_IDX INT unsigned NOT NULL auto_increment primary key,
	  BBS_IDX					INT,
	  B_REF						INT,
	  B_STEP					MEDIUMINT	unsigned,
	  B_LEVEL					MEDIUMINT	unsigned,
	  B_PASSWD				VARCHAR(100),
	  B_NAME					VARCHAR(100),
	  B_EMAIL					VARCHAR(200),
	  B_TITLE					VARCHAR(255),
	  B_CONTENT				TEXT,
	  B_CONTENT_TYPE	CHAR(1),
	  B_DATE					VARCHAR(20),
	  B_ATTACHE 			VARCHAR(200),
	  B_ATTACHE_SIZE	INT,
	  B_READ_NUM 			INT,
	  B_DOWNLOAD_NUM 	INT,
	  B_APPEND_NUM 		INT,
	  B_HOST 					VARCHAR(100),
	  INDEX H_$DOMAIN_TEMP_INDEX (BBS_IDX,B_REF,B_STEP));  
  
  INSERT INTO H_$DOMAIN_TEMP(
    SELECT 
    B_IDX,
    BBS_IDX,
    B_REF,
    B_STEP,
    B_LEVEL,
    B_PASSWD,
    B_NAME,
    B_EMAIL,
    B_TITLE,
    B_CONTENT,
    B_CONTENT_TYPE,
    B_DATE,
    B_ATTACHE,
    B_ATTACHE_SIZE,
    B_READ_NUM,
    B_DOWNLOAD_NUM,
    B_APPEND_NUM,
    B_HOST 
    FROM H_$DOMAIN
  );
  
  ALTER TABLE H_$DOMAIN RENAME H_$DOMAIN_BACK;
  
  ALTER TABLE H_$DOMAIN_TEMP RENAME H_$DOMAIN;
  
  
#예약메일 취소기능
ALTER TABLE RESERVATION ADD MAIL_RECONF_IDX  INT NOT NULL DEFAULT '0';  /*수신확인 인덱스 코드*/


#게시판 상단 TOP글 설정
CREATE TABLE BBS_TOP
(    BBS_IDX  INT unsigned  NOT NULL,
     B_IDX    INT unsigned  NOT NULL,
     primary key BBS_TOP_PK (BBS_IDX,B_IDX)
)type=InnoDB;


#휴면계정 자동정지 기능
ALTER TABLE DOMAIN ADD DOMAIN_PAUSE_DAYS  INT NOT NULL DEFAULT '0';  /*휴지 기간(일)*/


#마이네임
ALTER TABLE USERS ADD USERS_MEMO TEXT;  /*개인 소개 글*/

#조직도 관련 추가 필드
ALTER TABLE USER_GROUP ADD USER_GROUP_STRUCTURE TINYINT; /*조직도 사용 여부 0:불가능 1:가능 DEFAULT:0*/


#CLUB & SMS 

#####################################여기부터 CLUB
#동회회 분류 정보
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
    FOREIGN KEY CLUB_GROUP_MASTER_FK1 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE
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
    FOREIGN KEY CLUB_INFO_FK1 (group_idx) REFERENCES CLUB_GROUP_MASTER(group_idx) ON DELETE CASCADE,
    FOREIGN KEY CLUB_INFO_FK2 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE
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
    FOREIGN KEY CLUB_PRIDE_FK1 (club_idx) REFERENCES CLUB_INFO(club_idx) ON DELETE CASCADE,
    FOREIGN KEY CLUB_PRIDE_FK2 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE
) TYPE=INNODB;

CREATE TABLE CLUB_USER
(    
    club_idx INT UNSIGNED NOT NULL,    
    users_idx varchar(100) NOT NULL,
    auth char(1),
    reg_dt DATETIME,
    primary key CLUB_USER_PK (users_idx, club_idx),        
    INDEX CLUB_USER_IX1 (club_idx),
    FOREIGN KEY CLUB_USER_FK1 (club_idx) REFERENCES CLUB_INFO(club_idx) ON DELETE CASCADE,
    INDEX CLUB_USER_IX2 (users_idx),
    FOREIGN KEY CLUB_USER_FK2 (users_idx) REFERENCES USERS(users_idx) ON DELETE CASCADE
) TYPE=INNODB;

#게시판기본정보
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
    FOREIGN KEY CLUB_BBS_MASTER_FK1 (club_idx) REFERENCES CLUB_INFO(club_idx) ON DELETE CASCADE    
) TYPE=INNODB;


#게시판 실체 정보
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
    FOREIGN KEY CLUB_BBS_FK1 (bbs_idx) REFERENCES CLUB_BBS_MASTER(bbs_idx) ON DELETE CASCADE    
) TYPE=INNODB;

#한줄 답변
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
    FOREIGN KEY CLUB_SIMPLE_REPLY_FK1 (bbs_seq_no, bbs_idx) REFERENCES CLUB_BBS(seq_no, bbs_idx) ON DELETE CASCADE   
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
    FOREIGN KEY CLUB_CONF_FK1 (domain) REFERENCES DOMAIN(domain) on DELETE CASCADE
) TYPE=INNODB;


#####################################여기까지 CLUB


#####################################여기부터 SMS
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
FOREIGN KEY sms_emoticon_fk1 (flag_no) REFERENCES SMS_EMOTI_FLAG(flag_no) on DELETE CASCADE
) TYPE=INNODB;


LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/sms_emoti_flag.txt' INTO TABLE SMS_EMOTI_FLAG;
LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/sms_emoticon.txt' INTO TABLE SMS_EMOTICON;
LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/zipcode.txt' INTO TABLE ZIPCODE;
LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/ecard.txt' INTO TABLE ECARD;

#####################################여기까지 SMS

#CLUB_CONF에 데이터 밀어넣어준다.
INSERT CLUB_CONF(
domain,
photo_image,
site_image,
attachdir,
rownum,
bbs_size,
attachsize,
autocommit,
photo_rownum,
blocknum,
middlecategory,
last_modified,
title_img,
info_img,
info_bgimg,
notice_img,
recent_img,
root_dir)
values
('$DOMAIN',
'/photo',
'/site_image',
'/attach',
20,
10,
100,
'true',
6,
10,
20,
1099032003643,
'main_club_body_skin01_0.gif',
'default_club.gif',
'main_club_body_skin02_0.gif',
'main_club_body_skin03_0.gif',
'main_club_body_skin04_0.gif',
'/club'
);
