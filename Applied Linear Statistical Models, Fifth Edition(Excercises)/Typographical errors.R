setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("CH04PR12.txt",sep ="",  header = FALSE)

galleys<-dataset$V2
cost<-dataset$V1
  
#A

#rmodel<- lm(cost ~ 0+ galleys) # Regression through origin 
rmodel<- lm(cost ~  galleys)
print(rmodel$coefficients)

#B
plot(cost , galleys) 

# regression Through origin would be useful here since the dependant variable is COst
# it would give you an idea of how each galley affects the final price

#C

print ( pt(q=2.798, df=10, lower.tail=F))
   
#D
# Obtain a prediction interval for the correction cost on a forthcoming job involving 10 galleys.
# Use a confidence coefficient of 98 pen:ent.

newdata = data.frame(galleys  = 10)
y<- predict( rmodel<- lm(cost ~ galleys) ,level = .98, newdata, interval="predict") 
print(y)

