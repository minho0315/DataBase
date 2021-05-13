USE mysql;
DROP DATABASE IF EXISTS ShopDB;
DROP DATABASE IF EXISTS ModelDB;
DROP DATABASE IF EXISTS cookDB;
DROP DATABASE IF EXISTS movieDB;

CREATE DATABASE tableDB;

USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL -- 회원 테이블 
( userID CHAR(8), -- 사용자 아이디 
  userName VARCHAR(10), -- 이름 
  birthYear INT, -- 출생 연도 
  addr CHAR(2), -- 지역(경기, 서울, 경남 등으로 글자만 입력) 
  mobile1 CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등) 
  mobile2 CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈 제외) 
  height SMALLINT, -- 키 
  mDate DATE -- 회원 가입일 
);
CREATE TABLE buyTBL -- 구매 테이블 
( num INT, -- 순번(PK) 
  userID CHAR(8), -- 아이디(FK) 
  prodName CHAR(6), -- 물품 
  groupName CHAR(4), -- 분류 
  price INT, -- 단가 
  amount SMALLINT -- 수량 
);

USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
  userName VARCHAR(10) NOT NULL, 
  birthYear INT NOT NULL, 
  addr CHAR(2) NOT NULL,
  mobile1 CHAR(3) NULL, 
  mobile2 CHAR(8) NULL, 
  height SMALLINT NULL, 
  mDate DATE NULL 
);
CREATE TABLE buyTBL 
( num INT NOT NULL PRIMARY KEY, 
  userID CHAR(8) NOT NULL, 
  prodName CHAR(6) NOT NULL, 
  groupName CHAR(4) NULL, 
  price INT NOT NULL, 
  amount SMALLINT NOT NULL 
);

DROP TABLE IF EXISTS buyTBL;
CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
  userID CHAR(8) NOT NULL, 
  prodName CHAR(6) NOT NULL, 
  groupName CHAR(4) NULL, 
  price INT NOT NULL, 
  amount SMALLINT NOT NULL 
);

DROP TABLE IF EXISTS buyTBL;
CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
  userID CHAR(8) NOT NULL, 
  prodName CHAR(6) NOT NULL, 
  groupName CHAR(4) NULL, 
  price INT NOT NULL, 
  amount SMALLINT NOT NULL,
  FOREIGN KEY(userID) REFERENCES userTBL(userID)
);

INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO userTBL VALUES ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7');
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9');


INSERT INTO buyTBL VALUES (NULL, 'KHD', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES (NULL, 'KYM', '모니터', '전자', 200, 1);

INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5');
INSERT INTO userTBL VALUES ('KJD', '김제동', 1974, '경남', NULL , NULL, 173, '2013-3-3');
INSERT INTO userTBL VALUES ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4');
INSERT INTO userTBL VALUES ('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10');
INSERT INTO userTBL VALUES ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4');
INSERT INTO userTBL VALUES ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12');
INSERT INTO userTBL VALUES ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

INSERT INTO buyTBL VALUES (NULL, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO buyTBL VALUES (NULL, 'KJD', '책', '서적', 15, 5);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);

DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
  userName VARCHAR(10) NOT NULL, 
  birthYear INT NOT NULL 
);

DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL, 
  userName VARCHAR(10) NOT NULL, 
  birthYear INT NOT NULL, 
  CONSTRAINT PRIMARY KEY PK_userTBL_userID (userID) 
);


DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL, 
userName VARCHAR(10) NOT NULL, 
birthYear INT NOT NULL 
);

ALTER TABLE userTBL 
ADD CONSTRAINT PK_userTBL_userID 
PRIMARY KEY (userID);


DROP TABLE IF EXISTS prodTBL;
CREATE TABLE prodTBL 
( prodCode CHAR(3) NOT NULL, 
  prodID CHAR(4) NOT NULL, 
  prodDate DATETIME NOT NULL, 
  prodState CHAR(10) NULL
 );
 
ALTER TABLE prodTBL 
      ADD CONSTRAINT PK_prodTbl_proCode_prodID 
      PRIMARY KEY (prodCode, prodID);


CREATE TABLE prodTBL_FK 
( myID INT PRIMARY KEY,
  prodCode2 CHAR(3) NOT NULL, 
  prodID2 CHAR(4) NOT NULL,
  FOREIGN KEY(prodCode2,prodID2) REFERENCES prodTBL(prodCode, prodID)
 );

-- ------------------------------------------------------------------------------
 
DROP TABLE IF EXISTS buyTBL, userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
  userName VARCHAR(10) NOT NULL, 
  birthYear INT NOT NULL 
);
CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
  userID CHAR(8) NOT NULL, 
  prodName CHAR(6) NOT NULL, 
  FOREIGN KEY (userID) REFERENCES userTBL (userID) 
);

DROP TABLE IF EXISTS buyTBL;
CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
  userID CHAR(8) NOT NULL, 
 prodName CHAR(6) NOT NULL, 
  CONSTRAINT FK_userTBL_buyTBL FOREIGN KEY (userID) REFERENCES userTBL (userID) 
);

DROP TABLE IF EXISTS buyTBL;
CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
  userID CHAR(8) NOT NULL, 
  prodName CHAR(6) NOT NULL 
);
ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
      FOREIGN KEY (userID) 
      REFERENCES userTBL (userID);

SHOW INDEX FROM buyTBL; 
 
ALTER TABLE buyTBL 
      DROP FOREIGN KEY FK_userTBL_buyTBL; -- 외래키 제거 
ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
      FOREIGN KEY (userID) 
      REFERENCES userTBL (userID) 
      ON UPDATE CASCADE;
 
 
USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;

CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
  userName VARCHAR(10) NOT NULL, 
  birthYear INT NOT NULL, 
  email CHAR(30) NULL UNIQUE
);

DROP TABLE IF EXISTS userTBL;

CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
  userName VARCHAR(10) NOT NULL, 
  birthYear INT NOT NULL, 
  email CHAR(30) NULL, 
  CONSTRAINT AK_email UNIQUE (email) 
);



DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
  userName VARCHAR(10) NOT NULL, 
  birthYear int NOT NULL DEFAULT -1, 
  addr CHAR(2) NOT NULL DEFAULT '서울', 
  mobile1 CHAR(3) NULL, 
  mobile2 CHAR(8) NULL, 
  height smallint NULL DEFAULT 170, 
  mDate date NULL 
);


DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL 
( userID CHAR(8) NOT NULL PRIMARY KEY, 
userName VARCHAR(10) NOT NULL, 
birthYear int NOT NULL, 
addr CHAR(2) NOT NULL, 
mobile1 CHAR(3) NULL, 
mobile2 CHAR(8) NULL, 
height smallint NULL, 
mDate date NULL 
);
ALTER TABLE userTBL 
      ALTER COLUMN birthYear SET DEFAULT -1;
ALTER TABLE userTBL 
     ALTER COLUMN addr SET DEFAULT '서울';
ALTER TABLE userTBL 
     ALTER COLUMN height SET DEFAULT 170;

INSERT INTO userTBL VALUES ('YBJ', '유병재', default, default, '010', '12345678', default, '2019.12.12');
-- 열 이름이 명시되지 않으면 DEFAULT 문으로 설정된 값을 자동 입력한다.
INSERT INTO userTBL (userID, userName) VALUES ('PNR', '박나래');
-- 값이 직접 명시되어 있으면 DEFAULT 문으로 설정된 값을 무시한다.
INSERT INTO userTBL VALUES ('WB', '원빈', 1982, '대전', '010', '98765432', 176, '2020.5.5');

SELECT * FROM userTBL;

CREATE DATABASE IF NOT EXISTS compressDB;
USE compressDB;
CREATE TABLE normalTBL (emp_no INT, first_name VARCHAR(14));
CREATE TABLE compressTBL (emp_no INT, first_name VARCHAR(14)) 
      ROW_FORMAT=COMPRESSED;


INSERT INTO normalTbl 
      SELECT emp_no, first_name FROM employees.employees;
INSERT INTO compressTBL 
      SELECT emp_no, first_name FROM employees.employees;

SHOW TABLE STATUS FROM compressDB;

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

USE tableDB;
ALTER TABLE userTBL 
      ADD homepage VARCHAR(30) -- 열 추가 
             DEFAULT 'http://www.hanbit.co.kr' -- 디폴트 값 
             NULL; -- NULL 허용

USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;

CREATE TABLE userTBL 
( userID CHAR(8), 
  userName VARCHAR(10), 
  birthYear INT, 
  addr CHAR(2), 
  mobile1 CHAR(3), 
  mobile2 CHAR(8), 
  height SMALLINT, 
  mDate DATE
);

CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT PRIMARY KEY, 
  userID CHAR(8), 
  prodName CHAR(6), 
  groupName CHAR(4), 
  price INT, 
  amount SMALLINT 
);

INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO userTBL VALUES ('KHD', '강호동', NULL, '경북', '011', '22222222', 182, '2007-7-7');
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1865, '서울', '019', '33333333', 171, '2009-9-9');
INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5');

INSERT INTO buyTBL VALUES (NULL, 'KHD', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES (NULL, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '모니터', '전자', 200, 5);

ALTER TABLE userTBL 
      ADD CONSTRAINT PK_userTBL_userID 
      PRIMARY KEY (userID);

ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
      FOREIGN KEY (userID) 
      REFERENCES userTBL (userID);

DELETE FROM buyTBL WHERE userID = 'PSH';
ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
      FOREIGN KEY (userID) 
      REFERENCES userTBL (userID);

SET foreign_key_checks = 0;

INSERT INTO buyTBL VALUES (NULL, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO buyTBL VALUES (NULL, 'KJD', '책', '서적', 15, 5);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);

SET foreign_key_checks = 1;

SELECT @@foreign_key_checks;

UPDATE userTBL SET userID = 'PARK' WHERE userID='PSH';

INSERT INTO userTBL VALUES ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

SET foreign_key_checks = 0;
UPDATE userTBL SET userID = 'PARK' WHERE userID='PSH';
SET foreign_key_checks = 1;

ALTER TABLE buyTBL 
      DROP FOREIGN KEY FK_userTBL_buyTBL;
ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
             FOREIGN KEY (userID) 
             REFERENCES userTBL (userID) 
             ON UPDATE CASCADE;


USE tableDB;
DROP TABLE IF EXISTS buyTBL, userTBL;

CREATE TABLE userTBL 
( userID CHAR(8), 
  userName VARCHAR(10), 
  birthYear INT, 
  addr CHAR(2), 
  mobile1 CHAR(3), 
  mobile2 CHAR(8), 
  height SMALLINT, 
  mDate DATE
);

CREATE TABLE buyTBL 
( num INT AUTO_INCREMENT PRIMARY KEY, 
  userID CHAR(8), 
  prodName CHAR(6), 
  groupName CHAR(4), 
  price INT, 
  amount SMALLINT 
);

INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO userTBL VALUES ('KHD', '강호동', NULL, '경북', '011', '22222222', 182, '2007-7-7');
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1865, '서울', '019', '33333333', 171, '2009-9-9');
INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5');

INSERT INTO buyTBL VALUES (NULL, 'KHD', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES (NULL, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '모니터', '전자', 200, 5);

UPDATE userTBL SET userID = 'KANG' WHERE userID='KHD';

ALTER TABLE userTBL 
      ADD CONSTRAINT PK_userTBL_userID 
      PRIMARY KEY (userID);

ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
      FOREIGN KEY (userID) 
      REFERENCES userTBL (userID);
      
SET foreign_key_checks = 0;
INSERT INTO buyTBL VALUES (NULL, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO buyTBL VALUES (NULL, 'KJD', '책', '서적', 15, 5);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'LHJ', '책', '서적', 15, 1);
INSERT INTO buyTBL VALUES (NULL, 'PSH', '운동화', NULL, 30, 2);
SET foreign_key_checks = 1;

INSERT INTO userTBL VALUES ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

ALTER TABLE buyTBL 
      DROP FOREIGN KEY FK_userTBL_buyTBL;
ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
             FOREIGN KEY (userID) 
             REFERENCES userTBL (userID) 
             ON UPDATE CASCADE;



ALTER TABLE buyTBL 
      DROP FOREIGN KEY FK_userTBL_buyTBL;
ALTER TABLE buyTBL 
      ADD CONSTRAINT FK_userTBL_buyTBL 
             FOREIGN KEY (userID) 
             REFERENCES userTBL (userID) 
             ON UPDATE CASCADE 
             ON DELETE CASCADE;

DELETE FROM userTBL WHERE userID = 'PARK';
SELECT * FROM buyTBL;

USE tableDB;
CREATE VIEW v_userTBL 
AS 
      SELECT userID, userName, addr FROM userTBL;

CREATE VIEW v_userbuyTBL 
AS 
SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처' 
   FROM userTBL U 
      INNER JOIN buyTBL B 
         ON U.userID = B.userID;



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
CREATE VIEW v_userbuyTBL 
AS 
SELECT U.userID AS 'USER ID', U.userName AS 'USER NAME', B.prodName AS 'PRODUCT NAME', 
          U.addr, CONCAT(U.mobile1, U.mobile2) AS 'MOBILE PHONE' 
   FROM userTBL U 
      INNER JOIN buyTBL B 
         ON U.userID = B.userID;

SELECT `USER ID`, `USER NAME` FROM v_userbuyTBL; -- 주의! 백틱(키보드 1의 왼쪽 키) 사용

USE cookDB;
CREATE OR REPLACE VIEW v_userTBL 
AS 
      SELECT userID, userName, addr FROM userTBL;


UPDATE v_userTBL SET addr = '부산' WHERE userID='LKK';


CREATE OR REPLACE VIEW v_height180 
AS 
      SELECT * FROM userTBL WHERE height >= 180;

SELECT * FROM v_height180;

CREATE OR REPLACE VIEW v_userbuyTBL 
AS 
SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS mobile
   FROM userTBL U 
      INNER JOIN buyTBL B 
         ON U.userID = B.userID;

INSERT INTO v_userbuyTBL VALUES ('PKL', '박경리', '운동화', '경기', '00000000000', '2020-2-2');

DROP TABLE IF EXISTS buyTBL, userTBL;
SELECT * FROM v_userbuyTBL;
