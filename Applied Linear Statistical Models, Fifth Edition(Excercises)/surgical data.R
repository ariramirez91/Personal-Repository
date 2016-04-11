setwd("/users/ariel/Desktop/Predictive Analytics/Lecture 5/")
surg.data <- read.table("surgical_unit_data.csv",sep =",",  header = TRUE)

attach(surg.data) 
pairs(surg.data) 
cor(surg.data) 
library(leaps)

step(lm(Ln(surg.data$Y) ~ 1), data=surg.data, scope = ~ X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 , data = surg.data)
# But the leaps function provides the all-subsets analysis: # Printing the 2 best models of each size, using the Cp criterion: #

leaps(x =cbind( surg.data$X1 , surg.data$X2 , surg.data$X3 , surg.data$X4 , surg.data$X5 , surg.data$X6 , surg.data$
                  surg.data$X7 ,surg.data$X8), surg.data$Y = Ln(surg.data$Y), nbest=2, method="Cp") 

# Printing the 2 best models of each size, using the adjusted R^2 criterion:#

leaps(x = cbind(X1 , X2 , X3 , X4 , X5 , X6 , X7 , X8, data = surg.data), y = LnY, nbest=2, method="adjr2")
