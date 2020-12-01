--States
CREATE TABLE States(
        State_ID bigint(11) NOT NULL, 
        Name varchar(20) NOT NULL, 
        Abbreviation varchar(20) NOT NULL, 
CONSTRAINT States_PK PRIMARY KEY(State_ID));

--Cyber_Security_Questions
CREATE TABLE Cyber_Security_Questions(
        Questions_ID int NOT NULL,
        Answers varchar(200) NOT NULL,
CONSTRAINT Cyber_Security_Questions_PK PRIMARY KEY(Questions_ID));

--Customer
CREATE TABLE CUSTOMER(
        Customer_ID int NOT NULL,
        First_Name varchar(25) NOT NULL,
        Last_Name varchar(25) NOT NULL,
CONSTRAINT CUSTOMER_PK PRIMARY KEY(Customer_ID));

--Application
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
--CONSTRAINT Application_FK1 FOREIGN KEY (EIN_ID) REFERENCES Company_Information(EIN_ID),
--CONSTRAINT Application_FK2 FOREIGN KEY (Cert_Financials_ID) REFERENCES Certifications_Financials(Cert_Financials_ID));

-- Company Information 
CREATE TABLE Company_Information (
        EID_ID int(9) NOT NULL, 
        Company_Name varchar(50) NOT NULL,
        Entity_Type varchar(20) NOT NULL, 
        Company_Description varchar(200) NOT NULL,
        Contact_Phone int NOT NULL,
        Contact_Email varchar(20) NOT NULL, 
        Application_ID bigint(8) NOT NULL,
CONSTRAINT Company_Information_PK PRIMARY KEY (EID_ID),
CONSTRAINT Company_Information_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

--Certifications_Financials
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

--Country 
CREATE TABLE Country (
        Country_ID int(9) NOT NULL, 
        Name varchar(25) NOT NULL,
        Abbreviation char NOT NULL, 
        Application_ID bigint(8) ,
CONSTRAINT Country_PK PRIMARY KEY (Country_ID),
CONSTRAINT Country_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

--Address
CREATE TABLE Address (
        Address_ID bigint(11) NOT NULL,
        Application_ID bigint(8) NOT NULL,
        Address varchar(11) NOT NULL,
        Unit_Number int NOT NULL,
        State_ID varchar(11) NOT NULL,
        ZIP_CODE int NOT NULL, 
CONSTRAINT Address_PK PRIMARY KEY (Address_ID),
CONSTRAINT Address_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

--Patents
CREATE TABLE Patents (
        Patent_ID int NOT NULL,
        Application_ID bigint(8) NOT NULL,
        Patent_Name varchar(25) NOT NULL,
        Patent_Number int NOT NULL,
        Country_ID int(9) NOT NULL,
CONSTRAINT Patents_PK PRIMARY KEY (Patent_ID),
CONSTRAINT Patents_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Patents_FK2 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

--Sectors
CREATE TABLE Sectors(
        Sector_ID int NOT NULL,
        Sector_Name char,
CONSTRAINT Sectors_PK PRIMARY KEY(Sector_ID));

--Subsectors
CREATE TABLE Subsectors(
        Subsector_ID int,
        Subsector_Name char,
CONSTRAINT Subsectors_PK PRIMARY KEY(Subsector_ID));

--Company Sector
CREATE TABLE Company_Sector (
        Sector_ID int NOT NULL,
        Application_ID bigint(8),
        PrimaryBool bool,
        Name varchar(20),
CONSTRAINT Company_Sector_PK PRIMARY KEY (Sector_ID),
CONSTRAINT Company_Sector_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

--Company Subsector
CREATE TABLE Company_Subsector(
        Sector_ID int NOT NULL,
        Subsector_ID int,
        PrimaryBool2 bool,
        Application_ID bigint(8),
CONSTRAINT Company_Subsector_PK PRIMARY KEY (Subsector_ID,Sector_ID,Application_ID),
CONSTRAINT Company_Subsector_FK1 FOREIGN KEY (Sector_ID) REFERENCES Company_Sector(Sector_ID) ON UPDATE CASCADE,
CONSTRAINT Company_Subsector_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Company_Subsector_FK3 FOREIGN KEY (Subsector_ID) REFERENCES Subsectors(Subsector_ID) ON UPDATE CASCADE);

--Negative_Regulatory_Actions
CREATE TABLE Negative_Regulatory_Actions(
        Action_ID int NOT NULL,
        Application_ID bigint(8),
        Case_Number int, 
CONSTRAINT Negative_Regulatory_Actions_PK PRIMARY KEY (Action_ID),
CONSTRAINT Negative_Regulatory_Actions_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

--NAICS_CODES
CREATE TABLE NAICS_Codes(
        Codes int NOT NULL,
        Application_ID bigint(8) NOT NULL,
CONSTRAINT NAICS_Codes_PK PRIMARY KEY (CODES),
CONSTRAINT NAICS_Codes_FK FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);

--Cyber_Security_Clearence
CREATE TABLE Cyber_Security_Clearence(
        Application_ID bigint(8) NOT NULL,
        Questions_ID int NOT NULL,
        Administrative_Holds bool,
        Answers bool,
CONSTRAINT Cyber_Security_Clearence_PK PRIMARY KEY (Application_ID,Questions_ID),
CONSTRAINT Cyber_Security_Clearence_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Cyber_Security_Clearence_FK2 FOREIGN KEY (Questions_ID) REFERENCES Cyber_Security_Questions(Questions_ID) ON UPDATE CASCADE);

--Foreign_Associates
CREATE TABLE Foreign_Associates(
        Fassociate_ID int,
        Application_ID bigint(8),
        First_Name varchar(25),
        Last_Name varchar(25),
        Country_ID int,
        Type_Foreign varchar(25),
CONSTRAINT Foreign_Associates_PK PRIMARY KEY (Fassociate_ID),
CONSTRAINT Foreign_Associates_FK1 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Foreign_Associates_FK2 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

--Material
CREATE TABLE Material(
        Material_ID int,
        Country_ID int,
        Material_Name varchar(25),
CONSTRAINT Material_PK PRIMARY KEY (Material_ID),
CONSTRAINT Material_FK FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

--Imported_Materials
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

--Revenue
CREATE TABLE Revenue(
        Customer_ID int,
        Application_ID bigint(8),
        Country_ID int,
        Annual_Revenue bigint,
CONSTRAINT Revenue_PK PRIMARY KEY (Customer_ID,Application_ID,Country_ID),
CONSTRAINT Revenue_FK1 FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID) ON UPDATE CASCADE,
CONSTRAINT Revenue_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE,
CONSTRAINT Revenue_FK3 FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

--Investors
CREATE TABLE Investors(
        Investor_ID int NOT NULL,
        First_Name varchar(25),
        Last_Name varchar(25),
        Country_ID int,
CONSTRAINT Investors_PK PRIMARY KEY (Investor_ID),
CONSTRAINT Investors_FK FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID) ON UPDATE CASCADE);

--Funding
CREATE TABLE Funding(
        Funding_ID bigint NOT NULL,
        Application_ID bigint(8),
        RoundTypeint int,
        Investor_ID int,
        Number_Shares int,
        Capital_investment bigint,
        Ownership float,
CONSTRAINT Funding_PK PRIMARY KEY (Funding_ID),
CONSTRAINT Funding_FK1 FOREIGN KEY (Investor_ID) REFERENCES Investors(Investor_ID) ON UPDATE CASCADE,
CONSTRAINT Funding_FK2 FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID) ON UPDATE CASCADE);
