
ods noproctitle;
ods graphics / imagemap=on;

proc logistic data=SALARY.Train outmodel= Salary.Model plots
    (maxpoints=none)=(roc);
	class _workclass _education _marital_status _occupation _relationship _race 
		_sex _native_country / param=glm;
	model _50k(event='>50K')=age _education_num _capital_gain _capital_loss 
		_hours_per_week _workclass _education _marital_status _occupation 
		_relationship _race _sex _native_country / lackfit link=logit 
		selection=stepwise slentry=0.01 slstay=0.01 hierarchy=single technique=fisher;
run;
proc logistic inmodel=Salary.Model;
  score alpha= 0.01  data = Salary.test  out=Salary.Predicted;
run;

 data   salary.predicted2 ;
 set salary.predicted;

if p__50k > .25 then  p50k =">50K";
else p50k = "<=50K";
run;




proc freq data=Salary.Predicted2 ; 
table  F__50K  * p50k / out =Salary.ConfusionMatrix;
run;

proc print data =Salary.ConfusionMatrix;
run;