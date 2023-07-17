filename statvil 'StatVillage.raw';
 
title1 Stat Village - Selected units;

DATA statvil;                                                                   
   INFILE statvil missover;
   INPUT block unit
         hhsize (hhpera hhperb1 hhperb2 hhperd1 hhperd2 hhpere1 hhpere2 hhperf1 hhperf2
         hhperg1 hhperg2 hhperh1 hhperh2) (1.0)                /* people in the household */
         nuempinh nuirh empinch invsth govinch otinch totinch  /* income variables */
         dtypeh builth tenurh morgh roomh broomh valueh grosrth omph /* house characteristic */
         hmage  hmsex  hmmtn  hmhlos  hmocc91  hmlfact  hmwkswk  hmempin 
        shmage shmsex shmmtn shmhlos shmocc91 shmlfact shmwkswk shmempin;
   
  LABEL HHSIZE    = 'Number of Persons in the Household'                           
        HHPERA    = 'Number of Persons <5 Years of Age in the'                     
        HHPERB1   = 'Number of Males in the Household at Home'                    
        HHPERB2   = 'Num. of Females in the Household at Home'                    
        HHPERD1   = 'Number of Males in the Household at Home'                    
        HHPERD2   = 'Num. of Females in the Household at Home'                    
        HHPERE1   = 'Number of Males in the Household at Home'                    
        HHPERE2   = 'Num. of Females in the Household at Home'                    
        HHPERF1   = 'Number of Males in the Household at Home'                    
        HHPERF2   = 'Num. of Females in the Household at Home'                    
        HHPERG1   = 'Number of Males in the Household at Home'                    
        HHPERG2   = 'Num. of Females in the Household at Home'                    
        HHPERH1   = 'Number of Males in the Household at Home'                    
        HHPERH2   = 'Num. of Females in the Household at Home'                    
        NUEMPINH  = 'Num. of Employment Income Recipients in'                    
        NUIRH     = 'Number of Income recipients in Household'                      
        EMPINCH   = 'Total Household Employment Income'                           
        INVSTH    = 'Total Investment Income of Household'                         
        GOVINCH   = 'Total Household Government Transfer Paym'                    
        OTINCH    = 'All Other Household Income'                                   
        TOTINCH   = 'Total Household Income'                                      
        DTYPEH    = 'Structural Type of Dwelling'                                  
        BUILTH    = 'Period of Construction'                                       
        TENURH    = 'Tenure'                                                       
        MORGH     = 'Presence of Mortgage'                                          
        ROOMH     = 'Number of Rooms'                                               
        BROOMH    = 'Number of Bedrooms'                                           
        VALUEH    = 'Value of Dwelling'                                            
        GROSRTH   = 'Monthly Gross Rent'                                          
        OMPH      = 'Owner s Major Payments (Monthly)'                               
        HMAGE     = 'Age of Primary Household Maintainer'                           
        HMSEX     = 'Sex of Primary Household Maintainer'                           
        HMMTN     = 'Mother Tongue of Primary Household Maint'                      
        HMHLOS    = 'Highest Level of Schooling of Primary Hh'                     
        HMOCC91   = 'Occupation (1991 SOC) of Primary Hhold M'                    
        HMLFACT   = 'Labour Force Activity of Primary Hhold M'                    
        HMWKSWK   = 'Weeks Worked in 1990 by Primary Hhold Ma'                    
        HMEMPIN   = 'Total Employment Income of Primary Hhld'                     
        SHMAGE    = 'Age of Spouse or C-L Partner of Primary'                      
        SHMSEX    = 'Sex of Spouse or C-L Partner of Primary'                      
        SHMMTN    = 'Mother Tongue of Spouse or CLP of Primar'                     
        SHMHLOS   = 'Highest Level of Schooling of Spouse or'                     
        SHMOCC91  = 'Occupation (1991 SOC) of Spouse or CLP o'                   
        SHMLFACT  = 'Labour Force Activity of Spouse or CLP o'                   
        SHMWKSWK  = 'Weeks Worked in 1990 by Spouse or CLP of'                   
        SHMEMPIN  = 'Total Employment Income of Spouse or CLP';
 
proc print data=statvil(obs=40);
   var block unit hhsize hhpera hhperb1--hhperh2 nuempinh nuirh empinch--valueh grosrth omph;
 
proc print data=statvil(obs=40);
   var block unit hmage  hmsex   hmmtn  hmhlos  hmocc91  hmlfact  hmwkswk  hmempin;
 
proc print data=statvil(obs=40);
   var block unit shmage shmsex shmmtn shmhlos shmocc91 shmlfact shmwkswk shmempin;
 
proc means data=statvil n min max mean std maxdec=2;

