

*****Cleaning the Profile Data Set*****************************************************************************************************************************
***************************************************************************************************************************************************************

//Profile Data set//

use "$profile\IAS Profile.dta",clear

//Adjusting For the Not Applicable Values//

**For last feild of Experience\IAS**
replace last_field_of_experience="Not Available" if last_field_of_experience=="N.Applicable" 
replace last_field_of_experience="Not Available" if last_field_of_experience=="Not Available"
replace last_field_of_experience="Not Available" if last_field_of_experience=="N.A."


**For last category of Experience\IAS**
replace last_category_of_experience ="Not Available" if last_category_of_experience =="N.Available"
replace last_category_of_experience ="Not Available" if last_category_of_experience =="N.Applicable"


**For last Designation\IAS**
replace last_designation="Not Available" if last_designation=="N.A."


**For Strat date and end date\IAS**
replace last_start_date="Not Available" if last_start_date=="N.A."
replace last_end_date="Not Available" if last_end_date=="N.A."


// Cleaning Duplicates in Profile data set //

** Finding duplicates in Profile data set**
duplicates list id
duplicates tag id, generate(i)
tab i


** Dropping the  duplicates in Profile data set**
drop if (last_level=="Not Available" & (id=="BH015000" | id=="MT004500" | id=="MT007500" | id=="MT011411" | id=="MT011514" | id=="PB004300" | id=="PB008203" | id=="RJ029800"))
drop if (id=="PB005200" &  last_designation =="Fin Commissioner")
drop if (id=="UP020000"& last_end_date=="1993-07-01")
drop if (id=="TN010700" & last_end_date=="1992-06-01")
gen s_d= substr( last_start_date, 7,. )
gen e_d = substr( last_end_date ,7,.)
destring s_d e_d, replace force
duplicates tag id, gen(d)
drop if id=="TN010700" & s_d==1991
drop if id=="UP020000" & e_d==1993

**Cheking if any duplicates left**
drop i d s_d e_d



//Making Gender dummy//

gen gen_dum = .                            //Generating Gender Dummy
replace gen_dum =0 if gender == "Male"     //Dummy for Male
replace gen_dum = 1 if gender == "Female"  // Dummy for female


//Retirement Dummy//

destring retired, gen(retired_dum) force    //Destringing Retirement and making a dummy


//tabulating time spend in the last post//

gen start = substr( last_start_date,1,4)      //Seperating the Start year by using Substring
gen end = substr( last_end_date,1,4)          //Seperating the End year by using Substring
destring start, generate(last_St_dt) force    //Destring the Start date 
destring end, generate(last_End_dt) force     //Destring the End date
gen lastJ = last_End_dt - last_St_dt          //Generating tenure for last post 


//Proportion of Officer posted in home cadre//

gen homecadre_dum = 1 if cadre == place_of_domicile        //Generating Home Cadre dummy
replace homecadre_dum = 0 if cadre != place_of_domicile    //Dummy for those not in Home Cadre


// Tabulation last education level//
gen last_educ_level = .                     //Generating Last Level Of education

replace last_educ_level = 1 if last_education_qualification == "B.A. Honours" | last_education_qualification ==  "B.A. Honours Economics" | last_education_qualification ==   "B.A., B.Ed." | last_education_qualification ==  "B.A., LL.B." | last_education_qualification ==  "B.A.LLB (Hons)" | last_education_qualification == "B.A.M.S."  | last_education_qualification ==  "B.Arch."  | last_education_qualification ==   "B.Com Honours"  | last_education_qualification ==   "B.Com."  | last_education_qualification ==   "B.Com. Hons."  | last_education_qualification ==   "B.Com., LL.B."  | last_education_qualification ==   "B.D.S."  | last_education_qualification ==   "B.Des."  | last_education_qualification ==   "B.E."  | last_education_qualification ==   "B.E. (Hons)"  | last_education_qualification ==   "B.E.E."  | last_education_qualification ==   "B.Ed."  | last_education_qualification ==   "B.H.M.S."  | last_education_qualification ==   "B.Pharm."  | last_education_qualification ==   "B.S."  | last_education_qualification ==   "B.Sc."  | last_education_qualification ==   "B.Sc.(Agri)"  | last_education_qualification ==   "B.Sc.(Engg)"  | last_education_qualification ==   "B.Sc.(Hons)"  | last_education_qualification ==   "B.Tech" | last_education_qualification == "B.Tech."  | last_education_qualification ==   "B.V.Sc. & A.H."  | last_education_qualification ==   "Bachelor in General Law"  | last_education_qualification ==   "Bachelor of Engineering" | last_education_qualification == "Graduate"                 

replace last_educ_level = 2 if last_education_qualification == "Integrated Masters in Technology" | last_education_qualification == "M.A." | last_education_qualification == "M.A. Economics" | last_education_qualification == "M.A. English" | last_education_qualification == "M.A. Honours" | last_education_qualification == "M.B.A." | last_education_qualification == "M.B.A. (UK)" | last_education_qualification == " M.B.A. (UK)" | last_education_qualification == "M.B.E." | last_education_qualification == "M.B.L." | last_education_qualification == "M.B.M." | last_education_qualification == "M.C.A." | last_education_qualification == "M.C.M." | last_education_qualification == "M.Com." | last_education_qualification == "M.D." | last_education_qualification == "M.D.S." | last_education_qualification == "M.E." | last_education_qualification == "M.Ed." | last_education_qualification == "M.F.M." | last_education_qualification == "M.I.D.P." | last_education_qualification == "M.I.P.L." | last_education_qualification == "M.J.M.C." | last_education_qualification == "M.L." | last_education_qualification == "M.M.S." | last_education_qualification == "M.P.A." | last_education_qualification == "M.P.H." | last_education_qualification == "M.P.M." | last_education_qualification == "M.P.P." | last_education_qualification == "M.S." | last_education_qualification == "M.S.W." | last_education_qualification == "M.Sc." | last_education_qualification == "M.Sc. (Agri)" | last_education_qualification == "M.Stat." | last_education_qualification == "M.Tech" | last_education_qualification == "M.Tech." | last_education_qualification == "M.V.Sc." | last_education_qualification == "MASTER IN TAXATION AND BUSINESS LAW" | last_education_qualification == "MBA HR" | last_education_qualification == "Master in Business Administration" | last_education_qualification == "Master of Arts" | last_education_qualification == "Master of Business Laws" | last_education_qualification == "Master of Public Health" | last_education_qualification == "Master of Technology" | last_education_qualification == "Masters in Development Management" | last_education_qualification == "Masters in International Development" | last_education_qualification == "Masters in Public Management" | last_education_qualification == "Masters in Public Policy" | last_education_qualification == "Micro Master programme" | last_education_qualification == "Micro Masters" | last_education_qualification == "P.G." | last_education_qualification == "P.G. (Masters)" | last_education_qualification == "P.G. (USA)" | last_education_qualification == "PG Diploma" | last_education_qualification == "PG Diploma in Financial Management" | last_education_qualification == "POST GRADUATE DIPLOMA IN MANAGEMENT" | last_education_qualification == "POST GRADUATE IN PUBLIC POLICY AND MANAGEMENT" | last_education_qualification == "Post Graduate Diploma in Business Administration"

replace last_educ_level = 3 if last_education_qualification == "Doctorate" | last_education_qualification == "M.Phil" | last_education_qualification == "M.Phil." | last_education_qualification == "Ph. D."  | last_education_qualification == "Ph.D.(U.S.A.)" | last_education_qualification == "Post Ph.D."

replace last_educ_level = 4 if last_education_qualification == "C.A."  | last_education_qualification == "C.F.A." | last_education_qualification == "C.S." | last_education_qualification == "CAIIB" | last_education_qualification == "CFA and MFA" | last_education_qualification == "Certificate" | last_education_qualification == "Certificate Course in French" | last_education_qualification == "Certificate course" | last_education_qualification == "Chartered Accountant" | last_education_qualification == "Chevening Gurukul Leadership Programme" | last_education_qualification == "Company Secretary" | last_education_qualification == "D.Min" | last_education_qualification == "DIPLOMA IN FRENCH" | last_education_qualification == "DIPLOMA IN MANAGEMENT" | last_education_qualification == "Degree" | last_education_qualification == "Diploma" | last_education_qualification == "ICWAI" | last_education_qualification == "Information Technology" | last_education_qualification == "LL.B Professional" | last_education_qualification == "LL.B." | last_education_qualification == "LL.M." | last_education_qualification == "Management Programme in Public Policy" | last_education_qualification == "PGD PPM" | last_education_qualification == "PGDBA Part Time" | last_education_qualification == "PGDFM Finance"

label define lastedu 1 "undergrad" 2 "postgrad" 3 "Phd" 4 "Professional Degree"      //Label defining Last Education Level
label values last_educ_level lastedu                                                 //Label values for  Last Education Level

// Making dummy for last education level//
gen undergrad_dum = 1 if last_educ_level == 1
replace undergrad_dum = 0 if last_educ_level != 1
replace undergrad_dum = . if last_educ_level == .

gen postgrad_dum = 1 if last_educ_level == 2
replace postgrad_dum = 0 if last_educ_level != 2
replace postgrad_dum = . if last_educ_level == .

gen phd_dum = 1 if last_educ_level == 3
replace phd_dum = 0 if last_educ_level != 3
replace phd_dum = . if last_educ_level == .

gen profdegree_dum = 1 if last_educ_level == 4
replace profdegree_dum = 0 if last_educ_level != 4
replace profdegree_dum = . if last_educ_level == .

//Generating Years of education//

gen educ_years=.                                        //Generating Years of education 
replace educ_years = 15 if last_educ_level==1           //Assigning Years of Education to Undergraduated People
replace educ_years = 17 if last_educ_level==2           //Assigning Years of Education to Post graduated People
replace educ_years = 23 if last_educ_level==3           //Assigning Years of Education to PhD People
replace educ_years = 16 if last_educ_level==4           //Assigning Years of Education to Professional Degree People


// Generating source of recuitment//

gen srec = .                        
replace srec = 1 if source_of_recruitment == "Direct Recruitment"           
replace srec = 2 if source_of_recruitment == "By Promotion from State Civil Service"
replace srec = 3 if (source_of_recruitment != "Direct Recruitment" & source_of_recruitment !=  "By Promotion from State Civil Service")

label define sourceofrec 1 "By Direct Recruitment" 2 "By Promotion from State Civil Service" 3 "other waya of recruitment"   // Label Defining Source Of recruitment
label values srec sourceofrec                                                                                                // Label values for Source Of recruitment

//Generating Source of recruitment dum//

gen direct_rec_dum = 1 if srec==1
replace direct_rec_dum = 0 if srec!=1

gen Promo_rec_dum = 1 if srec==2
replace Promo_rec_dum = 0 if srec!=2

gen other_rec_dum = 1 if srec==3
replace other_rec_dum = 0 if srec!=3

//v5 = 1 shows the id of the indivdual if that individual had even 1 ICD in his/ her career and have improper data//

gen v5 = .
replace v5 = 1 if id == "AM007700"
replace v5 = 1 if id == "AM008700"
replace v5 = 1 if id == "AM008900"
replace v5 = 1 if id == "AM011600"
replace v5 = 1 if id == "AM012300"
replace v5 = 1 if id == "AM012400"
replace v5 = 1 if id == "AM014901"
replace v5 = 1 if id == "AM016701"
replace v5 = 1 if id == "AM017100"
replace v5 = 1 if id == "AM017200"
replace v5 = 1 if id == "AM017900"
replace v5 = 1 if id == "AM018300"
replace v5 = 1 if id == "AM018500"
replace v5 = 1 if id == "AM019000"
replace v5 = 1 if id == "AM019800"
replace v5 = 1 if id == "AM020300"
replace v5 = 1 if id == "AM021600"
replace v5 = 1 if id == "AM022400"
replace v5 = 1 if id == "AM022500"
replace v5 = 1 if id == "AM023400"
replace v5 = 1 if id == "AM023500"
replace v5 = 1 if id == "AM024700"
replace v5 = 1 if id == "AM024900"
replace v5 = 1 if id == "AM025200"
replace v5 = 1 if id == "AM025300"
replace v5 = 1 if id == "AM025600"
replace v5 = 1 if id == "AM026200"
replace v5 = 1 if id == "AM027700"
replace v5 = 1 if id == "AM028300"
replace v5 = 1 if id == "AM028500"
replace v5 = 1 if id == "AM028900"
replace v5 = 1 if id == "AM029200"
replace v5 = 1 if id == "AM029400"
replace v5 = 1 if id == "AM030000"
replace v5 = 1 if id == "AM108C02"
replace v5 = 1 if id == "AM109C06"
replace v5 = 1 if id == "AP004800"
replace v5 = 1 if id == "AP009300"
replace v5 = 1 if id == "AP012000"
replace v5 = 1 if id == "AP013200"
replace v5 = 1 if id == "AP023900"
replace v5 = 1 if id == "AP025200"
replace v5 = 1 if id == "AP025300"
replace v5 = 1 if id == "AP028300"
replace v5 = 1 if id == "AP033705"
replace v5 = 1 if id == "AP035900"
replace v5 = 1 if id == "AP038100"
replace v5 = 1 if id == "AP042402"
replace v5 = 1 if id == "AP108B05"
replace v5 = 1 if id == "BH016700"
replace v5 = 1 if id == "BH017503"
replace v5 = 1 if id == "BH019100"
replace v5 = 1 if id == "BH021501"
replace v5 = 1 if id == "BH022200"
replace v5 = 1 if id == "BH024200"
replace v5 = 1 if id == "BH025800"
replace v5 = 1 if id == "BH026600"
replace v5 = 1 if id == "BH030800"
replace v5 = 1 if id == "BH031300"
replace v5 = 1 if id == "BH032800"
replace v5 = 1 if id == "BH036900"
replace v5 = 1 if id == "BH038300"
replace v5 = 1 if id == "BH038500"
replace v5 = 1 if id == "BH039200"
replace v5 = 1 if id == "BH039800"
replace v5 = 1 if id == "BH041101"
replace v5 = 1 if id == "BH041600"
replace v5 = 1 if id == "BH042400"
replace v5 = 1 if id == "BH043200"
replace v5 = 1 if id == "BH045800"
replace v5 = 1 if id == "BH048400"
replace v5 = 1 if id == "BH048700"
replace v5 = 1 if id == "BH049200"
replace v5 = 1 if id == "BH050100"
replace v5 = 1 if id == "BH051700"
replace v5 = 1 if id == "BH052100"
replace v5 = 1 if id == "CG017400"
replace v5 = 1 if id == "CG032313"
replace v5 = 1 if id == "CG035801"
replace v5 = 1 if id == "CG038311"
replace v5 = 1 if id == "CG049000"
replace v5 = 1 if id == "CG049800"
replace v5 = 1 if id == "GJ003900"
replace v5 = 1 if id == "GJ007000"
replace v5 = 1 if id == "GJ007100"
replace v5 = 1 if id == "GJ010300"
replace v5 = 1 if id == "GJ010900"
replace v5 = 1 if id == "GJ013900"
replace v5 = 1 if id == "GJ019200"
replace v5 = 1 if id == "GJ019700"
replace v5 = 1 if id == "GJ020000"
replace v5 = 1 if id == "GJ020100"
replace v5 = 1 if id == "GJ024900"
replace v5 = 1 if id == "GJ026200"
replace v5 = 1 if id == "GJ029600"
replace v5 = 1 if id == "GJ032500"
replace v5 = 1 if id == "GJ032700"
replace v5 = 1 if id == "GJ033700"
replace v5 = 1 if id == "HP002200"
replace v5 = 1 if id == "HP010800"
replace v5 = 1 if id == "HP012300"
replace v5 = 1 if id == "HP014000"
replace v5 = 1 if id == "HP014500"
replace v5 = 1 if id == "HP014600"
replace v5 = 1 if id == "HP014700"
replace v5 = 1 if id == "HP014800"
replace v5 = 1 if id == "HP811010"
replace v5 = 1 if id == "HY012400"
replace v5 = 1 if id == "HY013300"
replace v5 = 1 if id == "HY013400"
replace v5 = 1 if id == "HY014700"
replace v5 = 1 if id == "HY015400"
replace v5 = 1 if id == "HY016900"
replace v5 = 1 if id == "HY018200"
replace v5 = 1 if id == "HY019300"
replace v5 = 1 if id == "HY019400"
replace v5 = 1 if id == "HY020612"
replace v5 = 1 if id == "HY021100"
replace v5 = 1 if id == "HY022100"
replace v5 = 1 if id == "HY023300"
replace v5 = 1 if id == "HY023800"
replace v5 = 1 if id == "JH021510"
replace v5 = 1 if id == "JH023200"
replace v5 = 1 if id == "JH025100"
replace v5 = 1 if id == "JH025600"
replace v5 = 1 if id == "JH037617"
replace v5 = 1 if id == "JH038100"
replace v5 = 1 if id == "JH039600"
replace v5 = 1 if id == "JH040300"
replace v5 = 1 if id == "JH042426"
replace v5 = 1 if id == "JH042435"
replace v5 = 1 if id == "JH048900"
replace v5 = 1 if id == "JH049500"
replace v5 = 1 if id == "JK002100"
replace v5 = 1 if id == "JK002500"
replace v5 = 1 if id == "JK003300"
replace v5 = 1 if id == "JK006900"
replace v5 = 1 if id == "JK009700"
replace v5 = 1 if id == "JK010400"
replace v5 = 1 if id == "KL007102"
replace v5 = 1 if id == "KL011000"
replace v5 = 1 if id == "KL011900"
replace v5 = 1 if id == "KL012200"
replace v5 = 1 if id == "KL013700"
replace v5 = 1 if id == "KL015705"
replace v5 = 1 if id == "KL016500"
replace v5 = 1 if id == "KL016900"
replace v5 = 1 if id == "KL017000"
replace v5 = 1 if id == "KL018300"
replace v5 = 1 if id == "KL019000"
replace v5 = 1 if id == "KL019001"
replace v5 = 1 if id == "KL019401"
replace v5 = 1 if id == "KL020700"
replace v5 = 1 if id == "KL021200"
replace v5 = 1 if id == "KL021500"
replace v5 = 1 if id == "KL022300"
replace v5 = 1 if id == "KL022800"
replace v5 = 1 if id == "KL023300"
replace v5 = 1 if id == "KN008100"
replace v5 = 1 if id == "KN010500"
replace v5 = 1 if id == "KN014600"
replace v5 = 1 if id == "KN023600"
replace v5 = 1 if id == "KN025014"
replace v5 = 1 if id == "KN031200"
replace v5 = 1 if id == "KN034500"
replace v5 = 1 if id == "KN035200"
replace v5 = 1 if id == "KN035400"
replace v5 = 1 if id == "KN109K01"
replace v5 = 1 if id == "MH015900"
replace v5 = 1 if id == "MH017000"
replace v5 = 1 if id == "MH029300"
replace v5 = 1 if id == "MH034000"
replace v5 = 1 if id == "MH037800"
replace v5 = 1 if id == "MH039700"
replace v5 = 1 if id == "MH041800"
replace v5 = 1 if id == "MH043200"
replace v5 = 1 if id == "MH043202"
replace v5 = 1 if id == "MH045700"
replace v5 = 1 if id == "MH045900"
replace v5 = 1 if id == "MH046101"
replace v5 = 1 if id == "MH046700"
replace v5 = 1 if id == "MH047201"
replace v5 = 1 if id == "MH048200"
replace v5 = 1 if id == "MH048500"
replace v5 = 1 if id == "MH108N05"
replace v5 = 1 if id == "MN011100"
replace v5 = 1 if id == "MN011400"
replace v5 = 1 if id == "MN012600"
replace v5 = 1 if id == "MN013400"
replace v5 = 1 if id == "MN014800"
replace v5 = 1 if id == "MN015800"
replace v5 = 1 if id == "MN015900"
replace v5 = 1 if id == "MN017800"
replace v5 = 1 if id == "MN018200"
replace v5 = 1 if id == "MN018700"
replace v5 = 1 if id == "MN019700"
replace v5 = 1 if id == "MN019900"
replace v5 = 1 if id == "MN020700"
replace v5 = 1 if id == "MN020900"
replace v5 = 1 if id == "MN021300"
replace v5 = 1 if id == "MN021700"
replace v5 = 1 if id == "MN112O06"
replace v5 = 1 if id == "MP010600"
replace v5 = 1 if id == "MP013700"
replace v5 = 1 if id == "MP015800"
replace v5 = 1 if id == "MP021100"
replace v5 = 1 if id == "MP022800"
replace v5 = 1 if id == "MP027900"
replace v5 = 1 if id == "MP029001"
replace v5 = 1 if id == "MP029300"
replace v5 = 1 if id == "MP044200"
replace v5 = 1 if id == "MP044300"
replace v5 = 1 if id == "MP044302"
replace v5 = 1 if id == "MP047000"
replace v5 = 1 if id == "MP049500"
replace v5 = 1 if id == "MT003000"
replace v5 = 1 if id == "MT003800"
replace v5 = 1 if id == "MT004400"
replace v5 = 1 if id == "MT004500"
replace v5 = 1 if id == "MT005100"
replace v5 = 1 if id == "MT006100"
replace v5 = 1 if id == "MT007400"
replace v5 = 1 if id == "MT007500"
replace v5 = 1 if id == "MT009100"
replace v5 = 1 if id == "MT009500"
replace v5 = 1 if id == "MT010000"
replace v5 = 1 if id == "MT012200"
replace v5 = 1 if id == "MT015400"
replace v5 = 1 if id == "NL001800"
replace v5 = 1 if id == "NL005300"
replace v5 = 1 if id == "NL005900"
replace v5 = 1 if id == "NL007200"
replace v5 = 1 if id == "NL108P02"
replace v5 = 1 if id == "NL111P04"
replace v5 = 1 if id == "OR010200"
replace v5 = 1 if id == "OR013300"
replace v5 = 1 if id == "OR021200"
replace v5 = 1 if id == "OR021500"
replace v5 = 1 if id == "OR022900"
replace v5 = 1 if id == "OR023300"
replace v5 = 1 if id == "OR024200"
replace v5 = 1 if id == "OR024500"
replace v5 = 1 if id == "OR027500"
replace v5 = 1 if id == "OR027700"
replace v5 = 1 if id == "OR027901"
replace v5 = 1 if id == "OR028201"
replace v5 = 1 if id == "PB006000"
replace v5 = 1 if id == "PB006500"
replace v5 = 1 if id == "PB009100"
replace v5 = 1 if id == "PB009600"
replace v5 = 1 if id == "PB013106"
replace v5 = 1 if id == "PB013900"
replace v5 = 1 if id == "PB014500"
replace v5 = 1 if id == "PB014900"
replace v5 = 1 if id == "PB015800"
replace v5 = 1 if id == "PB016200"
replace v5 = 1 if id == "PB016800"
replace v5 = 1 if id == "PB016900"
replace v5 = 1 if id == "PB017300"
replace v5 = 1 if id == "PB017400"
replace v5 = 1 if id == "PB018200"
replace v5 = 1 if id == "PB018211"
replace v5 = 1 if id == "PB018300"
replace v5 = 1 if id == "PB018611"
replace v5 = 1 if id == "PB018800"
replace v5 = 1 if id == "PB019016"
replace v5 = 1 if id == "PB019500"
replace v5 = 1 if id == "PB019600"
replace v5 = 1 if id == "PB020700"
replace v5 = 1 if id == "PB021100"
replace v5 = 1 if id == "PB021900"
replace v5 = 1 if id == "PB022101"
replace v5 = 1 if id == "PB022700"
replace v5 = 1 if id == "PB024700"
replace v5 = 1 if id == "PB024702"
replace v5 = 1 if id == "PB108T02"
replace v5 = 1 if id == "PB112R03"
replace v5 = 1 if id == "PB94A301"
replace v5 = 1 if id == "RJ013300"
replace v5 = 1 if id == "RJ018600"
replace v5 = 1 if id == "RJ018803"
replace v5 = 1 if id == "RJ022604"
replace v5 = 1 if id == "RJ026800"
replace v5 = 1 if id == "RJ027803"
replace v5 = 1 if id == "RJ032100"
replace v5 = 1 if id == "RJ033200"
replace v5 = 1 if id == "RJ033400"
replace v5 = 1 if id == "SK001500"
replace v5 = 1 if id == "SK003500"
replace v5 = 1 if id == "SK004200"
replace v5 = 1 if id == "SK004500"
replace v5 = 1 if id == "SK004600"
replace v5 = 1 if id == "SK004700"
replace v5 = 1 if id == "SK005300"
replace v5 = 1 if id == "TG035800"
replace v5 = 1 if id == "TG037700"
replace v5 = 1 if id == "TG042700"
replace v5 = 1 if id == "TN006500"
replace v5 = 1 if id == "TN006900"
replace v5 = 1 if id == "TN008300"
replace v5 = 1 if id == "TN013400"
replace v5 = 1 if id == "TN017900"
replace v5 = 1 if id == "TN020900"
replace v5 = 1 if id == "TN029113"
replace v5 = 1 if id == "TN030400"
replace v5 = 1 if id == "TN031500"
replace v5 = 1 if id == "TN032400"
replace v5 = 1 if id == "TN033600"
replace v5 = 1 if id == "TN034100"
replace v5 = 1 if id == "TN037200"
replace v5 = 1 if id == "TN038600"
replace v5 = 1 if id == "TN039300"
replace v5 = 1 if id == "TN039401"
replace v5 = 1 if id == "TN040100"
replace v5 = 1 if id == "TN040300"
replace v5 = 1 if id == "TN109U05"
replace v5 = 1 if id == "TN109U08"
replace v5 = 1 if id == "TR007800"
replace v5 = 1 if id == "TR009400"
replace v5 = 1 if id == "TR011500"
replace v5 = 1 if id == "TR012100"
replace v5 = 1 if id == "TR012800"
replace v5 = 1 if id == "TR013200"
replace v5 = 1 if id == "TR013800"
replace v5 = 1 if id == "TR014700"
replace v5 = 1 if id == "TR015000"
replace v5 = 1 if id == "TR016900"
replace v5 = 1 if id == "TR017000"
replace v5 = 1 if id == "TR020100"
replace v5 = 1 if id == "TR020600"
replace v5 = 1 if id == "TR020800"
replace v5 = 1 if id == "TR021000"
replace v5 = 1 if id == "TR021200"
replace v5 = 1 if id == "TR021600"
replace v5 = 1 if id == "TR021900"
replace v5 = 1 if id == "TR108O01"
replace v5 = 1 if id == "TR111O04"
replace v5 = 1 if id == "UD025700"
replace v5 = 1 if id == "UD040500"
replace v5 = 1 if id == "UD051516"
replace v5 = 1 if id == "UD055014"
replace v5 = 1 if id == "UD055211"
replace v5 = 1 if id == "UD059700"
replace v5 = 1 if id == "UD060017"
replace v5 = 1 if id == "UD066200"
replace v5 = 1 if id == "UD067400"
replace v5 = 1 if id == "UD108W01"
replace v5 = 1 if id == "UP024300"
replace v5 = 1 if id == "UP033400"
replace v5 = 1 if id == "UP034200"
replace v5 = 1 if id == "UP043700"
replace v5 = 1 if id == "UP043900"
replace v5 = 1 if id == "UP044400"
replace v5 = 1 if id == "UP047300"
replace v5 = 1 if id == "UP048300"
replace v5 = 1 if id == "UP056000"
replace v5 = 1 if id == "UP056500"
replace v5 = 1 if id == "UP057100"
replace v5 = 1 if id == "UP057623"
replace v5 = 1 if id == "UP059200"
replace v5 = 1 if id == "UP060919"
replace v5 = 1 if id == "UP062044"
replace v5 = 1 if id == "UP062402"
replace v5 = 1 if id == "UP062512"
replace v5 = 1 if id == "UP062514"
replace v5 = 1 if id == "UP063200"
replace v5 = 1 if id == "UP063700"
replace v5 = 1 if id == "UP065500"
replace v5 = 1 if id == "UP066100"
replace v5 = 1 if id == "UP067700"
replace v5 = 1 if id == "UP069000"
replace v5 = 1 if id == "UP069101"
replace v5 = 1 if id == "UP069301"
replace v5 = 1 if id == "UP069901"
replace v5 = 1 if id == "UP070200"
replace v5 = 1 if id == "UP070500"
replace v5 = 1 if id == "UP071100"
replace v5 = 1 if id == "UP071400"
replace v5 = 1 if id == "UP110V11"
replace v5 = 1 if id == "UP112P02"
replace v5 = 1 if id == "UP112V12"
replace v5 = 1 if id == "UP812134"
replace v5 = 1 if id == "UP929400"
replace v5 = 1 if id == "UT001700"
replace v5 = 1 if id == "UT002400"
replace v5 = 1 if id == "UT002500"
replace v5 = 1 if id == "UT008400"
replace v5 = 1 if id == "UT010500"
replace v5 = 1 if id == "UT011000"
replace v5 = 1 if id == "UT012100"
replace v5 = 1 if id == "UT014416"
replace v5 = 1 if id == "UT015100"
replace v5 = 1 if id == "UT016810"
replace v5 = 1 if id == "UT018800"
replace v5 = 1 if id == "UT025700"
replace v5 = 1 if id == "UT109A04"
replace v5 = 1 if id == "UT109A05"
replace v5 = 1 if id == "UT112A01"
replace v5 = 1 if id == "UT814404"
replace v5 = 1 if id == "WB013600"
replace v5 = 1 if id == "WB013800"
replace v5 = 1 if id == "WB013904"
replace v5 = 1 if id == "WB015000"
replace v5 = 1 if id == "WB018000"
replace v5 = 1 if id == "WB022500"
replace v5 = 1 if id == "WB026200"
replace v5 = 1 if id == "WB027900"
replace v5 = 1 if id == "WB028700"
replace v5 = 1 if id == "WB029000"
replace v5 = 1 if id == "WB030100"
replace v5 = 1 if id == "WB031800"
replace v5 = 1 if id == "WB032900"
replace v5 = 1 if id == "WB034800"
replace v5 = 1 if id == "WB036200"
replace v5 = 1 if id == "WB038700"

replace v5 =0 if v5==.

label variable v5 "Atleast 1 ICD in their whole career"


** Here V4 shows the peoples who had ICD but with improper data**
gen v4 = . 
replace v4 = 1 if id == "AM007700"
replace v4 = 1 if id == "AM008700"
replace v4 = 1 if id == "AM008900"
replace v4 = 1 if id == "AM012300"
replace v4 = 1 if id == "AM012500"
replace v4 = 1 if id == "AM014901"
replace v4 = 1 if id == "AM017100"
replace v4 = 1 if id == "AM017200"
replace v4 = 1 if id == "AM017900"
replace v4 = 1 if id == "AM018300"
replace v4 = 1 if id == "AM018400"
replace v4 = 1 if id == "AM018500"
replace v4 = 1 if id == "AM019800"
replace v4 = 1 if id == "AM020300"
replace v4 = 1 if id == "AM021300"
replace v4 = 1 if id == "AM022400"
replace v4 = 1 if id == "AM022500"
replace v4 = 1 if id == "AM023500"
replace v4 = 1 if id == "AM024900"
replace v4 = 1 if id == "AM025200"
replace v4 = 1 if id == "AM025300"
replace v4 = 1 if id == "AM025600"
replace v4 = 1 if id == "AM027700"
replace v4 = 1 if id == "AM028300"
replace v4 = 1 if id == "AM028400"
replace v4 = 1 if id == "AM028500"
replace v4 = 1 if id == "AM029200"
replace v4 = 1 if id == "AM029400"
replace v4 = 1 if id == "AM030000"
replace v4 = 1 if id == "AM108C02"
replace v4 = 1 if id == "AM109C06"
replace v4 = 1 if id == "AP004800"
replace v4 = 1 if id == "AP009300"
replace v4 = 1 if id == "AP012000"
replace v4 = 1 if id == "AP023200"
replace v4 = 1 if id == "AP023900"
replace v4 = 1 if id == "AP025200"
replace v4 = 1 if id == "AP025300"
replace v4 = 1 if id == "AP028300"
replace v4 = 1 if id == "AP042402"
replace v4 = 1 if id == "BH016700"
replace v4 = 1 if id == "BH019100"
replace v4 = 1 if id == "BH021501"
replace v4 = 1 if id == "BH022200"
replace v4 = 1 if id == "BH024200"
replace v4 = 1 if id == "BH025300"
replace v4 = 1 if id == "BH025800"
replace v4 = 1 if id == "BH031300"
replace v4 = 1 if id == "BH032800"
replace v4 = 1 if id == "BH039200"
replace v4 = 1 if id == "BH039800"
replace v4 = 1 if id == "BH041101"
replace v4 = 1 if id == "BH041600"
replace v4 = 1 if id == "BH042400"
replace v4 = 1 if id == "BH045800"
replace v4 = 1 if id == "BH048400"
replace v4 = 1 if id == "BH048700"
replace v4 = 1 if id == "BH049200"
replace v4 = 1 if id == "BH051700"
replace v4 = 1 if id == "BH052100"
replace v4 = 1 if id == "CG017400"
replace v4 = 1 if id == "CG032313"
replace v4 = 1 if id == "CG035801"
replace v4 = 1 if id == "CG111E01"
replace v4 = 1 if id == "GJ003900"
replace v4 = 1 if id == "GJ007100"
replace v4 = 1 if id == "GJ010900"
replace v4 = 1 if id == "GJ013900"
replace v4 = 1 if id == "GJ019200"
replace v4 = 1 if id == "GJ019700"
replace v4 = 1 if id == "GJ024900"
replace v4 = 1 if id == "GJ026200"
replace v4 = 1 if id == "GJ032500"
replace v4 = 1 if id == "HP002200"
replace v4 = 1 if id == "HP010800"
replace v4 = 1 if id == "HP014000"
replace v4 = 1 if id == "HP014500"
replace v4 = 1 if id == "HP014700"
replace v4 = 1 if id == "HP014800"
replace v4 = 1 if id == "HP811010"
replace v4 = 1 if id == "HY004500"
replace v4 = 1 if id == "HY011700"
replace v4 = 1 if id == "HY012400"
replace v4 = 1 if id == "HY012900"
replace v4 = 1 if id == "HY013400"
replace v4 = 1 if id == "HY018200"
replace v4 = 1 if id == "HY021100"
replace v4 = 1 if id == "HY023800"
replace v4 = 1 if id == "JH023200"
replace v4 = 1 if id == "JH025100"
replace v4 = 1 if id == "JH025600"
replace v4 = 1 if id == "JH038100"
replace v4 = 1 if id == "JH039600"
replace v4 = 1 if id == "JH048900"
replace v4 = 1 if id == "JH049500"
replace v4 = 1 if id == "JK002100"
replace v4 = 1 if id == "JK002500"
replace v4 = 1 if id == "JK003300"
replace v4 = 1 if id == "JK006900"
replace v4 = 1 if id == "KL011000"
replace v4 = 1 if id == "KL011900"
replace v4 = 1 if id == "KL012200"
replace v4 = 1 if id == "KL013700"
replace v4 = 1 if id == "KL015705"
replace v4 = 1 if id == "KL016600"
replace v4 = 1 if id == "KL019000"
replace v4 = 1 if id == "KL019001"
replace v4 = 1 if id == "KL019401"
replace v4 = 1 if id == "KL020700"
replace v4 = 1 if id == "KL021200"
replace v4 = 1 if id == "KL021500"
replace v4 = 1 if id == "KL022300"
replace v4 = 1 if id == "KL022800"
replace v4 = 1 if id == "KL023300"
replace v4 = 1 if id == "KN008100"
replace v4 = 1 if id == "KN010500"
replace v4 = 1 if id == "KN014600"
replace v4 = 1 if id == "KN023600"
replace v4 = 1 if id == "KN025014"
replace v4 = 1 if id == "KN031200"
replace v4 = 1 if id == "KN035200"
replace v4 = 1 if id == "KN035400"
replace v4 = 1 if id == "KN109K01"
replace v4 = 1 if id == "MH017000"
replace v4 = 1 if id == "MH029300"
replace v4 = 1 if id == "MH037800"
replace v4 = 1 if id == "MH039700"
replace v4 = 1 if id == "MH041800"
replace v4 = 1 if id == "MH043200"
replace v4 = 1 if id == "MH043202"
replace v4 = 1 if id == "MH045900"
replace v4 = 1 if id == "MH046101"
replace v4 = 1 if id == "MH048100"
replace v4 = 1 if id == "MH048200"
replace v4 = 1 if id == "MH048500"
replace v4 = 1 if id == "MH108N05"
replace v4 = 1 if id == "MN011100"
replace v4 = 1 if id == "MN011400"
replace v4 = 1 if id == "MN012600"
replace v4 = 1 if id == "MN013400"
replace v4 = 1 if id == "MN015800"
replace v4 = 1 if id == "MN015900"
replace v4 = 1 if id == "MN018200"
replace v4 = 1 if id == "MN019700"
replace v4 = 1 if id == "MN020900"
replace v4 = 1 if id == "MN021300"
replace v4 = 1 if id == "MN109O03"
replace v4 = 1 if id == "MN112O06"
replace v4 = 1 if id == "MP010600"
replace v4 = 1 if id == "MP016804"
replace v4 = 1 if id == "MP021100"
replace v4 = 1 if id == "MP027900"
replace v4 = 1 if id == "MP029001"
replace v4 = 1 if id == "MP029300"
replace v4 = 1 if id == "MP047000"
replace v4 = 1 if id == "MP049500"
replace v4 = 1 if id == "MT004400"
replace v4 = 1 if id == "MT004500"
replace v4 = 1 if id == "MT005100"
replace v4 = 1 if id == "MT007500"
replace v4 = 1 if id == "MT009100"
replace v4 = 1 if id == "MT009500"
replace v4 = 1 if id == "MT010000"
replace v4 = 1 if id == "NL001800"
replace v4 = 1 if id == "NL005900"
replace v4 = 1 if id == "NL007200"
replace v4 = 1 if id == "NL111P04"
replace v4 = 1 if id == "OR010200"
replace v4 = 1 if id == "OR013300"
replace v4 = 1 if id == "OR021200"
replace v4 = 1 if id == "OR024200"
replace v4 = 1 if id == "OR024500"
replace v4 = 1 if id == "OR027500"
replace v4 = 1 if id == "OR027700"
replace v4 = 1 if id == "OR027901"
replace v4 = 1 if id == "OR028201"
replace v4 = 1 if id == "OR108Q02"
replace v4 = 1 if id == "PB006000"
replace v4 = 1 if id == "PB006500"
replace v4 = 1 if id == "PB009600"
replace v4 = 1 if id == "PB013106"
replace v4 = 1 if id == "PB013900"
replace v4 = 1 if id == "PB015301"
replace v4 = 1 if id == "PB016200"
replace v4 = 1 if id == "PB016800"
replace v4 = 1 if id == "PB016900"
replace v4 = 1 if id == "PB017701"
replace v4 = 1 if id == "PB018200"
replace v4 = 1 if id == "PB018300"
replace v4 = 1 if id == "PB018800"
replace v4 = 1 if id == "PB019500"
replace v4 = 1 if id == "PB019700"
replace v4 = 1 if id == "PB021900"
replace v4 = 1 if id == "PB022101"
replace v4 = 1 if id == "PB024700"
replace v4 = 1 if id == "PB024702"
replace v4 = 1 if id == "PB108T02"
replace v4 = 1 if id == "PB112R03"
replace v4 = 1 if id == "RJ013300"
replace v4 = 1 if id == "RJ018600"
replace v4 = 1 if id == "RJ018803"
replace v4 = 1 if id == "RJ022604"
replace v4 = 1 if id == "RJ026800"
replace v4 = 1 if id == "RJ027803"
replace v4 = 1 if id == "RJ033200"
replace v4 = 1 if id == "RJ033400"
replace v4 = 1 if id == "SK003500"
replace v4 = 1 if id == "SK003700"
replace v4 = 1 if id == "SK004200"
replace v4 = 1 if id == "SK004500"
replace v4 = 1 if id == "SK004700"
replace v4 = 1 if id == "SK005300"
replace v4 = 1 if id == "SK005500"
replace v4 = 1 if id == "SK005600"
replace v4 = 1 if id == "TG035800"
replace v4 = 1 if id == "TG037700"
replace v4 = 1 if id == "TG042700"
replace v4 = 1 if id == "TN006500"
replace v4 = 1 if id == "TN006900"
replace v4 = 1 if id == "TN008300"
replace v4 = 1 if id == "TN013400"
replace v4 = 1 if id == "TN017900"
replace v4 = 1 if id == "TN029113"
replace v4 = 1 if id == "TN030400"
replace v4 = 1 if id == "TN031500"
replace v4 = 1 if id == "TN032400"
replace v4 = 1 if id == "TN034100"
replace v4 = 1 if id == "TN037200"
replace v4 = 1 if id == "TN038600"
replace v4 = 1 if id == "TN039300"
replace v4 = 1 if id == "TN039401"
replace v4 = 1 if id == "TN040300"
replace v4 = 1 if id == "TN109U05"
replace v4 = 1 if id == "TN109U08"
replace v4 = 1 if id == "TR009400"
replace v4 = 1 if id == "TR012800"
replace v4 = 1 if id == "TR015000"
replace v4 = 1 if id == "TR020100"
replace v4 = 1 if id == "TR020600"
replace v4 = 1 if id == "TR021200"
replace v4 = 1 if id == "TR021600"
replace v4 = 1 if id == "TR021900"
replace v4 = 1 if id == "TR108O01"
replace v4 = 1 if id == "TR111O04"
replace v4 = 1 if id == "UD025700"
replace v4 = 1 if id == "UD040500"
replace v4 = 1 if id == "UD059700"
replace v4 = 1 if id == "UD066200"
replace v4 = 1 if id == "UD067400"
replace v4 = 1 if id == "UD108W01"
replace v4 = 1 if id == "UP024300"
replace v4 = 1 if id == "UP034200"
replace v4 = 1 if id == "UP048300"
replace v4 = 1 if id == "UP056500"
replace v4 = 1 if id == "UP057623"
replace v4 = 1 if id == "UP063200"
replace v4 = 1 if id == "UP066100"
replace v4 = 1 if id == "UP067700"
replace v4 = 1 if id == "UP070400"
replace v4 = 1 if id == "UP071400"
replace v4 = 1 if id == "UP112P02"
replace v4 = 1 if id == "UT001700"
replace v4 = 1 if id == "UT002400"
replace v4 = 1 if id == "UT002500"
replace v4 = 1 if id == "UT008400"
replace v4 = 1 if id == "UT010500"
replace v4 = 1 if id == "UT011000"
replace v4 = 1 if id == "UT014416"
replace v4 = 1 if id == "UT015100"
replace v4 = 1 if id == "UT016810"
replace v4 = 1 if id == "UT109A04"
replace v4 = 1 if id == "UT109A05"
replace v4 = 1 if id == "UT814404"
replace v4 = 1 if id == "WB013600"
replace v4 = 1 if id == "WB013800"
replace v4 = 1 if id == "WB013904"
replace v4 = 1 if id == "WB018000"
replace v4 = 1 if id == "WB022500"
replace v4 = 1 if id == "WB026200"
replace v4 = 1 if id == "WB029000"
replace v4 = 1 if id == "WB030100"
replace v4 = 1 if id == "WB031800"
replace v4 = 1 if id == "WB032900"
replace v4 = 1 if id == "WB034500"
replace v4 = 0 if missing(v4)

label variable v4 "ICD personnels with improper data"

save "$profile\IAS Profile Detail.dta", replace

keep id cadre source_of_recruitment place_of_domicile mother_tongue retired_dum last_education_qualification last_level last_educ_level educ_years srec
save "$profile\IAS Profile subset.dta", replace


******************************************************************************************************************************************************************************************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************************************************************************************************************************************************************************************


***************************************************************************************************************************************************************************
//Experience Data Set//
***************************************************************************************************************************************************************************

use "$experience\IAS experience.dta",clear

//Cleaning the Not Available values//

**For last feild of Experience IAS**
replace field_of_experience="Not Available" if field_of_experience=="N.Applicable"
replace field_of_experience="Not Available" if field_of_experience=="Not Available"
replace field_of_experience="Not Available" if field_of_experience=="N.A."

**For last Category of Experience IAS**
replace category_of_experience ="Not Available" if category_of_experience =="N.Available"
replace category_of_experience ="Not Available" if category_of_experience =="N.Applicable"

**For Designation IAS**
replace designation="Not Available" if designation=="N.A."


//Cleaning The duplicates From Experience Data set//

**Finding Duplicates from Experience Data**

encode id, gen(e_id)         //Encoding ID

//Every person with a reference value is unique and hence making a unique Id for all Observations //

gen UID= (e_id*100+ reference_value)                           
duplicates tag UID, gen (dup)
replace dup = . if missing(UID)


//Deleting the duplicate from Experience Data set//

drop if (id=="RJ029800" & level=="Not Available")
drop if (id=="MT011411" & level=="Not Available")
drop if (id=="MT004500" & level=="Not Available")
drop if (id=="PB008203" & level=="Not Available")
drop if (id=="BH015000" & level=="Not Available")
drop if (id=="PB004300" & level=="Not Available")
drop if (id=="MT011514" & level=="Not Available")
drop if (id=="MT007500" & level=="Not Available")
   //Deleting duplicates for Shri Ras Das//
gen S_Ref_1=sum(reference_value) if name=="Shri Ras Das"
order id name cadre reference_value S_Ref
drop if (name=="Shri Ras Das" & S_Ref_1<253)
drop if (name=="Shri Ras Das" & reference_value==22 & level=="Junior Scale")
   //Deleting duplicates for Dr. Sada Nand//
gen S_Ref_2=sum(reference_value) if id=="PB005200"
order id name cadre reference_value S_Ref_2
drop if (id=="PB005200" & S_Ref_2>210)
drop if (id=="PB005200" & reference_value==0 & designation =="Fin Commissioner")
   //Deleting duplicates for Shri Vp Sawhney//
encode office, gen(e_office)
gen S_off_1=sum(e_office) if name=="Shri Vp Sawhney"
order id name cadre reference_value S_off_1
drop if (id=="UP020000" & S_off_1<26006)   

//cheking if any duplicates left//
drop dup
duplicates tag UID, gen (dup)
replace dup = . if missing(UID)
tab dup

//Droping The Variables that are not needed anymore//
drop dup 
drop S_Ref_1
drop S_Ref_2
drop S_off_1
drop e_office


//Making values of same correspondence//

replace designation="Additional Secretary" if designation=="Additional Secy"
replace designation="Joint Secretary" if designation=="Jt Secy"
replace designation="Under Secretary" if designation=="Under Secy"
replace designation="Secretary" if designation=="secy."
replace field_of_experience="Law and Justice" if field_of_experience=="Law & Justice"
replace field_of_experience="Rural Development" if field_of_experience=="Rural Dev"
replace category_of_experience="Service Commission" if category_of_experience=="Service Commn"
replace field_of_experience="Urban Development" if field_of_experience=="Urban Develoment"


//Creating cadre code//

gen cadre_code= .
replace cadre_code=1 if cadre=="Andhra Pradesh"

replace cadre_code=2 if cadre=="A G M U T"
replace cadre_code=3 if cadre=="Assam Meghalya"

replace cadre_code=4 if cadre=="Bihar"
replace cadre_code=5 if cadre=="Chhattisgarh"
replace cadre_code=7 if cadre=="Gujarat"
replace cadre_code=8 if cadre=="Haryana"
replace cadre_code=9 if cadre=="Himachal Pradesh"
replace cadre_code=10 if cadre=="Jammu & Kashmir"
replace cadre_code=11 if cadre=="Jharkhand"
replace cadre_code=12 if cadre=="Karnataka"
replace cadre_code=13 if cadre=="Kerala"
replace cadre_code=14 if cadre=="Madhya Pradesh"
replace cadre_code=15 if cadre=="Maharashtra"

replace cadre_code=16 if cadre=="Manipur"
replace cadre_code=17 if cadre=="Manipur-Tripura"
replace cadre_code=19 if cadre=="Nagaland"

replace cadre_code=20 if cadre=="Odisha"
replace cadre_code=21 if cadre=="Punjab"
replace cadre_code=22 if cadre=="Rajasthan"
replace cadre_code=23 if cadre=="Sikkim"
replace cadre_code=24 if cadre=="Tamil Nadu"
replace cadre_code=25 if cadre=="Telangana"

replace cadre_code=26 if cadre=="Tripura"

replace cadre_code=27 if cadre=="Uttar Pradesh"
replace cadre_code=28 if cadre=="Uttarakhand"
replace cadre_code=29 if cadre=="West Bengal"




//Creating identifier values such that a person from a particular cadre has his unique id//

gen identifier = (cadre_code*100000 + e_id)        //Generating a unique identifier for all IAS officers
sort cadre_code identifier reference_value


//Generating Start and end dates in string//

gen start = substr( start_date,1,4)          //Seperating the Start year by using Substring
gen end = substr( end_date,1,4)              //Seperating the End year by using Substring
destring start, generate(St_dt) force        //Destring the Start date
destring end, generate(End_dt) force         //Destring the End date


//Merge using Allotment yr data set to get the allotment yr in Experience data set//
merge m:1 id using "$profile\Allotment yr.dta" 

**Dropiing the Unmatched Observation of Profile Data set**

drop if _merge==2

**Droping label for encoded ID**
 
label values e_id .


**Ordering sorting and droping Merge Variable from the Data**
order e_id St_dt cadre_code identifier allotment_year category_of_experience reference_value
sort e_id St_dt
drop _merge

//Merge using Gender data set to get the gender in Experience data set//
merge m:1 id using "$profile\Gender.dta"

**Ordering droping Merge Variable from the Data**
order e_id St_dt cadre_code identifier gender allotment_year category_of_experience reference_value
drop if _merge==2
drop _merge

//Creating Split cadre code//

encode organisation, gen(eorganisation)
tab eorganisation
tab eorganisation, nolabel
gen v1 = .
replace v1 = 1 if eorganisation == 6
gen ncader = (v1*cadre_code)
sort v1
tab v1
encode office, gen(eoffice)
tab eoffice
tab eoffice, nolabel
gen noffice = (v1*eoffice)
sort v1
tab noffice
sort v1 e_id
order cadre v1 cadre_code e_id  eoffice

gen v2 = .
replace v2 = 1 if (!missing(noffice) & v1==1)
replace v2 = 0 if (missing(noffice) & v1==1)
tab v2
label variable v1 "dummy for Inter cadre deputation(ICD)"
label variable v2 "dummy 1=showing non missing values for office of all those who have ICD"
sort v1 e_id
order  cadre v1 v2
codebook e_id if v1==1
codebook e_id if (missing(eoffice) & v1==1)
codebook e_id if (!missing(eoffice) & v1==1)

gen v3 = .
order cadre v1 v2 v3 
replace v3=1 if (v1==1 & (e_id==23 | e_id==32 | e_id== 34 | e_id==66 | e_id==69 | e_id==99 | e_id==131 | e_id==132 | e_id==150 | e_id==161 | e_id==162 | e_id==163 | e_id==201 | e_id==206 | e_id==227 | e_id==250 | e_id==251 | e_id==284 | e_id==308 | e_id==315 | e_id==316 | e_id==319 | e_id==357 | e_id==363 | e_id==364 | e_id==365 | e_id==372 | e_id==374 | e_id==379 | e_id==386 | e_id==393 | e_id==549 | e_id==568 | e_id==582 | e_id==689 | e_id==718 | e_id==730 | e_id==731 | e_id==779 | e_id==990 | e_id==1199 | e_id==1225 | e_id==1239 | e_id==1244 | e_id==1267 | e_id==1278 | e_id==1282 | e_id==1355 | e_id==1382 | e_id==1526 | e_id==1529  | e_id==1552 | e_id==1569 |e_id==1572 | e_id==1667 | e_id==1704 | e_id==1707 | e_id==1712 | e_id==1736 | e_id==1740 | e_id==2016 | e_id==2038 | e_id==2045 | e_id==2175 | e_id==2275 | e_id==2286 | e_id==2324 | e_id==2349 | e_id==2409 | e_id==2419 | e_id==2512 | e_id==2526 | e_id==2690 | e_id==2901 | e_id==3023 | e_id==3083 | e_id==3088 | e_id==3090 | e_id==3091 | e_id==3167 | e_id==3204 | e_id==3285 | e_id==3293 | e_id==3301 | e_id==3313 | e_id==3393 | e_id==3467 | e_id==3526 | e_id==3680 | e_id==3685 | e_id==3687 | e_id==3728 | e_id==3734 | e_id==3810 | e_id==3814 | e_id==4008 | e_id==4014 | e_id==4024 | e_id==4093 | e_id==4356 | e_id==4370 | e_id==4373 | e_id==4398 | e_id==4430 | e_id==4438 | e_id==4462 | e_id==4463 | e_id==4470 | e_id==4498 | e_id==4520 | e_id==4522 | e_id==4536 | e_id==4542 | e_id==4546 | e_id==4699 | e_id==4722 | e_id==4739 | e_id==4870 | e_id==4899 | e_id==5023 | e_id==5085 | e_id==5087 | e_id==5098 | e_id==5334 | e_id==5461 | e_id==5621 | e_id==5646 | e_id==5708 | e_id==5737 | e_id==5739 | e_id==5834 | e_id==5838 | e_id==5859 | e_id==5860 | e_id==5863 | e_id==5881 | e_id==6095 | e_id==6096 | e_id==6100 | e_id==6102 | e_id==6111 | e_id==6112 | e_id==6118 | e_id==6120 | e_id==6126 | e_id==6127 | e_id==6134 | e_id==6140 | e_id==6215 | e_id==6266 | e_id==6300 | e_id==6386 | e_id==6400 | e_id==6403 | e_id==6740 | e_id==6771 | e_id==7131 | e_id==7133 | e_id==7140 | e_id==7164 | e_id==7180 | e_id==7181 | e_id==7187 | e_id==7303 | e_id==7380 | e_id==7386 | e_id==7393 | e_id==7504 | e_id==7532 | e_id==7655 | e_id==7781 | e_id==7784 | e_id==7860 | e_id==7863 | e_id==7866 | e_id==7871 | e_id==7888 | e_id==8056 | e_id==8060 | e_id==8096 | e_id==8134 | e_id==8146 | e_id==8179 | e_id==8234 | e_id==8240 | e_id==8241 | e_id==8251 | e_id==8255 | e_id==8265 | e_id==8271 | e_id==8304 | e_id==8306 | e_id==8353 | e_id==8357 | e_id==8387 | e_id==8389 | e_id==8395 | e_id==8412 | e_id==8602 | e_id==8668 | e_id==8673 | e_id==8768 | e_id==8846 | e_id==8883 | e_id==8974 | e_id==8976 | e_id==9224 | e_id==9226 | e_id==9237 | e_id==9241 | e_id==9243 | e_id==9245 | e_id==9246 | e_id==9247 | e_id==9314 | e_id==9324 | e_id==9363 | e_id==9480 | e_id==9483 | e_id==9492 | e_id==9539 | e_id==9588 | e_id==9736 | e_id==9754 | e_id==9771 | e_id==9790 | e_id==9819 | e_id==9866 | e_id==9893 | e_id==9908 | e_id==9912 | e_id==9922 | e_id==9954 | e_id==9957 | e_id==10189 | e_id==10196 | e_id==10204 | e_id==10214 | e_id==10215 | e_id==10218| e_id==10219 | e_id==10220 | e_id==10221 | e_id==10227 | e_id==10280 | e_id==10294 | e_id==10327 | e_id==10357 | e_id==10367 | e_id==10384 | e_id==10520 | e_id==10615 | e_id==10824 | e_id==10983 | e_id==11013 | e_id==11172 | e_id==11215 | e_id==11255 | e_id==11287  | e_id==11297 | e_id==11382 | e_id==11726 | e_id==11730 | e_id==11731 | e_id==11775 | e_id==11796 | e_id==11803 | e_id==11859 | e_id==11883 | e_id==11914 | e_id==12135 | e_id==12136 | e_id==12331 | e_id== 12446 | e_id==12447 | e_id==12452 | e_id==12494 | e_id==12544 | e_id==12603 | e_id==12680 | e_id==12719 | e_id==12741 | e_id==12768 | e_id==12812))
replace v3 = 0 if missing(v3) & v1==1
tab v3
codebook e_id if v3==1
codebook e_id if v3==0

gen v4 = .
order cadre v1 v2 v3 v4
replace v4=1 if  (e_id==23 | e_id==32 | e_id== 34 | e_id==66 | e_id==69 | e_id==99 | e_id==131 | e_id==132 | e_id==150 | e_id==161 | e_id==162 | e_id==163 | e_id==201 | e_id==206 | e_id==227 | e_id==250 | e_id==251 | e_id==284 | e_id==308 | e_id==315 | e_id==316 | e_id==319 | e_id==357 | e_id==363 | e_id==364 | e_id==365 | e_id==372 | e_id==374 | e_id==379 | e_id==386 | e_id==393 | e_id==549 | e_id==568 | e_id==582 | e_id==689 | e_id==718 | e_id==730 | e_id==731 | e_id==779 | e_id==990 | e_id==1199 | e_id==1225 | e_id==1239 | e_id==1244 | e_id==1267 | e_id==1278 | e_id==1282 | e_id==1355 | e_id==1382 | e_id==1526 | e_id==1529  | e_id==1552 | e_id==1569 |e_id==1572 | e_id==1667 | e_id==1704 | e_id==1707 | e_id==1712 | e_id==1736 | e_id==1740 | e_id==2016 | e_id==2038 | e_id==2045 | e_id==2175 | e_id==2275 | e_id==2286 | e_id==2324 | e_id==2349 | e_id==2409 | e_id==2419 | e_id==2512 | e_id==2526 | e_id==2690 | e_id==2901 | e_id==3023 | e_id==3083 | e_id==3088 | e_id==3090 | e_id==3091 | e_id==3167 | e_id==3204 | e_id==3285 | e_id==3293 | e_id==3301 | e_id==3313 | e_id==3393 | e_id==3467 | e_id==3526 | e_id==3680 | e_id==3685 | e_id==3687 | e_id==3728 | e_id==3734 | e_id==3810 | e_id==3814 | e_id==4008 | e_id==4014 | e_id==4024 | e_id==4093 | e_id==4356 | e_id==4370 | e_id==4373 | e_id==4398 | e_id==4430 | e_id==4438 | e_id==4462 | e_id==4463 | e_id==4470 | e_id==4498 | e_id==4520 | e_id==4522 | e_id==4536 | e_id==4542 | e_id==4546 | e_id==4699 | e_id==4722 | e_id==4739 | e_id==4870 | e_id==4899 | e_id==5023 | e_id==5085 | e_id==5087 | e_id==5098 | e_id==5334 | e_id==5461 | e_id==5621 | e_id==5646 | e_id==5708 | e_id==5737 | e_id==5739 | e_id==5834 | e_id==5838 | e_id==5859 | e_id==5860 | e_id==5863 | e_id==5881 | e_id==6095 | e_id==6096 | e_id==6100 | e_id==6102 | e_id==6111 | e_id==6112 | e_id==6118 | e_id==6120 | e_id==6126 | e_id==6127 | e_id==6134 | e_id==6140 | e_id==6215 | e_id==6266 | e_id==6300 | e_id==6386 | e_id==6400 | e_id==6403 | e_id==6740 | e_id==6771 | e_id==7131 | e_id==7133 | e_id==7140 | e_id==7164 | e_id==7180 | e_id==7181 | e_id==7187 | e_id==7303 | e_id==7380 | e_id==7386 | e_id==7393 | e_id==7504 | e_id==7532 | e_id==7655 | e_id==7781 | e_id==7784 | e_id==7860 | e_id==7863 | e_id==7866 | e_id==7871 | e_id==7888 | e_id==8056 | e_id==8060 | e_id==8096 | e_id==8134 | e_id==8146 | e_id==8179 | e_id==8234 | e_id==8240 | e_id==8241 | e_id==8251 | e_id==8255 | e_id==8265 | e_id==8271 | e_id==8304 | e_id==8306 | e_id==8353 | e_id==8357 | e_id==8387 | e_id==8389 | e_id==8395 | e_id==8412 | e_id==8602 | e_id==8668 | e_id==8673 | e_id==8768 | e_id==8846 | e_id==8883 | e_id==8974 | e_id==8976 | e_id==9224 | e_id==9226 | e_id==9237 | e_id==9241 | e_id==9243 | e_id==9245 | e_id==9246 | e_id==9247 | e_id==9314 | e_id==9324 | e_id==9363 | e_id==9480 | e_id==9483 | e_id==9492 | e_id==9539 | e_id==9588 | e_id==9736 | e_id==9754 | e_id==9771 | e_id==9790 | e_id==9819 | e_id==9866 | e_id==9893 | e_id==9908 | e_id==9912 | e_id==9922 | e_id==9954 | e_id==9957 | e_id==10189 | e_id==10196 | e_id==10204 | e_id==10214 | e_id==10215 | e_id==10218| e_id==10219 | e_id==10220 | e_id==10221 | e_id==10227 | e_id==10280 | e_id==10294 | e_id==10327 | e_id==10357 | e_id==10367 | e_id==10384 | e_id==10520 | e_id==10615 | e_id==10824 | e_id==10983 | e_id==11013 | e_id==11172 | e_id==11215 | e_id==11255 | e_id==11287  | e_id==11297 | e_id==11382 | e_id==11726 | e_id==11730 | e_id==11731 | e_id==11775 | e_id==11796 | e_id==11803 | e_id==11859 | e_id==11883 | e_id==11914 | e_id==12135 | e_id==12136 | e_id==12331 | e_id== 12446 | e_id==12447 | e_id==12452 | e_id==12494 | e_id==12544 | e_id==12603 | e_id==12680 | e_id==12719 | e_id==12741 | e_id==12768 | e_id==12812)
replace v4 = 0 if missing(v4)
replace v4 = . if missing(cadre_code)
tab v4
codebook e_id if v4==1

label variable v3 "=1Shows id for which we do not have enough info under ICD"
label variable v4 "=1Shows id for which we do not have enough info for all case under that id"

sort e_id cadre_code

**Generating a split cadre code**

gen splitcadrecode = cadre_code

replace splitcadrecode = 13 if v3==0 & (office=="Kerala" | office=="Thiruvananthapuram / Trivandrum" | office == "Kannur" | office == "Kozhikode" | office == "SC & ST Dev Deptt")
replace splitcadrecode = 27 if v3==0 & (office=="Uttar Pradesh" | office == "Medical" | office =="Ghaziabad" | office =="Gautam Budh Nagar" | office == "Ghazipur" | office =="Housing Deptt" | office == "Lucknow" | office == "Jaunpur" | office == "Jaunpur" | office == "Gorakhpur Dev Auth")
replace splitcadrecode = 4  if v3==0 & (office=="Bihar" | office == "Sitamarhi" | office == "Patna" | office == "Bhojpur" | office == "Home Deptt" | office == "Gaya" | (office == "Ranchi" & St_dt < 2000) | (office == "Gumala" & St_dt < 2000))
replace splitcadrecode = 7  if v3==0 & (office=="Gujarat" | office=="Sabarkantha"|  office =="Gandhinagar" | office=="Ahmedabad")
replace splitcadrecode = 1  if v3==0 & (office == "Andhra Pradesh" | office=="Krishna" | office=="Government of Andhra Pradesh" | office == "AP Industrial Infrastructure Dev Corpn Ltd (APIIC)" | (office=="Hyderabad" & St_dt < 2014) | office == "Power Deptt" | office == "Narsipatnam" | office == "Vishakapatnam" | office == "Chennai" | office == "State Warehousing Corpn" | office == "Rytu Bazaar" | office == "Public Deptt" | office == "General Admin Deptt")
replace splitcadrecode = 24  if v3==0 & (office=="Tamil Nadu" | office == "Adi Dravidar Housing & Dev Corpn" | office == "Salem") 
replace splitcadrecode = 15  if v3==0 & (office=="Maharashtra" | office == "Pune" | office=="Washim" | office=="Tribal Dev Deptt" | office=="Nagpur" | office == "Mumbai City" | office == "Aligarh" | office == "Development of Women & Children")
replace splitcadrecode = 25  if v3==0 & (office=="Hyderabad" & St_dt >= 2014)
replace splitcadrecode = 12  if v3==0 & (office=="Karnataka" | office =="Brussels (Belgium)" | office == "Raichur" | office == "Bangalore" | office == "Bangalore Metropolitan Tpt Corpn (BMTC)" | office == "Urban Development")
replace splitcadrecode = 14  if v3==0 & (office=="Madhya Pradesh" | office == "Chitrakoot" | office=="Satna" | office == "Shajapur" | office == "Dhar")
replace splitcadrecode = 20  if v3==0 & (office=="Odisha" | office == "Govt of Orissa" | office == "Orissa Silk Society")
replace splitcadrecode = 22  if v3==0 & (office=="Udaipur" | office == "Rajasthan" | office == "Governor's Office")
replace splitcadrecode = 29  if v3==0 & (office=="West Bengal" | office == "Howrah" )
replace splitcadrecode = 28  if v3==0 & (office=="Uttaranchal" | office == "Haridwar" | office == "Mussorie, Dehradun Dev Auth")
replace splitcadrecode = 10  if v3==0 & (office=="J&K State" | office == "Jammu")
replace splitcadrecode = 23  if v3==0 & office=="Sikkim"
replace splitcadrecode = 21  if v3==0 & (office=="Punjab" | office=="Roop Nagar" | office == "Kapurthala" | office == "Bhatinda" | office == "State Industrial Dev Corpn" | office =="Punjab State Electronic Corpn" | office == "Small Ind & Export Corp")
replace splitcadrecode = 11  if v3==0 & (office=="Jharkhand" | office=="Giridih" | (office=="Ranchi" & St_dt >= 2000) | office=="Ramgarh" | office=="Sahibganj" | office=="Dhanbad" | office=="School Edu Deptt"  | office == "Dhanbad" | (office == "Gumala" & St_dt >= 2000) | office == "Dumka" | office == "Pakur" | office == "Simdega" | office == "Ranchi Municipal Corpn" | office == "D/o Urban Dev")
replace splitcadrecode = 8  if v3==0 & (office=="Haryana" | office == "Panchkula" | office == "Panchkula & Shri Mata Mansa Devi Shrine Bd")

order cadre v1 v2 v3 v4 cadre_code splitcadrecode 

replace splitcadrecode = . if (v3 == 0 & splitcadrecode == cadre_code & office != "Maharashtra" & office != "Dhar" & office != "Shajapur" & office != "Punjab State Electronic Corpn"& office != "Salem") //Replacing split cadre code to null for those who we have info for and split adre code is a cadre code and even under ICD their state hae not changed//

replace splitcadrecode = . if (office == "Chandighar" & v3==0 ) // Replacing Split cadre code to null if we have proper info but the place is chandighar because that is an UT //

replace splitcadrecode = . if (cadre_code==2 | cadre_code==3 | cadre_code==16 | cadre_code==17 | cadre_code==26) //Replacing split cadre code to null for north east states//

replace splitcadrecode = . if v3 ==1 //Replacing split cadre code to null for which we do not have proper info//

order e_id St_dt cadre_code splitcadrecode identifier gender category_of_experience office reference_value
sort e_id identifier St_dt


**Defining start month of employment from the start date of employment**
generate start_dt = date( start_date , "YMD")
format start_dt %td
gen s_month=month(start_dt)
order e_id St_dt s_month

save "$experience\IAS experience_cleaned.dta", replace

***************************************************

//Merge using panel data frame with the Experience data set  //

use "$experience\MPanel Frame.dta",clear
merge 1:m e_id St_dt s_month using "$experience\IAS experience_cleaned.dta"
drop if _merge == 2
gen year = St_dt
gen S_month = s_month
replace St_dt = . if identifier == .
replace S_month = . if identifier == .
rename s_month month
order Count e_id year
sort Count e_id year month
order Count e_id year month St_dt S_month cadre_code

//Generating Tenure//
bysort e_id: egen S = min(St_dt)
bysort e_id: egen E = max(End_dt)
gen tenure = year-S
order Count e_id year month St_dt S_month cadre_code splitcadrecode identifier allotment_year tenure
replace tenure = . if allotment_year == .

//Making Variables of Interest continious//
bysort e_id: replace identifier = identifier[_n-1] if (missing(identifier) & year<=E & year>=S)
replace category_of_experience=category_of_experience[_n-1] if missing(category_of_experience)
replace category_of_experience = "" if identifier == .
replace cadre_code = cadre_code[_n-1] if (missing( cadre_code ) &year<=E & year>=S)
replace id = id[_n-1] if (missing(id) &year<=E & year>=S)
replace splitcadrecode = splitcadrecode[_n-1] if (missing(splitcadrecode) &year<=E & year>=S )
replace splitcadrecode = . if v3 == 1
replace allotment_year = allotment_year[_n-1] if (missing(allotment_year) &year<=E & year>=S)
replace gender = gender[_n-1] if (missing(gender) &year<=E & year>=S)
replace cadre = cadre[_n-1] if (missing(cadre) &year<=E & year>=S)
replace level = level[_n-1] if (missing(level) &year<=E & year>=S)
replace organisation = organisation[_n-1] if (missing(organisation) &year<=E & year>=S & organisation != "Cadre (Inter-Cadre Deputation)")
replace organisation = "" if (missing(St_dt) & organisation == "Cadre (Inter-Cadre Deputation)")
replace tenure = tenure[_n-1] if (missing(tenure) &year<=E & year>=S)

//Creating Organization dummy//

gen org_dum=1 if organisation== "Cadre (AIS)" | organisation=="Cadre (Deputation under Rule 6(2)(ii)"  | organisation== "Cadre (Ex-Cadre)" | organisation== "Cadre (Foreign Posting)" | organisation== "Cadre (Foreign Training)"  | organisation=="Cadre (Inter-Cadre Deputation)"  | organisation=="Cadre (Non-AIS)"   | organisation=="Cadre (PSU)"  | organisation=="Cadre (Study Leave)"   | organisation=="Cadre(Domestic Training)" | organisation== "Cadre(Extension of inter cadre deputation)"
replace org_dum=0 if org_dum!=1 & missing(org_dum)
replace org_dum=. if organisation==""
label define cadre_ias 0 "Central Cadre" 1 "state cadre"
label values org_dum cadre_ias

//Generating Transfer dummies on th basis of category of importance and Inter cadre deputation//

bysort e_id : gen trans_dum_1=.
bysort e_id : replace trans_dum_1 = 1 if ((allotment_year <= year & month == S_month & year == St_dt & category_of_experience!= category_of_experience[_n-1]) | (organisation=="Cadre (Inter-Cadre Deputation)" & !missing(St_dt)))
bysort e_id : replace trans_dum_1=0 if (allotment_year<= year & missing(trans_dum_1) &year<=E & year>=S )
bysort e_id : replace trans_dum_1= . if allotment_year > year
label variable trans_dum_1 "Transfer atleast once in a particular year"

order Count e_id year month St_dt S_month cadre_code splitcadrecode identifier allotment_year trans_dum_1 tenure gender category_of_experience  organisation org_dum
/*
duplicates tag Count , gen (dup)
tab dup
sort Count e_id year

bysort e_id: gen trans_dum_2=.
bysort e_id: replace trans_dum_2=1 if (dup>0 & St_dt[_n]== St_dt[_n-1])
label variable trans_dum_2 "Transfer more than in a particular year"

order Count e_id year St_dt cadre_code identifier allotment_year trans_dum_1 tenure gender category_of_experience  organisation
sort Count e_id year
by Count : gen S_2=sum(trans_dum_2) if dup > 1
order Count e_id year month St_dt S_month cadre_code splitcadrecode e_id year St_dt org_dum identifier allotment_year trans_dum_1 trans_dum_2

//Dropping duplicates//
drop  if (dup==11 & missing(trans_dum_2))
drop  if (dup==12 & (S_2==0 | S_2==1))
drop  if (dup==13 & (S_2==0 | S_2==1 | S_2==2))
drop  if (dup==14 & (S_2==0 | S_2==1 | S_2==2 | S_2==3))
drop  if (dup==15 & (S_2==0 | S_2==1 | S_2==2 | S_2==3 | S_2==4))
drop  if (dup==16 & (S_2==0 | S_2==1 | S_2==2 | S_2==3 | S_2==4 | S_2==5))
drop  if (dup==17 & (S_2==0 | S_2==1 | S_2==2 | S_2==3 | S_2==4 | S_2==5 | S_2==6))
drop  if (dup==18 & (S_2==0 | S_2==1 | S_2==2 | S_2==3 | S_2==4 | S_2==5 | S_2==6 | S_2==7))
drop  if (dup==19 & (S_2==0 | S_2==1 | S_2==2 | S_2==3 | S_2==4 | S_2==5 | S_2==6 | S_2==7 | S_2==8))
*/

bysort e_id : replace trans_dum_1 = 1 if ((allotment_year<= year & month == S_month & St_dt== year & category_of_experience!= category_of_experience[_n-1]) | (organisation=="Cadre (Inter-Cadre Deputation)" & !missing(St_dt)))
replace trans_dum_1 = . if allotment_year >  year
drop if tenure<0


/*
replace trans_dum_2 = . if allotment_year >  year
replace trans_dum_2=0 if trans_dum_1 != trans_dum_2

//Cheking if any duplicates left//
drop dup
duplicates tag Count , gen (dup)
tab dup
drop dup
*/


// Grouping levels of IAS officers//

gen level_dum = .
replace level_dum = 1 if (level == "Secretary" | level == "Secretary Equivalent" | level == "Above Secretary Level" | level == "Cabinet Secretary") 

replace level_dum = 2 if (level == "Additional Secretary" | level == "Additional Secretary Equivalent" | level == "Joint Secretary" | level == "Joint Secretary Equivalent" )

replace level_dum = 3 if (level == "Deputy Secretary" | level == "Deputy Secretary Equivalent" | level == "Director" | level == "Director Equivalent")

replace level_dum = 4 if (level == "Under Secretary" | level == "Under Secretary Equivalent")

replace level_dum = 5 if (level == "Apex Scale" | level == "HAG +" | level == "Higher Administrative Grade" | level == "Senior Administrative Grade" | level == "Senior Time Scale")

replace level_dum = 6 if (level == "Junior Administrative Grade (Ordinary Grade)" | level == "Junior Administrative Grade (Selection Grade)" | level == "Junior Scale" | level == "Other Scales")

label define level_ias 1 "Secretary and Above" 2 "Additional And Joint Secretaries" 3 "Deputy Secretary & director" 4 "Under Secretary" 5 "Higher Grades" 6 "Junior Grades"
label values level_dum level_ias

// Generating level dummy//
gen secretary_dum = 1 if level_dum == 1
replace secretary_dum =0 if level_dum !=1 
replace secretary_dum =. if level_dum == .

gen AJSecr_dum = 1 if level_dum == 2
replace AJSecr_dum =0 if level_dum !=2 
replace AJSecr_dum =. if level_dum == .

gen dsrecdir_dum = 1 if level_dum == 3
replace dsrecdir_dum =0 if level_dum !=3 
replace dsrecdir_dum =. if level_dum == .

gen usecr_dum = 1 if level_dum == 4
replace usecr_dum =0 if level_dum !=4 
replace usecr_dum =. if level_dum == .

gen highgr_dum = 1 if level_dum == 5
replace highgr_dum =0 if level_dum !=5 
replace highgr_dum =. if level_dum == .

gen jungr_dum = 1 if level_dum == 6
replace jungr_dum =0 if level_dum !=6 
replace jungr_dum =. if level_dum == .



//Transfer on the basis of level importance//

bysort e_id : gen trans_imp_high = .
bysort e_id : replace trans_imp_high = 1 if (level_dum < level_dum[_n-1] & !missing(St_dt))
bysort e_id : replace trans_imp_high = 0 if (level_dum >= level_dum[_n-1] & !missing(St_dt))
bysort e_id : replace trans_imp_high = 0 if (missing(trans_imp_high) &year<=E & year>=S )
replace trans_imp_high = . if allotment_year >  year
label variable trans_imp_high "Transfer to level of higher importance"

bysort e_id : gen trans_imp_same = .
bysort e_id : replace trans_imp_same = 1 if (level_dum == level_dum[_n-1] & !missing(St_dt))
bysort e_id : replace trans_imp_same = 0 if (level_dum != level_dum[_n-1] & !missing(St_dt))
bysort e_id : replace trans_imp_same = 0 if (missing(trans_imp_same) &year<=E & year>=S )
replace trans_imp_same = . if allotment_year >  year
label variable trans_imp_same "Transfer to level of similar importance"


//Finding total number of transfers//
bysort e_id: gen ntrans = sum(trans_dum_1)
bysort e_id: egen Ntrans = max(ntrans)
replace ntrans = . if trans_dum_1 == .
replace Ntrans = . if trans_dum_1 == .
label variable Ntrans "Total Number of transfer for a particular person in a year atleast once" 


//Finding total number of transfers to higher post//
bysort e_id: gen ntrans_high = sum(trans_imp_high)
bysort e_id: egen Ntrans_high = max(ntrans_high)
replace ntrans_high = . if trans_dum_1 == .
replace Ntrans_high = . if trans_dum_1 == .
label variable Ntrans "Total Number of transfer in a higher post for a particular person"

** Where V5 shows all the indudisuals observations who atleast once in their career had experienced ICD**
gen v5 = .
replace v5 = 1 if id == "AM007700"
replace v5 = 1 if id == "AM008700"
replace v5 = 1 if id == "AM008900"
replace v5 = 1 if id == "AM011600"
replace v5 = 1 if id == "AM012300"
replace v5 = 1 if id == "AM012400"
replace v5 = 1 if id == "AM014901"
replace v5 = 1 if id == "AM016701"
replace v5 = 1 if id == "AM017100"
replace v5 = 1 if id == "AM017200"
replace v5 = 1 if id == "AM017900"
replace v5 = 1 if id == "AM018300"
replace v5 = 1 if id == "AM018500"
replace v5 = 1 if id == "AM019000"
replace v5 = 1 if id == "AM019800"
replace v5 = 1 if id == "AM020300"
replace v5 = 1 if id == "AM021600"
replace v5 = 1 if id == "AM022400"
replace v5 = 1 if id == "AM022500"
replace v5 = 1 if id == "AM023400"
replace v5 = 1 if id == "AM023500"
replace v5 = 1 if id == "AM024700"
replace v5 = 1 if id == "AM024900"
replace v5 = 1 if id == "AM025200"
replace v5 = 1 if id == "AM025300"
replace v5 = 1 if id == "AM025600"
replace v5 = 1 if id == "AM026200"
replace v5 = 1 if id == "AM027700"
replace v5 = 1 if id == "AM028300"
replace v5 = 1 if id == "AM028500"
replace v5 = 1 if id == "AM028900"
replace v5 = 1 if id == "AM029200"
replace v5 = 1 if id == "AM029400"
replace v5 = 1 if id == "AM030000"
replace v5 = 1 if id == "AM108C02"
replace v5 = 1 if id == "AM109C06"
replace v5 = 1 if id == "AP004800"
replace v5 = 1 if id == "AP009300"
replace v5 = 1 if id == "AP012000"
replace v5 = 1 if id == "AP013200"
replace v5 = 1 if id == "AP023900"
replace v5 = 1 if id == "AP025200"
replace v5 = 1 if id == "AP025300"
replace v5 = 1 if id == "AP028300"
replace v5 = 1 if id == "AP033705"
replace v5 = 1 if id == "AP035900"
replace v5 = 1 if id == "AP038100"
replace v5 = 1 if id == "AP042402"
replace v5 = 1 if id == "AP108B05"
replace v5 = 1 if id == "BH016700"
replace v5 = 1 if id == "BH017503"
replace v5 = 1 if id == "BH019100"
replace v5 = 1 if id == "BH021501"
replace v5 = 1 if id == "BH022200"
replace v5 = 1 if id == "BH024200"
replace v5 = 1 if id == "BH025800"
replace v5 = 1 if id == "BH026600"
replace v5 = 1 if id == "BH030800"
replace v5 = 1 if id == "BH031300"
replace v5 = 1 if id == "BH032800"
replace v5 = 1 if id == "BH036900"
replace v5 = 1 if id == "BH038300"
replace v5 = 1 if id == "BH038500"
replace v5 = 1 if id == "BH039200"
replace v5 = 1 if id == "BH039800"
replace v5 = 1 if id == "BH041101"
replace v5 = 1 if id == "BH041600"
replace v5 = 1 if id == "BH042400"
replace v5 = 1 if id == "BH043200"
replace v5 = 1 if id == "BH045800"
replace v5 = 1 if id == "BH048400"
replace v5 = 1 if id == "BH048700"
replace v5 = 1 if id == "BH049200"
replace v5 = 1 if id == "BH050100"
replace v5 = 1 if id == "BH051700"
replace v5 = 1 if id == "BH052100"
replace v5 = 1 if id == "CG017400"
replace v5 = 1 if id == "CG032313"
replace v5 = 1 if id == "CG035801"
replace v5 = 1 if id == "CG038311"
replace v5 = 1 if id == "CG049000"
replace v5 = 1 if id == "CG049800"
replace v5 = 1 if id == "GJ003900"
replace v5 = 1 if id == "GJ007000"
replace v5 = 1 if id == "GJ007100"
replace v5 = 1 if id == "GJ010300"
replace v5 = 1 if id == "GJ010900"
replace v5 = 1 if id == "GJ013900"
replace v5 = 1 if id == "GJ019200"
replace v5 = 1 if id == "GJ019700"
replace v5 = 1 if id == "GJ020000"
replace v5 = 1 if id == "GJ020100"
replace v5 = 1 if id == "GJ024900"
replace v5 = 1 if id == "GJ026200"
replace v5 = 1 if id == "GJ029600"
replace v5 = 1 if id == "GJ032500"
replace v5 = 1 if id == "GJ032700"
replace v5 = 1 if id == "GJ033700"
replace v5 = 1 if id == "HP002200"
replace v5 = 1 if id == "HP010800"
replace v5 = 1 if id == "HP012300"
replace v5 = 1 if id == "HP014000"
replace v5 = 1 if id == "HP014500"
replace v5 = 1 if id == "HP014600"
replace v5 = 1 if id == "HP014700"
replace v5 = 1 if id == "HP014800"
replace v5 = 1 if id == "HP811010"
replace v5 = 1 if id == "HY012400"
replace v5 = 1 if id == "HY013300"
replace v5 = 1 if id == "HY013400"
replace v5 = 1 if id == "HY014700"
replace v5 = 1 if id == "HY015400"
replace v5 = 1 if id == "HY016900"
replace v5 = 1 if id == "HY018200"
replace v5 = 1 if id == "HY019300"
replace v5 = 1 if id == "HY019400"
replace v5 = 1 if id == "HY020612"
replace v5 = 1 if id == "HY021100"
replace v5 = 1 if id == "HY022100"
replace v5 = 1 if id == "HY023300"
replace v5 = 1 if id == "HY023800"
replace v5 = 1 if id == "JH021510"
replace v5 = 1 if id == "JH023200"
replace v5 = 1 if id == "JH025100"
replace v5 = 1 if id == "JH025600"
replace v5 = 1 if id == "JH037617"
replace v5 = 1 if id == "JH038100"
replace v5 = 1 if id == "JH039600"
replace v5 = 1 if id == "JH040300"
replace v5 = 1 if id == "JH042426"
replace v5 = 1 if id == "JH042435"
replace v5 = 1 if id == "JH048900"
replace v5 = 1 if id == "JH049500"
replace v5 = 1 if id == "JK002100"
replace v5 = 1 if id == "JK002500"
replace v5 = 1 if id == "JK003300"
replace v5 = 1 if id == "JK006900"
replace v5 = 1 if id == "JK009700"
replace v5 = 1 if id == "JK010400"
replace v5 = 1 if id == "KL007102"
replace v5 = 1 if id == "KL011000"
replace v5 = 1 if id == "KL011900"
replace v5 = 1 if id == "KL012200"
replace v5 = 1 if id == "KL013700"
replace v5 = 1 if id == "KL015705"
replace v5 = 1 if id == "KL016500"
replace v5 = 1 if id == "KL016900"
replace v5 = 1 if id == "KL017000"
replace v5 = 1 if id == "KL018300"
replace v5 = 1 if id == "KL019000"
replace v5 = 1 if id == "KL019001"
replace v5 = 1 if id == "KL019401"
replace v5 = 1 if id == "KL020700"
replace v5 = 1 if id == "KL021200"
replace v5 = 1 if id == "KL021500"
replace v5 = 1 if id == "KL022300"
replace v5 = 1 if id == "KL022800"
replace v5 = 1 if id == "KL023300"
replace v5 = 1 if id == "KN008100"
replace v5 = 1 if id == "KN010500"
replace v5 = 1 if id == "KN014600"
replace v5 = 1 if id == "KN023600"
replace v5 = 1 if id == "KN025014"
replace v5 = 1 if id == "KN031200"
replace v5 = 1 if id == "KN034500"
replace v5 = 1 if id == "KN035200"
replace v5 = 1 if id == "KN035400"
replace v5 = 1 if id == "KN109K01"
replace v5 = 1 if id == "MH015900"
replace v5 = 1 if id == "MH017000"
replace v5 = 1 if id == "MH029300"
replace v5 = 1 if id == "MH034000"
replace v5 = 1 if id == "MH037800"
replace v5 = 1 if id == "MH039700"
replace v5 = 1 if id == "MH041800"
replace v5 = 1 if id == "MH043200"
replace v5 = 1 if id == "MH043202"
replace v5 = 1 if id == "MH045700"
replace v5 = 1 if id == "MH045900"
replace v5 = 1 if id == "MH046101"
replace v5 = 1 if id == "MH046700"
replace v5 = 1 if id == "MH047201"
replace v5 = 1 if id == "MH048200"
replace v5 = 1 if id == "MH048500"
replace v5 = 1 if id == "MH108N05"
replace v5 = 1 if id == "MN011100"
replace v5 = 1 if id == "MN011400"
replace v5 = 1 if id == "MN012600"
replace v5 = 1 if id == "MN013400"
replace v5 = 1 if id == "MN014800"
replace v5 = 1 if id == "MN015800"
replace v5 = 1 if id == "MN015900"
replace v5 = 1 if id == "MN017800"
replace v5 = 1 if id == "MN018200"
replace v5 = 1 if id == "MN018700"
replace v5 = 1 if id == "MN019700"
replace v5 = 1 if id == "MN019900"
replace v5 = 1 if id == "MN020700"
replace v5 = 1 if id == "MN020900"
replace v5 = 1 if id == "MN021300"
replace v5 = 1 if id == "MN021700"
replace v5 = 1 if id == "MN112O06"
replace v5 = 1 if id == "MP010600"
replace v5 = 1 if id == "MP013700"
replace v5 = 1 if id == "MP015800"
replace v5 = 1 if id == "MP021100"
replace v5 = 1 if id == "MP022800"
replace v5 = 1 if id == "MP027900"
replace v5 = 1 if id == "MP029001"
replace v5 = 1 if id == "MP029300"
replace v5 = 1 if id == "MP044200"
replace v5 = 1 if id == "MP044300"
replace v5 = 1 if id == "MP044302"
replace v5 = 1 if id == "MP047000"
replace v5 = 1 if id == "MP049500"
replace v5 = 1 if id == "MT003000"
replace v5 = 1 if id == "MT003800"
replace v5 = 1 if id == "MT004400"
replace v5 = 1 if id == "MT004500"
replace v5 = 1 if id == "MT005100"
replace v5 = 1 if id == "MT006100"
replace v5 = 1 if id == "MT007400"
replace v5 = 1 if id == "MT007500"
replace v5 = 1 if id == "MT009100"
replace v5 = 1 if id == "MT009500"
replace v5 = 1 if id == "MT010000"
replace v5 = 1 if id == "MT012200"
replace v5 = 1 if id == "MT015400"
replace v5 = 1 if id == "NL001800"
replace v5 = 1 if id == "NL005300"
replace v5 = 1 if id == "NL005900"
replace v5 = 1 if id == "NL007200"
replace v5 = 1 if id == "NL108P02"
replace v5 = 1 if id == "NL111P04"
replace v5 = 1 if id == "OR010200"
replace v5 = 1 if id == "OR013300"
replace v5 = 1 if id == "OR021200"
replace v5 = 1 if id == "OR021500"
replace v5 = 1 if id == "OR022900"
replace v5 = 1 if id == "OR023300"
replace v5 = 1 if id == "OR024200"
replace v5 = 1 if id == "OR024500"
replace v5 = 1 if id == "OR027500"
replace v5 = 1 if id == "OR027700"
replace v5 = 1 if id == "OR027901"
replace v5 = 1 if id == "OR028201"
replace v5 = 1 if id == "PB006000"
replace v5 = 1 if id == "PB006500"
replace v5 = 1 if id == "PB009100"
replace v5 = 1 if id == "PB009600"
replace v5 = 1 if id == "PB013106"
replace v5 = 1 if id == "PB013900"
replace v5 = 1 if id == "PB014500"
replace v5 = 1 if id == "PB014900"
replace v5 = 1 if id == "PB015800"
replace v5 = 1 if id == "PB016200"
replace v5 = 1 if id == "PB016800"
replace v5 = 1 if id == "PB016900"
replace v5 = 1 if id == "PB017300"
replace v5 = 1 if id == "PB017400"
replace v5 = 1 if id == "PB018200"
replace v5 = 1 if id == "PB018211"
replace v5 = 1 if id == "PB018300"
replace v5 = 1 if id == "PB018611"
replace v5 = 1 if id == "PB018800"
replace v5 = 1 if id == "PB019016"
replace v5 = 1 if id == "PB019500"
replace v5 = 1 if id == "PB019600"
replace v5 = 1 if id == "PB020700"
replace v5 = 1 if id == "PB021100"
replace v5 = 1 if id == "PB021900"
replace v5 = 1 if id == "PB022101"
replace v5 = 1 if id == "PB022700"
replace v5 = 1 if id == "PB024700"
replace v5 = 1 if id == "PB024702"
replace v5 = 1 if id == "PB108T02"
replace v5 = 1 if id == "PB112R03"
replace v5 = 1 if id == "PB94A301"
replace v5 = 1 if id == "RJ013300"
replace v5 = 1 if id == "RJ018600"
replace v5 = 1 if id == "RJ018803"
replace v5 = 1 if id == "RJ022604"
replace v5 = 1 if id == "RJ026800"
replace v5 = 1 if id == "RJ027803"
replace v5 = 1 if id == "RJ032100"
replace v5 = 1 if id == "RJ033200"
replace v5 = 1 if id == "RJ033400"
replace v5 = 1 if id == "SK001500"
replace v5 = 1 if id == "SK003500"
replace v5 = 1 if id == "SK004200"
replace v5 = 1 if id == "SK004500"
replace v5 = 1 if id == "SK004600"
replace v5 = 1 if id == "SK004700"
replace v5 = 1 if id == "SK005300"
replace v5 = 1 if id == "TG035800"
replace v5 = 1 if id == "TG037700"
replace v5 = 1 if id == "TG042700"
replace v5 = 1 if id == "TN006500"
replace v5 = 1 if id == "TN006900"
replace v5 = 1 if id == "TN008300"
replace v5 = 1 if id == "TN013400"
replace v5 = 1 if id == "TN017900"
replace v5 = 1 if id == "TN020900"
replace v5 = 1 if id == "TN029113"
replace v5 = 1 if id == "TN030400"
replace v5 = 1 if id == "TN031500"
replace v5 = 1 if id == "TN032400"
replace v5 = 1 if id == "TN033600"
replace v5 = 1 if id == "TN034100"
replace v5 = 1 if id == "TN037200"
replace v5 = 1 if id == "TN038600"
replace v5 = 1 if id == "TN039300"
replace v5 = 1 if id == "TN039401"
replace v5 = 1 if id == "TN040100"
replace v5 = 1 if id == "TN040300"
replace v5 = 1 if id == "TN109U05"
replace v5 = 1 if id == "TN109U08"
replace v5 = 1 if id == "TR007800"
replace v5 = 1 if id == "TR009400"
replace v5 = 1 if id == "TR011500"
replace v5 = 1 if id == "TR012100"
replace v5 = 1 if id == "TR012800"
replace v5 = 1 if id == "TR013200"
replace v5 = 1 if id == "TR013800"
replace v5 = 1 if id == "TR014700"
replace v5 = 1 if id == "TR015000"
replace v5 = 1 if id == "TR016900"
replace v5 = 1 if id == "TR017000"
replace v5 = 1 if id == "TR020100"
replace v5 = 1 if id == "TR020600"
replace v5 = 1 if id == "TR020800"
replace v5 = 1 if id == "TR021000"
replace v5 = 1 if id == "TR021200"
replace v5 = 1 if id == "TR021600"
replace v5 = 1 if id == "TR021900"
replace v5 = 1 if id == "TR108O01"
replace v5 = 1 if id == "TR111O04"
replace v5 = 1 if id == "UD025700"
replace v5 = 1 if id == "UD040500"
replace v5 = 1 if id == "UD051516"
replace v5 = 1 if id == "UD055014"
replace v5 = 1 if id == "UD055211"
replace v5 = 1 if id == "UD059700"
replace v5 = 1 if id == "UD060017"
replace v5 = 1 if id == "UD066200"
replace v5 = 1 if id == "UD067400"
replace v5 = 1 if id == "UD108W01"
replace v5 = 1 if id == "UP024300"
replace v5 = 1 if id == "UP033400"
replace v5 = 1 if id == "UP034200"
replace v5 = 1 if id == "UP043700"
replace v5 = 1 if id == "UP043900"
replace v5 = 1 if id == "UP044400"
replace v5 = 1 if id == "UP047300"
replace v5 = 1 if id == "UP048300"
replace v5 = 1 if id == "UP056000"
replace v5 = 1 if id == "UP056500"
replace v5 = 1 if id == "UP057100"
replace v5 = 1 if id == "UP057623"
replace v5 = 1 if id == "UP059200"
replace v5 = 1 if id == "UP060919"
replace v5 = 1 if id == "UP062044"
replace v5 = 1 if id == "UP062402"
replace v5 = 1 if id == "UP062512"
replace v5 = 1 if id == "UP062514"
replace v5 = 1 if id == "UP063200"
replace v5 = 1 if id == "UP063700"
replace v5 = 1 if id == "UP065500"
replace v5 = 1 if id == "UP066100"
replace v5 = 1 if id == "UP067700"
replace v5 = 1 if id == "UP069000"
replace v5 = 1 if id == "UP069101"
replace v5 = 1 if id == "UP069301"
replace v5 = 1 if id == "UP069901"
replace v5 = 1 if id == "UP070200"
replace v5 = 1 if id == "UP070500"
replace v5 = 1 if id == "UP071100"
replace v5 = 1 if id == "UP071400"
replace v5 = 1 if id == "UP110V11"
replace v5 = 1 if id == "UP112P02"
replace v5 = 1 if id == "UP112V12"
replace v5 = 1 if id == "UP812134"
replace v5 = 1 if id == "UP929400"
replace v5 = 1 if id == "UT001700"
replace v5 = 1 if id == "UT002400"
replace v5 = 1 if id == "UT002500"
replace v5 = 1 if id == "UT008400"
replace v5 = 1 if id == "UT010500"
replace v5 = 1 if id == "UT011000"
replace v5 = 1 if id == "UT012100"
replace v5 = 1 if id == "UT014416"
replace v5 = 1 if id == "UT015100"
replace v5 = 1 if id == "UT016810"
replace v5 = 1 if id == "UT018800"
replace v5 = 1 if id == "UT025700"
replace v5 = 1 if id == "UT109A04"
replace v5 = 1 if id == "UT109A05"
replace v5 = 1 if id == "UT112A01"
replace v5 = 1 if id == "UT814404"
replace v5 = 1 if id == "WB013600"
replace v5 = 1 if id == "WB013800"
replace v5 = 1 if id == "WB013904"
replace v5 = 1 if id == "WB015000"
replace v5 = 1 if id == "WB018000"
replace v5 = 1 if id == "WB022500"
replace v5 = 1 if id == "WB026200"
replace v5 = 1 if id == "WB027900"
replace v5 = 1 if id == "WB028700"
replace v5 = 1 if id == "WB029000"
replace v5 = 1 if id == "WB030100"
replace v5 = 1 if id == "WB031800"
replace v5 = 1 if id == "WB032900"
replace v5 = 1 if id == "WB034800"
replace v5 = 1 if id == "WB036200"
replace v5 = 1 if id == "WB038700"
replace v5 = 0 if v5 == .
replace v5 = . if missing(cadre_code)
label variable v5 "Atleast 1 ICD in their whole career"

order Count cadre cadre_code splitcadrecode e_id year month St_dt S_month org_dum identifier allotment_year trans_dum_1 trans_imp_high trans_imp_same tenure gender category_of_experience organisation level_dum


save "$experience\Replication Transfer.dta", replace

clear

// For testing ICD charecteristics in regression panel//
use "$experience\Replication Transfer.dta",clear
merge m:1 id cadre using "$profile\IAS Profile subset.dta", generate(_merge_2)
sort Count e_id year month
drop if _merge_2==2

//deleting the duplicates//
duplicates tag month if  month== month[_n-1], gen(mdup)
drop if  (month== month[_n-1]) &  mdup>0

//Making Gender dummy//

gen gen_dum = .                            //Generating Gender Dummy
replace gen_dum =0 if gender == "Male"     //Dummy for Male
replace gen_dum = 1 if gender == "Female"  // Dummy for female

**Proportion of Officer posted in home cadre**

gen homecadre_dum = 1 if cadre == place_of_domicile        //Generating Home Cadre dummy
replace homecadre_dum = 0 if cadre != place_of_domicile    //Dummy for those not in Home Cadre
replace homecadre_dum = . if cadre_code == .


gen undergrad_dum = 1 if last_educ_level == 1
replace undergrad_dum = 0 if last_educ_level != 1
replace undergrad_dum = . if last_educ_level == .

gen postgrad_dum = 1 if last_educ_level == 2
replace postgrad_dum = 0 if last_educ_level != 2
replace postgrad_dum = . if last_educ_level == .

gen phd_dum = 1 if last_educ_level == 3
replace phd_dum = 0 if last_educ_level != 3
replace phd_dum = . if last_educ_level == .

gen profdegree_dum = 1 if last_educ_level == 4
replace profdegree_dum = 0 if last_educ_level != 4
replace profdegree_dum = . if last_educ_level == .

**Generating Source of recruitment dum**
gen direct_rec_dum = 1 if srec==1
replace direct_rec_dum = 0 if srec!=1
replace direct_rec_dum = . if srec == .

gen Promo_rec_dum = 1 if srec==2
replace Promo_rec_dum = 0 if srec!=2
replace Promo_rec_dum = . if srec == .

gen other_rec_dum = 1 if srec==3
replace other_rec_dum = 0 if srec!=3
replace other_rec_dum = . if srec == .

**Generating Last level dummy for an IAS Officer***
gen last_level_dum = .
replace last_level_dum = 1 if (last_level == "Secretary" | last_level == "Secretary Equivalent" | last_level == "Above Secretary Level" | last_level == "Cabinet Secretary") 

replace last_level_dum = 2 if (last_level == "Additional Secretary" | last_level == "Additional Secretary Equivalent" | last_level == "Joint Secretary" | last_level == "Joint Secretary Equivalent")

replace last_level_dum = 3 if (last_level == "Deputy Secretary" | last_level == "Deputy Secretary Equivalent" | last_level == "Director" | last_level == "Director Equivalent")

replace last_level_dum = 4 if (last_level == "Under Secretary" | last_level == "Under Secretary Equivalent")

replace last_level_dum = 5 if (last_level == "Apex Scale" | last_level == "HAG +" | last_level == "Higher Administrative Grade" | last_level == "Senior Administrative Grade" | last_level == "Senior Time Scale")

replace last_level_dum = 6 if (last_level == "Junior Administrative Grade (Ordinary Grade)" | last_level == "Junior Administrative Grade (Selection Grade)" | last_level == "Junior Scale" | last_level == "Other Scales")

replace last_level_dum = . if last_level== "Election Commissioner"

label define last_level_ias 1 "Secretary and Above" 2 "Additional And Joint Secretaries" 3 "Deputy Secretary & director" 4 "Under Secretary" 5 "Higher Grades" 6 "Junior Grades"
label values last_level_dum last_level_ias

drop _merge _merge_2

//Generating Transfer dummies on th basis of field_of_experience and Inter cadre deputation to do robustness on transfer//
replace field_of_experience=field_of_experience[_n-1] if missing(field_of_experience)
replace field_of_experience = "" if identifier == .
bysort e_id : gen trans_dum_2=.
bysort e_id : replace trans_dum_2 = 1 if ((allotment_year <= year & month == S_month & year == St_dt & field_of_experience!= field_of_experience[_n-1]) | (organisation=="Cadre (Inter-Cadre Deputation)" & !missing(St_dt)))
bysort e_id : replace trans_dum_2=0 if (allotment_year<= year & missing(trans_dum_2) &year<=E & year>=S )
bysort e_id : replace trans_dum_2= . if allotment_year > year
label variable trans_dum_2 "Transfer atleast once in a particular year based on feild of experience"

order Count cadre cadre_code splitcadrecode e_id year month St_dt S_month org_dum identifier allotment_year trans_dum_1 trans_dum_2 


save "$experience\ICD test Replication Transfer.dta", replace

clear


