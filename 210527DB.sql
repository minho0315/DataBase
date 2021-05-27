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
DROP PROCEDURE IF EXISTS userProc;
DELIMITER $$ 

CREATE PROCEDURE userProc() 
BEGIN 
SELECT * FROM userTBL; -- 스토어드 프로시저 내용 
END $$

DELIMITER ;

CALL userProc();


USE cookDB;
DROP PROCEDURE IF EXISTS userProc1;

DELIMITER $$ 

CREATE PROCEDURE userProc1(IN uName VARCHAR(10)) 
BEGIN 
   SELECT * FROM userTBL WHERE userName = uName;
   
END $$ 

DELIMITER ;

 CALL userProc1('이경규');
 
 
DROP PROCEDURE IF EXISTS userProc2;
DELIMITER $$ 
CREATE PROCEDURE userProc2( 
     IN userBirth INT, 
     IN userHeight INT 
) 
BEGIN 
   SELECT * FROM userTBL 
     WHERE birthYear > userBirth AND height > userHeight;
 END $$ 
 DELIMITER ;
 
 CALL userProc2(1970, 178);
 
 
 DROP PROCEDURE IF EXISTS userProc3;

DELIMITER $$ 

CREATE PROCEDURE userProc3( 
    IN txtValue CHAR(10), 
    OUT outValue INT 
) 
BEGIN 
    INSERT INTO testTBL VALUES(NULL, txtValue);
    SELECT MAX(id) INTO outValue FROM testTBL;
 END $$ 
 
 DELIMITER ;
 
CREATE TABLE IF NOT EXISTS testTBL( 
     id INT AUTO_INCREMENT PRIMARY KEY, 
     txt CHAR(10) 
 );


CALL userProc3 ('테스트값', @myValue);

SELECT * FROM testTBL;

SELECT CONCAT('현재 입력된 ID 값 ==>', @myValue);
 
 
 
 DROP PROCEDURE IF EXISTS ifelseProc;
DELIMITER $$ 
CREATE PROCEDURE ifelseProc( 
     IN uName VARCHAR(10) 
) 
BEGIN 
     DECLARE bYear INT; -- 변수 선언 
     SELECT birthYear into bYear FROM userTBL 
         WHERE userName = uName;
      IF (bYear >= 1970) THEN 
             SELECT '아직 젊군요..';
      ELSE 
             SELECT '나이가 지긋하네요..';
      END IF;
 END $$ 
 DELIMITER ;
 
 CALL ifelseProc ('김국진');
 
 
DROP TABLE IF EXISTS guguTBL;

CREATE TABLE guguTBL (txt VARCHAR(100)); -- 구구단 저장용 테이블 

DROP PROCEDURE IF EXISTS whileProc;

DELIMITER $$ 

CREATE PROCEDURE whileProc() 
BEGIN 
  DECLARE str VARCHAR(100); -- 각 단을 문자열로 저장 
  DECLARE i INT; -- 구구단 앞자리 
  DECLARE k INT; -- 구구단 뒷자리 
  SET i = 2; -- 2단부터 계산
 
  WHILE (i < 10) DO -- 바깥 반복문(2~9단 반복) 
    SET str = ''; -- 각 단의 결과를 저장할 문자열 초기화 
    SET k = 1; -- 구구단 뒷자리는 항상 1부터 9까지 
    WHILE (k < 10) DO 
      SET str = CONCAT(str, ' ', i, 'x', k, '=', i * k); -- 문자열 만들기  
      SET k = k + 1; -- 뒷자리 증가 
    END WHILE;
    
    SET i = i + 1; -- 앞자리 증가 
    INSERT INTO guguTBL VALUES(str); -- 각 단의 결과를 테이블에 입력 
    
  END WHILE;
END $$ 

DELIMITER ;
 
CALL whileProc();

SELECT * FROM guguTBL;
 
 
 
DROP TABLE IF EXISTS guguTBL;

DROP PROCEDURE IF EXISTS errorProc;
DELIMITER $$ 
CREATE PROCEDURE errorProc() 
BEGIN 
    DECLARE i INT; -- 1씩 증가하는 값 
    DECLARE hap INT; -- 합계(정수형), 오버플로를 발생시킬 예정 
    DECLARE saveHap INT; -- 합계(정수형), 오버플로가 발생하기 직전의 값 저장 

    DECLARE EXIT HANDLER FOR 1264 -- 정수형 오버플로가 발생하면 이 부분 수행 
    BEGIN 
         SELECT CONCAT('INT 오버플로 직전의 합계 --> ', saveHap);
         SELECT CONCAT('1+2+3+4+…+', i, '=오버플로');
     END;
 
     SET i = 1; -- 1부터 증가 
     SET hap = 0; -- 합계 누적 
 
     WHILE (TRUE) DO -- 무한 루프 
         SET saveHap = hap; -- 오버플로 직전의 합계 저장 
         SET hap = hap + i; -- 오버플로가 발생하면 11행과 12행 수행 
         SET i = i + 1;
     END WHILE;
 END $$ 
 DELIMITER ;
 
 CALL errorProc();
 
 -- --------------------------------------------------------------------------------
 SHOW DATABASES;
 
 SHOW TABLES FROM INFORMATION_SCHEMA;
 
 USE MYSQL;
 SELECT * FROM INFORMATION_SCHEMA.ROUTINES;
 
SHOW CREATE PROCEDURE cookDB.whileProc;



DROP PROCEDURE IF EXISTS nameProc;

DELIMITER $$ 

CREATE PROCEDURE nameProc( 
    IN tableName VARCHAR(20)
) 
BEGIN 
   SELECT * FROM tableName;
END $$ 

DELIMITER ;
 
CALL nameProc('userTBL');



DROP PROCEDURE IF EXISTS nameProc;

DELIMITER $$ 

CREATE PROCEDURE nameProc( 
     IN tableName VARCHAR(20) 
) 
BEGIN 
   SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
   PREPARE myQuery FROM @sqlQuery;
   EXECUTE myQuery;
  DEALLOCATE PREPARE myQuery;
 END $$ 
 
 DELIMITER ;
 
 CALL nameProc('userTBL');




SET GLOBAL log_bin_trust_function_creators = 1;

SELECT @@log_bin_trust_function_creators;


USE cookDB;

DROP FUNCTION IF EXISTS userFunc;

DELIMITER $$ 

CREATE FUNCTION userFunc(value1 INT, value2 INT) 
RETURNS INT

BEGIN 
  RETURN value1 + value2;
END $$ 

DELIMITER ;
 
 SELECT userFunc(100, 200);
 

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

DROP FUNCTION IF EXISTS getAgeFunc;

DELIMITER $$ 

CREATE FUNCTION getAgeFunc(bYear INT) 
     RETURNS INT 
BEGIN 
     DECLARE age INT;
     SET age = YEAR(CURDATE()) - bYear;
     RETURN age;
END $$ 

DELIMITER ;

SELECT getAgeFunc(1979) INTO @age1979;
SELECT getAgeFunc(1997) INTO @age1997;
SELECT CONCAT('1997년과 1979년의 나이차 ==> ', (@age1979-@age1997));


SELECT userID, userName, getAgeFunc(birthYear) AS '만 나이' FROM userTBL;



DROP PROCEDURE IF EXISTS cursorProc;

DELIMITER $$

CREATE PROCEDURE cursorProc() 
BEGIN 
     DECLARE userHeight INT; -- 고객의 키 
     DECLARE cnt INT DEFAULT 0; -- 고객의 인원수(읽은 행의 수) 
     DECLARE totalHeight INT DEFAULT 0; -- 키의 합계 

     DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 행의 끝 여부(기본은 FALSE) 
 
    DECLARE userCuror CURSOR FOR -- 커서 선언 
         SELECT height FROM userTBL;
 
    DECLARE CONTINUE HANDLER -- 행의 끝이면 endOfRow 변수에 TRUE 대입 
         FOR NOT FOUND SET endOfRow = TRUE;
 
     OPEN userCuror; -- 커서 열기 
 
     cursor_loop: LOOP 
         FETCH userCuror INTO userHeight; -- 고객의 키 1개 대입 
 
         IF endOfRow THEN -- 더 이상 읽을 행이 없으면 LOOP 종료 
             LEAVE cursor_loop;
        END IF;
 
        SET cnt = cnt + 1;
        SET totalHeight = totalHeight + userHeight;
     END LOOP cursor_loop;
 
     -- 고객의 평균 키 출력 
     SELECT CONCAT('고객 키의 평균 ==> ', (totalHeight/cnt));
 
     CLOSE userCuror; -- 커서 닫기 
 END $$ 
 
 DELIMITER ;

CALL cursorProc();

USE cookDB;
ALTER TABLE userTBL ADD grade VARCHAR(5);

DROP PROCEDURE IF EXISTS gradeProc;

DELIMITER $$ 

CREATE PROCEDURE gradeProc() 
BEGIN 
    DECLARE id VARCHAR(10); -- 사용자 아이디를 저장할 변수 
    DECLARE hap BIGINT; -- 총구매액을 저장할 변수 
    DECLARE userGrade CHAR(5); -- 고객 등급 변수 

    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
 
   DECLARE userCuror CURSOR FOR -- 커서 선언 
        SELECT U.userid, sum(price * amount) 
            FROM buyTBL B 
               RIGHT OUTER JOIN userTBL U 
               ON B.userid = U.userid 
            GROUP BY U.userid, U.userName;
 
   DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET endOfRow = TRUE;

    OPEN userCuror; -- 커서 열기
    grade_loop: LOOP 
        FETCH userCuror INTO id, hap; -- 첫 행 값 대입
        IF endOfRow THEN
            LEAVE grade_loop;
        END IF;
 
        CASE 
            WHEN (hap >= 1500) THEN SET userGrade = '최우수고객';
            WHEN (hap >= 1000) THEN SET userGrade ='우수고객';
            WHEN (hap >= 1) THEN SET userGrade ='일반고객';
            ELSE SET userGrade ='유령고객';
        END CASE;
 
        UPDATE userTBL SET grade = userGrade WHERE userID = id;
     END LOOP grade_loop;
 
     CLOSE userCuror; -- 커서 닫기 
 END $$ 
 
 DELIMITER ;

CALL gradeProc();
SELECT * FROM userTBL;

-- ------------------------------------------------------------------

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
CREATE TABLE IF NOT EXISTS testTBL (id INT, txt VARCHAR(10));
INSERT INTO testTBL VALUES (1, '이엑스아이디');
INSERT INTO testTBL VALUES (2, '블랙핑크');
INSERT INTO testTBL VALUES (3, '에이핑크');


DROP TRIGGER IF EXISTS testTrg;

DELIMITER // 

CREATE TRIGGER testTrg -- 트리거 이름 
     AFTER DELETE -- 삭제 후에 작동하도록 지정 
     ON testTBL -- 트리거를 부착할 테이블 
     FOR EACH ROW -- 각 행마다 적용 
BEGIN 
     SET @msg = '가수 그룹이 삭제됨'; -- 트리거 실행 시 작동하는 코드
     
END // 

DELIMITER ;

SET @msg = '';
INSERT INTO testTBL VALUES (4, '여자친구');
SELECT @msg;

UPDATE testTBL SET txt = '레드벨벳' WHERE id = 3;
SELECT @msg;

DELETE FROM testTBL WHERE id = 4;
SELECT @msg;


USE cookDB;
DROP TABLE buyTBL; -- 구매 테이블은 실습에 필요 없으므로 삭제 
CREATE TABLE backup_userTBL 
( userID char(8) NOT NULL, 
  userName varchar(10) NOT NULL, 
  birthYear int NOT NULL, 
  addr char(2) NOT NULL, 
  mobile1 char(3), 
  mobile2 char(8), 
  height smallint, 
  mDate date, 
  modType char(2), -- 변경된 유형(‘수정’ 또는 ‘삭제’) 
  modDate date, -- 변경된 날짜 
  modUser varchar(256) -- 변경한 사용자 
);



DROP TRIGGER IF EXISTS backUserTBL_UpdateTrg;

DELIMITER // 

CREATE TRIGGER backUserTBL_UpdateTrg -- 트리거 이름 
     AFTER UPDATE -- 변경 후 작동하도록 지정 
     ON userTBL -- 트리거를 부착할 테이블 
     FOR EACH ROW 
BEGIN 
   INSERT INTO backup_userTBL VALUES (OLD.userID, OLD.userName, OLD.birthYear, 
      OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
      '수정', CURDATE(), CURRENT_USER());
 END // 
 
 DELIMITER ;


UPDATE userTBL SET addr = '제주' WHERE userID = 'KJD';


USE cookDB;
DROP TRIGGER IF EXISTS userTBL_InsertTrg; -- 앞에서 실습한 트리거 제거 
DROP TRIGGER IF EXISTS userTBL_BeforeInsertTrg;

DELIMITER // 
CREATE TRIGGER userTBL_BeforeInsertTrg -- 트리거 이름 
     BEFORE INSERT -- 데이터를 삽입하기 전 작동하도록 지정 
     ON userTBL -- 트리거를 부착할 테이블 
     FOR EACH ROW 
BEGIN 
     IF NEW.birthYear < 1900 THEN 
         SET NEW.birthYear = 0;
     ELSEIF NEW.birthYear > YEAR(CURDATE()) THEN 
         SET NEW.birthYear = YEAR(CURDATE());
     END IF;
 END // 
 
 DELIMITER ;
 
 
 INSERT INTO userTBL VALUES 
   ('AAA', '에이', 1877, '서울', '011', '11112222', 181, '2019-12-25');
INSERT INTO userTBL VALUES 
   ('BBB', '비이', 2977, '경기', '011', '11113333', 171, '2011-3-25');



USE mysql;
DROP DATABASE IF EXISTS triggerDB;
CREATE DATABASE IF NOT EXISTS triggerDB;

USE triggerDB;
CREATE TABLE orderTBL -- 구매 테이블 
( orderNo INT AUTO_INCREMENT PRIMARY KEY, -- 구매 일련번호 
  userID VARCHAR(5), -- 구매한 회원 아이디 
  prodName VARCHAR(5), -- 구매한 물건 
  orderamount INT -- 구매한 개수 
);
CREATE TABLE prodTBL -- 물품 테이블 
( prodName VARCHAR(5), -- 물건 이름 
  account INT -- 남은 물건 수량 
);
CREATE TABLE deliverTBL -- 배송 테이블 
( deliverNo INT AUTO_INCREMENT PRIMARY KEY, -- 배송 일련번호 
  prodName VARCHAR(5), -- 배송할 물건 
  account INT UNIQUE -- 배송할 물건 개수 
);

INSERT INTO prodTBL VALUES ('사과', 100);
INSERT INTO prodTBL VALUES ('배', 100);
INSERT INTO prodTBL VALUES ('귤', 100);

-- 물품 테이블에서 개수를 감소시키는 트리거 
DROP TRIGGER IF EXISTS orderTrg;
DELIMITER // 
CREATE TRIGGER orderTrg -- 트리거 이름 
AFTER INSERT 
ON orderTBL -- 트리거를 부착할 테이블 
FOR EACH ROW 
BEGIN 
UPDATE prodTBL SET account = account - NEW.orderamount 
 WHERE prodName = NEW.prodName;
 END // 
 DELIMITER ;
 
 -- 배송 테이블에 새 배송 건을 삽입하는 트리거 
 DROP TRIGGER IF EXISTS prodTrg;
 DELIMITER //
 CREATE TRIGGER prodTrg -- 트리거 이름 
 AFTER UPDATE 
 ON prodTBL -- 트리거를 부착할 테이블 
 FOR EACH ROW 
 BEGIN 
 DECLARE orderAmount INT;
 -- 주문 개수 = (변경 전 개수 - 변경 후 개수) 
 SET orderAmount = OLD.account - NEW.account;
 INSERT INTO deliverTBL(prodName, account) 
 VALUES(NEW.prodName, orderAmount);
 END // 
 DELIMITER ;

INSERT INTO orderTBL VALUES (NULL, 'JOHN', '배', 5);

SELECT * FROM orderTBL;
SELECT * FROM prodTBL;
SELECT * FROM deliverTBL;
