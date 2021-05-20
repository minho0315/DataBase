USE mysql;
DROP DATABASE IF EXISTS cookDB; -- 만약 cookDB가 존재하면 우선 삭제한다.
CREATE DATABASE cookDB;

USE cookDB;
CREATE TABLE userTbl -- 회원 테이블
( userID     CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  userName       VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr        CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1   CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2   CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height       SMALLINT,  -- 키
  mDate       DATE  -- 회원 가입일
);
CREATE TABLE buyTbl -- 회원 구매 테이블
(  num       INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID     CHAR(8) NOT NULL, -- 아이디(FK)
   prodName    CHAR(6) NOT NULL, --  물품명
   groupName    CHAR(4)  , -- 분류
   price        INT  NOT NULL, -- 단가
   amount       SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

INSERT INTO userTbl VALUES('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO userTbl VALUES('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7');
INSERT INTO userTbl VALUES('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9');
INSERT INTO userTbl VALUES('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5');
INSERT INTO userTbl VALUES('KJD', '김제동', 1974, '경남', NULL , NULL      , 173, '2013-3-3');
INSERT INTO userTbl VALUES('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4');
INSERT INTO userTbl VALUES('SDY', '신동엽', 1971, '경기', NULL , NULL      , 176, '2008-10-10');
INSERT INTO userTbl VALUES('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4');
INSERT INTO userTbl VALUES('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12');
INSERT INTO userTbl VALUES('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

INSERT INTO buyTbl VALUES(NULL, 'KHD', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'KYM', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'PSH', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KHD', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'PSH', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'KJD', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'LHJ', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'LHJ', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'PSH', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'LHJ', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'PSH', '운동화', NULL   , 30,   2);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

USE cookDB;
CREATE TABLE TBL1 
( a INT PRIMARY KEY, 
  b INT, 
  c INT 
);

SHOW INDEX FROM TBL1;

CREATE TABLE TBL2
( a INT PRIMARY KEY, 
  b INT UNIQUE,
  c INT UNIQUE, 
  d INT 
);
SHOW INDEX FROM TBL2;

CREATE TABLE TBL3 
( a INT UNIQUE, 
  b INT UNIQUE, 
  c INT UNIQUE, 
  d INT 
);
SHOW INDEX FROM TBL3;

CREATE TABLE TBL4 
( a INT UNIQUE NOT NULL, 
  b INT UNIQUE, 
  c INT UNIQUE, 
 d INT 
);
SHOW INDEX FROM TBL4;

CREATE TABLE TBL5 
( a INT UNIQUE NOT NULL, 
  b INT UNIQUE, 
  c INT UNIQUE, 
  d INT PRIMARY KEY 
);
SHOW INDEX FROM TBL5;

CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL 
( userID char(8) NOT NULL PRIMARY KEY,
  userName varchar(10) NOT NULL, 
  birthYear int NOT NULL, 
  addr char(2) NOT NULL 
);

INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울');
INSERT INTO userTBL VALUES ('KHD', '강호동', 1970, '경북');
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1965, '서울');
INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울');
INSERT INTO userTBL VALUES ('KJD', '김제동', 1974, '경남');
SELECT * FROM userTBL;

ALTER TABLE userTBL DROP PRIMARY KEY;
ALTER TABLE userTBL 
      ADD CONSTRAINT pk_userName PRIMARY KEY (userName);
SELECT * FROM userTBL;

-- -------------------------------------------------------

CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS clusterTBL;
CREATE TABLE clusterTBL 
( userID char(8), 
  userName varchar(10) 
);

INSERT INTO clusterTBL VALUES ('YJS', '유재석');
INSERT INTO clusterTBL VALUES ('KHD', '강호동');
INSERT INTO clusterTBL VALUES ('KKJ', '김국진');
INSERT INTO clusterTBL VALUES ('KYM', '김용만');
INSERT INTO clusterTBL VALUES ('KJD', '김제동');
INSERT INTO clusterTBL VALUES ('NHS', '남희석');
INSERT INTO clusterTBL VALUES ('SDY', '신동엽');
INSERT INTO clusterTBL VALUES ('LHJ', '이휘재');
INSERT INTO clusterTBL VALUES ('LKK', '이경규');
INSERT INTO clusterTBL VALUES ('PSH', '박수홍');

ALTER TABLE clusterTBL 
      ADD CONSTRAINT PK_clusterTBL_userID 
             PRIMARY KEY (userID);
SELECT * FROM clusterTBL;

CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
DROP TABLE IF EXISTS secondaryTBL;
CREATE TABLE secondaryTBL 
( userID char(8), 
  userName varchar(10) 
);
INSERT INTO secondaryTBL VALUES ('YJS', '유재석');
INSERT INTO secondaryTBL VALUES ('KHD', '강호동');
INSERT INTO secondaryTBL VALUES ('KKJ', '김국진');
INSERT INTO secondaryTBL VALUES ('KYM', '김용만');
INSERT INTO secondaryTBL VALUES ('KJD', '김제동');
INSERT INTO secondaryTBL VALUES ('NHS', '남희석');
INSERT INTO secondaryTBL VALUES ('SDY', '신동엽');
INSERT INTO secondaryTBL VALUES ('LHJ', '이휘재');
INSERT INTO secondaryTBL VALUES ('LKK', '이경규');
INSERT INTO secondaryTBL VALUES ('PSH', '박수홍');

ALTER TABLE secondaryTBL 
      ADD CONSTRAINT UK_secondaryTBL_userID 
             UNIQUE (userID);
SELECT * FROM secondaryTBL;

-- ------------------------------------------------------------------------
USE cookDB;
SELECT * FROM userTBL;

CREATE INDEX idx_userTBL_addr
    ON userTBL(addr);

CREATE UNIQUE INDEX idx_userTBL_userName 
      ON userTBL (userName);
SHOW INDEX FROM userTBL;

CREATE INDEX idx_userTBL_userName_birthYear 
      ON userTBL (userName, birthYear);
      
DROP INDEX idx_userTBL_userName ON userTBL;
SHOW INDEX FROM userTBL;

SELECT * FROM userTBL WHERE userName = '신동엽' and birthYear = '1971';

CREATE INDEX idx_userTBL_mobile1 
      ON userTBL (mobile1);

SELECT * FROM userTBL WHERE mobile1 = '011';

SHOW INDEX FROM userTBL;

DROP INDEX idx_userTBL_addr ON userTBL;
DROP INDEX idx_userTBL_userName_birthYear ON userTBL;
DROP INDEX idx_userTBL_mobile1 ON userTBL;

ALTER TABLE userTBL DROP PRIMARY KEY;










