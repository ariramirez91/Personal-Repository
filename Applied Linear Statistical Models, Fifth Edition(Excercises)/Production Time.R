setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("CH03PR18.txt",sep ="",  header = FALSE)

prodtime <- dataset$V1
prodsize<- dataset$V2

#A

plot(prodtime,prodsize)
print(cor(prodtime,prodsize))

sqrtprodsize <- sqrt(prodsize)

plot (prodtime ,sqrtprodsize)
print(cor(prodtime,sqrtprodsize))

# Production time square root makes the best transformation for the model
# As seen in the plot the linear relation improves as well as the correlation index.

#B

plot (prodtime ,sqrtprodsize)
print(cor(prodtime,sqrtprodsize))

# The linear relationship increases when using the transformation X2 = x^1/2
# the correlation index increases as well.

#C

rmodel <- lm(prodtime ~ sqrtprodsize)
plot (prodtime ,sqrtprodsize) 
abline(rmodel)

#D

plot(rmodel$residuals,rmodel$fitted.values)
# It appears the Residuals are statistically independant from each other

qqnorm(rmodel$residuals)

#It appears the residuals follow a normal distribution 

#E
rmodeloriginal<- lm(prodtime~ prodsize)
print(rmodeloriginal$coefficients)


