DROP TABLE NOTE_RECONF CASCADE CONSTRAINTS;

DROP TABLE REL_NOTE_ATTACHE CASCADE CONSTRAINTS;

DROP TABLE NOTE_ATTACHE CASCADE CONSTRAINTS;

DROP TABLE NOTE_devkebicom CASCADE CONSTRAINTS;

CREATE TABLE NOTE_ATTACHE
(
	NOTE_ATTACHE_IDX  NUMBER  NOT NULL ,
	NOTE_ATTACHE_LOCATION  VARCHAR2(200) NOT  NULL,
	NOTE_ATTACHE_LOGICAL_NM  VARCHAR2(100)  NOT NULL ,
	NOTE_ATTACHE_PHYSICAL_NM  VARCHAR2(100)  NOT NULL ,
	NOTE_ATTACHE_SIZE  NUMBER  NULL
);

ALTER TABLE NOTE_ATTACHE
	ADD  PRIMARY KEY (NOTE_ATTACHE_IDX);


CREATE TABLE NOTE_devkebicom
(
	NOTE_IDX  NUMBER  NOT NULL ,
	USERS_IDX  VARCHAR2(200)  NOT NULL,
	USERS_ID  VARCHAR2(200)  NOT NULL ,
	DOMAIN  VARCHAR2(200)  NOT NULL ,
	NOTE_BOX_TYPE  NUMBER(1)  NOT NULL ,
	NOTE_SAVE_YN  CHAR(1)  DEFAULT 'N' NOT NULL ,
	NOTE_FROM  VARCHAR2(2000)  NULL ,
	NOTE_TO  VARCHAR2(2000)  NULL ,
	NOTE_CONTENT  NCLOB  NULL ,
	NOTE_TIME  DATE  NULL ,
	REF_NOTE_IDX  NUMBER  NULL,
	NOTE_ISREAD CHAR(1) DEFAULT 'N' NOT NULL
);

ALTER TABLE NOTE_devkebicom
	ADD  PRIMARY KEY (NOTE_IDX);

CREATE TABLE NOTE_RECONF
(
	NOTE_RECONF_IDX  NUMBER  NOT NULL,
	USERS_IDX  VARCHAR2(200)  NOT NULL ,
	NOTE_IDX  NUMBER  NOT NULL ,
	NOTE_RECONF_TO  VARCHAR2(200)  NULL ,
	NOTE_RECONF_TO_ORI  VARCHAR2(200)  NULL ,
	NOTE_SEND_TIME  DATE  NULL ,
	NOTE_READ_TIME  DATE  NULL ,
	NOTE_SEND_IDX  NUMBER  NULL ,
	NOTE_RECONF_STATE  NUMBER(1)  NULL
);

ALTER TABLE NOTE_RECONF
	ADD  PRIMARY KEY (NOTE_RECONF_IDX);


CREATE TABLE REL_NOTE_ATTACHE
(
	NOTE_IDX  NUMBER  NULL ,
	NOTE_ATTACHE_IDX  NUMBER  NULL 
);


CREATE INDEX IDX_REL_NOTE_ATTACHE1 ON REL_NOTE_ATTACHE
(
	NOTE_IDX  ASC
);


CREATE INDEX IDX_REL_NOTE_ATTACHE2 ON REL_NOTE_ATTACHE
(
	NOTE_ATTACHE_IDX  ASC
);

DROP SEQUENCE SEQ_NOTE_devkebicom;
DROP SEQUENCE SEQ_NOTE_ATTACHE;
DROP SEQUENCE SEQ_NOTE_RECONF;

CREATE SEQUENCE SEQ_NOTE_devkebicom;
CREATE SEQUENCE SEQ_NOTE_ATTACHE;
CREATE SEQUENCE SEQ_NOTE_RECONF;