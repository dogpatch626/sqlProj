insert into Application (Application_ID,First_Name,Last_Name,Phone_Number,Email,Company_Name,EIN_ID,Entity_type,Company_Description,Certifications_financials_ID )    
values (1234, "John", "Stewart", 6462120229, "stewart@gmail.com", "Stewarts robos", 11234567, 6, "A Robotics company", 11 );

insert into Address     ;
insert into Cyber_security_clearence  (Application_ID,Questions_ID, Answers) values (1234, 1, TRUE)  ;
insert into Certifications_financials  (Certifications_financials_ID, Tax_Records_7Years, Company_Felonies, Company_Clearence_DCSA, SF328_Certification, CMMC_Certificate, Application_ID)
values (11, "YES", "NO", "Yes", "NO", TRUE, 1234 )   ;
insert into Company_information (EID_ID, Company_Name, Entity_Type, Company_Description, Contact_Phone, Contact_Email, Application_ID )    
 values (11234567, "Stewarts robos", 'Limited Liability Company', "A robotics company", 6462120229, "stewart@gmail.com", 1234)   ;
insert into Company_sector (Sector_ID, Application_ID, PrimaryBool, )  values (10, 1234, TRUE)  ;
insert into Company_subsector     ; --none
insert into Customer  (Customer_ID, First_Name, Last_Name) values (1, "Dan", "Justin")   ; 
-- foreign associates
insert into Foreign_associates (Fassociate_ID, Application_ID, First_Name, Last_Name, Country_ID) 
values (1, 1234, "jack", "johnson", 4)    ;

insert into Foreign_associates (Fassociate_ID, Application_ID, First_Name, Last_Name, Country_ID) 
values (2, 1234, "Jimmy", "Jazz", 6)    ;
--

-- funding
insert into Funding  (Funding_ID, Application_ID, Investor_ID, Number_Shares,Capital_investment, Ownership) 
values (1, 1234, 1, 1000, 2000, 25.0  )  ;

insert into Funding  (Funding_ID, Application_ID, Investor_ID, Number_Shares,Capital_investment, Ownership) 
values (2, 1234, 1, 400, 500, 5.0  )  ;
--
insert into Imported_materials (Material_ID, Application_ID, Country_ID, Import_Percent, Material_Name)
values (1, 1237, 4, 10.0, "Titanium")    ;
-- investors
insert into Investors (Investor_ID, First_Name,Last_Name,Country_ID ) values(1, "Jack", "johnson", 4)    ;

insert into Investors (Investor_ID, First_Name,Last_Name,Country_ID ) values(2, "Jimmy", "Jazz", 6)    ;
--
insert into Material  (Material_ID, Country_ID, Material_Name) values (1, 4, "Titanium")   ; 
insert into Naics_codes (Codes,Application_ID) values (115210,1234)  ;
insert into Negative_regulatory_actions     ; -- none
insert into Patents (Patent_ID, Application_ID, Patent_Name, Patent_Number) values (0000126, 1234, "Robo Arm", 1, 231, )   ;
insert into Revenue (Customer_ID, Application_ID, Country_ID, Annual_Revenue) values (1, 1234, 231, 100000)    ;

---------------
insert into Application (Application_ID,First_Name,Last_Name,Phone_Number,Email,Company_Name,EIN_ID,Entity_type,Company_Description,Cert_Financials_ID ) values (1234, "John", "Stewart", 6462120229, "stewart@gmail.com", "Stewarts robos", 11234567, 6, "A Robotics company", 11 );
insert into Cyber_Security_Clearence  (Application_ID,Questions_ID, Answers) values (1234, 1, TRUE);
insert into Certifications_financials (Cert_Financials_ID, Tax_Records_7Years, Company_Felonies, Company_Clearence_DCSA, SF328_Certification, CMMC_Certificate, Application_ID) values (11, "YES", "NO", "Yes", "NO", "YES", 1234 );
insert into Company_information (EID_ID, Company_Name, Entity_Type, Company_Description, Contact_Phone, Contact_Email, Application_ID ) values (11234567, "Stewarts robos", 'Limited Liability Company', "A robotics company", 6462120229, "stewart@gmail.com", 1234);
insert into Company_sector (Sector_ID, Application_ID, PrimaryBool) values (10, 1234, TRUE);
insert into Customer (Customer_ID, First_Name, Last_Name) values (1, "Dan", "Justin"); 
insert into Foreign_associates (Fassociate_ID, Application_ID, First_Name, Last_Name, Country_ID) values (1, 1234, "jack", "johnson", 4);
insert into Foreign_associates (Fassociate_ID, Application_ID, First_Name, Last_Name, Country_ID) values (2, 1234, "Jimmy", "Jazz", 6);
insert into Investors (Investor_ID, First_Name,Last_Name,Country_ID ) values(1, "Jack", "johnson", 4) ;
insert into Investors (Investor_ID, First_Name,Last_Name,Country_ID ) values(2, "Jimmy", "Jazz", 6) ;
insert into Funding (Funding_ID, Application_ID, Investor_ID, Number_Shares,Capital_investment, Ownership) values (1, 1234, 1, 1000, 2000, 25.0 );
insert into Funding (Funding_ID, Application_ID, Investor_ID, Number_Shares,Capital_investment, Ownership) values (2, 1234, 1, 400, 500, 5.0 );
insert into Material (Material_ID, Country_ID, Material_Name) values (1, 4, "Titanium") ; 
insert into Imported_materials (Material_ID, Application_ID, Country_ID, Import_Percent, Material_Name) values (1, 1234, 4, 10.0, "Titanium") ;
insert into Naics_codes (Codes,Application_ID) values (115210,1234) ;
insert into Patents (Patent_ID, Application_ID, Patent_Name, Patent_Number, Country_ID) values (0000126, 1234, "Robo Arm", 1, 231);
insert into Revenue (Customer_ID, Application_ID, Country_ID, Annual_Revenue) values (1, 1234, 231, 100000);

insert into Address (Application_ID, Address, State_ID,ZIP_CODE) values(1234, 'One Apple Park Way', 6 ,95014);
insert into Company_subsector (Sector_ID, Subsector_ID, PrimaryBool2, Application_ID) values (10, '5.i', 1 ,1234);
insert into Negative_regulatory_actions (Action_ID, Application_ID, Case_Number) values(1, 1234, 001);
