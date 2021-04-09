CREATE TABLE testTBL1 (id int, userName char(3), age int);
INSERT INTO testTBL1 VALUES (1, '뽀로로', 16);

INSERT INTO testTBL1 (id, userName) VALUES (2, '크롱');

USE cookDB;
CREATE TABLE testTBL2 
( id int AUTO_INCREMENT PRIMARY KEY, 
  userName char(3), 
  age int 
);
INSERT INTO testTBL2 VALUES (NULL, '에디', 15);
INSERT INTO testTBL2 VALUES (NULL, '포비', 12);
INSERT INTO testTBL2 VALUES (NULL, '통통이', 11);
SELECT * FROM testTBL2;

ALTER TABLE testTBL2 AUTO_INCREMENT=100;
INSERT INTO testTBL2 VALUES (NULL, '패티', 13);
SELECT * FROM testTBL2;

USE cookDB;
CREATE TABLE testTBL3 
( id int AUTO_INCREMENT PRIMARY KEY, 
  userName char(3), 
  age int 
);
ALTER TABLE testTBL3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3;
INSERT INTO testTBL3 VALUES (NULL, '우디', 20);
INSERT INTO testTBL3 VALUES (NULL, '버즈', 18);
INSERT INTO testTBL3 VALUES (NULL, '제시', 19);
SELECT * FROM testTBL3;

SELECT @@auto_increment_increment;
SET @a = 10;
SELECT @a;

INSERT INTO testTBL3 VALUES (NULL, '토이', 17), (NULL, '스토리', 18), (NULL, '무비', 19);
SELECT * FROM testTBL3;

USE cookDB;
CREATE TABLE testTBL4 (id int, Fname varchar(50), Lname varchar(50));
INSERT INTO testTBL4 
   SELECT emp_no, first_name, last_name FROM employees.employees;
   
CREATE TABLE testTBL6 
    (SELECT emp_no AS id, first_name AS Fname, last_name AS Lname 
             FROM employees.employees);
SELECT * FROM testTBL6 LIMIT 3;

CREATE TABLE testTBL7 
    (SELECT emp_no id, first_name Fname, last_name Lname 
             FROM employees.employees);
SELECT * FROM testTBL6 LIMIT 3;

USE cookDB;
UPDATE testTBL4 
SET Lname = '없음' 
WHERE Fname = 'Kyoichi';

USE cookDB;
DELETE FROM testTBL4 WHERE Fname = 'Aamer';

USE cookDB;
CREATE TABLE bigTBL1 (SELECT * FROM employees.employees);
CREATE TABLE bigTBL2 (SELECT * FROM employees.employees);
CREATE TABLE bigTBL3 (SELECT * FROM employees.employees);

DELETE FROM bigTBL1;
DROP TABLE bigTBL2;
TRUNCATE TABLE bigTBL3;

USE cookDB;
CREATE TABLE memberTBL (SELECT userID, userName, addr FROM userTBL LIMIT 3); -- 3건만 가져옴 
ALTER TABLE memberTBL 
      ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- 기본키 지정 
SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES ('KHD', '강후덜', '미국'); -- 기본키 중복 입력 
INSERT INTO memberTBL VALUES ('LSM', '이상민', '서울');
INSERT INTO memberTBL VALUES ('KSJ', '김성주', '경기');

INSERT IGNORE INTO memberTBL VALUES ('KHD', '강후덜', '미국');
INSERT IGNORE INTO memberTBL VALUES ('LSM', '이상민', '서울');
INSERT IGNORE INTO memberTBL VALUES ('KSJ', '김성주', '경기');
SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES ('KHD', '강후덜', '미국')
      ON DUPLICATE KEY UPDATE userName='강후덜', addr='미국';
INSERT INTO memberTBL VALUES ('DJM', '동짜몽', '일본') 
      ON DUPLICATE KEY UPDATE userName='동짜몽', addr='일본';
SELECT * FROM memberTBL;


USE cookDB;
SELECT ROW_NUMBER() OVER(ORDER BY height DESC) "키큰순위", userName, addr, height 
   FROM userTBL;

SELECT ROW_NUMBER() OVER(ORDER BY height DESC,
userName ASC) "키큰순위", userName, addr, height 
   FROM userTBL;

SELECT addr, ROW_NUMBER() OVER(PARTITION BY addr
ORDER BY height DESC, userName ASC) "지역 별키큰순위",
userName, height 
   FROM userTBL;
   
SELECT DENSE_RANK() OVER(ORDER BY height DESC) "키큰순
위", userName, addr, height 
   FROM userTBL;
   
SELECT RANK() OVER(ORDER BY height DESC) "키큰순위",
userName, addr, height 
   FROM userTBL;
   
SELECT NTILE(2) OVER(ORDER BY height DESC) "반번호",
userName, addr, height 
   FROM userTBL;
   
USE cookDB;
SELECT userName, addr, height AS "키", 
        height - (LEAD(height, 1, height) OVER (ORDER BY height DESC)) AS "다음 사람과 키 차이"
   FROM userTBL;
   
SELECT addr, userName, height AS "키", 
        height - (FIRST_VALUE(height) OVER (PARTITION BY addr ORDER BY height DESC)) 
              AS "지역별 최대키와 차이" 
   FROM userTBL;