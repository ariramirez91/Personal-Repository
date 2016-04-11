setwd("/users/ariel/Desktop/Predictive Analytics/Homework2")
dataset <- read.table("CH03PR04.txt",sep ="",  header = FALSE )


# A
 dotchart(dataset$V2)
 
 # there is a disperse number of Copiers serviced with no apparent outliers
 
 #B
 plot(dataset$V2, xlab = "time ", ylab = "Number of Copiers Serviced")
 
 # The number of copiers serviced is not affected over time.
 
 #C
 f1 <- lm(dataset$V1 ~ dataset$V2)
 
 stem(f1$residuals)
 
 # This tells me that the residuals follow a normal distribution around zero,
 # Which tells me they are independant from each other.
 
 #D
 
 plot(f1$fitted.values, f1$residuals)
 plot(dataset$V2, f1$residuals)
 
 # The plots provide the same information
 
 #E
 qqnorm(f1$residuals, main= " Normal Probability Plot" )
 
 stderr <- summary(f1)$sigma
 n <- 45
 expValNorm <- sapply(1:n, function(k) stderr * qnorm((k-.375)/(n+.25)))
 ordResiduals <- sort(f1$residuals)
 print(paste( "Correlation under normality:",(cor(expValNorm, ordResiduals))))
 
 # For n= 50 and a confidence of .10 the value of correlation on table b.6 is .981
 # The correlation returns a value of .989 therefore we assume the values are normally distributed
 
 #F
 plot(f1$residuals)
 # Residuals appear indepenant and uncorrelated. However, they have really high values 
 # so , the model appears not to be really accurate.
 
 #G

#test<-(bptest(dataset$V1 ~ dataset$V2))
 
#  studentized Breusch-Pagan test
#  
#  data:  dataset$V1 ~ dataset$V2
#  BP = 3.0628, df = 1, p-value = 0.0801
#  

 ## With a alpha of 0.01 we may not accept the null hypothes and conclude that the variance 
 #is homogeneous among residuals
 
 #H
 
 
 plot(f1$residuals,dataset$V3)
 
 #There is an aparent relation between the residuals and the age of copiers serviced on the call. 
 #the adition of these variable 
 #will improve the model.
 
 plot(f1$residuals,dataset$V4)
 
 # there is no aparent realtionship between the residuals and the years of experience values.
 # this variable will not impact the model.
 
 
 
 