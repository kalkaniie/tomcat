CREATE TABLE CLUB_GROUP_MASTER
(		group_idx INT UNSIGNED NOT NULL AUTO_INCREMENT,    
    group_name VARCHAR(100),
    ref_idx INT UNSIGNED,
    depth int unsigned,
    domain varchar(100),    
    PRIMARY KEY CLUB_GROUP_MASTER_PK (group_idx,domain),
    INDEX CLUB_GROUP_MASTER_IX1 (group_idx, ref_idx),
    INDEX CLUB_GROUP_MASTER_IX2 (ref_idx),    
    INDEX CLUB_GROUP_MASTER_IX4 (group_idx),
    INDEX CLUB_GROUP_MASTER_IX3 (domain),
    FOREIGN KEY CLUB_GROUP_MASTER_FK1 (domain) REFERENCES DOMAIN(domain) ON DELETE CASCADE ON UPDATE CASCASE
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

#####################################여기까지 CLUB

#####################################여기부터 SMS
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


LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/sms_emoti_flag.txt' INTO TABLE SMS_EMOTI_FLAG;
LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/sms_emoticon.txt' INTO TABLE SMS_EMOTICON;
LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/zipcode.txt' INTO TABLE ZIPCODE;
LOAD DATA INFILE '/usr/local/kebi/orion/nara/properties/database/mysql/ecard.txt' INTO TABLE ECARD;
