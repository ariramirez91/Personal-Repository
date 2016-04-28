# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 13 13:48:03 2016

@author: ariel
"""
import pandas as pd
import numpy as np
import matplotlib.pylab as plt
import statsmodels.api as sm

dataFull = pd.read_csv("TeamsOriginal.csv", sep=",") 

#print len(dataFull[1])

traindata =  dataFull[(dataFull['yearID'] >1980) & (dataFull['yearID'] < 2013) ]
#traindata =  dataFull[(dataFull['yearID'] >1995 ) & (dataFull['yearID'] < 2013) ]
#traindata =  dataFull[dataFull['yearID'] == 2014 ]
W     = traindata['W'][:, np.newaxis]          #Y 
ERA   = traindata['ERA'][:, np.newaxis]       #X1
H     = traindata['H'][:, np.newaxis]          #X2
BB    = traindata['BB'][:, np.newaxis]         #X3
R1    = traindata['R'][:, np.newaxis]          #X4
SB    = traindata['SB'][:, np.newaxis]         #X5
E     = traindata['E'][:, np.newaxis]          #X6
FP    = traindata['FP'][:, np.newaxis]       #X7
ATT   = traindata['attendance'][:, np.newaxis] #X8 
R     = traindata['R'][:, np.newaxis]          #X9
TRI   = traindata['3B'][:, np.newaxis]         #X10
DOUB  = traindata['3B'][:, np.newaxis]         #X11
HR    = traindata['HR'][:, np.newaxis]         #X12
SO    = traindata['SO'][:, np.newaxis]         #X13
AB    = traindata['AB'][:, np.newaxis]          
BA =traindata['H']/traindata['AB']             #X14
DP    = traindata['DP'][:, np.newaxis]
IPouts    = traindata['IPouts'][:, np.newaxis] #15
BBA    = traindata['BBA'][:, np.newaxis] #15
SOA    = traindata['SOA'][:, np.newaxis] #15

testdata =  dataFull[dataFull['yearID'] == 1992 ]

Wt     = testdata['W'][:, np.newaxis]
ABt     = testdata['AB'][:, np.newaxis]          
ERAt   = testdata['ERA'][:, np.newaxis]        #X2
Ht     = testdata['H'][:, np.newaxis]          #X3
BBt    = testdata['BB'][:, np.newaxis]         #X4
R1t    = testdata['R'][:, np.newaxis]          #X5
SBt    = testdata['SB'][:, np.newaxis]         #X6
Et     = testdata['E'][:, np.newaxis]          #X7
FPt    = testdata['FP'][:, np.newaxis]         #X8
ATTt   = testdata['attendance'][:, np.newaxis] #X9 
Rt     = testdata['R'][:, np.newaxis]          #X10
TRIt   = testdata['3B'][:, np.newaxis]         #X11
DOUBt  = testdata['3B'][:, np.newaxis]         #X12
HRt    = testdata['HR'][:, np.newaxis]         #X13
SOt    = testdata['SO'][:, np.newaxis]         #X14
IPOuts = testdata['IPouts'][:, np.newaxis] #15
BBAt   =testdata['BBA'][:, np.newaxis] #15

Y = W
X = np.column_stack((ERA,H,BB,R,SB,E,FP,ATT,R,TRI,DOUB,HR,SO,BA,BBA))
#X = np.column_stack((ERA))
X = sm.add_constant(X, prepend=True)
Fmodel = sm.OLS(Y, X )

Ytest = W
TestVar = [ERA,BB,SB,ATT,FP,R]
Xtest = np.column_stack((TestVar))
Xtest = sm.add_constant(Xtest, prepend=True)
Rmodel = sm.OLS(Ytest, Xtest)

Fitmodel = Rmodel.fit()

print Fitmodel.summary()
print(Fitmodel.summary().as_latex())
params = Fitmodel.params
print TestVar.__iter__()

#Ypred = -161.6555 -15.3433 * ERAt+ 0.0030*Ht +0.0062*BBt+0.0123*SBt+1.052e-06*ATTt+231.3499*FPt+ 0.0932*Rt
intercept = params[0]
TestDataVar = ERAt,BBt,SBt,Et,FPt,Rt

Ypred=intercept + params[1]*ERAt+params[2]*BBt+params[3]*SBt+params[4]\
*ATTt+params[5] *FPt+params[6]*Rt

Residuals = Ypred - Wt
plt.scatter(W, ERA)
plt.xlabel("Wins")
plt.ylabel("Runs Scored")
plt.show(),

plt.scatter(W, DOUB)
plt.xlabel("Wins")
plt.ylabel("Doubles hit")
plt.show()

obs = range(30)
plt.scatter(Ypred, Wt)
plt.xlabel("Predicted Wins")
plt.ylabel("Observed Wins")
plt.show()

plt.hist(Residuals)
plt.tile("Residuals Distribution", 16)
plt.show()



def average(my_list):
    sumall = sum(my_list)
    average = sumall / len(my_list)
    return average
    
average = average(Residuals)
print "Residuals mean = ",average

variance = np.var(Residuals)
print "Residuals Variance =",variance

dataFull2 = pd.read_csv("Salary.csv", sep=",") 

salaryData =  dataFull2[dataFull2['x14'] == 1 ]  # Extracts Free Agents

salary     = salaryData['y'][:, np.newaxis]
runs    = salaryData['x3'][:, np.newaxis]
walks     = salaryData['x9'][:, np.newaxis]
RBI       = salaryData['x8'][:, np.newaxis]
HR       = salaryData['x7'][:, np.newaxis]

plt.plot(salary, HR)
plt.show()

dataFull3 = pd.read_csv("pitchers.csv", sep=",")

pitcherSalaryData =  dataFull3[(dataFull3['YEARS'] > 5) &  (dataFull3['SALARY'] != ".")] # Extracts Free Agents

pSalary    = pitcherSalaryData['SALARY'][:, np.newaxis]
pERA       = pitcherSalaryData['ERA'][:, np.newaxis]

print pSalary[1]
print pERA[1]

plt.plot(pSalary,pERA)
plt.show()

#plt.scatter(pSalary, pERA)
#plt.show()












