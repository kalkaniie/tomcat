CREATE TABLE DOMAIN
(    DOMAIN                     VARCHAR(100) NOT NULL primary key ,       /*ȸ���� ������ ��*/
     DOMAIN_TYPE                CHAR(1),                        /*���Ա��� C:��� (��ü)   P:����*/
     DOMAIN_NAME                VARCHAR(100),                   /*����,ȸ���,�б���*/
     DOMAIN_JOB                 VARCHAR(4),                     /*�������� �ڵ�*/
     DOMAIN_TEL                 VARCHAR(20),                    /*���� ���� ��ȭ��ȣ*/
     DOMAIN_ZIPCODE             VARCHAR(10),                    /*�����ȣ*/
     DOMAIN_ADDRESS1            VARCHAR(100),                   /*�ּ�  ���� ���� �ּ�*/
     DOMAIN_ADDRESS2            VARCHAR(100),                   /*�����ּ�*/
     DOMAIN_HOMEPAGE            VARCHAR(100),                   /*Ȩ������ �ּ� Ȩ������ �ּ�*/
     DOMAIN_AGREEMENT           CHAR(1),                        /*��Ͼ����뿩�� Y: ��� N : ������ DEFAULT Y*/
     DOMAIN_AGREEMENT_STMT      TEXT,                           /*��Ͼ�� ���� ��Ͼ�� ����*/
     DOMAIN_GREETINGS           CHAR(1),                        /*�����λ縻 ��뿩�� Y: ��� N : ������ DEFAULT Y*/
     DOMAIN_GREETINGS_FROM      VARCHAR(200),                   /*�����λ� �߼��� �̸���*/
     DOMAIN_GREETINGS_TITLE     TEXT,                           /*�����λ� ����*/
     DOMAIN_GREETINGS_CONTENTTYPE       VARCHAR(20),            /*�����λ縻 ���� TYPE*/
     DOMAIN_GREETINGS_CONTENT   TEXT,                           /*�����λ縻 ����*/
     DOMAIN_CERTIFY             CHAR(1),                        /*����Y: ��밡��  N : ���Ұ��� DEFAULT N */
     DOMAIN_JOIN_CERTIFY        CHAR(1),                        /*ȸ�����Խ� ����Ű��뿩��     Y: ��� N : ������ DEFAULT N */
     DOMAIN_JOIN_CERTIFY_OPT    CHAR(1),                        /*�Ѱ� ����Ű�� �Ѹ� ���     Y: ��� N : ������ DEFAULT N */
     DOMAIN_JOIN_WAY            TINYINT unsigned ,              /*����� ���Թ��       1.�������� 2.������ ���� 3.������ ���� 4.���Ծ��� (DEFAULT:1)*/
     DOMAIN_GROUP_OPT           TINYINT unsigned ,              /*�׷켳�����  1.���Խ� ���� 2.������ ����(DEFAULT:1)*/
     DOMAIN_JOIN_REQUIRED_ITEM  VARCHAR(100),                   /*�����ʼ� �׸� 1.�ֹι�ȣ  2.����  3.�������  4.���� 5.��ȭ��ȣ  6.����   7.�б�/�����   8.�а�/�μ��� 9.�ּ�  10.�й�/���   11.�������� e-mail (DEFAULT="1")*/
     DOMAIN_JOIN_CERTIFY_ITEM   VARCHAR(100),                   /*���������׸�  1.�̸�  2.�ֹι�ȣ  3.�й�/���   4�а�/�μ��� (DEFAULT:1,2)*/
     DOMAIN_JOINDATE            DATETIME,                       /*�����Ͻ�*/
     DOMAIN_EXPIREDDATE         DATETIME,                       /* ���� ��������*/
     DOMAIN_LANG                VARCHAR(10),                    /*������ ���� DEFAULT : CONFIG������ ����*/
     DOMAIN_FUNCTION_KEY        VARCHAR(20),                    /*�����κ� �޴���뿩��(�����κ� �޴���뿩��(�����κ� �޴���뿩��(������,POP3,��������,���ϰ���,���ͳݵ�ũ,�Խ���,��Ʈ���,�޽���,Ȩ������,SMS default:1111111111) */
     DOMAIN_LIMIT_STORAGE       INT,                            /*��������ü ��뷮 ���� DEFAULT = -1(���Ѿ���)*/
     DOMAIN_LIMIT_USERS         INT,                            /*������ ������ ����  DEFAULT = -1(���Ѿ���)*/
     DOMAIM_LIMIT_FORWARD       MEDIUMINT       unsigned ,      /*���� ���������� ���� ���� DEFAULT = 10*/
     DOMAIN_LIMIT_UPLOAD        MEDIUMINT       unsigned ,      /*÷������ �뷮 ���� DEFAULT = 10*/
     DOMAIN_USER_VOLUME         MEDIUMINT       unsigned ,      /*����� �⺻ �뷮 DEFAULT=20*/
     DOMAIN_MEMO                TEXT,                           /*�޸�*/
     DOMAIN_DISPLAY_TOP         CHAR(1),                        /*������ ��� ǥ�� ���� Y: ��� N : ������ DEFAULT Y*/
     DOMAIN_DISPLAY_BOTTOM      CHAR(1),                        /*������ �ϴ� ǥ�� ���� Y: ��� N : ������ DEFAULT Y*/
     DOMAIN_DISPLAY_MENU        CHAR(1),                        /*������ �޴� ǥ�� ���� Y: ��� N : ������ DEFAULT Y*/
     DOMAIN_DISPLAY_MENU_POSITION       CHAR(1),                /*�޴� ��ġ     L:�����޴� ��� R:�����޴���� DEFAULT L*/
     DOMAIN_TABLE_PIX           MEDIUMINT       unsigned ,      /*��ü���̺�ũ��*/
     DOMAIN_TOP_PIX             MEDIUMINT       unsigned ,      /*��������� */
     DOMAIN_LEFT_SPACE          MEDIUMINT       unsigned ,      /*�������� */
     DOMAIN_BOTTOM_SPACE        MEDIUMINT       unsigned ,      /*�ϴܿ��� */
     DOMAIN_DISPLAY_BGIMG       CHAR(1),                        /*����̹��� ��뿩��.  Y:���, N:������.  DEFAULT:N*/
     DOMAIN_BGIMG               VARCHAR(50),                    /*��׶��� �̹���*/
     DOMAIN_BGCOLOR             VARCHAR(10),                    /*��׶��� COLOR*/
     DOMAIN_TXT_COPY            VARCHAR(200),                   /*Copyright ����*/
     DOMAIN_COLOR_SKIN          CHAR(1),                        /*Į����        DEFAULT G(GRAY)*/
     DOMAIN_COLOR_TXT           VARCHAR(10),                    /*�⺻ ���ڻ�*/
     DOMAIN_COLOR_TOPTXT        VARCHAR(10),                    /*��� ���ڻ�*/
     DOMAIN_BGCOLOR_MENU        VARCHAR(10),                    /*�޴� ����*/
     DOMAIN_BGCOLOR_BTN         VARCHAR(10),                    /*�ϴ� ����*/
     DOMAIN_COLOR_ALINK         VARCHAR(10),                    /*��ũ�� ���ڻ�*/
     DOMAIN_BGCOLOR_TOP         VARCHAR(10),                    /*��� ����*/
     DOMAIN_BGCOLOR_TABLE       VARCHAR(10),                    /*���̺� ����*/
     DOMAIN_COLOR_TABLELINE     VARCHAR(10),                    /*���̺� ���λ�*/
     DOMAIN_COLOR_COPY          VARCHAR(10),                    /*Copyright ���ڻ�*/
     DOMAIN_TOP_HTML_USE        CHAR(1),                          /*��������� HTML��뿩��*/
     DOMAIN_TOP_HTML            VARCHAR(50),                    /*��������� HTML��*/
     DOMAIN_TOP_BGCOLOR         VARCHAR(10),                    /*��������� ����*/
     DOMAIN_DISPLAY_TOP_BGIMG   CHAR(1),                        /*����̹��� ��뿩��.  Y:���, N:������.  DEFAULT:N*/
     DOMAIN_TOP_BGIMG           VARCHAR(50),                    /*��������� ����̹���*/
     DOMAIN_TOP_BTN             MEDIUMINT,                          /*��������� �޴�����*/
     DOMAIN_TOP_BTNCOLOR        VARCHAR(10),                    /*��������� �޴� ���ڻ�*/
     DOMAIN_TOP_MENU_POS        TINYINT,                        /*��������� �޴���ġ*/
     DOMAIN_DISPLAY_LOGO        CHAR(1),                        /*����̹��� ��뿩��.  Y:���, N:������.  DEFAULT:N*/
     DOMAIN_LOGO                VARCHAR(50),                      /*��������� �ΰ�*/
     DOMAIN_LOGO_TXT            VARCHAR(200),                   /*��������� ȫ������*/
     DOMAIN_LOGO_TXTCOLOR       VARCHAR(10),                    /*��������� ȫ��������*/
     DOMAIN_BTN_CNT             TINYINT         unsigned ,      /*��������� ���� ����*/
     DOMAIN_TABLE_POS           CHAR(1),                        /*��ü���̺���ġ        L:���� ��� R:���� C:�߾� DEFAULT L*/
     DOMAIN_INPUT_TXT           VARCHAR(10),                    /*�ؽ�Ʈ�ڽ� ���λ� */
     DOMAIN_LOGO_LINK           VARCHAR(255),                   /*�ΰ�ũ*/
     DOMAIN_MOTO_USE            CHAR(1),                        /*���ΰ� ��뿩��       Y:���, N:������. DEFAULT N*/
     DOMAIN_MENU_PIX            MEDIUMINT       unsigned ,      /*�޴��ȼ�      DEFAULT 146*/
     DOMAIN_BTN1_TITLE          VARCHAR(40),                    /*1��° �����̸�*/
     DOMAIN_BTN1_LINK           VARCHAR(255),                   /*1��° ���ϸ�ũ*/
     DOMAIN_BTN1_TARGET         VARCHAR(40),                    /*1��° ���� Ÿ��*/
     DOMAIN_BTN1_ALT            VARCHAR(60),                    /*1��° ���� ALT*/
     DOMAIN_BTN2_TITLE          VARCHAR(40),                    /*2��° �����̸�*/
     DOMAIN_BTN2_LINK           VARCHAR(255),                   /*2��° ���ϸ�ũ*/
     DOMAIN_BTN2_TARGET         VARCHAR(40),                    /*2��° ���� Ÿ��*/
     DOMAIN_BTN2_ALT            VARCHAR(60),                    /*2��° ���� ALT*/
     DOMAIN_BTN3_TITLE          VARCHAR(40),                    /*3��° �����̸�*/
     DOMAIN_BTN3_LINK           VARCHAR(255),                   /*3��° ���ϸ�ũ*/
     DOMAIN_BTN3_TARGET         VARCHAR(40),                    /*3��° ���� Ÿ��*/
     DOMAIN_BTN3_ALT            VARCHAR(60),                    /*3��° ���� ALT*/
     DOMAIN_BTN4_TITLE          VARCHAR(40),                    /*4��° �����̸�*/
     DOMAIN_BTN4_LINK           VARCHAR(255),                   /*4��° ���ϸ�ũ*/
     DOMAIN_BTN4_TARGET         VARCHAR(40),                    /*4��° ���� Ÿ��*/
     DOMAIN_BTN4_ALT            VARCHAR(60),                    /*4��° ���� ALT*/
     DOMAIN_BTN5_TITLE          VARCHAR(40),                    /*5��° �����̸�*/
     DOMAIN_BTN5_LINK           VARCHAR(255),                   /*5��° ���ϸ�ũ*/
     DOMAIN_BTN5_TARGET         VARCHAR(40),                    /*5��° ���� Ÿ��*/
     DOMAIN_BTN5_ALT            VARCHAR(60),                    /*5��° ���� ALT*/
     DOMAIN_BTN6_TITLE          VARCHAR(40),                    /*6��° �����̸�*/
     DOMAIN_BTN6_LINK           VARCHAR(255),                   /*6��° ���ϸ�ũ*/
     DOMAIN_BTN6_TARGET         VARCHAR(40),                    /*6��° ���� Ÿ��*/
     DOMAIN_BTN6_ALT            VARCHAR(60),                    /*6��° ���� ALT*/
     DOMAIN_BTN7_TITLE          VARCHAR(40),                    /*7��° �����̸�*/
     DOMAIN_BTN7_LINK           VARCHAR(255),                   /*v7��° ���ϸ�ũ*/
     DOMAIN_BTN7_TARGET         VARCHAR(40),                    /*7��° ���� Ÿ��*/
     DOMAIN_BTN7_ALT            VARCHAR(60),                    /*7��° ���� ALT*/
     DOMAIN_SMS_LIMIT           INT,                                    /*SMS ����� �߼۰Ǽ�*/
     DOMAIN_MAIL_QUOTA  INT NOT NULL DEFAULT '0', /*���� �߼� ���� default = 0,  ������ : 0*/
     DOMAIN_MAIL_BANNER  TINYINT NOT NULL DEFAULT '0',  /*���� �߼� ���� ��뿩�� 0:������ 1:�����*/
     DOMAIN_MAIL_BANNER_TEXT TEXT,                      /*���� �߼ۿ� ���� ����*/
     DOMAIN_ACCOUNT_LIMIT INT NOT NULL DEFAULT '0',   /*���δ� ��Ƽ ���� �ִ��*/
     DOMAIN_PAUSE_DAYS  INT NOT NULL DEFAULT '0', /*���� �Ⱓ(��)*/
     DOMAIN_BIGMAIL_QUOTA  		BIGINT(15)  DEFAULT 0		/* ��뷮���� ������ ����*/
)type=InnoDB;

CREATE TABLE CERTIFY
(    CERTIFY_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*����Ű �ε���(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN               	VARCHAR(100)   NOT NULL, 	/*ȸ���� ������ �� */
     CERTIFY_ISVALID		CHAR(1),			/*��밡�ɿ���	Y:��밡�� N:���Ұ���*/
     CERTIFY_NAME               VARCHAR(200), 			/*������̸�*/
     CERTIFY_JUMIN1		VARCHAR(6),			/*�ֹε�Ϲ�ȣ1*/
     CERTIFY_JUMIN2		VARCHAR(7),			/*�ֹε�Ϲ�ȣ2*/
     CERTIFY_DEPARTMENT		VARCHAR(100),			/*�а�/�μ���*/
     CERTIFY_LICENCENUM		VARCHAR(200)			/*�й�/���*/
)type=InnoDB;

CREATE TABLE RESERVEID
(    RESERVEID_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*���� ID �ε���(SEQ) (PK)	���� ID �ε���, SERIAL NO(1-99999999)*/
     DOMAIN			VARCHAR(100)    NOT NULL, 	/*�����θ�*/   		
     RESERVEID_ID		VARCHAR(100)            /*���� ID*/
)type=InnoDB;

CREATE TABLE USERS
(   USERS_IDX			VARCHAR(200)	NOT NULL primary key,	/*�����Ű(PK)	���ΰ���Ű(ID@DOMAIN)*/
    USERS_ID			VARCHAR(100)	NOT NULL,	/*���̵�*/
    USERS_PASSWD		VARCHAR(50)	NOT NULL,	/*�н�����*/
    DOMAIN			VARCHAR(100)	NOT NULL,	/*������*/
    USERS_HOMEDIR		VARCHAR(100)	NOT NULL,	/*����� Ȩ ���丮*/
    USERS_PERMIT	        CHAR(1)         NOT NULL,                 	/*���� ����	W:������  S:����㰡 N:�������*/
    USERS_AUTH			CHAR(1)         NOT NULL,			/*����	S: �ý��� ������ A:������ U:�Ϲ�*/
    USERS_NAME			VARCHAR(20),			/*�ѱ��̸�*/
    USERS_ENGNAME		VARCHAR(50),			/*�����̸�*/
    USERS_NICKNAME		VARCHAR(40),			/*����*/
    USERS_JUMIN1		VARCHAR(6),			/*�ֹε�Ϲ�ȣ1*/
    USERS_JUMIN2		VARCHAR(7),			/*�ֹε�Ϲ�ȣ2*/ 
    USERS_SEX			CHAR(1),			/*����	M : ����  F : ����*/
    USERS_BIRTH			VARCHAR(10),			/*�������*/
    USERS_ISSOLAR		CHAR(1),			/*��/����	S : ���  L : ����*/
    USERS_CELLNO		VARCHAR(30),			/*�ڵ�����ȣ*/
    USERS_FAXNO			VARCHAR(30),			/*�ѽ���ȣ*/
    USERS_TELNO			VARCHAR(30),			/*��ȭ��ȣ*/
    USERS_ZIPCODE		VARCHAR(10),			/*�����ȣ*/
    USERS_ADDRESS1		VARCHAR(100),			/*�ּ�1*/
    USERS_ADDRESS2		VARCHAR(100),			/*�ּ�2*/
    USERS_JOBCODE		CHAR(4),			/*�����ڵ�*/
    USERS_COMPNAME		VARCHAR(100),			/*�б�/ȸ���*/
    USERS_DEPARTMENT		VARCHAR(100),			/*�а�/�μ���*/
    USERS_PREVEMAIL		VARCHAR(50),			/*�����̸���*/
    USERS_SCHOOLING		CHAR(4),			/*�����з� S100,S101��*/
    USERS_INTEREST		CHAR(4),			/*���ɻ� I100,I101��*/
    USERS_LICENCENUM            VARCHAR(200),			/*�й�, ���*/
    USERS_ISOPEN		VARCHAR(50),			/*������������	�̸�/ID/����,����ó,����/����,���ɺо�/�����з�*/
    USERS_JOINDATE		DATETIME,			/*�����Ͻ�*/
    USERS_EXPIREDDATE DATETIME,            /* ����� ���� �������� */
    USERS_LOGCOUNT		INT,				/*���Ӽ�*/
    USERS_LASTHOST		VARCHAR(40),			/*��������ȣ��Ʈ*/
    USERS_MAX_VOLUME		INT,				/*�ִ� ��� �뷮(MB)*/
    USERS_CUR_VOLUME		INT,				/*���� ������� ���� �뷮(MB)*/
    USERS_LASTDATE		DATETIME,			/*�������ӽð�*/
    USERS_SIGNATURE		CHAR(1),			/*�������ϻ�뿩��	Y:����� N:������ DEFAULT N*/ 
    USERS_SIGNATURESTMT		TEXT,				/*�������ϳ���*/
    USERS_AUTORE		CHAR(1),			/*�ڵ������뿩��	Y:��� N :�̻�� DEFAULT N*/
    USERS_AUTORESTMT		TEXT,				/*�ڵ����䳻��*/
    USERS_USENAME		CHAR(1),			/*����� �̸�	K : �ѱ� E : ���� N: ���� DEFAULT K*/
    USERS_SENDBOX		CHAR(1),			/*�������� ������ �⺻��	Y:���� ���� �ڵ����� ���� �����Կ� ���� N:������� DEFAULT Y*/
    USERS_DELBOX		CHAR(1),			/*�������� ������ �⺻��	Y:���� ������ �ڵ����� �����뿡 ���� N:������� DEFAULT Y*/
    USERS_AUTO_DEL		CHAR(1),			/*�ڵ������� ������ �⺻��	Y:�ڵ������� �����뿡 ���� N:������� DEFAULT Y*/
    USERS_LISTNUM	        MEDIUMINT,			/*��������ǥ��	ȭ�鿡 ǥ�õǴ� ���� ����*/
    USERS_ISVOTE		CHAR(1),			/*��ǥ��������	Y:���� N:������ DEFAULT N*/
    USERS_ABSENT		CHAR(1),			/*������ ����	Y:������ N: ���� DEFAULT : N*/
    USERS_ABSENT_SDATE		DATETIME,			/*���� ���� ��¥*/
    USERS_ABSENT_EDATE		DATETIME,			/*���� �� ��¥*/
    USERS_ABSENT_RESTMT		TEXT,				/*�����߽� �ڵ��亯����*/
    USERS_OPT_FWD	        CHAR(1),                   	/*�ڵ����� ��뿩��	Y: ����� N: �̻��*/
    USERS_OPT_FWD_SAVE	        CHAR(1),                	/*�ڵ������� ���忩��	Y: ������ N: ����*/
    USERS_FWD_LIST	        TEXT,   		      	/*�ڵ����� �ּ� ���	�ڵ������� �ּ� ���*/
    USERS_READDR		TEXT,				/*ȸ�ſ� �ּ� ���*/
    USERS_SPAM_LEVEL		CHAR(1),			/*����������ܼ���	N:���ܾ��� L:���� M:�߰� H:����*/
    USERS_DEL_WASTE 		SMALLINT,			/*������ ���� ���� �Ⱓ*/
    USERS_DEL_SPAM		SMALLINT,			/*���� ������ ���� �Ⱓ*/
    USERS_LANG 			VARCHAR(10),			/*����� ���� DEFAULT:DOMAIN�� ����*/
    USERS_MAIL_ALARM            SMALLINT,			/*������ Ȯ���ֱ�(��) DEFAULT:10*/
    USERS_ALARM_SOUND		SMALLINT,			/*������ �˶��Ҹ� DEFAULT:1,  0:������*/
    USERS_INDEX_PAGE            CHAR(1),			/*ùȭ�� ���� DEFALUT : 0 (����) */
    USERS_RECEIVE_INFOMAIL	CHAR(1),	/*�������� �ޱ� DEFAULT : Y*/
    USERS_MAIL_VIEW		TINYINT,			  /*����ǥ�ù��	1:1�� 2:2�� 3:��â*/
    USERS_MAIL_INJURE		CHAR(1),			/*���� ���ؼ� ��뿩��	Y:��� N :�̻�� DEFAULT Y */
    USERS_ORGANIZE_IDX		INT,				/*������ �׷�IDX(������) default:0 */
    USERS_AUTHORITY_IDX		INT,				/*���� IDX(������) default : 0*/
    USERS_SMS_QUOTA       INT,	      /*SMS �ִ� ��� �߼� �Ǽ� default = 0,  ������ : -1*/
    USERS_MAIL_QUOTA      INT NOT NULL DEFAULT '0',  /*���� �߼� ���� default = 0,  ������ : 0*/
    USERS_MEMO            TEXT                /*���� �Ұ� ��*/
)type=InnoDB;

--���� users table�� users_id�� �ε����� �Ǵ�.(���踦 �α� ����)
alter table  USERS add index USERS_INDEX2(USERS_ID);


CREATE TABLE USERS_REGIST
(    USERS_REGIST_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*����Ű �ε���(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN               	VARCHAR(100)   NOT NULL, 	/*ȸ���� ������ �� */
     USERS_REGIST_ID            VARCHAR(100), 			/*�����ID*/
     USERS_REGIST_NAME          VARCHAR(200), 			/*������̸�*/
     USERS_REGIST_PASSWD	VARCHAR(50),			/*�н�����*/
     USERS_REGIST_JUMIN1	VARCHAR(6),			/*�ֹε�Ϲ�ȣ1*/
     USERS_REGIST_JUMIN2	VARCHAR(7),			/*�ֹε�Ϲ�ȣ2*/
     USERS_REGIST_DEPARTMENT	VARCHAR(100),			/*�а�/�μ���*/
     USERS_REGIST_LICENCENUM	VARCHAR(200)			/*�й�/���*/
)type=InnoDB;

CREATE TABLE USERS_PAUSE
(    USERS_PAUSE_IDX           INT     unsigned NOT NULL auto_increment primary key,   /*����Ű �ε���(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN                     VARCHAR(100)   NOT NULL,        /*ȸ���� ������ �� */
     USERS_PAUSE_ID            VARCHAR(100),                   /*�����ID*/
     USERS_PAUSE_NAME          VARCHAR(200),                   /*������̸�*/
     USERS_PAUSE_PASSWD        VARCHAR(50),                    /*�н�����*/
     USERS_PAUSE_JUMIN1        VARCHAR(6),                     /*�ֹε�Ϲ�ȣ1*/
     USERS_PAUSE_JUMIN2        VARCHAR(7),                     /*�ֹε�Ϲ�ȣ2*/
     USERS_PAUSE_DEPARTMENT    VARCHAR(100),                   /*�а�/�μ���*/
     USERS_PAUSE_LICENCENUM    VARCHAR(200)                    /*�й�/���*/
)type=InnoDB;

CREATE TABLE USERS_DELETE
(    USERS_DELETE_IDX		INT	unsigned NOT NULL auto_increment primary key,  	/*����Ű �ε���(SEQ) (PK) SERIAL NO(1-99999999)*/
     DOMAIN               	VARCHAR(100)   NOT NULL, 	/*ȸ���� ������ �� */
     USERS_DELETE_ID            VARCHAR(100), 			/*�����ID*/
     USERS_DELETE_NAME          VARCHAR(200), 			/*������̸�*/
     USERS_DELETE_PASSWD	VARCHAR(50),			/*�н�����*/
     USERS_DELETE_JUMIN1	VARCHAR(6),			/*�ֹε�Ϲ�ȣ1*/
     USERS_DELETE_JUMIN2	VARCHAR(7),			/*�ֹε�Ϲ�ȣ2*/
     USERS_DELETE_DEPARTMENT	VARCHAR(100),			/*�а�/�μ���*/
     USERS_DELETE_LICENCENUM	VARCHAR(200)			/*�й�/���*/
)type=InnoDB;

CREATE TABLE BASEINFO                                           
(   BASEINFO_TYPE	         CHAR(1),	         	/* P:��ȣ�� ����,H:��й�ȣ ��Ʈ,J:����,S:�����з�,I:���ɺо� */
    BASEINFO_ID                  CHAR(4),	                /* �⺻����ID */
    BASEINFO_VALUE               VARCHAR(100)	                /* �⺻�������� */
)type=InnoDB;

CREATE TABLE ZIPCODE
(	ZIPCODE_CD		  VARCHAR(10),		/* �����ȣ */ 
	ZIPCODE_ADDR1		VARCHAR(20),           	/* �õ� */  
 	ZIPCODE_ADDR2		VARCHAR(20),           	/* �ñ��� */
	ZIPCODE_ADDR3		VARCHAR(50),           	/* �� */
	ZIPCODE_ADDR4		VARCHAR(50),
	ZIPCODE_CHANGE 	VARCHAR(20)
)type=InnoDB;

CREATE TABLE MBOX
( MBOX_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*MBOX �ε���Ű(PK) SERIAL NO(1-4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,   /*����� ����Ű*/
	MBOX_TYPE		SMALLINT	NOT NULL,		    /*1.���������� 2.���������� 3.���������� 4.�ӽú����� 5.��������� 6.���������*/
	MBOX_REF    INT NOT NULL DEFAULT '0', /*parent MBOX_IDX */
	MBOX_NAME		VARCHAR(50),				      /*MAILBOX �̸�*/
	MBOX_SIZE		INT,				              /*����ũ��*/
	MBOX_MAILCOUNT  INT,					        /*MAILBOX�� ���� ����*/
	MBOX_SUBSCRIBE CHAR(1) DEFAULT 'Y',    /*������ ���(IMAP)*/
	INDEX MBOX_INDEX_USERS_IDX (USERS_IDX),
	INDEX MBOX_INDEX_MBOX_IDX_MBOX_TYPE (MBOX_IDX, MBOX_TYPE)
)type=InnoDB;


CREATE TABLE AUTODIVISION
(	AUTODIVISION_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*�ڵ��з� �ε��� SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*����� IDX*/
	MBOX_IDX		INT,						/*������ �ε��� Ű*/
	AUTODIVISION_TYPE	TINYINT,					/*0:��ü, 1: �����»�� 2,�޴»��, 3:����*/
	AUTODIVISION_KEYWORD	VARCHAR(200),					/*�ڵ��з� Ű����*/
	NOTICE INT(1),
	INDEX AUTODIVISION_INDEX (USERS_IDX)
)type=InnoDB;

CREATE TABLE FILTER
(	FILTER_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*���͸� �ε��� SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*����� IDX*/
	FILTER_AUTH		TINYINT,					/*1:SYSTEM������ 2:�����ΰ�����3:�Ϲ�����*/
	FILTER_TYPE		TINYINT,					/*1:���Űź��̸��� 2:���Űźε����� 3:���Űź����� 4:���Űź�IP 5:���Ÿ����ּ� 6���ŵ�����*/
	FILTER_KEYWORD		VARCHAR(200),					/*���͸� Ű����*/
	INDEX INDEX_FILTER_USERS_IDX (USERS_IDX),
	INDEX INDEX_FILTER_FILTER_AUTH (FILTER_AUTH)
)type=InnoDB;

CREATE TABLE INJURE
(	INJURE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*���ؼ� Ű���� �ε��� SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*����� IDX*/
	INJURE_AUTH		TINYINT,					/*1:SYSTEM������ 2:�����ΰ�����3:�Ϲ�����*/
	INJURE_KEYWORD		VARCHAR(200),					/*���ؼ� Ű����*/
	INDEX INDEX_INJURE_USERS_IDX (USERS_IDX)
)type=InnoDB;

CREATE TABLE POP
(	POP_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*POP �ε��� SEQ(1~4294967295)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,			/*����� IDX*/
  POP_PROTOCOL		VARCHAR(200),					/*PROTOCOL*/
  POP_SERVER		VARCHAR(200),					/*POP SERVER*/
  POP_ID			VARCHAR(200),					/*POP ID*/
  POP_PASSWD		VARCHAR(200),					/*POP PASSWD*/
  MBOX_IDX		INT,						/*������ ������ IDX*/
  POP_ISDEL		VARCHAR(1),					/*�������� ��������	Y:���� N:���� DEFAULT : N*/
  POP_MBOX		VARCHAR(100),					/*������ ������	������:INBOX*/
  INDEX INDEX_POP_USERS_IDX (USERS_IDX)
)type=InnoDB;

CREATE TABLE RESERVATION
(	RESERVATION_IDX INT unsigned  NOT NULL  auto_increment  primary key,	/*����߼� �ε��� SEQ(1~4294967295)*/
  USERS_IDX VARCHAR(200)  NOT NULL, /*����� IDX*/
  RESERVATION_TO  TEXT,						/*���� ���� �̸���*/
	RESERVATION_FILE  VARCHAR(200),					/*����߼��� ���� ���� ������*/
	RESERVATION_TIME  DATETIME,					/*����߼۽ð�*/
	MAIL_RECONF_IDX INT   NOT NULL, /*����Ȯ�� �ε��� �ڵ�*/
	INDEX INDEX_RESERVATION_USERS_IDX (USERS_IDX),
	INDEX INDEX_RESERVATION_RECONF  (MAIL_RECONF_IDX)
)type=InnoDB;

CREATE TABLE ORGANIZE
(	ORGANIZE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*������ �׷� �ε��� PK SEQ(1~4294967295)*/
	DOMAIN                  VARCHAR(100)   NOT NULL,      			/*ȸ���� ������ �� */	
	ORGANIZE_REF		INT,						/*�θ� �׷� �ε���*/
  ORGANIZE_STEP		INT,						/*�׷� ����*/
	ORGANIZE_LEVEL		INT,						/*�θ� �׷� �� ����*/
  ORGANIZE_DEF		INT,						/*�θ� �׷� �� ����*/
  ORGANIZE_ADMIN      VARCHAR(200), 				      	/*�׷� ������ IDX*/
	ORGANIZE_NAME           VARCHAR(100), 				      	/*�׷��(�μ���)*/
  ORGANIZE_TITLE          VARCHAR(200), 				      	/*�׷�Ÿ��Ʋ*/
	ORGANIZE_OPERATION      TEXT,	 	   			   	/*�׷� �������*/
	ORGANIZE_STMT      	TEXT, 						/*�׷� ����*/
	ORGANIZE_SCHEDULE       TINYINT,					/*�׷� ���� ��ü ��������	0:����� 1:���� DEFAULT :0*/
  ORGANIZE_SCHEDULE_HIGHER      TINYINT,					/*�׷� ���� �����׷� ��������	0:����� 1:���� DEFAULT :0*/
	ORGANIZE_SCHEDULE_LOWER       TINYINT,					/*�׷� ���� �����׷� ��������	0:����� 1:���� DEFAULT :0*/
	ORGANIZE_SCHEDULE_EQUALTY     TINYINT 					/*�׷� ���� ���ޱ׷� ��������	0:����� 1:���� DEFAULT :0*/
)type=InnoDB;

CREATE TABLE AUTHORITY
(	AUTHORITY_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*���� �ε��� (PK)SEQ(1~4294967295)*/	
	DOMAIN                  VARCHAR(100)   NOT NULL,		      	/*ȸ���� ������ �� */		
	AUTHORITY_NAME		VARCHAR(100),					/*���޸�*/
	AUTHORITY_LEVEL		INT						/*����*/
)type=InnoDB;

CREATE TABLE MEMBER
(	MEMBER_IDX		INT	unsigned NOT NULL auto_increment primary key, /*���� �ε��� (PK)(SEQ : 1~999999999)*/
	DOMAIN                  VARCHAR(100)    NOT NULL,			 	/*ȸ���� ������ �� */
	USERS_IDX		VARCHAR(200)	NOT NULL,	/*�����IDX*/
	ORGANIZE_IDX		INT		NOT NULL,       /*�׷� IDX*/
	AUTHORITY_IDX		INT,		                /*���� IDX*/
	INDEX MEMBER_INDEX (ORGANIZE_IDX)
)type=InnoDB;


CREATE TABLE ADDRESS_GROUP
(	ADDRESS_GROUP_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*�ּҷϱ׷��ε���(pk) (SEQ 1~4294967295)*/
	USERS_IDX		VARCHAR(200)	NOT NULL,			/*�����IDX*/
	ADDRESS_GROUP_STMT	VARCHAR(255),					/*�׷켳��*/
	INDEX ADDRESS_GROUP_USERS_IDX (USERS_IDX)
)type=InnoDB;

CREATE TABLE ADDRESS
( ADDRESS_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*�ּҷ� �ε���(PK) (SEQ 1~4294967295)*/
	USERS_IDX		VARCHAR(200)	NOT NULL,			/*�����Ű*/
	ADDRESS_GROUP_IDX	INT,						/*�ּҷϱ׷��ε���*/
	ADDRESS_NAME		VARCHAR(100),					/*�̸�*/
	ADDRESS_EMAIL		VARCHAR(200),					/*�̸���*/
	ADDRESS_TEL		VARCHAR(100),					/*����ȭ ��ȣ*/
	ADDRESS_CELLTEL		VARCHAR(100),					/*�޴�����ȣ*/
	ADDRESS_HOMEZIP		VARCHAR(100),					/*�������ȣ*/
	ADDRESS_HOMEADDR	VARCHAR(100),					/*���ּ�*/
	ADDRESS_OFFICE		VARCHAR(100),					/*ȸ���*/
	ADDRESS_DEPT		VARCHAR(100),					/*�μ�*/
	ADDRESS_DUTY		VARCHAR(100),					/*��å*/
	ADDRESS_OFFICETEL	VARCHAR(100),					/*ȸ����ȭ��ȣ*/
	ADDRESS_OFFICEZIP	VARCHAR(100),					/*ȸ������ȣ*/
	ADDRESS_OFFICEADDR	VARCHAR(100),					/*ȸ���ּ�*/
	ADDRESS_BIRTH		VARCHAR(100),					/*����*/
	ADDRESS_ISSOLAR		CHAR(1),					/*���:S ����:L*/
	ADDRESS_HOMEURL		VARCHAR(200),					/*Ȩ�������ּ�*/
	ADDRESS_STMT		TEXT,						/*����*/
	INDEX ADDRESS_INDEX (USERS_IDX,ADDRESS_GROUP_IDX)
)type=InnoDB;

CREATE TABLE BBS_GROUP
(	BBS_GROUP_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*�Խ��� �׷��ε���(pk) (SEQ 1~4294967295)*/
	DOMAIN          	VARCHAR(100)	NOT NULL,			/*ȸ���� ������ �� */
	BBS_GROUP_NAME		VARCHAR(100),					/*�Խ��� �׷��*/
	BBS_GROUP_LEVEL		INT						/*�Խ��� ����*/
)type=InnoDB;

CREATE TABLE BBS
(	BBS_IDX			INT	unsigned NOT NULL auto_increment primary key,		/*�Խ��� �ε���(PK)(SEQ)*/
	DOMAIN         		VARCHAR(100)	NOT NULL,			  	/*ȸ���� ������ �� */
  BBS_ADMIN		VARCHAR(200),  					   	/*�Խ��� ������ IDX*/
	BBS_TYPE		TINYINT,						/*�Խ��� ��� Ÿ��	1:������ �Խ��� 2:�����α׷� �Խ��� 3:��Ʈ��� �Խ���*/
	BBS_MODE		TINYINT,						/*�Խ��� ����	1:�������� 2:�Խ��� 3:�ڷ��*/
	BBS_GROUP_IDX		INT,							/*�Խ��� �׷��ε���	�Խ��� �׷��ε��� (-1: �⺻�׷�, ������ �׷��ϰ��:BBS_GROUP_IDX, ��Ʈ��� �׷��ϰ��:ORGANIZE_IDX)*/
	BBS_NAME		VARCHAR(255),						/*�Խ��� ����*/
	BBS_USE_REPLY		TINYINT,						/*�亯��ɻ�뿩��	0:������ 1: �����*/
	BBS_USE_ATTACHE		TINYINT,						/*���Ͼ��ε��ɻ�뿩��	0:������ 1: �����*/
	BBS_USE_APPEND		TINYINT,						/*������ ��۱�� ��뿩��	0:������ 1: �����*/
	BBS_USE_ATTACHE_SIZE	TINYINT,						/*���Ͼ��ε� ÷�ο뷮	default :10MB*/
	BBS_AUTH_MEMBER		TINYINT,						/*ȸ��(������ȸ�� or �׷� ȸ��)������	0:���� ���� 1: �б���� 2:�������*/
	BBS_AUTH_GUEST		TINYINT,						/*guest����	0:���� ���� 1: �б���� 2:�������(��Ʈ��ݿ����� ��� ��׷� ȸ������ ����)*/
	BBS_AUTH_HIGHER		TINYINT,						/*�����׷� ����	0:���� ���� 1: �б���� 2:�������*/
	BBS_AUTH_LOWER		TINYINT,						/*�����׷� ����	0:���� ���� 1: �б���� 2:�������*/
	BBS_AUTH_EQUALTY	TINYINT							/*���ޱ׷� ����	0:���� ���� 1: �б���� 2:�������*/
)type=InnoDB;

CREATE TABLE BBS_USERLOG
(	BBS_USERLOG_IDX		VARCHAR(200)	NOT NULL,				/*�α� �ε���(ID@DOMAIN_B_IDX)(�ε��� ����� ���� ����Ű ����)*/
  USERS_IDX		VARCHAR(200)	NOT NULL,				/*���ΰ���Ű(ID@DOMAIN)*/
	BBS_USERLOG_DATE	VARCHAR(20),						        /*�Խù� �������*/
	INDEX BBS_USERLOG_INDEX (USERS_IDX)
)type=InnoDB;

CREATE TABLE BBS_TOP
(    BBS_IDX  INT unsigned  NOT NULL,
     B_IDX    INT unsigned  NOT NULL,
     primary key BBS_TOP_PK (BBS_IDX,B_IDX)
)type=InnoDB;

CREATE TABLE SCHEDULE
(	SCHEDULE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*�������� �ε���(PK)*/
	USERS_IDX		VARCHAR(200)	 NOT NULL,			/*�����Ű(PK)	���ΰ���Ű(ID@DOMAIN)*/
	USERS_NAME		VARCHAR(100)	 NOT NULL,			/*������̸�*/
	DOMAIN          	VARCHAR(100)     NOT NULL,     			/*ȸ���� ������ �� */
	ORGANIZE_IDX		INT,						/*������ �׷� �ε���*/        
	SCHEDULE_SHARE		TINYINT,					/*��������	0:����1:�׷�2:ȸ��3:��ü*/	
	SCHEDULE_TYPE		TINYINT,					/*����Ÿ��	0:��������1:�����2:����3�ް�4���5����6����7������8��Ÿ*/
	SCHEDULE_TITLE		VARCHAR(200),					/*��������*/
	SCHEDULE_STMT		TEXT,						/*��������*/
	SCHEDULE_SDATE		DATETIME, 					/*���� ���� �Ͻ�*/
	SCHEDULE_EDATE		DATETIME,					/*���� ���� �Ͻ�*/
	SCHEDULE_REPEAT		TINYINT,					/*�����ݺ�	0:�ݺ�����1:�ϰ��ݺ�2:�ְ��ݺ�3�����ݺ�4:�Ⱓ�ݺ�*/
	SCHEDULE_DAYLY		TINYINT,					/*�Ϸ����� �ɼ� ����	DEFAULT:0 1:�Ϸ����� 2:�Ϸ��̻� �����Ⱓ*/
	SCHEDULE_ALARM		TINYINT,					/*���� �˸� 0:�˸��� ���� 1:���۽ð� 2:1�ð��� 3:1���� 4:2���� 5:3���� 6:1������*/
	SCHEDULE_ALARM_DATE	DATETIME,					/*�����˸� �ð� 	�˸��ð� default = NOW()*/
	SCHEDULE_ALARM_WAY	TINYINT,						/*�����˸����	1:���� 2:SMS 3:����+SMS*/
	SCHEDULE_DDAY     TINYINT NOT NULL DEFAULT '0',   /*D-DAY 0:������ 1:�����*/
	INDEX SCHEDULE_USERS_IDX (USERS_IDX),
	INDEX SCHEDULE_ORGANIZE_IDX (ORGANIZE_IDX)
)type=InnoDB;

CREATE TABLE FILE_SHARE
(   	FILE_SHARE_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*���ϰ��� �ε���(PK)*/
	USERS_IDX			VARCHAR(200),			/*�����Ű*/
	FILE_SHARE_FOLDER		TEXT,			/*���� ��ι� �̸�*/
	FILE_SHARE_AUTH			CHAR(1)				/*���� ���� r:�б� ���� w:�������*/
)type=InnoDB;

CREATE TABLE POLL
(	POLL_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*���� �ε���(PK)(SEQ)*/
	USERS_IDX			VARCHAR(200)    NOT NULL,		 	/*�����ۼ���*/ 
	DOMAIN				VARCHAR(100)	NOT NULL, 			/*������*/ 
	POLL_CONTENT			TEXT,						/*��������*/
	POLL_SDATE			DATETIME,					/*���� ������*/
	POLL_EDATE			DATETIME,					/*���� ������*/
	POLL_PROGRESS			CHAR(1)						/*���� ���� ���� P:���� S:�Ϸ� R:���*/
)type=InnoDB;

CREATE TABLE POLL_ITEM
(	POLL_IDX			INT,						/*���� �ε���(PK)(SEQ)*/
	POLL_ITEM_NUM			TINYINT,					/*�������� ��ȣ*/
	POLL_ITEM_CONTENT		TEXT,						/*�������� ����*/
	POLL_ITEM_SUM			INT						/*�������� Ŭ�� Ƚ��*/
)type=InnoDB;

CREATE TABLE POLL_LIST
(	POLL_IDX			INT		NOT NULL,			/*���� �ε���(PK)(SEQ)*/
	USERS_IDX			VARCHAR(100)	NOT NULL			/*�����Ű(PK)	���ΰ���Ű(ID@DOMAIN)*/
)type=InnoDB;

CREATE TABLE MAIL_REPORT
( MAIL_REPORT_IDX		INT	unsigned NOT NULL auto_increment primary key,		/*�ҷ����ϽŰ� �ε���*/
	DOMAIN                  VARCHAR(100)	NOT NULL,      		/*ȸ���� ������ �� */
	USERS_IDX		VARCHAR(200)	NOT NULL,		/*�Ű��� IDX*/
	USERS_NAME		VARCHAR(20),				/*�Ű����̸�*/
	MAIL_REPORT_DATE	VARCHAR(20),				/*�Ű�����*/
	MAIL_REPORT_FROM	VARCHAR(200),				/*�ҷ����� �߼��� �̸���*/
	MAIL_REPORT_SENDDATE	VARCHAR(20),				/*���Ϲ߼�����*/
	MAIL_REPORT_STMT	TEXT,					/*���ϽŰ���*/
	MAIL_REPORT_STATE	TINYINT					/*ó������ 1:�ű� 2:ó���� 3: �ҷ����� 4:�ҷ������� 5:�ߺ� 6:�̵��*/ 
)type=InnoDB;

CREATE TABLE SYSTEM_INFO
(	SYSTEM_INFO_IDX		VARCHAR(100)	NOT NULL,	/*�ý��� ���� Ű*/
  SYSTEM_INFO_VALUE	TEXT				/*�ý��� ���� */
)type=InnoDB;

CREATE TABLE USER_GROUP
(      USER_GROUP_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*�׷� �ε��� SEQ(1~9999999999)(PK)*/
       DOMAIN      	VARCHAR(100)	NOT NULL,		/*������*/
       USER_GROUP_DEF	INT	NOT NULL,			/*���� �׷� IDX*/
       USER_GROUP_REF	INT	NOT NULL,			/*�ֻ��� �׷� IDX*/
       USER_GROUP_NAME	VARCHAR(255)	NOT NULL,		/*���ο뷮(����:byte)*/
       USER_GROUP_DEFAULT	TINYINT,			/*���Խ� �⺻ �׷� (0:DEFAULT 1:�⺻�׷�)*/
       USER_GROUP_FUNCTION	VARCHAR(20),			/*��� ������	�׷캰 �޴���뿩��(�����κ� �޴���뿩��(������,POP3,��������,���ϰ���,���ڰ���,�Խ���,��Ʈ���,�޽���,Ȩ������,SMS default:1111111111)*/
       USER_GROUP_VOLUME	INT,				/*�׷캰 ����� �⺻ �뷮	�׷캰 ����� �⺻ �뷮 DEFAULT = ������ default �뷮*/
       USER_GROUP_MAIL	TINYINT,				/*��ü���� �߼� ���� ���� 0:�Ұ��� 1:���� DEFAULT:0*/
       USER_GROUP_SCHEDULE	TINYINT,			/*��ü���� ��� ���� ���� 0:�Ұ��� 1:���� DEFAULT:0*/
       USER_GROUP_ADDRESS	TINYINT,			/*�����ּҷ� ��� ���� 0:�Ұ��� 1:���� DEFAULT:0*/	
       USER_GROUP_STRUCTURE	TINYINT,			/*������ ��� ���� 0:�Ұ��� 1:���� DEFAULT:0*/	
       USER_GROUP_COMMUNITY	TINYINT,			/*��ȣȸ ���� ���ɿ��� 0:�Ұ��� 1:���� DEFAULT:0*/
       USER_GROUP_SMS_QUOTA     INT	                       /*SMS �������Ǽ�*/
)type=InnoDB;

CREATE TABLE USER_GROUP_LIST
(      USER_GROUP_LIST_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*�׷� �ε��� SEQ(1~9999999999)(PK)*/
       DOMAIN      	VARCHAR(100)	NOT NULL,		/*������*/
       USERS_IDX      	VARCHAR(255)	NOT NULL,		/*���ΰ���Ű(ID@DOMAIN)*/
       USER_GROUP_IDX   INT	NOT NULL,		/*�׷� IDX*/
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
(      SMS_REQUEST_IDX               INT	unsigned NOT NULL auto_increment primary key,      /*SMS���ۿ�û �ε���(PK)*/
       USERS_IDX                     VARCHAR(255) NOT NULL,   /*�����Ű(PK) ���ΰ���Ű(ID@DOMAIN)*/
       SMS_REQUEST_DATE              DATETIME NOT NULL,            /*���ۿ�û�ð�*/
       SMS_REQUEST_SEND_DATE         DATETIME NOT NULL,            /*���۽ð�*/
       SMS_REQUEST_TYPE              CHAR(1) NOT NULL,         	   /*����(0-���, 1-����)*/
       SMS_REQUEST_SEND_HP           VARCHAR(20) NOT NULL,    	   /*�۽����޴�����ȣ*/
       SMS_REQUEST_RECEIVE_HP        VARCHAR(20) NOT NULL,        /*�������޴�����ȣ*/
       SMS_REQUEST_MESSAGE           TEXT NOT NULL 		  /*���� �޼���*/
)type=InnoDB;

CREATE TABLE SMS_RESULT
(      SMS_RESULT_IDX               INT NOT NULL,      /*SMS���۰�� �ε���(PK)*/
       USERS_IDX                    VARCHAR(255) NOT NULL,   /*�����Ű(PK) ���ΰ���Ű(ID@DOMAIN)*/
       SMS_RESULT_DATE              DATETIME NOT NULL,            /*���ۿ�û�ð�*/
       SMS_RESULT_SEND_DATE         DATETIME NOT NULL,            /*���۽ð�*/
       SMS_RESULT_TYPE              CHAR(1) NOT NULL,         /*����(0-���, 1-����)*/
       SMS_RESULT_SEND_HP           VARCHAR(20) NOT NULL,    /*�۽����޴�����ȣ*/
       SMS_RESULT_RECEIVE_HP        VARCHAR(20) NOT NULL,    /*�������޴�����ȣ*/
       SMS_RESULT_MESSAGE           TEXT NOT NULL,  /*���� �޼���*/
       SMS_RESULT_SEND_COUNT        INT NOT NULL,       /*�������� Ƚ��*/
       SMS_RESULT_CODE              CHAR(1) NOT NULL          /*���۰���ڵ�(0-���, 1-���ۿ�û, 2-���ۿϷ�, 3-����)*/
)type=InnoDB;

CREATE TABLE SMS_RESULT_SYSTEM
(      SMS_RESULT_SYSTEM_IDX             INT NOT NULL,     /*����SMS���۰�� �ε���(PK)*/
       USERS_IDX                         VARCHAR(255) NOT NULL,  /*�����Ű(PK) ���ΰ���Ű(ID@DOMAIN)*/
       SMS_RESULT_SYSTEM_SEND_DATE       DATETIME NOT NULL,           /*���۽ð�*/
       SMS_RESULT_SYSTEM_TYPE            CHAR(1) NOT NULL,        /*����(0-���, 1-����)*/
       SMS_RESULT_SYSTEM_SEND_COUNT      INT NOT NULL,      /*�������� Ƚ��*/
       SMS_RESULT_SYSTEM_CODE            CHAR(1) NOT NULL         /*���۰���ڵ�(2-���ۿϷ�, 3-����)*/
)type=InnoDB;

CREATE TABLE MAIL_LOG
(      MAIL_LOG_DATE        DATETIME NOT NULL,			/*�αױ�Ͻð�(����:�ð�)(PK)*/
       MAIL_LOG_DOMAIN      VARCHAR(100) NOT NULL,		/*������*/
       MAIL_LOG_RECEIVE_COUNT INT NULL,			/*���� ���� ����*/
       MAIL_LOG_SEND_COUNT  INT NULL,			/*���� ���� ����*/
       MAIL_LOG_RECEIVE_VOLUME INT NULL,			/*���� ���� �뷮(����:byte)*/
       MAIL_LOG_SEND_VOLUME INT NULL,			/*���� ���� �뷮(����:byte)*/
       MAIL_LOG_ERROR_COUNT INT NULL			/*���� ���� ����*/
)type=InnoDB;

CREATE TABLE MAIL_RECONF
(      MAIL_RECONF_IDX		INT	unsigned NOT NULL auto_increment primary key,	/* �ε��� SEQ(1~9999999999)(PK)*/
       MAIL_RECONF_GROUP	DOUBLE	 NOT NULL,	/* GROUP*/
       USERS_IDX      		VARCHAR(200)	NOT NULL,		/*���ΰ���Ű(ID@DOMAIN)*/
       MAIL_RECONF_TO		VARCHAR(200)	NOT NULL,		/*�޴� ��� �̸���*/
       MAIL_RECONF_SUBJECT	VARCHAR(255),				/*����*/
       MAIL_RECONF_STATE	TINYINT,				/*���� default 0:�������� 1:���� 2:����߼� 3: �߼۽��� 4:�߼����*/ 	
       MAIL_RECONF_SDATE	VARCHAR(20),   				/*���� �߼� �Ͻ�*/
       MAIL_RECONF_RDATE	VARCHAR(20),    			/*���� ���� �ð� DEFAULT = NULL*/
       MAIL_RECONF_MESSAGE_ID VARCHAR(255),				/*K-Message-ID ��� ���� ����*/
       MAIL_RECONF_M_IDX      INT,         /*���� �������� ���� IDX*/
       INDEX MAIL_RECONF_INDEX (USERS_IDX),
       INDEX INDEX_MAIL_RECONF_M_IDX (MAIL_RECONF_M_IDX),
       INDEX INDEX_MAIL_RECONF_MESSAGE_IDX (MAIL_RECONF_MESSAGE_ID)
)type=InnoDB;

CREATE TABLE PUBLICGROUP
(  	  PUBLICGROUP_IDX		INT	unsigned NOT NULL auto_increment primary key,	/*�׷� �ε��� SEQ(1~9999999999)(PK)*/
    	PUBLICGROUP_DEF		INT	NOT NULL,					/*�θ�׷� �ε���(0 : �ֻ��� �׷�)*/			
    	DOMAIN			VARCHAR(100)	NOT NULL,	/*������*/
    	PUBLICGROUP_NAME	VARCHAR(255)	NOT NULL,	/*�׷� ��*/
    	INDEX PUBLICGROUP_INDEX (PUBLICGROUP_DEF)
)type=InnoDB;

CREATE TABLE PUBLICADDRESS
(   	PUBLICADDRESS_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*�����ּҷ� �ε���(PK)*/
    	PUBLICGROUP_IDX		INT	NOT NULL,	/*�����ּҷϱ׷��ε���(FK)*/
      DOMAIN			VARCHAR(100)	NOT NULL,	/*������*/ 
    	PUBLICADDRESS_NAME	VARCHAR(100),			/*�̸�*/
    	PUBLICADDRESS_DEPT	VARCHAR(100),			/*�μ�*/
    	PUBLICADDRESS_DUTY	VARCHAR(100),			/*��å*/
    	PUBLICADDRESS_EMAIL	VARCHAR(200),			/*�̸���*/
    	PUBLICADDRESS_TEL	VARCHAR(100),			/*����ȭ ��ȣ*/
    	PUBLICADDRESS_CELLTEL	VARCHAR(100),			/*�޴�����ȣ*/
    	PUBLICADDRESS_HOMEZIP	VARCHAR(100),			/*�����ȣ*/
    	PUBLICADDRESS_HOMEADDR	VARCHAR(100),			/*�ּ�*/
    	INDEX PUBLICADDRESS_INDEX (PUBLICGROUP_IDX)
)type=InnoDB;

CREATE TABLE HBBS 
(         BBS_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*�Խ��� �ε���(PK)(SEQ)*/
          DOMAIN         		VARCHAR(100)	NOT NULL, 			  	/*ȸ���� ������ �� */
          USERS_IDX		VARCHAR(200),   					   	/*�Խ��� ������ IDX*/
          BBS_NAME		VARCHAR(255), 						/*�Խ��� ����*/
          BBS_USE_REPLY		TINYINT, 						/*�亯��ɻ�뿩��	0:������ 1: �����*/
          BBS_USE_ATTACHE		TINYINT, 						/*���Ͼ��ε��ɻ�뿩��	0:������ 1: �����*/
          BBS_USE_APPEND		TINYINT,  						/*������ ��۱�� ��뿩��	0:������ 1: �����*/
          USE_ATTACHE_SIZE	TINYINT, 							/*���Ͼ��ε� ÷�ο뷮	default :10MB*/
          BBS_AUTH		TINYINT,							/*������	0:���� ���� 1: �б���� 2:�������*/
          BBS_LISTNUM	MEDIUMINT,						/*�Խ��� �۸���Ʈ ����*/
          INDEX HBBS_INDEX (USERS_IDX)
)type=InnoDB;

CREATE TABLE ECARD
(    ECARD_IDX INT  unsigned NOT NULL auto_increment primary key,
     ECARD_THEME   VARCHAR(200)  NOT NULL,  /*ī�� �׸�*/
     ECARD_TITLE   VARCHAR(200),             /*ī�� ����*/
     ECARD_DATE    DATETIME,                 /*ī�� ����Ͻ�*/
     ECARD_SENDNUM INT      			           /*�߼�Ƚ��*/
)type=InnoDB;

CREATE TABLE PASSWD_HINT( 
     USERS_IDX	VARCHAR(200) NOT NULL primary key,      /*����� IDX*/
     PASSWD_HINT_QUESTION	INT NOT NULL,  /*��й�ȣ ����*/
     PASSWD_HINT_ANSWER		VARCHAR(200) NOT NULL  /*��й�ȣ ��*/
)type=InnoDB;

CREATE TABLE ACCOUNT
(    ACCOUNT_IDX    VARCHAR(200)  NOT NULL primary key,	/*��Ƽ����*/
     USERS_IDX      VARCHAR(200)  NOT NULL ,
     DOMAIN         VARCHAR(100)   NOT NULL, 	/*ȸ���� ������ �� */
     MBOX_IDX       INT unsigned  NOT NULL  DEFAULT '0',	/*������ ����� MBOX �ε���Ű DEFAULT '0' 0:�� ��� ���� ������ */
     ACCOUNT_ISVALID  TINYINT   NOT NULL  DEFAULT '0', 	/*��뿩��  NOT NULL DEFAULT '0' 0:������ 1:�����*/
     ACCOUNT_ISDATED  TINYINT   NOT NULL  DEFAULT '0', 	/*��¥ ���뿩��  NOT NULL DEFAULT '0' 0:������ 1:�����*/
     ACCOUNT_SDATE  DATETIME, 			/*�������Ͻ�*/
     ACCOUNT_EDATE  DATETIME,  			/*��������Ͻ�*/
     INDEX INDEX_ACCOUNT_USERS_IDX (USERS_IDX),
     INDEX INDEX_ACCOUNT_DOMAIN (DOMAIN),
     FOREIGN KEY(USERS_IDX) REFERENCES USERS(USERS_IDX) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY(DOMAIN) REFERENCES DOMAIN(DOMAIN) ON DELETE CASCADE ON UPDATE CASCADE
)type=InnoDB;


ALTER TABLE DOMAIN TYPE=InnoDB;


--#####################################������� CLUB
--��ȸȸ �з� ����
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

--�Խ��Ǳ⺻����
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


--�Խ��� ��ü ����
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

--���� �亯
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


--#####################################������� CLUB


--#####################################������� SMS
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

--#####################################������� SMS

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J100','��ǻ��/���ͳ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J101','����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J102','����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J103','����/������');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J104','���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J105','�������Ϲ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J106','�Ƿ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J107','����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J108','��ȭ/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J109','����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J110','������');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J111','����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J112','��/��/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J113','����/�ֺ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J114','�ʵ��л�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J115','���л�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J116','����л�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J117','����/���п���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J118','�ڿ���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J119','����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('J','J120','��Ÿ');

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S100','�ʵ��б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S101','�ʵ��б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S102','���б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S103','���б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S104','����б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S105','����б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S106','���б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S107','���б� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S108','���п� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S109','���п� ����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('S','S199','��Ÿ');

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I100','��ȭ/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I101','����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I102','����/��ȭ');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I103','��ǻ��/���ͳ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I104','�ڰ���/���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I105','�м�/�̿�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I106','����/���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I107','��ȭ/����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I108','����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I109','������/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I110','����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I111','�ε���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I112','����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I113','�丮/����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I114','�ڵ���/����̺�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I115','����/���׸���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I116','�ǰ�/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I117','����/�̵��');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('I','I199','��Ÿ');

INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C100','���ͳݼ���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C101','����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C102','����/�������');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C103','����/����/����');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C104','�Ǽ�/���׸���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C105','���/�ݼӱ���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C106','��/��/��/�Ӿ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C107','�Ƿ�/�ǰ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C108','����/ȭ��');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C109','����/�м�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C110','���ķ�');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C111','����/����/���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C112','����/����/�ڵ���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C113','�뿪');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C114','����/�̺�Ʈ');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C115','�������');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C116','��Ÿ���');
INSERT INTO BASEINFO (BASEINFO_TYPE,BASEINFO_ID,BASEINFO_VALUE) VALUES('C','C117','��ü');

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'����','','2002-1-1 0:0:0',
'2002-1-1 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'������','','2002-3-1 0:0:0',
'2002-3-1 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'�ĸ���','','2002-4-5 0:0:0',
'2002-4-5 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'��̳�','','2002-5-5 0:0:0',
'2002-5-5 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,9,'����̳�','','2002-5-8 0:0:0',
'2002-5-8 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,9,'�����ǳ�','','2002-5-15 0:0:0',
'2002-5-15 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'������','','2002-6-6 0:0:0',
'2002-6-6 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'������','','2002-7-17 0:0:0',
'2002-7-17 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'������','','2002-8-15 0:0:0',
'2002-8-15 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,9,'�����ǳ�','','2002-10-1 0:0:0',
'2002-10-1 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'��õ��','','2002-10-3 0:0:0',
'2002-10-3 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,9,'�ѱ۳�','','2002-10-9 0:0:0',
'2002-10-9 23:59:59',4,1,0,NOW(),0);

INSERT INTO SCHEDULE(USERS_IDX,USERS_NAME,DOMAIN,SCHEDULE_SHARE,SCHEDULE_TYPE,SCHEDULE_TITLE,SCHEDULE_STMT,SCHEDULE_SDATE,SCHEDULE_EDATE,
SCHEDULE_REPEAT,SCHEDULE_DAYLY,SCHEDULE_ALARM,SCHEDULE_ALARM_DATE,SCHEDULE_ALARM_WAY) 
VALUES ('webmaster@tft.kebi.com','������','tft.kebi.com',3,7,'��ź��','','2002-12-25 0:0:0',
'2002-8-15 23:59:59',4,1,0,NOW(),0);

INSERT INTO SYSTEM_INFO(SYSTEM_INFO_IDX,SYSTEM_INFO_VALUE) VALUES('SYSTEM_USE_AGREEMENT','N');
INSERT INTO SYSTEM_INFO(SYSTEM_INFO_IDX,SYSTEM_INFO_VALUE) VALUES('SYSTEM_AGREEMENT_STMT','');

INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��?��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��?��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'ȫ��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��Ʊ׶�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��ī');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����ȣ��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�����*�ҳ�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�ؿܻ���Ʈ');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�������ũ');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'���Ա�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'���ͳݹ��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'���');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��Ƽ');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�Žñ�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'ȫ�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'ȭ��¯');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��ȭ��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�̼�����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�Ǹ���');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����ƽ');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�߾�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�дϽ�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�߾ִ�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�׹�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'19��*�̻�');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'ī����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��¥');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'�߽�����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'��ü��');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'ī����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'ī��볳');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����ȯ');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'������');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����');
INSERT INTO FILTER (USERS_IDX,FILTER_AUTH,FILTER_TYPE,FILTER_KEYWORD) VALUES('webmaster@tft.kebi.com',2,3,'����ź�ü��');
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
(      SHARE_GROUP_IDX			INT	unsigned NOT NULL auto_increment primary key,	/*�׷� �ε��� SEQ(1~9999999999)(PK)*/
       DOMAIN      					VARCHAR(100)	NOT NULL,			/*������*/
       SHARE_GROUP_DEF			INT	NOT NULL,								/*���� �׷� IDX*/
       SHARE_GROUP_REF			INT	NOT NULL,								/*�ֻ��� �׷� IDX*/
       SHARE_GROUP_NAME			VARCHAR(255)	NOT NULL,			/*���ο뷮(����:byte)*/
       SHARE_GROUP_DEFAULT	TINYINT,										/*���Խ� �⺻ �׷� (0:DEFAULT 1:�⺻�׷�)*/
       SHARE_GROUP_HOMEDIR	VARCHAR(255)	NOT NULL,			/* �������� ���丮*/
       SHARE_GROUP_QUOTA 		BIGINT(20),									/* �������� ������*/
       SHARE_GROUP_STATUS 	CHAR(1)  DEFAULT 'S'										/* �����׷� ���� S:��� N :�̻�� */
)type=InnoDB;

CREATE TABLE SHARE_GROUP_LIST
(      SHARE_GROUP_LIST_IDX	INT	unsigned NOT NULL auto_increment primary key,	/*�׷� �ε��� SEQ(1~9999999999)(PK)*/
       DOMAIN      	     VARCHAR(100)	NOT NULL,		/*������*/
       USERS_IDX      	 VARCHAR(255)	NOT NULL,		/*���ΰ���Ű(ID@DOMAIN)*/
       SHARE_GROUP_IDX   INT	NOT NULL,						/*�׷� IDX*/
       SHARE_STATUS   		 CHAR(1) DEFAULT 'S',									/* �����׷� ���� Y:��� N :�̻�� */
       SHARE_AUTH   		 VARCHAR(2)	NOT NULL DEFAULT '10',		/* �������� ���� 1:�ϱ� 2:���� 10:�б�/����*/
       INDEX SHARE_GROUP_LIST_INDEX_USERS_IDX (USERS_IDX),
       INDEX SHARE_GROUP_LIST_INDEX_SHARE_GROUP_IDX (SHARE_GROUP_IDX)
)type=InnoDB;
