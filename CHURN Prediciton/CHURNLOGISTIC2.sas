FILENAME REFFILE "/folders/myfolders/CHURN/ChurnData2.csv" TERMSTR=CR;
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CHURN.CHURN2;
	GETNAMES=YES;
RUN;
proc sql noprint;
	select count(*) into :count from CHURN.CHURN2;
quit;
data CHURN.Train2 CHURN.Test2;
	set CHURN.CHURN2;
	retain __tmp1-__tmp%trim(&count) __nobs__ __nobs1__ __nobs2__;
	drop _i_ __seed__ __tmp1-__tmp%trim(&count);
	drop _n1_ __nobs__ __nobs1__ __nobs2__;
	array __tmp(*) __tmp1-__tmp%trim(&count);
	if (_n_=1) then
		do;			__seed__=-1;
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
							output CHURN.Train2;
						end;
					else if (__tmp(_n1_) <=__nobs2__) then
						do;
							output CHURN.Test2;
						end;end;end;
run;
PROC CONTENTS DATA=CHURN.CHURN2; RUN;
ods noproctitle;
ods graphics / imagemap=on;
proc logistic data=CHURN.Train2   plots(maxpoints=none)=roc OUTMODEL=Churn.Prediction  ;
	class gender SeniorCitizen Partner Dependents PhoneService MultipleLines 
		InternetService OnlineSecurity OnlineBackup DeviceProtection TechSupport 
		StreamingTV StreamingMovies Contract PaperlessBilling PaymentMethod / 
		param=glm;
	model Churn(event='Yes')=TotalCharges MonthlyCharges tenure gender 
		SeniorCitizen Partner Dependents PhoneService MultipleLines InternetService 
		OnlineSecurity OnlineBackup DeviceProtection TechSupport StreamingTV 
		StreamingMovies Contract PaperlessBilling PaymentMethod / link=logit lackfit
		selection=stepwise slentry=0.01 slstay=0.01 hierarchy=single technique=fisher;
run;

proc logistic inmodel=Churn.Prediction ;
  score alpha= 0.01  data = CHURN.Test2  out=churn.Predicted;
run;
 data  churn.Predicted2 ;
 set churn.Predicted;

if  P_Yes > .20 then  P_Churn ="Yes";
else P_Churn = "No";
if I_Churn = "" then P_Churn = ".";
run;

proc freq data=churn.Predicted2  ; 
table Churn * P_Churn / out = CHURN.ConfusionMatrix;
run;

proc print data =CHURN.ConfusionMatrix;
run;
  