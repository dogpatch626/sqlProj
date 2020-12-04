drop table Country2;
CREATE TEMPORARY TABLE Country2 SELECT Country_ID, Abbreviation, Name, Concern_or_not FROM csci362.Country WHERE (Country.Concern_or_not is TRUE);
SELECT * FROM Country2;

drop table Funding2;
CREATE TEMPORARY TABLE Funding2
SELECT
    Application_ID,
    CONCAT('$', SUM(Capital_investment)) AS Capital_investment_SUM
FROM
    csci362.Funding
Group BY Application_ID;
SELECT * FROM Funding2;

drop table Funding3;
CREATE TEMPORARY TABLE Funding3
SELECT
    Application_ID,
    CONCAT('$', SUM(Capital_investment))  AS Capital_investment_SUM_CONCERN
FROM
    csci362.Funding
INNER JOIN  csci362.Country2 
    ON (Funding.Country_ID  = Country2.Country_ID)
Group BY Application_ID;
SELECT * FROM Funding3;

DROP table Funding4;
CREATE TEMPORARY TABLE Funding4
SELECT
    Funding2.Application_ID,
    LPAD(CONCAT(FORMAT(((REPLACE(Capital_investment_SUM_CONCERN, '$', ''))/(REPLACE(Capital_investment_SUM, '$', '')))*100,1),'%'),22,' ') AS FUNDING_CONERN_PERCENT
FROM
    csci362.Funding2
INNER JOIN  csci362.Funding3 
    ON (Funding2.Application_ID  = Funding3.Application_ID)
Group BY Application_ID;
SELECT * FROM Funding4; 


DROP table Cyber_Security_Clearence2;
CREATE TEMPORARY TABLE Cyber_Security_Clearence2
SELECT
    Cyber_Security_Clearence.Application_ID,
    SUM(IF (Answers = 'YES',1,0)) AS QUESTION_ANS_YES,
    COUNT(Answers) AS QUESTION_IN_TOTAL,
    LPAD(CONCAT(FORMAT(SUM(IF (Answers = 'YES',1,0))/COUNT(Answers)*100,1),'%'),26,' ') AS QUESTION_ANSWER_YES_PERCENT
FROM
    csci362.Cyber_Security_Clearence
Group BY Application_ID;
SELECT * FROM Cyber_Security_Clearence2; 
