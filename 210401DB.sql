-- USE employees; 
SELECT * FROM employees.employees;

SELECT first_name, last_name, gender FROM employees;

SELECT first_name FROM employees;

DESC employees;
 
SELECT first_name, gender FROM employees LIMIT 0, 10;
SELECT first_name, gender FROM employees LIMIT 2, 8;

DROP DATABASE IF EXISTS cookDB; -- 만약 cookDB가 존재하면 우선 삭제한다.
CREATE DATABASE cookDB;

USE cookDB;
CREATE TABLE userTBL -- 회원 테이블 
( userID CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK) 
  userName VARCHAR(10) NOT NULL, -- 이름 
  birthYear INT NOT NULL, -- 출생 연도 
  addr CHAR(2) NOT NULL, -- 지역(경기, 서울, 경남 식으로 2글자만 입력) 
  mobile1 CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등) 
  mobile2 CHAR(8), -- 휴대폰의 나머지 번호(하이픈 제외) 
  height SMALLINT, -- 키 
  mDate DATE -- 회원 가입일
);
CREATE TABLE buyTBL -- 구매 테이블 
( num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK) 
  userID CHAR(8) NOT NULL, -- 아이디(FK) 
  prodName CHAR(6) NOT NULL, -- 물품 
  groupName CHAR(4), -- 분류 
  price INT NOT NULL, -- 단가 
  amount SMALLINT NOT NULL, -- 수량 
  FOREIGN KEY (userID) REFERENCES userTBL (userID)
);

INSERT INTO userTBL VALUES ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-8-8');
INSERT INTO userTBL VALUES ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-7-7');
INSERT INTO userTBL VALUES ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-9-9');
INSERT INTO userTBL VALUES ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-5-5');
INSERT INTO userTBL VALUES ('KJD', '김제동', 1974, '경남', NULL , NULL, 173, '2013-3-3');
INSERT INTO userTBL VALUES ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-4-4');
INSERT INTO userTBL VALUES ('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10');
INSERT INTO userTBL VALUES ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-4-4');
INSERT INTO userTBL VALUES ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12');
INSERT INTO userTBL VALUES ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-5-5');

INSERT INTO buyTBL VALUES (NULL, 'KHD', '운동화', NULL, 30, 2);
INSERT INTO buyTBL VALUES (NULL, 'KHD', '노트북', '전자', 1000, 1);
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


SELECT * FROM userTBL WHERE userName = '강호동';
SELECT * FROM userTBL WHERE addr = '경남';

SELECT * FROM userTBL WHERE birthYear >= 1970 AND height >= 182;
SELECT * FROM userTBL WHERE birthYear >= 1970 OR height >= 182;

SELECT userName, height FROM userTBL WHERE height BETWEEN 180 AND 182;

SELECT userName, addr FROM userTBL WHERE addr='경남' OR addr='충남' OR addr='경북';

SELECT userName, addr FROM userTBL WHERE addr IN ('경남', '충남', '경북');

SELECT userName, height FROM userTBL WHERE userName LIKE '김%';
SELECT userName, height FROM userTBL WHERE userName LIKE '_경규';
SELECT * FROM userTBL WHERE addr LIKE '경_';

SELECT height FROM userTBL WHERE userName = '김용만';
SELECT userName, height FROM userTBL WHERE height > (SELECT height FROM userTBL WHERE userName = '김용만');

SELECT height FROM userTBL WHERE addr = '경기';
-- SELECT userName, height FROM userTBL 
--    WHERE height >= (SELECT height FROM userTBL WHERE addr = '경기');
   
SELECT userName, height FROM userTBL 
   WHERE height >= ANY(SELECT height FROM userTBL WHERE addr = '경기');
SELECT userName, height FROM userTBL 
   WHERE height >= ALL(SELECT height FROM userTBL WHERE addr = '경기');


SELECT userName, mDate FROM userTBL ORDER BY mDate ASC;
SELECT * FROM userTBL ORDER BY addr, mDate ASC;
SELECT * FROM userTBL ORDER BY addr, mDate DESC;

SELECT DISTINCT addr AS 주소 FROM userTBL ORDER BY addr;


USE employees;
SELECT emp_no, hire_date FROM employees 
   ORDER BY hire_date ASC;

USE employees;
SELECT emp_no, hire_date FROM employees 
   ORDER BY hire_date ASC LIMIT 5;
   
USE cookDB;
CREATE TABLE buyTBL2 (SELECT * FROM buyTBL);
SELECT * FROM buyTBL2;

USE cookDB;
CREATE TABLE buyTBL3 (SELECT userID, prodName FROM buyTBL);
SELECT * FROM buyTBL3;

USE cookDB;
SELECT userID, amount FROM buyTBL ORDER BY userID;

SELECT SUM(amount) FROM buyTBL; -- GROUP BY userID;
SELECT userID, SUM(amount) FROM buyTBL GROUP BY userID;

SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수' 
   FROM buyTBL GROUP BY userID;
   
SELECT *, SUM(price * amount) AS '총구매액'     
   FROM buyTBL GROUP BY userID;
   
USE cookDB;
SELECT SUM(amount) AS '평균 구매 개수' FROM buyTBL;

SELECT userName, MAX(height), MIN(height) FROM userTBL;

SELECT userName, MAX(height), MIN(height) 
   FROM userTBL GROUP BY userName;
   
SELECT userName, height 
   FROM userTBL 
   WHERE height = (SELECT MAX(height) FROM userTBL) 
         OR height = (SELECT MIN(height) FROM userTBL);

SELECT COUNT( * ) FROM userTBL;

SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자' FROM userTBL; -- null 카운팅은 안한다

SELECT userID AS '사용자', SUM(price * amount) AS '총구매액'
   FROM buyTBL 
   GROUP BY userID 
   HAVING SUM(price * amount) > 1000;
   
SELECT userID AS '사용자', SUM(price * amount) AS '총구매' 
   FROM buyTBL 
   GROUP BY userID 
   HAVING SUM(price * amount) > 1000 
   ORDER BY SUM(price * amount) DESC;
   
