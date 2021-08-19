
library(mlbench)
library(caret)
library(e1071)
library(lime)
library(dplyr)
library(ggplot2)
library(lubridate)
library(quantmod)
library(PerformanceAnalytics)
#library(rugarch)
library(olsrr)
library(psych)
library(crayon)

# This part of code reading Test and Train file 

train <- read.csv(file.choose(), stringsAsFactors = FALSE, header = TRUE)
test <- read.csv(file.choose(), stringsAsFactors = FALSE, header = TRUE)

#Ading 0 or 1
#adding factor varaible to in train and test, So that AFTER 
#combing and handling missing value we can separate them
train$ind <- TRUE
test$ind <- FALSE
test$SalePrice <- NA

Comb_set <- rbind(train, test)


hist(Comb_set$SalePrice,
     density = NULL,  breaks=30, col = " red")


ggplot(Comb_set, aes(y = SalePrice, x = GrLivArea))+
  geom_point(color ='red')

ggplot(Comb_set, aes(y = SalePrice, x = TotalBsmtSF))+
  geom_point(color ='green')

ggplot(Comb_set, aes(y = SalePrice, x = YearBuilt))+
  geom_point(color ='green')+  geom_smooth(se =0, method = 'lm')




#Getting NA value in each col in percentage
funt <- function(n) {sum(is.na(n))/length(n)*100}
apply(Comb_set, 2, funt)
md.pattern(Comb_set)

library(mice)
library(car)
library(tidyverse)

scatterplotMatrix(~SalePrice + OverallQual + GrLivArea + GarageCars +
                    TotalBsmtSF + FullBath + YearBuilt, data = train)

na<-data.frame (map(Comb_set, ~sum(is.na(.))))
map(train, ~sum(is.na(.)))

total_row <- nrow(train)
Comb_set <- Comb_set[,-c(73:75,58,7)]
gra_Ares <- mean(Comb_set$GarageArea, na.rm = TRUE)
Comb_set[is.na(Comb_set$GarageArea), "GarageArea"] <- gra_Ares

Comb_set[is.na(Comb_set$GarageQual), "GarageQual"] <- 'TA'
Comb_set[is.na(Comb_set$GarageCond), "GarageCond"] <- 'TA'
Comb_set[is.na(Comb_set$GarageFinish),"GarageFinish"] <- 'Unf'

Comb_set[is.na(Comb_set$GarageCars),"GarageCars"] <- 2
Comb_set[is.na(Comb_set$GarageType),"GarageType"] <- 'Attchd'
Comb_set[is.na(Comb_set$Functional),"Functional"] <- 'Typ'

Comb_set[is.na(Comb_set$KitchenQual),"KitchenQual"] <- 'TA'
Comb_set[is.na(Comb_set$BsmtHalfBath),"BsmtHalfBath"] <- 0

Comb_set[is.na(Comb_set$Electrical),"Electrical"] <- 'SBrkr '
Comb_set[is.na(Comb_set$BsmtFinType2), "BsmtFinType2"]<-'Unf'

Comb_set[is.na(Comb_set$BsmtQual), "BsmtQual"] <- 'TA'

Comb_set[is.na(Comb_set$MasVnrArea), "MasVnrArea"] <- mean(Comb_set$MasVnrArea, na.rm = T)

Comb_set[is.na(Comb_set$MasVnrType), "MasVnrType"] <- 'BrkFace' #None

Comb_set[is.na(Comb_set$LotFrontage), "LotFrontage"] <- mean(Comb_set$LotFrontage, na.rm = T)
Comb_set[is.na(Comb_set$BsmtExposure), "BsmtExposure"] <- 'No'
Comb_set[is.na(Comb_set$BsmtCond), "BsmtCond"] <- 'TA'
Comb_set[is.na(Comb_set$BsmtFinSF2),"BsmtFinSF2"] <- 0
Comb_set[is.na(Comb_set$BsmtFinType1), "BsmtFinType1"]<-'Unf'

Comb_set[is.na(Comb_set$TotalBsmtSF),"TotalBsmtSF"]  <- mean(Comb_set$TotalBsmtSF, na.rm= T)
Comb_set[is.na(Comb_set$Utilities), "Utilities"]<-'AllPub'

Comb_set[is.na(Comb_set$BsmtFullBath ), "BsmtFullBath"]<-0
Comb_set[is.na(Comb_set$BsmtUnfSF),"BsmtUnfSF"]  <- mean(Comb_set$BsmtUnfSF , na.rm= T)
Comb_set[is.na(Comb_set$BsmtFinSF1 ),"BsmtFinSF1"]  <- mean(Comb_set$BsmtFinSF1 , na.rm= T)
Comb_set[is.na(Comb_set$Exterior2nd), "Exterior2nd"]<-'VinylSd'
Comb_set[is.na(Comb_set$SaleType), "SaleType"]<-'WD'
Comb_set[is.na(Comb_set$GarageYrBlt),"GarageYrBlt"]  <- round(mean(Comb_set$GarageYrBlt , na.rm= T))



na<-data.frame (map(Comb_set, ~sum(is.na(.))))

house_train<-Comb_set[Comb_set$ind==TRUE,]
house.test<-Comb_set[Comb_set$ind==FALSE,]


library(ggplot2)
library(lubridate)
library(Boruta)

boruta <- Boruta(SalePrice~., data = house_train, doTrace = 2, maxRuns = 100)
print(boruta)
getNonRejectedFormula(boruta)
plot(boruta)

set.seed(1234)
cvcontrol <- trainControl(method = "repeatedcv",
                          number = 5,
                          repeats = 2,
                          allowParallel = T)

set.seed(1234)
library(xgboost)
bag <- train(SalePrice~OverallQual+GrLivArea+BsmtFinSF1 +BsmtFinSF1+
               TotalBsmtSF+ X1stFlrSF+X2ndFlrSF+GarageArea+
               LotArea+YearBuilt+Fireplaces+YearRemodAdd,
             data = house_train,
             method = "xgbTree",
             trControl = cvcontrol,
             importance =T,tuneGrid =expand.grid(nrounds = 600,
                                                 max_depth =5,
                                                 eta = 0.2,
                                                 gamma= 2.1,
                                                 colsample_bytree =1,
                                                 min_child_weight =1,
                                                 subsample =1))


plot(varImp(bag))
pred <-predict(bag, house_train)
plot(pred ~ house_train$SalePrice, col=' blue')

pred <-predict(bag, house.test)

plot(pred ~ house_train$SalePrice)

scatterplotMatrix(SalePrice~OverallQual+GrLivArea+BsmtFinSF1+BsmtFinSF1 +
                     TotalBsmtSF+ X1stFlrSF+X2ndFlrSF+GarageArea+
                     LotArea+YearBuilt+Fireplaces+YearRemodAdd +OverallCond)

heatmap(as.matrix(house_train))

Id<-house.test$Id
output.df<-as.data.frame(Id)
output.df$SalePrice<- pred

write.csv(output.df, file = "kaggle_Submission.csv",row.names = FALSE)


library(randomForest)
#Random Forest
set.seed(1234)
Forest <- train(SalePrice~OverallQual+GrLivArea+BsmtFinSF1+
                  TotalBsmtSF+ X1stFlrSF+X2ndFlrSF+GarageArea+
                  LotArea+YearBuilt+Fireplaces+YearRemodAdd,
                data = train,
                method = "rf",
                trControl = cvcontrol,
                importance =T)

plot(varImp(Forest))
plot(Forest)


set.seed(1234)
cvcontrol <- trainControl(method = "repeatedcv",
                          number = 5,
                          repeats = 2,
                          allowParallel = T)

set.seed(1234)
library(xgboost)
bag <- train(SalePrice~OverallQual+GrLivArea+BsmtFinSF1 +BsmtFinSF1+
               TotalBsmtSF+ X1stFlrSF+X2ndFlrSF+GarageArea+
               LotArea+YearBuilt+Fireplaces+YearRemodAdd,
             data = house_train,
             method = "xgbTree",
             trControl = cvcontrol,
             importance =T,tuneGrid =expand.grid(nrounds = 600,
                                                 max_depth =5,
                                                 eta = 0.2,
                                                 gamma= 2.1,
                                                 colsample_bytree =1,
                                                 min_child_weight =1,
                                                 subsample =1))



set.seed(1234)
cvcontrol <- trainControl(method = "repeatedcv",
                          number = 5,
                          repeats = 2,
                          allowParallel = T)

#Random Forest
set.seed(1234)
Forest <- train(SalePrice ~ MSSubClass + MSZoning + LotFrontage + LotArea + LotShape + 
                  LandContour + LandSlope + Neighborhood + Condition1 + BldgType + 
                  HouseStyle + OverallQual + OverallCond + YearBuilt + YearRemodAdd + 
                  RoofStyle + Exterior1st + Exterior2nd + MasVnrType + MasVnrArea + 
                  ExterQual + Foundation + BsmtQual + BsmtExposure + BsmtFinType1 + 
                  BsmtFinSF1 + BsmtUnfSF + TotalBsmtSF + HeatingQC + CentralAir + 
                  Electrical + X1stFlrSF + X2ndFlrSF + GrLivArea + BsmtFullBath + 
                  FullBath + HalfBath + BedroomAbvGr + KitchenAbvGr + KitchenQual + 
                  TotRmsAbvGrd + Functional + Fireplaces + GarageType + GarageYrBlt + 
                  GarageFinish + GarageCars + GarageArea + PavedDrive + WoodDeckSF + 
                  OpenPorchSF + EnclosedPorch + ScreenPorch + SaleCondition,
                data = house_train,
                method = "rf",
                trControl = cvcontrol,
                importance =T)

plot(varImp(bag))
plot(Forest)

Id<-house.test$Id
output.df<-as.data.frame(Id)
output.df$SalePrice<- pred

write.csv(output.df, file = "kaggle_Submission.csv",row.names = FALSE)

