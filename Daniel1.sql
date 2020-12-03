CREATE TABLE `applications` (
  `Application_ID` bigint(8) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Middle_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Phone_number` int(11) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `Company_Name` varchar(50) NOT NULL,
  `EIN` int(11) NOT NULL,
  `Entity_Type` NOT NULL,
  `Company_Description` varchar(200) NOT NULL,
  
  PRIMARY KEY (`Application_ID`)
);

--  create applications 
-- create cert and finance


CREATE TABLE `Certifications_Financials` (
  `Cert&Finance_ID` bigint(11) NOT NULL,
  `Tax_Records(7Years)` bigint(11) NOT NULL,
  `Company_Felonies` int NOT NULL,
  `Company_Clearence_(DCSA)` int NOT NULL,
  `SF-328_Certification` varchar(11) NOT NULL,
  `CMMC_Certificate` bool NOT NULL, 
  `Application_ID` bigint(8) NOT NULL,
  PRIMARY KEY (`Cert&Finance_ID`),
  KEY `db_app_id` (`Application_ID`),
  
  CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE
)



--address
CREATE TABLE `Address` (
  `Address_ID` bigint(11) NOT NULL,
  `Application_ID` bigint(8) NOT NULL,
  `Address` varchar NOT NULL,
  `Unit_Number` int NOT NULL,
  `State_ID` varchar(11) NOT NULL,
  `ZIP_CODE` int NOT NULL, 
  PRIMARY KEY (`Address_ID`),
  KEY `db_app_id` (`Application_ID`),
  --FK STATE_ID?
  CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE
)

--Patents
CREATE TABLE `Patents` (
  `Patent_ID` int NOT NULL,
  `Application_ID` bigint(8) NOT NULL,
  `Patent_Name` varchar NOT NULL,
  `Patent_Number` int NOT NULL,
  `Country_ID` varchar NOT NULL,
  PRIMARY KEY (`Patent_ID`),
  KEY `db_app_id` (`Application_ID`),
  
  CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE
)

--Funding 
CREATE TABLE `Funding` (
  `Funding_ID` bigint(11) NOT NULL, 
  `Application_ID` int NOT NULL,
  `RoundType` int NOT NULL, 
  `Incestor_ID` int NOT NULL,
  `Number_of_Shares` int NOT NULL,
  `Capital_Investment` bigint NOT NULL,
  `Ownership_%` int NOT NULL, 
  PRIMARY KEY (`Funding_ID`), 
  KEY `db_app_id` (`Application_ID`), 
  )
  
  -- States
  CREATE TABLE `States` (
    `State_ID` bigint(11) NOT NULL, 
    `Name` varchar NOT NULL, 
    `Abbreviation` varchar NOT NULL, 
    PRIMARY KEY (`State_ID`) 
    KEY `db_app_id` (`State_ID`),
    
    CONSTRAINT `db_app_id` PRIVATE KEY (`State_ID`) REFERENCES `Address` (`State_ID`) ON UPDATE CASCADE
 )
 
 -- Company Information 
CREATE TABLE `Company_Information` (
  `EID_ID` int(9) NOT NULL, 
  `Company_Name` varchar NOT NULL,
  `Entity_Type` varchar NOT NULL, 
  `Company_Description` varchar NOT NULL,
  `Contact_Phone` int NOT NULL,
  `Contact_Email` varchar NOT NULL, 
  PRIMARY KEY (`Company_Information`), 
  KEY `db_app_id` (`EID_ID`), 
  )
    
 --Country 
 Create TABLE `Country_ID` (
   `Country_ID` int(9) NOT NULL, 
   `Name` varchar NOT NULL,
   `Abbreviation` char NOT NULL, 
   PRIMARY KEY (`Country_ID`),
   KEY `db_app_id` ('Country_ID'),
   )
   

   
    
  
