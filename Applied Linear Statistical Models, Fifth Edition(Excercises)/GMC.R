dataset <- read.csv("New_GMC_Pickup.csv")

print(dataset)

plot(dataset)
summary(dataset)

print(cor(dataset$X,dataset$Y))
print(covariance <- cov(dataset))


f1 <-lm(Y ~ X, data = dataset)

print(summary(f1)

print (f1)

dataset2 <- read.csv("Chicago_Insurance_Data.csv")

f2<- lm(Y ~ X, data = dataset2)

print(summary(f2))

par(mfrow = c(2,2))

plot(f2)



