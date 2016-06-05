proc freq data=Salary.PredictedSalary ; 
table  I__50k  *_50k  / out = SALARY.ConfusionMatrix;
run;

proc print data =Salary.ConfusionMatrix;
run;