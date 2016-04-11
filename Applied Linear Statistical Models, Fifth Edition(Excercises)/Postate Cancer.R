setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("APPENC05.txt",sep ="",  header = FALSE)

PSA<- dataset$V2
cancerv<-dataset$V3

plot (PSA,cancerv)
print(cor(PSA,cancerv))

# There appears not to be a high degree of linearity by looking at the plot. 
# Also, the correlation level is only .64
# The linearity assumption is not met

rmodel<-lm(PSA~cancerv)

ordcancerv<- sort(cancerv)
 plot(rmodel$residuals , ordcancerv)
 
# There appears to be a relationship when plotting residuals agaisnt ordered values of Cancer volume
# The statistical independence of residuals assumption is not met in this model.
 
 plot( rmodel$fitted.values, rmodel$residuals, main ="Homoscedastacity test" )
 
 group1 <- dataset[which(PSA<= 20),]
 f.group1 <- lm( group1$V2  ~ group1$V1)
 
 print (anova(f.group1))
 
 group2 <-  dataset [which(PSA >20),]
 f.group2 <- lm ( group2$V2  ~ group2$V1)
 
 
 print(anova(f.group2)) 
 
 # Variance of residuals appears to not be constant. 
 # Brown-Forsythe test shows the difference in variance when the PSA level is over an under 20
 # There is an issue with the homoscedastacity assumption
 
 qqnorm(rmodel$residuals)
 
# The graph does not follow a 45 degree pattern 
 # The Normality of residuals assumption is not met.

 predict(lm (PSA ~ cancerv ), newdata = data.frame(cancerv=20)  )
 
 # This model is really weak , Cancer Volume is not a good variable to use when predicting PSA Level
 
 
 
 