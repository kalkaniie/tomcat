CREATE TABLE FORMLETTER
(    FORMLETTER_IDX   INT  unsigned NOT NULL auto_increment primary key,
     DOMAIN                     VARCHAR(100)   NOT NULL,
     FORMLETTER_TYPE            INT,
     FORMLETTER_SUBJECT         VARCHAR(200),
     CONTENT               TEXT
)type=InnoDB;
