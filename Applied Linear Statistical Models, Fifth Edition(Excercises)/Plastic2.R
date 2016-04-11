setwd("/users/ariel/Desktop/Predictive Analytics/Homework2")
dataset <- read.table("CHP1PR22.txt",sep ="",  header = FALSE )

#A

f1 <- lm(dataset$V1 ~ dataset$V2)

plot(f1$residuals)

# Residuals are independant throughout the data set.

#B
plot(f1$residuals, f1$fitted.values)

# Residuals are independant from each other, though their values appear to be high at times.

#C

qqnorm(f1$residuals, main= " Normal Probability Plot" )

stderr <- summary(f1)$sigma
n <- 16
expValNorm <- sapply(1:n, function(k) stderr * qnorm((k-.375)/(n+.25)))
ordResiduals <- sort(f1$residuals)
print(paste( "Correlation under normality:",(cor(expValNorm, ordResiduals))))

#  From Table B.6, with α = 0 05 . and n=16, the
#  critical value is .941. Since .99167 > .941
#  We can assume normality in this cases.

#D

percentile = f1$residuals
quantile(percentile , c(.25,.50,.75))


#E

group1 <- dataset [which(dataset$V2<= 24),]
f.group1 <- lm( group1$V2  ~ group1$V1)

print (anova(f.group1))


group2 <-  dataset [which(dataset$V2 >24),]
f.group2 <- lm ( group2$V2  ~ group2$V1)


print(anova(f.group2)) 



# since the variance for the residuals is pretty much the same when we subset the data into two 
# groups. We may conclude that the residuals are stable throughout the whole dataset. Therefore 
# the created  model is not overlooking anything 
# by looking at the graph in part b i was already able to tell that this was going to be the case.

