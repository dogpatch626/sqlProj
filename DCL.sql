SYSTEM mysql - u root - p

DROP ROLE 'developer'
	,'administrator'
	,'user'
	,'all_mandatory_roles' @ 'localhost';

CREATE ROLE 'developer'
	,'administrator'
	,'user'
	,'all_mandatory_roles' @ 'localhost';

GRANT ALL
	ON CSCI362.*
	TO 'developer';

GRANT SELECT
	ON CSCI362.Country
	TO 'all_mandatory_roles' @ 'localhost';

GRANT SELECT
	ON CSCI362.States
	TO 'all_mandatory_roles' @ 'localhost';

GRANT SELECT
	ON CSCI362.Sectors
	TO 'all_mandatory_roles' @ 'localhost';

GRANT SELECT
	ON CSCI362.Subsectors
	TO 'all_mandatory_roles' @ 'localhost';

GRANT SELECT
	ON CSCI362.Cyber_security_questions
	TO 'all_mandatory_roles' @ 'localhost';

SET PERSIST mandatory_roles = 'all_mandatory_roles@localhost';

GRANT SELECT
	,INSERT
	,UPDATE
	,DELETE
	ON CSCI362.*
	TO 'administrator';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Application
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Company_information
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Cyber_security_clearence
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Funding
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Address
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Company_sector
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Company_subsector
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Foreign_associates
	TO 'user';

GRANT INSERT
	,UPDATE
	,
	ON CSCI362.Investors
	TO 'user';

CREATE USER

IF NOT EXISTS 'developer1' @ 'localhost' IDENTIFIED BY 'developer1';
	GRANT 'developer'
		TO 'developer1' @ 'localhost';

CREATE USER

IF NOT EXISTS 'developer2' @ 'localhost' IDENTIFIED BY 'developer2';
	GRANT 'developer'
		TO 'developer2' @ 'localhost';

GRANT SELECT
	ON CSCI362.Address
	TO 'developer2' @ 'localhost';

REVOKE SELECT
	ON CSCI362.Address
	FROM 'developer2' @ 'localhost';

GRANT SELECT
	ON CSCI362.Application
	TO 'developer2' @ 'localhost';

REVOKE SELECT
	ON CSCI362.Application
	FROM 'developer2' @ 'localhost';

GRANT SELECT
	ON CSCI362.Company_information
	TO 'developer2' @ 'localhost';

REVOKE SELECT
	ON CSCI362.Company_information
	FROM 'developer2' @ 'localhost';

GRANT SELECT
	ON CSCI362.Cyber_security_clearence
	TO 'developer2' @ 'localhost';

REVOKE SELECT
	ON CSCI362.Cyber_security_clearence
	FROM 'developer2' @ 'localhost';

GRANT SELECT
	ON CSCI362.Funding
	TO 'developer2' @ 'localhost';

REVOKE SELECT
	ON CSCI362.Funding
	FROM 'developer2' @ 'localhost';

CREATE USER 'admin1' @ 'localhost' IDENTIFIED
	WITH caching_sha2_password BY 'admin1' COMMENT 'Some information about Admin1';

GRANT 'administrator'
	TO 'admin1' @ 'localhost';

SELECT *
FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
WHERE USER = 'admin1'
	AND HOST = 'localhost';

CREATE USER 'admin2' @ 'localhost' ATTRIBUTE '{"fname": "James", "lname": "Scott", "phone": "123-456-7890"}';

GRANT 'administrator'
	TO 'admin2' @ 'localhost';

SELECT *
FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
WHERE USER = 'admin2'
	AND HOST = 'localhost' \G

SELECT USER AS User
	,HOST AS Host
	,CONCAT (
		ATTRIBUTE - >> "$.fname"
		," "
		,ATTRIBUTE - >> "$.lname"
		) AS 'Full Name'
	,ATTRIBUTE - >> "$.comment" AS Comment
FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
WHERE USER = 'admin2'
	AND HOST = 'localhost';

CREATE USER 'Company1' @ 'localhost' IDENTIFIED
	WITH caching_sha2_password BY 'Company1' PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;

GRANT 'user'
	TO 'Company1' @ 'localhost';

CREATE USER 'Company2' @ 'localhost' IDENTIFIED
	WITH mysql_native_password BY 'Company2'
		,REQUIRE X509
WITH MAX_QUERIES_PER_HOUR 60 PASSWORD HISTORY 5 ACCOUNT LOCK;

GRANT 'user'
	TO 'Company2' @ 'localhost';
