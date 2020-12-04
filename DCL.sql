SET PERSIST mandatory_roles = '';
Drop ROLE IF EXISTS 'developer'@'localhost', 'administrator'@'localhost', 'user'@'localhost', 'all_mandatory_roles'@'localhost';
Drop USER IF EXISTS 'Company1_John'@'localhost','Company2'@'localhost','admin1'@'localhost','admin2'@'localhost','developer1'@'localhost','developer2'@'localhost';
CREATE ROLE 'developer'@'localhost', 'administrator'@'localhost', 'user'@'localhost', 'all_mandatory_roles'@'localhost';

GRANT ALL ON CSCI362.* TO 'developer'@'localhost';

GRANT SELECT ON CSCI362.Country TO 'all_mandatory_roles'@'localhost';
GRANT SELECT ON CSCI362.States TO 'all_mandatory_roles'@'localhost';
GRANT SELECT ON CSCI362.Sectors TO 'all_mandatory_roles'@'localhost';
GRANT SELECT ON CSCI362.Subsectors TO 'all_mandatory_roles'@'localhost';
GRANT SELECT ON CSCI362.Cyber_security_questions TO 'all_mandatory_roles'@'localhost';
SET PERSIST mandatory_roles = 'all_mandatory_roles@localhost';
SHOW GRANTS FOR 'all_mandatory_roles'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON CSCI362.* TO 'administrator'@'localhost';
SHOW GRANTS FOR 'administrator'@'localhost';

GRANT INSERT, UPDATE ON CSCI362.Application TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Company_information TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Cyber_security_clearence TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Funding TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Address TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Company_sector TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Company_subsector TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Foreign_associates TO 'user'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Investors TO 'user'@'localhost';
SHOW GRANTS FOR 'user'@'localhost';

CREATE USER IF NOT EXISTS 'developer1'@'localhost' IDENTIFIED BY 'developer1';
GRANT 'developer'@'localhost' TO 'developer1'@'localhost';
SHOW GRANTS FOR 'developer1'@'localhost';

CREATE USER IF NOT EXISTS 'developer2'@'localhost' IDENTIFIED BY 'developer2';
GRANT 'developer'@'localhost' TO 'developer2'@'localhost';
GRANT SELECT ON CSCI362.Address to 'developer2'@'localhost';
REVOKE SELECT ON CSCI362.Address FROM 'developer2'@'localhost';
GRANT SELECT ON CSCI362.Application to 'developer2'@'localhost';
REVOKE SELECT ON CSCI362.Application FROM 'developer2'@'localhost';
GRANT SELECT ON CSCI362.Company_information to 'developer2'@'localhost';
REVOKE SELECT ON CSCI362.Company_information FROM 'developer2'@'localhost';
GRANT SELECT ON CSCI362.Cyber_security_clearence to 'developer2'@'localhost';
REVOKE SELECT ON CSCI362.Cyber_security_clearence FROM 'developer2'@'localhost';
GRANT SELECT ON CSCI362.Funding to 'developer2'@'localhost';
REVOKE SELECT ON CSCI362.Funding FROM 'developer2'@'localhost';
SHOW GRANTS FOR 'developer2'@'localhost';

CREATE USER 'admin1'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'admin1' COMMENT 'Some information about Admin1';
GRANT 'administrator'@'localhost' TO 'admin1'@'localhost';
SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'admin1' AND HOST = 'localhost';
SHOW GRANTS FOR 'admin1'@'localhost';

CREATE USER 'admin2'@'localhost' ATTRIBUTE '{"fname": "James", "lname": "Scott", "phone": "123-456-7890"}';
GRANT 'administrator'@'localhost' TO 'admin2'@'localhost';
SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'admin2' AND HOST = 'localhost'\G
SELECT USER AS User, HOST AS Host, CONCAT(ATTRIBUTE->>"$.fname"," ",ATTRIBUTE->>"$.lname") AS 'Full Name', ATTRIBUTE->>"$.comment" AS Comment FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='admin2' AND HOST = 'localhost';
SHOW GRANTS FOR 'admin2'@'localhost';

CREATE USER 'Company1_John'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'Company1_John' PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;
GRANT 'user'@'localhost' TO 'Company1_John'@'localhost';
SHOW GRANTS FOR 'Company1_John'@'localhost';

CREATE USER 'Company2'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Company2' REQUIRE X509 WITH MAX_QUERIES_PER_HOUR 60 PASSWORD HISTORY 5 ACCOUNT LOCK;
GRANT 'user'@'localhost' TO 'Company2'@'localhost';
SHOW GRANTS FOR 'Company2'@'localhost';
GRANT INSERT, UPDATE ON CSCI362.Application TO 'user'@'localhost';

SELECT CURRENT_ROLE();



CREATE OR REPLACE SQL SECURITY DEFINER
VIEW CSCi362.Application_John AS
    SELECT 
        Application.Application_ID AS Application_ID,
        Application.First_Name AS First_Name,
        Application.Middle_Name AS Middle_Name,
        Application.Last_Name AS Last_Name,
        Application.Phone_Number AS Phone_Number,
        Application.Email AS Email,
        Application.Company_Name AS Company_Name,
        Application.Company_Description AS Company_Description,
        Application.Cert_Financials_ID AS Cert_Financials_ID
    FROM
		CSCi362.Application
    WHERE
        (Application.First_Name = 'John');
GRANT SELECT,UPDATE ON CSCi362.Application_John TO 'Company1_John'@'localhost';
SHOW GRANTS FOR 'Company1_John'@'localhost';


SHOW GRANTS FOR 'admin1'@'localhost';
REVOKE ALL, GRANT OPTION FROM 'admin1'@'localhost';
REVOKE 'administrator'@'localhost' FROM 'admin1'@'localhost';
SHOW GRANTS FOR 'admin1'@'localhost';
GRANT SELECT ON CSCI362.Funding to 'admin1'@'localhost';

SELECT user FROM mysql.user;
