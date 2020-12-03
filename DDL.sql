SET LINESIZE 500;
SET PAGESIZE 200;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Application;
DROP TABLE IF EXISTS Certifications_financials;
DROP TABLE IF EXISTS Company_information;
DROP TABLE IF EXISTS Company_sector;
DROP TABLE IF EXISTS Company_subsector;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Customer; 
DROP TABLE IF EXISTS Cyber_security_clearence;
DROP TABLE IF EXISTS Cyber_security_questions;
DROP TABLE IF EXISTS Foreign_associates;
DROP TABLE IF EXISTS Funding;
DROP TABLE IF EXISTS Imported_materials;
DROP TABLE IF EXISTS Investors;
DROP TABLE IF EXISTS Material; 
DROP TABLE IF EXISTS Naics_codes;
DROP TABLE IF EXISTS Negative_regulatory_actions;
DROP TABLE IF EXISTS Patents;
DROP TABLE IF EXISTS Revenue;
DROP TABLE IF EXISTS Sectors;
DROP TABLE IF EXISTS States;
DROP TABLE IF EXISTS Subsectors;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE States(
        State_ID bigint(11) NOT NULL AUTO_INCREMENT, 
        Abbreviation varchar(20) NOT NULL,
        Name varchar(20) NOT NULL,
CONSTRAINT States_PK PRIMARY KEY(State_ID));

CREATE TABLE Cyber_Security_Questions(
        Questions_ID int NOT NULL,
        Question varchar(200) NOT NULL,
CONSTRAINT Cyber_Security_Questions_PK PRIMARY KEY(Questions_ID));

CREATE TABLE CUSTOMER(
        Customer_ID int NOT NULL,
        First_Name varchar(25) NOT NULL,
        Last_Name varchar(25) NOT NULL,
CONSTRAINT CUSTOMER_PK PRIMARY KEY(Customer_ID));

CREATE TABLE Application (
        Application_ID bigint(8) NOT NULL,
        First_Name varchar(50) NOT NULL,
        Middle_Name varchar(50) NOT NULL,
        Last_Name varchar(50) NOT NULL,
        Phone_Number int(11) NOT NULL,
        Email varchar(50) NOT NULL,
        Company_Name varchar(50) NOT NULL,
        EIN_ID int(11) NOT NULL,
        Entity_Type int(11) NOT NULL,
        Company_Description varchar(200) NOT NULL,
        Cert_Financials_ID bigint(11) NOT NULL,
CONSTRAINT Application_PK PRIMARY KEY (Application_ID));

CREATE TABLE Company_Information (
        EID_ID int(9) NOT NULL, 
        Company_Name varchar(50) NOT NULL,
        Entity_Type varchar(30) Check (Entity_Type IN ('C-CORP','S-CORP', 'B-CORP', 'Limited Liability Partnership', 'Limited Liability Company')), 
        Company_Description varchar(200) NOT NULL,
        Contact_Phone int NOT NULL,
        Contact_Email varchar(20) NOT NULL, 
        Application_ID bigint(8) NOT NULL,
CONSTRAINT Company_Information_PK PRIMARY KEY (EID_ID),
CONSTRAINT Company_Information_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

CREATE TABLE Certifications_Financials (
        Cert_Financials_ID bigint(11) NOT NULL,
        Tax_Records_7Years bigint(11) NOT NULL,
        Company_Felonies int(11) NOT NULL,
        Company_Clearence_DCSA int NOT NULL,
        SF328_Certification varchar(11) NOT NULL,
        CMMC_Certificate bool NOT NULL, 
        Application_ID bigint(8) NOT NULL,
CONSTRAINT Certifications_Financials_PK PRIMARY KEY (Cert_Financials_ID),
CONSTRAINT Certifications_Financials_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

CREATE TABLE Country (
        Country_ID int(9) NOT NULL AUTO_INCREMENT,
        Abbreviation varchar(2) NOT NULL,
        Name varchar(25) NOT NULL,
CONSTRAINT Country_PK PRIMARY KEY (Country_ID));

CREATE TABLE Address (
        Address_ID bigint(11) NOT NULL,
        Application_ID bigint(8) NOT NULL,
        Address varchar(11) NOT NULL,
        Unit_Number int NOT NULL,
        State_ID bigint(11) NOT NULL,
        ZIP_CODE int NOT NULL, 
CONSTRAINT Address_PK PRIMARY KEY (Address_ID),
CONSTRAINT Address_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Address_FK2 FOREIGN KEY (State_ID) REFERENCES States(State_ID) ON UPDATE CASCADE);

CREATE TABLE Patents (
        Patent_ID int NOT NULL,
        Application_ID bigint(8) NOT NULL,
        Patent_Name varchar(25) NOT NULL,
        Patent_Number int NOT NULL,
        Country_ID int(9) NOT NULL,
CONSTRAINT Patents_PK PRIMARY KEY (Patent_ID),
CONSTRAINT Patents_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Patents_FK2 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

CREATE TABLE Sectors(
        Sector_ID int NOT NULL AUTO_INCREMENT,
        Sector_Name varchar(25) NOT NULL,
CONSTRAINT Sectors_PK PRIMARY KEY(Sector_ID));

CREATE TABLE Subsectors(
        Subsector_ID varchar(25) NOT NULL,
        Subsector_Name varchar(25),
CONSTRAINT Subsectors_PK PRIMARY KEY(Subsector_ID));

CREATE TABLE Company_Sector (
        Sector_ID int NOT NULL,
        Application_ID bigint(8),
        PrimaryBool bool,
        Name varchar(20),
CONSTRAINT Company_Sector_PK PRIMARY KEY (Sector_ID,Application_ID),
CONSTRAINT Company_Sector_FK1 FOREIGN KEY (Sector_ID) REFERENCES Sectors(Sector_ID) ON UPDATE CASCADE,
CONSTRAINT Company_Sector_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

CREATE TABLE Company_Subsector(
        Sector_ID int NOT NULL,
        Subsector_ID varchar(25) NOT NULL,
        PrimaryBool2 bool,
        Application_ID bigint(8),
CONSTRAINT Company_Subsector_PK PRIMARY KEY (Subsector_ID,Sector_ID,Application_ID),
CONSTRAINT Company_Subsector_FK1 FOREIGN KEY (Sector_ID) REFERENCES Company_Sector(Sector_ID) ON UPDATE CASCADE,
CONSTRAINT Company_Subsector_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Company_Subsector_FK3 FOREIGN KEY (Subsector_ID) REFERENCES Subsectors(Subsector_ID) ON UPDATE CASCADE);

CREATE TABLE Negative_Regulatory_Actions(
        Action_ID int NOT NULL,
        Application_ID bigint(8) NOT NULL,
        Case_Number int, 
CONSTRAINT Negative_Regulatory_Actions_PK PRIMARY KEY (Action_ID),
CONSTRAINT Negative_Regulatory_Actions_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

CREATE TABLE NAICS_Codes(
        Codes int NOT NULL,
        Application_ID bigint(8) NOT NULL,
CONSTRAINT NAICS_Codes_PK PRIMARY KEY (CODES),
CONSTRAINT NAICS_Codes_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

CREATE TABLE Cyber_Security_Clearence(
        Application_ID bigint(8) NOT NULL,
        Questions_ID int NOT NULL,
        Administrative_Holds bool,
        Answers bool,
CONSTRAINT Cyber_Security_Clearence_PK PRIMARY KEY (Application_ID,Questions_ID),
CONSTRAINT Cyber_Security_Clearence_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Cyber_Security_Clearence_FK2 FOREIGN KEY (Questions_ID) REFERENCES Cyber_Security_Questions(Questions_ID) ON UPDATE CASCADE);

CREATE TABLE Foreign_Associates(
        Fassociate_ID int NOT NULL,
        Application_ID bigint(8) NOT NULL,
        First_Name varchar(25),
        Last_Name varchar(25),
        Country_ID int,
        Type_Foreign varchar(25),
CONSTRAINT Foreign_Associates_PK PRIMARY KEY (Fassociate_ID),
CONSTRAINT Foreign_Associates_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Foreign_Associates_FK2 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

CREATE TABLE Material(
        Material_ID int,
        Country_ID int,
        Material_Name varchar(25),
CONSTRAINT Material_PK PRIMARY KEY (Material_ID),
CONSTRAINT Material_FK FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

CREATE TABLE Imported_Materials(
        Material_ID int,
        Application_ID bigint(8),
        Country_ID int,
        Import_Percent float,
        Material_Name varchar(25),
CONSTRAINT Imported_Materials_PK PRIMARY KEY (Material_ID,Application_ID,Country_ID),
CONSTRAINT Imported_Materials_FK1 FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID) ON UPDATE CASCADE,
CONSTRAINT Imported_Materials_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Imported_Materials_FK3 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

CREATE TABLE Revenue(
        Customer_ID int,
        Application_ID bigint(8),
        Country_ID int,
        Annual_Revenue bigint,
CONSTRAINT Revenue_PK PRIMARY KEY (Customer_ID,Application_ID,Country_ID),
CONSTRAINT Revenue_FK1 FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID) ON UPDATE CASCADE,
CONSTRAINT Revenue_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Revenue_FK3 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

CREATE TABLE Investors(
        Investor_ID int NOT NULL,
        First_Name varchar(25),
        Last_Name varchar(25),
        Country_ID int,
CONSTRAINT Investors_PK PRIMARY KEY (Investor_ID),
CONSTRAINT Investors_FK FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

CREATE TABLE Funding(
        Funding_ID bigint NOT NULL,
        Application_ID bigint(8) NOT NULL,
        RoundTypeint int,
        Investor_ID int,
        Number_Shares int,
        Capital_investment bigint,
        Ownership float,
CONSTRAINT Funding_PK PRIMARY KEY (Funding_ID),
CONSTRAINT Funding_FK1 FOREIGN KEY (Investor_ID) REFERENCES Investors(Investor_ID) ON UPDATE CASCADE,
CONSTRAINT Funding_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

describe Address;
describe Application;
describe Certifications_financials;
describe Company_information;
describe Company_sector;
describe Company_subsector;
describe Country;
describe Customer; 
describe Cyber_security_clearence;
describe Cyber_security_questions;
describe Foreign_associates;
describe Funding;
describe Imported_materials;
describe Investors;
describe Material; 
describe Naics_codes;
describe Negative_regulatory_actions;
describe Patents;
describe Revenue;
describe Sectors;
describe States;
describe Subsectors;

COMMIT;
