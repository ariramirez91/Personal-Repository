setwd("/users/ariel/Desktop/Predictive Analytics/HW3/")
dataset <- read.table("CH06PR18.txt",sep ="",  header = FALSE)

rmodel<- lm (dataset$V1~dataset$V2+ dataset$V3+ dataset$V4+dataset$V5  )

print(anova(rmodel))
print(summary(rmodel))

Y<-c()
Y[1]<-predict(lm (V1~V2+ V3+ V4+V5, data = dataset), newdata = data.frame(V2=5, V3= 8.25, V4= 0, 
                                                                          V5 = 250000)  )
Y[2]<-predict(lm (V1~V2+ V3+ V4+V5, data = dataset), newdata = data.frame(V2=6, V3= 8.50, V4= 0.23, 
                                                                          V5 = 270000)  )
Y[3]<-predict(lm (V1~V2+ V3+ V4+V5, data = dataset), newdata = data.frame(V2=14, V3= 11.5, V4= 0.11, 
                                                                          V5= 300000)  )
Y[4]<-predict(lm (V1~V2+ V3+ V4+V5, data = dataset), newdata = data.frame(V2=12, V3= 10.25, V4= 0, 
                                                                          V5 = 310000)  )

SE<-c()
SE[1]<-predict( lm(V1~V2+ V3+ V4+V5, data = dataset),newdata=data.frame(V2=5, V3= 8.25, V4= 0, 
                V5 = 250000),se.fit=T,interval="prediction")$se.fit
SE[2]<-predict( lm(V1~V2+ V3+ V4+V5, data = dataset),newdata=data.frame(V2=6, V3= 8.50, V4= 0.23,
                V5 = 270000),se.fit=T,interval="prediction")$se.fit
SE[3]<-predict( lm(V1~V2+ V3+ V4+V5, data = dataset),newdata=data.frame(V2=14, V3= 11.5, V4= 0.11, 
                V5= 300000),se.fit=T,interval="prediction")$se.fit
SE[4]<-predict( lm(V1~V2+ V3+ V4+V5, data = dataset),newdata=data.frame(V2=12, V3= 10.25, V4= 0, 
                V5 = 310000) ,se.fit=T,interval="prediction")$se.fit


B<-qt((1-.05/2),df=76)


for (i in 1:4) {
  
     lower<-Y[i] - B*SE[i]
     upper<-Y[i] + B*SE[i]
  
  print(paste ("Interval for obs.#", i , lower ,"-",  upper ))
}
