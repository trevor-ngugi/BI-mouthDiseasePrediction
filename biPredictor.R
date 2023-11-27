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

### 1.c. Decision tree for a classification problem with caret ----
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

### 3.c. kNN for a classification problem with CARET's train function ----
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




