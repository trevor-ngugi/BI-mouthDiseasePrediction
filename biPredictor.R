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
#naniar ----
if (!is.element("naniar", installed.packages()[, 1])) {
  install.packages("naniar", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("naniar")
# Amelia ----
if (!is.element("Amelia", installed.packages()[, 1])) {
  install.packages("Amelia", dependencies = TRUE)
}
require("Amelia")
# corrplot ----
if (!is.element("corrplot", installed.packages()[, 1])) {
  install.packages("corrplot", dependencies = TRUE)
}
require("corrplot")
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
# language server ----
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
# ggcorrplot ----
if (!is.element("ggcorrplot", installed.packages()[, 1])) {
  install.packages("ggcorrplot", dependencies = TRUE)
}
require("ggcorrplot")

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

## httr ----
if (require("httr")) {
  require("httr")
} else {
  install.packages("httr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## jsonlite ----
if (require("jsonlite")) {
  require("jsonlite")
} else {
  install.packages("jsonlite", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#loading the datasets ----
library(readr)
Data_of_teeth <- read_csv("data/Data of teeth.csv")
View(Data_of_teeth)

#explatory data analysis ----
# Dimensions ----
# Dimensions refer to the number of observations (rows) and the number of
# attributes/variables/features (columns). Execute the following commands to
# display the dimensions of your datasets:
dim(Data_of_teeth)

# Data Types ----
# Knowing the data types will help you to identify the most appropriate
# visualization types and algorithms that can be applied. It can also help you
# to identify the need to convert from categorical data (factors) to integers
# or vice versa where necessary. Execute the following command to identify the
# data types:
sapply(Data_of_teeth, class)

# Descriptive Statistics ----
## Measures of Frequency ----
disease_density_freq <- Data_of_teeth$Disease
cbind(frequency = table(disease_density_freq), percentage = prop.table(table(disease_density_freq)) *
        100)

symptom1_density_freq <- Data_of_teeth$"Symptom 1"
cbind(frequency = table(symptom1_density_freq), percentage = prop.table(table(symptom1_density_freq)) *
        100)

symptom2_density_freq <- Data_of_teeth$"Symptom 2"
cbind(frequency = table(symptom2_density_freq), percentage = prop.table(table(symptom2_density_freq)) *
        100)
symptom3_density_freq <- Data_of_teeth$"Symptom 3"
cbind(frequency = table(symptom3_density_freq), percentage = prop.table(table(symptom3_density_freq)) *
        100)
treatment_density_freq <- Data_of_teeth$Treatment
cbind(frequency = table(treatment_density_freq), percentage = prop.table(table(treatment_density_freq)) *
        100)

## Measures of Distribution/Dispersion/Spread/Scatter/Variability ----
summary(Data_of_teeth)

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

# Applying coding scheme to create a new column
teeth_Num <- Data_of_teeth
teeth_Num$symptom1 <- symptom_coding[Data_of_teeth$"Symptom 1"]
teeth_Num$symptom2 <- symptom_coding[Data_of_teeth$"Symptom 2"]
teeth_Num$symptom3 <- symptom_coding[Data_of_teeth$"Symptom 3"]

### Create Box and Whisker Plots for Each Numeric Attribute ----
boxplot(teeth_Num[, 7], main = names(teeth_Num)[7])
boxplot(teeth_Num[, 8], main = names(teeth_Num)[8])
boxplot(teeth_Num[, 9], main = names(teeth_Num)[9])

###  Create Bar Plots for Each Categorical Attribute ----
barplot(table(teeth_Num[, 4]), main = names(teeth_Num)[4])

###  Create a Missingness Map to Identify Missing Data ----
missmap(Data_of_teeth, col = c("red", "grey"), legend = TRUE)

## Multivariate Plots ----
### Create a Correlation Plot ----
# Correlation plots can be used to get an idea of which attributes change
# together. The function “corrplot()” found in the package “corrplot” is
# required to perform this. The larger the dot in the correlation plot, the
# larger the correlation. Blue represents a positive correlation whereas red
# represents a negative correlation.
corrplot(cor(teeth_Num[, 7:9]), method = "circle")

# Alternatively, the 'ggcorrplot::ggcorrplot()' function can be used to plot a
# more visually appealing plot.
ggcorrplot(cor(teeth_Num[, 7:9]))

# Confirm the "missingness" in the Dataset before Imputation ----
# Are there missing values in the dataset?
any_na(Data_of_teeth)
any_na(teeth_Num)

# How many?
n_miss(Data_of_teeth)
n_miss(teeth_Num)

# What is the percentage of missing data in the entire dataset?
prop_miss(Data_of_teeth)
prop_miss(teeth_Num)

# How many missing values does each variable have?
Data_of_teeth %>% is.na() %>% colSums()
teeth_Num %>% is.na() %>% colSums()

# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(Data_of_teeth)
miss_var_summary(teeth_Num)

# remove the column that has misssing data
Data_of_teeth<-Data_of_teeth[-6]
teeth_Num<-teeth_Num[-6]

# remove the symptom columns that have character values
teeth_Num<-teeth_Num[,-1:-3]
# remove the treatment columns that have character values
teeth_Num<-teeth_Num[-2]

# confirm if there is missing data
any_na(Data_of_teeth)
any_na(teeth_Num)

# standardizing data ----
#not applicable 
# BEFORE
summary(teeth_Num)
sapply(teeth_Num[, -1], sd)

model_of_the_transform <- preProcess(teeth_Num,
                                     method = c("scale", "center"))
print(model_of_the_transform)
teeth_Num_standardize_transform <- predict(model_of_the_transform, # nolint
                                           teeth_Num)

# AFTER
summary(teeth_Num_standardize_transform)
sapply(teeth_Num_standardize_transform[, -1], sd)

#skewness
sapply(teeth_Num_standardize_transform[, -1],  skewness, type = 2)

hist(teeth_Num_standardize_transform[, 2], main = names(teeth_Num_standardize_transform)[2])

model_of_the_transform <- preProcess(teeth_Num_standardize_transform, method = c("YeoJohnson"))
print(model_of_the_transform)
teeth_Num_yeo_johnson_transform <- predict(model_of_the_transform, # nolint
                                                teeth_Num_standardize_transform)

# AFTER
summary(teeth_Num_yeo_johnson_transform)

# Calculate the skewness after the Yeo-Johnson transform
sapply(teeth_Num_yeo_johnson_transform[, -1],  skewness, type = 2)

## Split the dataset ----
# Define a 75:25 train:test data split of the dataset.
# That is, 75% of the original data will be used to train the model and
# 25% of the original data will be used to test the model.
train_index <- createDataPartition(teeth_Num$Disease,
                                   p = 0.75,
                                   list = FALSE)
teeth_disease_train <- teeth_Num[train_index, ]
teeth_disease_test <- teeth_Num[-train_index, ]

### 1. Decision tree for a classification problem with caret ----
#### Train the model ----
set.seed(7)
# We apply the 5-fold cross validation resampling method
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_rpart <- train(Disease ~ ., data = teeth_Num,
                                    method = "rpart", metric = "Accuracy",
                                    trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_rpart)

#### Make predictions ----
predictions <- predict(teeth_caret_model_rpart,
                       teeth_disease_test[, 2:4],
                       type = "raw")

#### Display the model's evaluation metrics ----
table(predictions, teeth_disease_test$Disease)

confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teeth_disease_test[, 1:4]$Disease))
print(confusion_matrix)

## 2.  Naïve Bayes ----
#### Train the model ----
# We apply the 5-fold cross validation resampling method
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_nb <- train(Disease ~ .,
                                 data = teeth_disease_train,
                                 method = "nb", metric = "Accuracy",
                                 trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_nb)

#### Make predictions ----
predictions <- predict(teeth_caret_model_nb,
                       teeth_disease_test[, 2:4])

#### Display the model's evaluation metrics ----
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teeth_disease_test[, 1:4]$Disease))
print(confusion_matrix)

### 3. kNN for a classification problem with CARET's train function ---- 
set.seed(7)
train_control <- trainControl(method = "cv", number = 10)
teeth_caret_model_knn <- train(Disease ~ ., data = teeth_Num,
                                  method = "knn", metric = "Accuracy",
                                  preProcess = c("center", "scale"),
                                  trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_knn)

#### Make predictions ----
predictions <- predict(teeth_caret_model_knn,
                       teeth_disease_test[, 2:4])

#### Display the model's evaluation metrics ----
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teeth_disease_test[, 1:4]$Disease))
print(confusion_matrix)

### 4. SVM Classifier for a classification problem with CARET ----
#### Train the model ----
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_svm_radial <- # nolint: object_length_linter.
  train(Disease ~ ., data = teeth_disease_train, method = "svmRadial",
        metric = "Accuracy", trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_svm_radial)

#### Make predictions ----
predictions <- predict(teeth_caret_model_svm_radial,
                       teeth_disease_test[, 2:4])

#### Display the model's evaluation metrics ----
table(predictions, teeth_disease_test$Disease)
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teeth_disease_test[, 1:4]$Disease))
print(confusion_matrix)

#model performance comparison ----
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

### CART ----
set.seed(7)
teeth_model_cart <- train(Disease ~ ., data = teeth_Num,
                             method = "rpart", trControl = train_control)

### KNN ----
set.seed(7)
teeth_model_knn <- train(Disease ~ ., data = teeth_Num,
                            method = "knn", trControl = train_control)

### SVM ----
set.seed(7)
teeth_model_svm <- train(Disease ~ ., data = teeth_Num,
                            method = "svmRadial", trControl = train_control)

### naive bayes ----
set.seed(7)
teeth_model_nb <- train(Disease ~ ., data = teeth_Num,
                         method = "nb", trControl = train_control)



##  Call the `resamples` Function ----
# We then create a list of the model results and pass the list as an argument
# to the `resamples` function.

results <- resamples(list( CART = teeth_model_cart,
                          KNN = teeth_model_knn, SVM = teeth_model_svm,
                          NB = teeth_model_nb))

#  Display the Results ----
## 1. Table Summary ----
# This is the simplest comparison. It creates a table with one model per row
# and its corresponding evaluation metrics displayed per column.

summary(results)

## 2. Box and Whisker Plot ----
# This is useful for visually observing the spread of the estimated accuracies
# for different algorithms and how they relate.

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)

## 3. Dot Plots ----
# They show both the mean estimated accuracy as well as the 95% confidence
# interval (e.g. the range in which 95% of observed scores fell).

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)

## 4. Scatter Plot Matrix ----
# This is useful when considering whether the predictions from two
# different algorithms are correlated. If weakly correlated, then they are good
# candidates for being combined in an ensemble prediction.

splom(results)

## 5. Pairwise xyPlots ----
# You can zoom in on one pairwise comparison of the accuracy of trial-folds for
# two models using an xyplot.

# xyplot plots to compare models
xyplot(results, models = c("KNN", "SVM"))

# or
# xyplot plots to compare models
xyplot(results, models = c("SVM", "CART"))

# or
# xyplot plots to compare models
xyplot(results, models = c("KNN", "CART"))

# or
# xyplot plots to compare models
xyplot(results, models = c("KNN", "NB"))

# or
# xyplot plots to compare models
xyplot(results, models = c("NB", "CART"))

## 6. Statistical Significance Tests ----
# This is used to calculate the significance of the differences between the
# metric distributions of the various models.

### Upper Diagonal ----
# The upper diagonal of the table shows the estimated difference between the
# distributions. If we think that LDA is the most accurate model from looking
# at the previous graphs, we can get an estimate of how much better it is than
# specific other models in terms of absolute accuracy.

### Lower Diagonal ----
# The lower diagonal contains p-values of the null hypothesis.
# The null hypothesis is a claim that "the distributions are the same".
# A lower p-value is better (more significant).

diffs <- diff(results)

summary(diffs)

#  Stacking ----
# The "caretEnsemble" package allows you to combine the predictions of multiple
# caret models.

## caretEnsemble::caretStack() ----
# Given a list of caret models, the "caretStack()" function (in the
# "caretEnsemble" package) can be used to specify a higher-order model to
# learn how to best combine together the predictions of sub-models.

## caretEnsemble::caretList() ----
# The "caretList()" function provided by the "caretEnsemble" package can be
# used to create a list of standard caret models.

# Example of Stacking algorithms
train_index <- createDataPartition(teeth_Num$Disease,
                                   p = 0.75,
                                   list = FALSE)
teeth_disease_train <- teeth_Num[train_index, ]
teeth_disease_test <- teeth_Num[-train_index, ]
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3,
                              savePredictions = "final", classProbs = F)
set.seed(7)

sapply(teeth_disease_train, class)
data2$x2 <- as.factor(data2$x2) 
teeth_disease_train$Disease<-as.factor(teeth_disease_train$Disease)
sapply(teeth_disease_train, class)

algorithm_list <- c( "knn", "rpart","svmRadial")
models <- caretList(Disease ~ ., data = teeth_disease_train, trControl = train_control,
                    methodList = algorithm_list)

# Summarize results before stacking
results <- resamples(models)
summary(results)
dotplot(results)

# The predictions made by the sub-models that are combined using stacking
# should have a low-correlation (for diversity amongst the sub-models, i.e.,
# different sub-models are accurate in different ways). If the predictions for
# the sub-models were highly correlated (> 0.75) then they would be making the
# same or very similar predictions most of the time reducing the benefit of
# combining the predictions.

# correlation between results
modelCor(results)
splom(results)

#saving the model ----
# We print a summary of what caret has done
print(teeth_caret_model_svm_radial)
print(teeth_caret_model_knn)
print(teeth_caret_model_nb)
print(teeth_caret_model_rpart)

# We then print the details of the model that has been created
print(teeth_caret_model_svm_radial$finalModel)
print(teeth_caret_model_knn$finalModel)
print(teeth_caret_model_nb$finalModel)
print(teeth_caret_model_rpart$finalModel)

#  Test the Model ----
# We can test the model
set.seed(9)
predictions <- predict(teeth_caret_model_nb, newdata = teeth_disease_test)
confusionMatrix(predictions,as.factor(teeth_disease_test$Disease))

set.seed(9)
predictions <- predict(teeth_caret_model_svm_radial, newdata = teeth_disease_test)
confusionMatrix(predictions,as.factor(teeth_disease_test$Disease))

set.seed(9)
predictions <- predict(teeth_caret_model_knn, newdata = teeth_disease_test)
confusionMatrix(predictions,as.factor(teeth_disease_test$Disease))

set.seed(9)
predictions <- predict(teeth_caret_model_rpart, newdata = teeth_disease_test)
confusionMatrix(predictions,as.factor(teeth_disease_test$Disease))

saveRDS(teeth_caret_model_svm_radial, "./models/saved_teeth_caret_model_svm_radial.rds")
# The saved model can then be loaded later as follows:
loaded_teeth_caret_model_svm_radial <- readRDS("./models/saved_teeth_caret_model_svm_radial.rds")
print(loaded_teeth_caret_model_svm_radial)



# consume the plumber api ----
get_gumDisease_predictions <-
  function(arg_symptomOne, arg_symptomTwo, arg_symptomThree) {
    base_url <- "http://127.0.0.1:5022/gumDisease"
    
    params <- list(arg_symptomOne = arg_symptomOne, arg_symptomTwo = arg_symptomTwo,
                   arg_symptomThree = arg_symptomThree)
    
    query_url <- modify_url(url = base_url, query = params)
    
    model_prediction <- GET(query_url)
    
    model_prediction_raw <- content(model_prediction, as = "text",
                                    encoding = "utf-8")
    
    jsonlite::fromJSON(model_prediction_raw)
  }

# get oral cancer
get_gumDisease_predictions(8,7,6)

# gets periodontits
get_gumDisease_predictions(15,14,2)





