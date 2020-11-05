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
