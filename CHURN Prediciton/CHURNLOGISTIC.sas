FILENAME REFFILE "/folders/myfolders/CHURN/ChurnData.csv" TERMSTR=CR;

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CHURN.CHURN;
	GETNAMES=YES;
RUN;
FILENAME REFFILE "/folders/myfolders/ChurnData.csv" TERMSTR=CR;

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CHURN.CHURN;
	GETNAMES=YES;
RUN;

proc sql noprint;
	select count(*) into :count from CHURN.CHURN;
quit;

data CHURN.Train CHURN.Test;
	set CHURN.CHURN;
	retain __tmp1-__tmp%trim(&count) __nobs__ __nobs1__ __nobs2__;
	drop _i_ __seed__ __tmp1-__tmp%trim(&count);
	drop _n1_ __nobs__ __nobs1__ __nobs2__;
	array __tmp(*) __tmp1-__tmp%trim(&count);

	if (_n_=1) then
		do;
			__seed__=-1;
			__nobs__=&count;

			do _i_=1 to dim(__tmp);
				__tmp(_i_)=_i_;
			end;
			call ranperm(__seed__, of __tmp(*));
			__nobs1__=round(0.8*__nobs__);
			__nobs2__=round(0.2*__nobs__)+__nobs1__;
		end;
	_n1_=_n_;

	if (_n1_ <=dim(__tmp)) then
		do;

			if (__tmp(_n1_) > 0) then
				do;

					if (__tmp(_n1_) <=__nobs1__) then
						do;
							output CHURN.Train;
						end;
					else if (__tmp(_n1_) <=__nobs2__) then
						do;
							output CHURN.Test;
						end;
				end;
		end;
run;
PROC CONTENTS DATA=CHURN.CHURN; RUN;
%web_open_table(CHURN.CHURN);
ods noproctitle;
ods graphics / imagemap=on;
proc logistic data=CHURN.Train  plots=roc   outmodel=pout;
	class Intl_Plan VMail_Plan / param= glm;
	model Churn(event='1')= CustServ_Calls Intl_Calls Account_Length VMail_Message 
		Day_Mins Eve_Mins Night_Mins Intl_Mins Day_Calls Day_Charge Eve_Calls 
		Eve_Charge Night_Calls Night_Charge Intl_Charge Intl_Plan / lackfit
		link=logit selection=backward slstay=0.05 hierarchy=single 
		;		
run;

proc logistic inmodel=pout;
  score   data = CHURN.Test out=pred ;
run;

proc freq data=pred ; 
table Churn * I_Churn/ out = CHURN.ConfusionMatrix;
run;

proc print data =CHURN.ConfusionMatrix;
run;
  



