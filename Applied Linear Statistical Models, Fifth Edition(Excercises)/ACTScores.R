setwd("/users/ariel/Desktop/Predictive Analytics/Homework2")
dataset <- read.table("CH03PR03.txt",sep ="",  header = FALSE )

# 3.3
# A

# ACT Scores
boxplot(dataset$V2)

#B

f1 <- lm(dataset$V1 ~ dataset$V2)

dotchart(f1$residuals)

# From thi dot plot we can conclude that the residuals follow a normal distribution pattern with only a few
# outliers.

#C
plot(f1$fitted.values, f1$residuals, xlab = "Fitted Values" , ylab = "Residuals")

# By looking at this plot we can assume that the values for the residuals are independant from each other
# even as the fitted values go up.

qqnorm(f1$residuals, main= " Normal Probability Plot" )

print( paste(" Correlation between Fitted Values and Residuals ",
              (cor(f1$fitted.values , f1$residuals ))))


stderr <- summary(f1)$sigma
n <- 120
expValNorm <- sapply(1:n, function(k) stderr * qnorm((k-.375)/(n+.25)))
ordResiduals <- sort(f1$residuals)

print(paste( "Correlation under normality:",(cor(expValNorm, ordResiduals))))

# since there is no values of confidence for N = 120 in table b.6 
# i used n= 100 at its minimun value which is .979 and the values get larger as n gets larger
# since our correlation is 0.97372748292771 lower than .979 we assume the values are not normally distributed.

# E 
 

group1 <- dataset[ which(dataset$V2 >26),]
  f.group1 <- lm( group1$V2 ~ group1$V1 )
 
group2 <- dataset[ which(dataset$V2 >=26),]
  f.group2 <- lm( group2$V2 ~ group2$V1 )

print(anova(f.group1))

print(anova(f.group2))

# Group 2 has a significant higher residuals overall.
# this does not supports my findings on part c that residuals are getting higher as we 
#get higher ACT Scores get higher

#F
plot(f1$residuals,dataset$V3)

#There is an aparent relation between the residuals and the intelligence score values. the adition of these variable 
#will improve the model.

plot(f1$residuals,dataset$V4)

# there is no aparent realtionship between the residuals and the class rank percentile values.
# this variable will not impact the model.


 

 

