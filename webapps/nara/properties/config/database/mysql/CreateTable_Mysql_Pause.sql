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
