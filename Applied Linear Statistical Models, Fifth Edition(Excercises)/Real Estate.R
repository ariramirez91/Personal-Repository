setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("APPENC07.txt",sep ="",  header = FALSE)


sampledata <- dataset[sample(nrow(dataset), 200),]


plot(sampledata$V2, sampledata$V3)

print(cor(sampledata$V2,sampledata$V3))

#There appears to be a good degree of linear relationship between X and Y from looking at the graph
# the correlation index of .81 confirms that there is in fact a relation between X and Y
# The lineraity assumption is met.


rmodel <- lm(sampledata$V2 ~ sampledata$V3)
print(rmodel$coefficients)

plot( rmodel$fitted.values, rmodel$residuals, main ="Homoscedastacity test" )
# Variance of residuals appears to not be constant. 
# There is an issue with the homoscedastacity assumption


qqnorm(rmodel$residuals)


# the model appears to fall more under normality for the residuals, Thought there seems to be some outliers towards
# the larger values.

ordsqfeet<- sort(sampledata$V3)
plot(rmodel$residuals , ordsqfeet)

# The residuals appear to be idependant from each other when plot agasint ordered square feet. No apparent relation 
# is evident.Therefore, this assumption is met for this model.


#Predicted price for 1100 square feet

predict(lm(V2 ~ V3, data = sampledata ), newdata = data.frame(V3=4900)  )
#Predicted price for 4900 square feet

# The model seems to predict well low values of Sales price. However, when it comes to predicting higher values.
# it appears to have a higher range of error.

