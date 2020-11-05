        CREATE TABLE
                MONITOR_MAIL_LOG (
                        MAIL_ID VARCHAR(100) NOT NULL,
                        MAIL_HOSTNAME VARCHAR(40) NOT NULL,
                        MAIL_CREATE_DATE DATETIME NOT NULL,
                        MAIL_RESULT_DATE DATETIME,
                        MAIL_DELETE_DATE DATETIME,
                        MAIL_ORIGIN VARCHAR(10) NOT NULL,
                        MAIL_DESTINATION VARCHAR(10) NOT NULL,
                        MAIL_DOMAIN VARCHAR(40),
                        MAIL_IP VARCHAR(40),
                        LOG_ID VARCHAR(100) NOT NULL,
                        MAIL_SENDER VARCHAR(100) NOT NULL,
                        MAIL_RECIPIENT VARCHAR(100) NOT NULL,
                        MAIL_TYPE VARCHAR(10) NOT NULL,
                        MAIL_RESULT CHAR(1),
                        MAIL_VOLUME INT DEFAULT 0,
                        MAIL_MESSAGE VARCHAR(200),
                        PRIMARY KEY (MAIL_ID, MAIL_HOSTNAME)
                )