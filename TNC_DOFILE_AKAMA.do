
global IN "D:\Desktop\my 2022\Nature conservacy"
cd "$IN"

clear all
set more off

*loading the data*
import delimited data, clear

*Data cleaning*
*gender*
gen gender=.
replace gender=1 if gender1==1|gender2==1|gender3==1|gender4==1|gender5==1|gender6==1|gender7==1|gender8==1
replace gender=0 if gender1==2|gender2==2|gender3==2|gender4==2|gender5==2|gender6==2|gender7==2|gender8==2
label define gender 0 "female" 1 "male"
label values gender gender
fre gender
*age*
egen meange = rowmean(age1-age8)
* marital status

*livestock ownership*
replace lvsown=0 if lvsown==2
label define lvsown 0 "no" 1 "yes"
label values lvsown lvsown
fre lvsown

**sale and purchase value of farm including buildings**

sum farmsalev
sum farmbuyv

gen log_farmsalev=log(farmsalev)
gen log_farmbuyv=log(farmbuyv)


* Descriptive statistics*

sum gender age1-age8 married1-married8 hhsize educ1-educ8
asdoc sum gender age1-age8 married1-married8 hhsize educ1-educ8
*farm work*

fre farmwork1
gen farmwork=0
replace farmwork=1 if farmwork1==1
label define farmwork 0 "no" 1 "yes"
label values farmwork farmwork
fre farmwork

*nonfarm work*

fre nfarmwork1
gen nfarmwork=0
replace nfarmwork=1 if nfarmwork1==1
label define nfarmwork 0 "no" 1 "yes"
label values nfarmwork nfarmwork
fre nfarmwork

**Household has at least one member engaged in both farm and non-farm activities**
gen both_activities = farmwork1==1 & nfarmwork1==1

fre both_activities
* Calculate the probability
sum both_activities, meanonly
scalar prob_both_activities = r(mean)
**Mathematical Modeling**
* Model the expected number of households meeting the criterion in a sample of 100 randomly selected households
* Expected number = Probability of having both activities * Total number of households in the sample (100)

* Assuming we have 100 randomly selected households in your dataset

* Calculate the expected number of households meeting the criterion
scalar expected_households = prob_both_activities * 100
di expected_households
**36.230072**

