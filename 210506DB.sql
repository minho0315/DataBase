-- USE cookDB;
-- SELECT * 
--    FROM buyTBL 
--      INNER JOIN userTBL 
--         ON buyTBL.userID = userTBL.userID 
--    WHERE buyTBL.userID = 'KYM';
--    
--    
-- USE cookDB;
-- SELECT * 
--    FROM buyTBL 
--      INNER JOIN userTBL 
--         ON buyTBL.userID = userTBL.userID 
--   --  WHERE buyTBL.userID = 'KYM' OR buyTBL.userID = 'KHD';
  
-- USE cookDB;
-- SELECT * 
--    FROM userTBL 
--      INNER JOIN buyTBL 
--         ON userTBL.userID = buyTBL.userID 
--   --  WHERE buyTBL.userID = 'KYM' OR buyTBL.userID = 'KHD';
    
-- USE cookDB;
-- SELECT buyTBL.num, userTBL.userID, buyTBL.price
--    FROM buyTBL 
--      INNER JOIN userTBL 
--         ON buyTBL.userID = userTBL.userID 
-- 	ORDER BY buyTBL.num;
-- --    WHERE buyTBL.userID = 'KYM';
  
-- SELECT buyTBl.userID, userName, prodName, addr, CONCAT(mobile1, mobile2) AS '연락처' 
--    FROM buyTBL 
--       INNER JOIN userTBL 
--          ON buyTBL.userID = userTBL.userID;
  
--   SELECT B.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'   
--    FROM buyTBL AS B
--       INNER JOIN userTBL AS U 
--          ON B.userID = U.userID
-- 	  WHERE B.userID = 'KYM';
         
-- SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
--    FROM userTBL U 
--       INNER JOIN buyTBL B
--          ON U.userID = B.userID 
--    ORDER BY U.userID;


-- SELECT DISTINCT U.userID, U.userName, B.prodName, U.addr, B.num
--    FROM userTBL U 
--       INNER JOIN buyTBL B
--          ON U.userID = B.userID 
--    ORDER BY U.userID;

-- USE cookDB;
-- CREATE TABLE stdTBL 
-- ( stdName VARCHAR(10) NOT NULL PRIMARY KEY, 
--   addr CHAR(4) NOT NULL
-- );
-- CREATE TABLE clubTBL 
-- ( clubName VARCHAR(10) NOT NULL PRIMARY KEY, 
--   roomNo CHAR(4) NOT NULL
-- );
-- CREATE TABLE stdclubTBL 
-- ( num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
--   stdName VARCHAR(10) NOT NULL, 
--   clubName VARCHAR(10) NOT NULL, 
--   FOREIGN KEY(stdName) REFERENCES stdTBL(stdName), 
--   FOREIGN KEY(clubName) REFERENCES clubTBL(clubName)
-- );
-- INSERT INTO stdTBL VALUES ('강호동', '경북'), ('김제동', '경남'), ('김용만', '서울'), ('이휘재', '경기'), ('박수홍', '서울');
-- INSERT INTO clubTBL VALUES ('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), ('봉사', '104호');
-- INSERT INTO stdclubTBL VALUES (NULL, '강호동', '바둑'), (NULL, '강호동', '축구'), (NULL, '김용만', '축구'), (NULL, '이휘재', '축구'), (NULL, '이휘재', '봉사'), (NULL, '박수홍', '봉사');

-- SELECT *
--    FROM stdTBL S 
--       LEFT OUTER JOIN stdclubTBL SC
--          ON S.stdName = SC.stdName
--       LEFT OUTER JOIN clubTBL C
--          ON SC.clubName = C.clubName;
-- --   ORDER BY S.stdName;

-- SELECT *
--    FROM stdTBL S 
--       LEFT OUTER JOIN stdclubTBL SC
--          ON S.stdName = SC.stdName
--       RIGHT OUTER JOIN clubTBL C
--          ON SC.clubName = C.clubName;
-- --   ORDER BY S.stdName;

-- USE cookDB;
-- SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'    
--    FROM userTBL U 
--       LEFT OUTER JOIN buyTBL B 
--          ON U.userID = B.userID 
--    ORDER BY U.userID;

-- SELECT U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
--    FROM userTBL U 
--       LEFT OUTER JOIN buyTBL B 
--          ON U.userID = B.userID 
--    WHERE B.prodName IS NULL 
--    ORDER BY U.userID;

-- SELECT S.stdName, S.addr, C.clubName, C.roomNo 
--    FROM stdTBL S 
--       LEFT OUTER JOIN stdclubTBL SC 
--          ON S.stdName = SC.stdName 
--       LEFT OUTER JOIN clubTBL C 
--          ON SC.clubName = C.clubName 
-- UNION 
-- SELECT S.stdName, S.addr, C.clubName, C.roomNo 
--    FROM stdTBL S 
--       LEFT OUTER JOIN stdclubTBL SC 
--          ON SC.stdName = S.stdName 
--       RIGHT OUTER JOIN clubTBL C 
--          ON SC.clubName = C.clubName;

-- USE cookDB;
-- SELECT * 
--    FROM buyTBL 
--       CROSS JOIN userTBL;

-- USE employees;
-- SELECT COUNT( * ) AS '데이터개수' 
--    FROM employees 
--       CROSS JOIN titles;

-- SELECT userName, CONCAT(mobile1, '-', mobile2) AS '전화번호' FROM userTBL 
--    WHERE userName NOT IN (SELECT userName FROM userTBL WHERE mobile1 IS NULL);


-- DROP PROCEDURE IF EXISTS ifProc; -- 기존에 스토어드 프로시저를 만든 적이 있다면 삭제 
-- DELIMITER $$ 
-- CREATE PROCEDURE ifProc() 
-- BEGIN 
--   DECLARE var1 INT; -- var1 변수 선언 
--   SET var1 = 100; -- 변수에 값 대입

--   IF var1 = 100 THEN -- 만약 @var1이 100이라면 
--    SELECT '100입니다.';
--   ELSE 
--    SELECT '100이 아닙니다.';
--   END IF;
-- END $$ 
-- DELIMITER ;

-- CALL ifProc();


-- DROP PROCEDURE IF EXISTS ifProc2;
-- USE employees;

-- DELIMITER $$ 
-- CREATE PROCEDURE ifProc2() 
-- BEGIN 
--      DECLARE hireDATE DATE; -- 입사일 
--      DECLARE curDATE DATE; -- 오늘 
--      DECLARE days INT; -- 근무한 일수

--      SELECT hire_date INTO hireDate -- hire_date 열의 결과를 hireDATE에 대입 
--         FROM employees.employees 
--         WHERE emp_no = 10001;

--      SET curDATE = CURRENT_DATE(); -- 현재 날짜 
--      SET days = DATEDIFF(curDATE, hireDATE); -- 날짜의 차이, 일 단위

--      IF (days/365) >= 5 THEN -- 5년이 지났다면 
--             SELECT CONCAT('입사한지 ', days, '일이나 지났습니다. 축하합니다!') AS '메시지';
--      ELSE 
--             SELECT CONCAT('입사한지 ' + days + '일밖에 안되었네요. 열심히 일하세요.') AS '메시지';
--      END IF;
-- END $$ 
-- DELIMITER ;
-- CALL ifProc2();

-- DROP PROCEDURE IF EXISTS caseProc;
-- DELIMITER $$ 

-- CREATE PROCEDURE caseProc() 
-- BEGIN 
--     DECLARE point INT;
--     DECLARE credit CHAR(1);
--     SET point = 96;
--    
--     CASE 
--         WHEN point >= 90 THEN 
--                  SET credit = 'A';
--         WHEN point >= 80 THEN 
--                  SET credit = 'B';
--         WHEN point >= 70 THEN 
--                  SET credit = 'C';
--         WHEN point >= 60 THEN 
--                  SET credit = 'D';
--         ELSE SET credit = 'F';
--     END CASE;
--     
--     SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
--     
-- END $$ 

-- DELIMITER ;
-- CALL caseProc();

-- SELECT U.userID, U.userName, SUM(price * amount) AS '총구매액', 
--        CASE 
--           WHEN (SUM(price * amount) >= 1500) THEN '최우수고객'
--           WHEN (SUM(price * amount) >= 1000) THEN '우수고객'
--           WHEN (SUM(price * amount) >= 1 ) THEN '일반고객'
--           ELSE '유령고객'
--        END AS '고객등급'
--     FROM buyTBL B 
--        RIGHT OUTER JOIN userTBL U 
--          ON B.userID = U.userID 
--     GROUP BY U.userID, U.userName 
--     ORDER BY sum(price * amount) DESC;

-- DROP PROCEDURE IF EXISTS errorProc;
-- DELIMITER $$ 
-- CREATE PROCEDURE errorProc() 
-- BEGIN 
--      -- DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 없어요ㅠㅠ' AS '메시지';
--      SELECT * FROM noTable; -- noTable은 없음 
-- END $$ 
-- DELIMITER ;

-- CALL errorProc();
-- SELECT '다음 문장입니다.';

-- DROP PROCEDURE IF EXISTS errorProc2;
-- DELIMITER $$ 

-- CREATE PROCEDURE errorProc2() 
-- BEGIN 
--     DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
--     BEGIN 
--       SHOW ERRORS; -- 오류 메시지를 보여줌 
--       SELECT '오류가 발생했네요. 작업은 취소시켰습니다.' AS '메시지';
--       ROLLBACK; -- 오류 발생 시 작업을 롤백 
--     END;
--     INSERT INTO userTBL VALUES('YJS', '윤정수', 1988, '서울', NULL, NULL, 170, CURRENT_DATE()); 
--     -- 중복되는 아이디이므로 오류 발생 
-- END $$ 

-- DELIMITER ;

-- CALL errorProc2();

USE cookDB;
DROP TABLE IF EXISTS myTable;

CREATE TABLE myTable (id INT AUTO_INCREMENT PRIMARY KEY, mDate DATETIME);

SET @curDATE = CURRENT_TIMESTAMP(); -- 현재 날짜와 시간

PREPARE myQuery FROM 'INSERT INTO myTable VALUES(NULL, ?)';
EXECUTE myQuery USING @curDATE;
DEALLOCATE PREPARE myQuery;

SELECT * FROM myTable;