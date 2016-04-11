setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("APPENC02.txt",sep ="",  header = FALSE)

rmodel<- lm (dataset$V8~dataset$V5)

print(anova(rmodel))
print(summary(rmodel))
 
#A

# B= t(.95;423)

B<-qt((1-.05/2),df=423)

coeff0<-rmodel$coefficients[1]
coeff1<-rmodel$coefficients[2]

B0lower<- coeff0 - B * 34.75
B0upper<- coeff0 + B * 34.75 

print(paste("The Bonferroni joint confidence intervals for B0 is:",B0lower,"-",B0upper))

B1lower<- coeff1 - B * 0.00004837
B1upper<- coeff1 + B * 0.00004837

print(paste("The Bonferroni joint confidence intervals for B1 is:",B1lower,"-",B1upper))

#B

B0lower<- -100 - B * 34.75
B0upper<- -100 + B *34.75 

print(paste("Joint confident interval for B0= -100 is: ",B0lower,"-",B0upper))

B1lower<- .0028 - B * 0.00004837
B1upper<- .0028 + B * 0.00004837

print(paste("Joint confident interval for B1 =  .0028 is",B1lower,"-",B1upper))

#C

X <- c(500000,1000000,5000000)
w <- sqrt(2*qf((1-.10),df1=2,df2=438)) 
b <- qt((1-.10/2),df=438)

se<-predict( lm(V8~V5, data = dataset),newdata=data.frame(V5 = X), se.fit=T,interval="prediction")$se.fit

physicians<-predict( lm(V8~V5, data = dataset),newdata=data.frame(V5 = X))

for(i in 1:3) {
print(paste("The expected number of active physicians for a population =", X[i],"is ", physicians[i]))
}

# Working-Hotelling Band
lower<- physicians - w * se
upper<- physicians + w * se 

#Bonferroni Band
lower2<- physicians - b * se
upper2<- physicians + b * se 

for(i in 1:3) {
  print(paste("The Limits for", X[i],"is", lower[i],"-",upper[i], "Using the Working-Hotelling Band"))
  print(paste("The Limits for", X[i],"is", lower2[i],"-",upper2[i], "Using the Bonferroni Band"))
  print(" ")
  
}

#D

# The Working-Hotelling bands for the confidence region are better in terms of shorter expected length.  
# This is mainly due to the large number  of levels of X



