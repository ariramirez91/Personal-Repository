setwd("/users/ariel/Desktop/Predictive Analytics/Homework2")
dataset <- read.table("CHP1PR21.txt",sep ="",  header = FALSE )



# A
dotchart(dataset$V2)

#the number of transfrs appears to follow a symetrical pattern.
# higher amounts appear less

#B

plot(dataset$V2, xlab = "time ", ylab = "Number of Transfers")

# the number of transfers does not appear to follow an specific pattern.

#D

f1 <- lm(dataset$V1 ~ dataset$V2)
stem(f1$residuals)

# this shows me that the most of the values are on the negative side. Which may mean
# the model overestimates results

#D

plot(f1$residuals, dataset$V2 )

#E

stderr <- summary(f1)$sigma
n <- 10
expValNorm <- sapply(1:n, function(k) stderr * qnorm((k-.375)/(n+.25)))
ordResiduals <- sort(f1$residuals)

print(paste( "Correlation under normality:",(cor(expValNorm, ordResiduals))))

# For n= 10 and a confidence of .01 the value of correlation on table b.6 is .879
# The correlation returns a value of .960 therefore we assume the values are normally distributed

#F

plot(f1$residuals)

# They appear to be independant from each other however, there seems to be a pattern after 8 observations

# G 

#print(bptest(dataset$V1 ~ dataset$V2))
#studentized Breusch-Pagan test

# data:  dataset$V1 ~ dataset$V2
# BP = 3.0628, df = 1, p-value = 0.0801