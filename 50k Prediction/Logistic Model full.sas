/*
 *
 * Task code generated by SAS Studio 3.5 
 *
 * Generated on '5/2/16, 8:29 PM' 
 * Generated by 'sasdemo' 
 * Generated on server 'LOCALHOST' 
 * Generated on SAS platform 'Linux LIN X64 2.6.32-573.18.1.el6.x86_64' 
 * Generated on SAS version '9.04.01M3P06242015' 
 * Generated on browser 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.86 Safari/537.36' 
 * Generated on web client 'http://localhost:10080/SASStudio/35/main?locale=en_US&zone=GMT-04%253A00' 
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc logistic data=SALARY.Train outmodel= Salary.Model plots
    (maxpoints=none)=(roc);
	class _workclass _education _marital_status _occupation _relationship _race 
		_sex _native_country / param=glm;
	model _50k(event='>50K')=age _education_num _capital_gain _capital_loss 
		_hours_per_week _workclass _education _marital_status _occupation 
		_relationship _race _sex _native_country / link=logit 
		selection=none slentry=0.01 slstay=0.01 hierarchy=single technique=fisher;
run;


proc logistic inmodel=Salary.Model;
  score alpha= 0.01  data = Salary.test  out=Salary.Predicted;
run;
proc freq data=Salary.Predicted ; 
table  F__50K  * I__50k / out =Salary.ConfusionMatrix;
run;

proc print data =Salary.ConfusionMatrix;
run;