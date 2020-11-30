--  create applications
CREATE TABLE `applications` (
  `Application_ID` 	bigint(8) 		    NOT NULL,
  `First_Name` 			varchar(50) 	    NOT NULL,
  `Middle_Name` 		varchar(50)     	NOT NULL,
  `Last_Name` 			varchar(50)     	NOT NULL,
  `Phone_number` 		int(11) 		      NOT NULL,
  `EMAIL` 				  varchar(50) 	    NOT NULL,
  `Company_Name` 		varchar(50)     	NOT NULL,
  `EIN` 				    int(11) 	  	    NOT NULL,
  `Entity_Type` 		int(11)			      NOT NULL,
  `Company_Description` varchar(200) 	NOT NULL,
  
  PRIMARY KEY (`Application_ID`)
);

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
  KEY  `db_CID` (`Country_ID`),
  CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE,

  CONSTRAINT `db_CID` FOREIGN KEY (`Country_ID`) REFERENCES `country` (`Country_ID`) ON UPDATE CASCADE
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
    CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

  )
  
  -- States
CREATE TABLE `States`(
    `State_ID` bigint(11) NOT NULL, 
    `Name` varchar NOT NULL, 
    `Abbreviation` varchar NOT NULL, 
    `Application_ID` bigint(8) ,
    PRIMARY KEY (`State_ID`),
    KEY `db_app_id` (`Application_ID`),
    
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
  `Application_ID` bigint(8) NOT NULL,
  PRIMARY KEY (`EID_ID`), 
  KEY `db_app_id` (`Application_ID`),

  CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

  )
    
 --Country 
CREATE TABLE `Country` (
   `Country_ID` int(9) NOT NULL, 
   `Name` varchar NOT NULL,
   `Abbreviation` char NOT NULL, 
   `Application_ID` bigint(8) ,
   PRIMARY KEY (`Country_ID`),
   KEY `db_app_id` (`Application_ID`),
   CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

   )

   --
   -- Company Sector
CREATE TABLE `Company_Sector` (
  `Sector_ID` int NOT NULL,
  `Application_ID` bigint(8),
  `Primary` bool,
  `Name` varchar,
PRIMARY KEY `Sector_ID`,
KEY `db_app_id` (`Application_ID`),
CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE


)
   
    
  --Company Subsector
CREATE TABLE `Company_Subsector`(
`Sector_ID` int NOT NULL,
`Subsector_ID` int,
`Primary` bool,
`Application_ID` bigint(8),
PRIMARY KEY `Subsector_ID`,
 KEY `db_app_id` (`Application_ID`),
 KEY `SecID` (`Sector_ID`),
CONSTRAINT `SecID` FOREIGN KEY (`Sector_ID`) REFERENCES `Company_Sector` (`Sector_ID`) ON UPDATE CASCADE,

CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE
  )

--Negative_Regulatory_Actions
CREATE TABLE `Negative_Regulatory_Actions`(
`Action_ID` int NOT NULL,
`Applications_ID` bigint(8),
`Case_Number` int, 
PRIMARY KEY `Action_ID`,
KEY `db_app_id` (`Application_ID`),
CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

)

--NAICS_CODES
CREATE TABLE `NAICS_Codes`(
  `Codes` int NOT NULL,
  `Application_ID`bigint(8),
  PRIMARY KEY `CODES`,
  KEY `db_app_id` (`Application_ID`),
CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

)

--Cyber_Security_Clearence

CREATE TABLE `Cyber_Security_Clearence`(
`Application_ID`bigint(8),
`Questions_ID` int NOT NULL,
`Answers` bool,
`Administrative_Holds` bool,
`Answers` varchar,
KEY `db_app_id` (`Application_ID`),
CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

)

--Foreign_Associates
CREATE TABLE `Foreign_Associates`(
`Fassociate_ID` int,
`Application_ID` bigint(8),
`First_Name` varchar,
`Last_Name` varchar,
`Country_ID` int,
`Type` varchar 
PRIMARY KEY `Fassociate_ID`,
KEY `db_CID` (`Country_ID`),
KEY `db_app_id` (`Application_ID`),
CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE,
CONSTRAINT `db_CID` FOREIGN KEY (`Country_ID`) REFERENCES `country` (`Country_ID`) ON UPDATE CASCADE

)

--Imported_Materials

CREATE TABLE `Imported_Materials`(
  `Material_ID` int,
  `Application_ID` bigint(8),
  `Country_ID` int,
  `Import_Percent` float,
  `Material_Name` varchar,
  KEY `db_CID` (`Country_ID`),
  
PRIMARY KEY `Material_ID`,
KEY `db_app_id` (`Application_ID`),
CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE,
CONSTRAINT `db_CID` FOREIGN KEY (`Country_ID`) REFERENCES `country` (`Country_ID`) ON UPDATE CASCADE

)
--Customer
CREATE TABLE `CUSTOMER`(
  `Customer_ID` int,
  `First_Name` varchar,
  `Last_Name` varchar,
  PRIMARY KEY `Customer_ID`,

)

--Revenue
CREATE TABLE `Revenue`(
  `Customer_ID` int,
  `Application_ID` bigint(8),
  `Country_ID` int,
  `Annual_Revenue` bigint,
  
PRIMARY KEY `Material_ID`,
KEY `CusID` (`Customer_ID`),

KEY `db_app_id` (`Application_ID`),
CONSTRAINT `CusID` FOREIGN KEY (`Customer_ID`) REFERENCES `CUSTOMER` (`Customer_ID`) ON UPDATE CASCADE,

CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE,
CONSTRAINT `db_CID` FOREIGN KEY (`Country_ID`) REFERENCES `country` (`Country_ID`) ON UPDATE CASCADE

)
--investors
CREATE TABLE `investors`(
  `Investor_ID` int,
  `First_Name` varchar,
  `Last_Name` varchar,
  `Country_ID` int,
  PRIMARY KEY `Investor_ID`,
  KEY `db_CID` (`Country_ID`),
CONSTRAINT `db_CID` FOREIGN KEY (`Country_ID`) REFERENCES `country` (`Country_ID`) ON UPDATE CASCADE

)

--Funding
CREATE TABLE `funding`(
  `Funding_ID` bigint,
  `Application_ID` int,
  `RoundType`int,
  `Investor_ID` int,
  `Number_Shares` int,
  `Capital_investment` bigint,
  `Ownership` float,
PRIMARY KEY `Funding_ID`,
KEY `db_app_id` (`Application_ID`),
KEY `invest` (`Investor_ID`)
  CONSTRAINT `invest` FOREIGN KEY (`Investor_ID`) REFERENCES `investors` (`Investor_ID`) ON UPDATE CASCADE,

  CONSTRAINT `db_app_id` FOREIGN KEY (`Application_ID`) REFERENCES `applications` (`Application_ID`) ON UPDATE CASCADE

)

