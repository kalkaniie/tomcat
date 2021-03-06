DROP TABLE ECARD;

CREATE TABLE ECARD
(    ECARD_IDX INT  unsigned NOT NULL auto_increment primary key,
     ECARD_THEME   VARCHAR(200)  NOT NULL,  /*카드 테마*/
     ECARD_TITLE   VARCHAR(200),             /*카드 제목*/
     ECARD_DATE    DATETIME,                 /*카드 등록일시*/
     ECARD_SENDNUM INT                             /*발송횟수*/
);


INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('계절-날씨','당신의 별',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('계절-날씨','봄맞이',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('계절-날씨','비오는날',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('계절-날씨','햇살담아',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('계절-날씨','행복하세요',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','기다림',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','기다림2',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','꽃의연가',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','무서운병',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','사랑해서좋은사람',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','알랙산더대왕의보물',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','영원한우정',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','오늘하루가',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','우산을들어줄',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','의미있는삶',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','커피한잔의여유',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','fall-in-love',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','friend',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('사랑-우정-격려','heart',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','근하신년',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','기원합니다',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','눈사람',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','루돌프사슴코',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','밝아오는새해',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','올해당신은',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','유리구슬',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','즐거운성탄절',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','크리스마스방문',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('스페셜 데이','MerryChristmas',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('알림','꼭오세요',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('알림','초대-수화',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','가을에태어난당신',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','감사',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','결혼행진',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','너를위한케익',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','오늘은말야',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','즐거웠던추억들',NOW(),0);
INSERT INTO ECARD(ECARD_THEME,ECARD_TITLE,ECARD_DATE,ECARD_SENDNUM) VALUES('축하-감사','졸업축하',NOW(),0);

