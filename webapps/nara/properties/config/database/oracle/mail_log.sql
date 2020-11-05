CreateTable
        CREATE TABLE
                MONITOR_MAIL_LOG (
                        MAIL_ID VARCHAR2(100) NOT NULL,
                        MAIL_HOSTNAME VARCHAR2(40) NOT NULL,
                        MAIL_CREATE_DATE DATE NOT NULL,
                        MAIL_RESULT_DATE DATE,
                        MAIL_DELETE_DATE DATE,
                        MAIL_ORIGIN VARCHAR2(10) NOT NULL,
                        MAIL_DESTINATION VARCHAR2(10) NOT NULL,
                        MAIL_DOMAIN VARCHAR2(40),
                        MAIL_IP VARCHAR2(40),
                        LOG_ID VARCHAR2(100) NOT NULL,
                        MAIL_SENDER VARCHAR2(100) NOT NULL,
                        MAIL_RECIPIENT VARCHAR2(100) NOT NULL,
                        MAIL_TYPE VARCHAR2(10) NOT NULL,
                        MAIL_RESULT CHAR(1),
                        MAIL_VOLUME NUMBER(20,0) DEFAULT 0,
                        MAIL_MESSAGE VARCHAR2(200),
                        PRIMARY KEY (MAIL_ID, MAIL_HOSTNAME)
                )