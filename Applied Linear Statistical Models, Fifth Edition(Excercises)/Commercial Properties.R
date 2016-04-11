setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("CH06PR18.txt",sep ="",  header = FALSE)

rmodel<- lm (dataset$V1~dataset$V2+ dataset$V3+ dataset$V4 + dataset$V5 )


#A
print(anova(rmodel))
print(summary(rmodel))

T<- (qt((1-0.05),df=76))

# the t test value is 1.6615 since the The p-value is 7.272e-14 
# Therefore we reject the null hypothesis 

#B

B <- (qt((1-0.05/2),df=76))

coeff1<-(rmodel$coefficients[2])
coeff2<-(rmodel$coefficients[3])
coeff4<-(rmodel$coefficients[5])
coeff3<-(rmodel$coefficients[4])

B1lower<- coeff1 - B * 2.134e-02
B1upper<- coeff1 + B *2.134e-02 

B2lower<- coeff2 - B * 6.317e-02
B2upper<- coeff2 + B * 6.317e-02 

B3lower<- coeff3- B * 1.087 
B3upper<- coeff3 + B * 1.087 

B4lower<- coeff3- B * 1.385e-06 
B4upper<- coeff3 + B * 1.385e-06 

print(paste("Joint confident interval for B1 =",B1lower,"-",B1upper))
print(paste("Joint confident interval for B2 =",B2lower,"-",B2upper))
print(paste("Joint confident interval for B3 =",B3lower,"-",B3upper))
print(paste("Joint confident interval for B4 =",B4lower,"-",B4upper))

#C 

#R square = 0.5847 which means that 58 percent of the rental rates can be explained by the regression model

