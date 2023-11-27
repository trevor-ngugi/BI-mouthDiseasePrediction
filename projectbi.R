# packages to install ----
if (!is.element("corrplot", installed.packages()[, 1])) {
  install.packages("corrplot", dependencies = TRUE)
}
require("corrplot")

# confirming missing data
if (!is.element("Amelia", installed.packages()[, 1])) {
  install.packages("Amelia", dependencies = TRUE)
}
require("Amelia")

## MICE ----
# We use the MICE package to perform data imputation
if (!is.element("mice", installed.packages()[, 1])) {
  install.packages("mice", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("mice")
## dplyr ----
if (!is.element("dplyr", installed.packages()[, 1])) {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("dplyr")
if (!is.element("naniar", installed.packages()[, 1])) {
  install.packages("naniar", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("naniar")

if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}



# STEP 1. Install and Load the Required Packages ----
## ggplot2 ----
if (require("ggplot2")) {
  require("ggplot2")
} else {
  install.packages("ggplot2", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## pROC ----
if (require("pROC")) {
  require("pROC")
} else {
  install.packages("pROC", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## dplyr ----
if (require("dplyr")) {
  require("dplyr")
} else {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## readr ----
if (require("readr")) {
  require("readr")
} else {
  install.packages("readr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
 # packages for lab 4
## e1071 ----
if (require("e1071")) {
  require("e1071")
} else {
  install.packages("e1071", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## factoextra ----
if (require("factoextra")) {
  require("factoextra")
} else {
  install.packages("factoextra", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## FactoMineR ----
if (require("FactoMineR")) {
  require("FactoMineR")
} else {
  install.packages("FactoMineR", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## stats ----
if (require("stats")) {
  require("stats")
} else {
  install.packages("stats", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## MASS ----
if (require("MASS")) {
  require("MASS")
} else {
  install.packages("MASS", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## glmnet ----
if (require("glmnet")) {
  require("glmnet")
} else {
  install.packages("glmnet", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## e1071 ----
if (require("e1071")) {
  require("e1071")
} else {
  install.packages("e1071", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## kernlab ----
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## rpart ----
if (require("rpart")) {
  require("rpart")
} else {
  install.packages("rpart", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caretEnsemble ----
if (require("caretEnsemble")) {
  require("caretEnsemble")
} else {
  install.packages("caretEnsemble", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## C50 ----
if (require("C50")) {
  require("C50")
} else {
  install.packages("C50", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## adabag ----
if (require("adabag")) {
  require("adabag")
} else {
  install.packages("adabag", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## plumber ----
if (require("plumber")) {
  require("plumber")
} else {
  install.packages("plumber", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
#  step 1:loading data ----
library(readr)
Data_of_teeth <- read_csv("data/Data of teeth.csv")
View(Data_of_teeth)

## step 2:descriptive statistics ----
# Dimensions
dim(Data_of_teeth)

# Data Types
sapply(Data_of_teeth, class)

# Summary of each variable
summary(Data_of_teeth)

## Measures of Frequency ----
### STEP 3. Identify the number of instances that belong to each class. ----
teeth_density_freq <- Data_of_teeth$Disease
cbind(frequency = table(teeth_density_freq), percentage = prop.table(table(teeth_density_freq)) *
        100)

symptom_one_density_freq <- Data_of_teeth$'Symptom 1'
cbind(frequency = table(symptom_one_density_freq), percentage = prop.table(table(symptom_one_density_freq)) *
        100)

symptom_two_density_freq <- Data_of_teeth$'Symptom 2'
cbind(frequency = table(symptom_two_density_freq), percentage = prop.table(table(symptom_two_density_freq)) *
        100)
symptom_three_density_freq <- Data_of_teeth$'Symptom 3'
cbind(frequency = table(symptom_three_density_freq), percentage = prop.table(table(symptom_three_density_freq)) *
        100)



#cant do correlation because  x shoudl numeric


corrplot(cor(Data_of_teeth[, 1:2]), method = "circle") #x must be numeric
# create ggplots for univariate and multivariate



missmap(Data_of_teeth, col = c("red", "grey"), legend = TRUE)

# STEP 4. Confirm the "missingness" in the Dataset before Imputation ----
# Are there missing values in the dataset?

any_na(Data_of_teeth)

n_miss(Data_of_teeth)

prop_miss(Data_of_teeth)

Data_of_teeth %>% is.na() %>% colSums()

miss_var_summary(Data_of_teeth)

#remove the column 6
Data_of_teeth<-Data_of_teeth[-6]

miss_var_summary(Data_of_teeth)

any_na(Data_of_teeth)

# Creating a sample data frame with symptoms
data <- data.frame(
  symptom = c("a cracked tooth", "Bad breath", "Black, white, or brown tooth stains", 
              "bleeding", "Cracked or chipped teeth", "Difficulty chewing or swallowing", 
              "Dramatic weight loss", "Ear Pain", "Grooves on your teeth’s surface", 
              "gum disease", "Holes or pits in your teeth", "pain", 
              "Pain when you bite down", "Painful chewing", "Red and swollen gums", 
              "sore throat", "Tender or bleeding gums", "worn-down fillings or crowns", 
              "Yellowish discoloration")
)

# Coding scheme for symptoms
symptom_coding <- c(
  "a cracked tooth" = 1, 
  "Bad breath" = 2, 
  "Black, white, or brown tooth stains" = 3, 
  "bleeding" = 4, 
  "Cracked or chipped teeth" = 5, 
  "Difficulty chewing or swallowing" = 6, 
  "Dramatic weight loss" = 7, 
  "Ear Pain" = 8, 
  "Grooves on your teeth’s surface" = 9, 
  "gum disease" = 10, 
  "Holes or pits in your teeth" = 11, 
  "pain" = 12, 
  "Pain when you bite down" = 13, 
  "Painful chewing" = 14, 
  "Red and swollen gums" = 15, 
  "sore throat" = 16, 
  "Tender or bleeding gums" = 17, 
  "worn-down fillings or crowns" = 18, 
  "Yellowish discoloration" = 19
)
#treat_coding <- c(
 # "cavity" = 1, 
  #"dentin hypersensitivity" = 2, 
  #"Mouth Sores" = 3, 
  #"Oral Cancer" = 4, 
  #"Periodontitis" = 5, 
  #"Tooth Erosion" = 6
#)

# Applying coding scheme to create a new column
# this code need to transform it
data$numeric_symptom <- symptom_coding[data$symptom]
teethTry<-Data_of_teeth
teethTry$symptom1 <- symptom_coding[teethTry$"Symptom 1"]
teethTry$symptom2 <- symptom_coding[teethTry$"Symptom 2"]
teethTry$symptom3 <- symptom_coding[teethTry$"Symptom 3"]
teethTry<-teethTry[-2]


### The Scale Basic Transform on the Boston Housing Dataset ----
# BEFORE
summary(teethTry)

model_of_the_transform <- preProcess(teethTry, method = c("scale"))
print(model_of_the_transform)
teeth_scale_transform <- predict(model_of_the_transform,
                                          teethTry)
# AFTER
summary(teeth_scale_transform)

### The Centre Basic Transform on the Boston Housing Dataset ----
# BEFORE
summary(teethTry)
model_of_the_transform <- preProcess(teethTry, method = c("center"))
print(model_of_the_transform)
teeth_center_transform <- predict(model_of_the_transform,
                                 teethTry)

# AFTER
# add boxplot code
summary(teeth_center_transform)

### The Standardize Basic Transform on the Boston Housing Dataset ----
# BEFORE
summary(teethTry)
sapply(teethTry[, -1], sd)

model_of_the_transform <- preProcess(teethTry,
                                     method = c("scale", "center"))
print(model_of_the_transform)
teeth_standardize_transform <- predict(model_of_the_transform, # nolint
                                                teethTry)

# AFTER
summary(teeth_standardize_transform)
sapply(teeth_standardize_transform[, -1], sd)

### The Normalize Transform on the Boston Housing Dataset ----
summary(teethTry)
model_of_the_transform <- preProcess(teethTry, method = c("range"))
print(model_of_the_transform)
teethTry_normalize_transform <- predict(model_of_the_transform, # nolint
                                              teethTry)
summary(teethTry_normalize_transform)


## 1.c. Split the dataset ----
# Define a 75:25 train:test data split of the dataset.
# That is, 75% of the original data will be used to train the model and
# 25% of the original data will be used to test the model.

train_index <- createDataPartition(Data_of_teeth$Disease,
                                   p = 0.75,
                                   list = FALSE)
teeth_disease_train <- Data_of_teeth[train_index, ]
teeth_disease_indians_diabetes_test <- Data_of_teeth[-train_index, ]

# using teeth try dataset
train_index <- createDataPartition(teethTry$Disease,
                                   p = 0.75,
                                   list = FALSE)
teethTry_train <- teethTry[train_index, ]
teethTry_test <- teethTry[-train_index, ]

#### Train the model ----
teeth_model_rpart <- rpart(Disease ~ ., data = teethTry_train)

#### Display the model's details ----
print(teeth_model_rpart)

#### Make predictions ----
predictions <- predict(teeth_model_rpart,
                       teethTry_test[, 2:4],
                       type = "class")

#### Display the model's evaluation metrics ----
table(predictions, teethTry_test$Disease)

confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teethTry_test[, 1:4]$Disease))
print(confusion_matrix)

### 2.b. Naïve Bayes Classifier for a Classification Problem with CARET ----
# using teeth try dataset
train_index <- createDataPartition(teethTry$Disease,
                                   p = 0.75,
                                   list = FALSE)
teethTry_train <- teethTry[train_index, ]
teethTry_test <- teethTry[-train_index, ]

#### Train the model ----
# We apply the 5-fold cross validation resampling method
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_nb <- train( Disease~ .,
                                 data = teethTry_train,
                                 method = "nb", metric = "Accuracy",
                                 trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_nb)

#### Make predictions ----
predictions <- predict(teeth_caret_model_nb,
                       teethTry_test[, 2:4])

#### Display the model's evaluation metrics ----
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teethTry_test[, 1:4]$Disease))
print(confusion_matrix)

### 3.c. kNN for a classification problem with CARET's train function ----
# using teeth try dataset
train_index <- createDataPartition(teethTry$Disease,
                                   p = 0.75,
                                   list = FALSE)
teethTry_train <- teethTry[train_index, ]
teethTry_test <- teethTry[-train_index, ]

#### Train the model ----
# We apply the 10-fold cross validation resampling method
# We also apply the standardize data transform
set.seed(7)
train_control <- trainControl(method = "cv", number = 10)
teeth_caret_model_knn <- train(Disease ~ ., data = teethTry,
                                  method = "knn", metric = "Accuracy",
                                  preProcess = c("center", "scale"),
                                  trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_knn)

#### Make predictions ----
predictions <- predict(teeth_caret_model_knn,
                       teethTry_test[, 2:4])

#### Display the model's evaluation metrics ----
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teethTry_test[, 1:4]$Disease))
print(confusion_matrix)

### 4.c. SVM Classifier for a classification problem with CARET ----
# using teeth try dataset
train_index <- createDataPartition(teethTry$Disease,
                                   p = 0.75,
                                   list = FALSE)
teethTry_train <- teethTry[train_index, ]
teethTry_test <- teethTry[-train_index, ]


#### Train the model ----
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_svm_radial <- # nolint: object_length_linter.
  train(Disease ~ ., data = teethTry_train, method = "svmRadial",
        metric = "Accuracy", trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_svm_radial)

#### Make predictions ----
predictions <- predict(teeth_caret_model_svm_radial,
                       teethTry_test[, 2:4])

#### Display the model's evaluation metrics ----
table(predictions, teethTry_test$Disease)
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teethTry_test[, 1:4]$Disease))
print(confusion_matrix)


#model perfomrance
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

### CART ----
set.seed(7)
teeth_model_cart <- train(Disease ~ ., data = teethTry,
                             method = "rpart", trControl = train_control)

### KNN ----
set.seed(7)
teeth_model_knn <- train(Disease ~ ., data = teethTry,
                            method = "knn", trControl = train_control)

### SVM ----
set.seed(7)
teeth_model_svm <- train(Disease ~ ., data = teethTry,
                            method = "svmRadial", trControl = train_control)

results <- resamples(list( CART = teeth_model_cart,
                          KNN = teeth_model_knn, SVM = teeth_model_svm
                          ))
summary(results)

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)

splom(results)

# xyplot plots to compare models
xyplot(results, models = c("SVM", "CART"))

diffs <- diff(results)
summary(diffs)

##stacking algorithims----
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3,
                              savePredictions = TRUE, classProbs = TRUE)
set.seed(seed)

algorithm_list <- c( "rpart", "knn", "svmRadial")
models <- caretList(Disease ~ ., data = teethTry, trControl = train_control,
                    methodList = algorithm_list)

results <- resamples(models)
summary(results)
dotplot(results)

# correlation between results
modelCor(results)
splom(results)

#save model----
saveRDS(teeth_caret_model_svm_radial, "./models/saved_teeth_caret_model_svm_radial.rds")

loaded_teeth_model_svm <- readRDS("./models/saved_teeth_caret_model_svm_radial.rds")
print(loaded_teeth_model_svm)

predictions_with_loaded_model <-
  predict(loaded_teeth_model_svm, newdata = teethTry_test)
confusionMatrix(predictions_with_loaded_model, as.factor(teethTry_test$Disease))

#* @apiTitle gum disease Prediction Model API

#* @apiDescription Used to predict whether a patient has diabetes or not.

#* @param arg_symptomOne The number of pregnancies the patient has had
#* @param arg_symptomTwo Plasma glucose concentration (glucose tolerance test)
#* @param arg_symptomThree Diastolic blood pressure (mm Hg)
 
predict_gum <-
  function(arg_symptomOne, arg_symptomTwo, arg_symptomThree ) {
    # Create a data frame using the arguments
    to_be_predicted <-
      data.frame(symptom1 = as.numeric(arg_symptomOne),
                 symptom2 = as.numeric(arg_symptomTwo),
                 symptom3 = as.numeric(arg_symptomThree))
    # Make a prediction based on the data frame
    predict(loaded_teeth_model_svm, to_be_predicted)
  }


