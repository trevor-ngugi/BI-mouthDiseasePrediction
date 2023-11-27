Business Intelligence Lab Submission Markdown
================
<trevor ngugi>
\<27/11/2023\>

  - [Student Details](#student-details)
  - [Setup Chunk](#setup-chunk)
  - [Loading the gum disease Dataset](#loading-the-gum-disease-dataset)
  - [Explatory data analysis](#explatory-data-analysis)
      - [Dimensions](#dimensions)
      - [Data Types](#data-types)
  - [Descriptive Statistics](#descriptive-statistics)
      - [Measures of Frequency](#measures-of-frequency)
      - [Measures of
        Distribution/Dispersion/Spread/Scatter/Variability](#measures-of-distributiondispersionspreadscattervariability)
      - [changing the symptom into numeric
        values](#changing-the-symptom-into-numeric-values)
      - [univariate plots](#univariate-plots)
          - [Create Box and Whisker Plots for Each Numeric
            Attribute](#create-box-and-whisker-plots-for-each-numeric-attribute)
          - [Create Bar Plots for Each Categorical
            Attribute](#create-bar-plots-for-each-categorical-attribute)
          - [Create a Missingness Map to Identify Missing
            Data](#create-a-missingness-map-to-identify-missing-data)
      - [multivariate plots](#multivariate-plots)
          - [Create a Correlation Plot](#create-a-correlation-plot)
  - [preprocessing and data
    transformation](#preprocessing-and-data-transformation)
      - [Confirm the “missingness” in the Dataset before
        Imputation](#confirm-the-missingness-in-the-dataset-before-imputation)
  - [Selection of model](#selection-of-model)
      - [Split the dataset](#split-the-dataset)
      - [1. Decision tree for a classification problem with
        caret](#1-decision-tree-for-a-classification-problem-with-caret)
      - [2. Naïve Bayes](#2-naïve-bayes)
      - [3. kNN for a classification problem with CARET’s train
        function](#3-knn-for-a-classification-problem-with-carets-train-function)
      - [4. SVM Classifier for a classification problem with
        CARET](#4-svm-classifier-for-a-classification-problem-with-caret)
      - [Call the `resamples` Function](#call-the-resamples-function)
      - [Display the Results](#display-the-results)
          - [1. Table Summary](#1-table-summary)
          - [2. Box and Whisker Plot](#2-box-and-whisker-plot)
          - [3. Dot Plots](#3-dot-plots)
          - [4. Scatter Plot Matrix](#4-scatter-plot-matrix)
          - [5. Pairwise xyPlots](#5-pairwise-xyplots)
          - [6. Statistical Significance
            Tests](#6-statistical-significance-tests)
  - [Stacking](#stacking)
      - [Example of Stacking
        algorithms](#example-of-stacking-algorithms)
  - [\<You can Provide Another Appropriate Title Here if you
    wish\>](#you-can-provide-another-appropriate-title-here-if-you-wish)
      - [\<You Can Have a Sub-Title Here if you
        wish\>](#you-can-have-a-sub-title-here-if-you-wish)
      - [\<You Can Have Another Sub-Title Here if you
        wish\>](#you-can-have-another-sub-title-here-if-you-wish)

# Student Details

<table>
<colgroup>
<col style="width: 23%" />
<col style="width: 76%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>Student ID Numbers and Names of Group Members</strong></td>
<td><ol type="1">
<li>133996 - B - Trevor ngugi</li>
</ol></td>
</tr>
<tr class="even">
<td><strong>GitHub Classroom Group Name</strong></td>
<td>champions</td>
</tr>
<tr class="odd">
<td><strong>Course Code</strong></td>
<td>BBT4206</td>
</tr>
<tr class="even">
<td><strong>Course Name</strong></td>
<td>Business Intelligence II</td>
</tr>
<tr class="odd">
<td><strong>Program</strong></td>
<td>Bachelor of Business Information Technology</td>
</tr>
<tr class="even">
<td><strong>Semester Duration</strong></td>
<td>21<sup>st</sup> August 2023 to 28<sup>th</sup> November 2023</td>
</tr>
</tbody>
</table>

# Setup Chunk

We start by installing all the required packages

``` r
## formatR - Required to format R code in the markdown ----
if (!is.element("formatR", installed.packages()[, 1])) {
  install.packages("formatR", dependencies = TRUE,
                   repos="https://cloud.r-project.org")
}
require("formatR")


## readr - Load datasets from CSV files ----
if (!is.element("readr", installed.packages()[, 1])) {
  install.packages("readr", dependencies = TRUE,
                   repos="https://cloud.r-project.org")
}
require("readr")

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
```

-----

**Note:** the following “*KnitR*” options have been set as the defaults
in this markdown:  
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE,
collapse = FALSE, tidy.opts = list(width.cutoff = 80), tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

``` r
knitr::opts_chunk$set(
    eval = TRUE,
    echo = TRUE,
    warning = FALSE,
    collapse = FALSE,
    tidy = TRUE
)
```

-----

**Note:** the following “*R Markdown*” options have been set as the
defaults in this markdown:

> output:  
>   
> github\_document:  
> toc: yes  
> toc\_depth: 4  
> fig\_width: 6  
> fig\_height: 4  
> df\_print: default  
>   
> editor\_options:  
> chunk\_output\_type: console

# Loading the gum disease Dataset

The gum disease datatset is then loaded. The dataset and its metadata
are available here:
<https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>

``` r
library(readr)
Data_of_teeth <- read_csv("../data/Data of teeth.csv")
```

    ## New names:
    ## Rows: 54 Columns: 6
    ## ── Column specification
    ## ──────────────────────────────────────────────────────── Delimiter: "," chr
    ## (5): Symptom 1, Symptom 2, Symptom 3, Disease, Treatment lgl (1): ...6
    ## ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
    ## Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## • `` -> `...6`

# Explatory data analysis

## Dimensions

Dimensions refer to the number of observations (rows) and the number of
attributes/variables/features (columns). Execute the following commands
to display the dimensions of your datasets:

``` r
dim(Data_of_teeth)
```

    ## [1] 54  6

## Data Types

Knowing the data types will help you to identify the most appropriate
visualization types and algorithms that can be applied. It can also help
you to identify the need to convert from categorical data (factors) to
integers or vice versa where necessary. Execute the following command to
identify the data types:

``` r
sapply(Data_of_teeth, class)
```

    ##   Symptom 1   Symptom 2   Symptom 3     Disease   Treatment        ...6 
    ## "character" "character" "character" "character" "character"   "logical"

# Descriptive Statistics

## Measures of Frequency

``` r
disease_density_freq <- Data_of_teeth$Disease
cbind(frequency = table(disease_density_freq), percentage = prop.table(table(disease_density_freq)) *
    100)
```

    ##                         frequency percentage
    ## cavity                          6   11.11111
    ## dentin hypersensitivity         6   11.11111
    ## Mouth Sores                     6   11.11111
    ## Oral Cancer                     6   11.11111
    ## Periodontitis                  24   44.44444
    ## Tooth Erosion                   6   11.11111

``` r
symptom1_density_freq <- Data_of_teeth$"Symptom 1"
cbind(frequency = table(symptom1_density_freq), percentage = prop.table(table(symptom1_density_freq)) *
    100)
```

    ##                                     frequency percentage
    ## a cracked tooth                             2   3.703704
    ## Bad breath                                  6  11.111111
    ## Black, white, or brown tooth stains         2   3.703704
    ## bleeding                                    2   3.703704
    ## Cracked or chipped teeth                    2   3.703704
    ## Difficulty chewing or swallowing            2   3.703704
    ## Dramatic weight loss                        2   3.703704
    ## Ear Pain                                    2   3.703704
    ## Grooves on your teeth’s surface             2   3.703704
    ## gum disease                                 2   3.703704
    ## Holes or pits in your teeth                 2   3.703704
    ## pain                                        2   3.703704
    ## Pain when you bite down                     2   3.703704
    ## Painful chewing                             6  11.111111
    ## Red and swollen gums                        6  11.111111
    ## sore throat                                 2   3.703704
    ## Tender or bleeding gums                     6  11.111111
    ## worn-down fillings or crowns                2   3.703704
    ## Yellowish discoloration                     2   3.703704

``` r
symptom2_density_freq <- Data_of_teeth$"Symptom 2"
cbind(frequency = table(symptom2_density_freq), percentage = prop.table(table(symptom2_density_freq)) *
    100)
```

    ##                                     frequency percentage
    ## a cracked tooth                             2   3.703704
    ## Bad breath                                  6  11.111111
    ## Black, white, or brown tooth stains         2   3.703704
    ## bleeding                                    2   3.703704
    ## Cracked or chipped teeth                    2   3.703704
    ## Difficulty chewing or swallowing            2   3.703704
    ## Dramatic weight loss                        2   3.703704
    ## Ear Pain                                    2   3.703704
    ## Grooves on your teeth’s surface             2   3.703704
    ## gum disease                                 2   3.703704
    ## Holes or pits in your teeth                 2   3.703704
    ## pain                                        2   3.703704
    ## Pain when you bite down                     2   3.703704
    ## Painful chewing                             6  11.111111
    ## Red and swollen gums                        6  11.111111
    ## sore throat                                 2   3.703704
    ## Tender or bleeding gums                     6  11.111111
    ## worn-down fillings or crowns                2   3.703704
    ## Yellowish discoloration                     2   3.703704

``` r
symptom3_density_freq <- Data_of_teeth$"Symptom 3"
cbind(frequency = table(symptom3_density_freq), percentage = prop.table(table(symptom3_density_freq)) *
    100)
```

    ##                                     frequency percentage
    ## a cracked tooth                             2   3.703704
    ## Bad breath                                  6  11.111111
    ## Black, white, or brown tooth stains         2   3.703704
    ## bleeding                                    2   3.703704
    ## Cracked or chipped teeth                    2   3.703704
    ## Difficulty chewing or swallowing            2   3.703704
    ## Dramatic weight loss                        2   3.703704
    ## Ear Pain                                    2   3.703704
    ## Grooves on your teeth’s surface             2   3.703704
    ## gum disease                                 2   3.703704
    ## Holes or pits in your teeth                 2   3.703704
    ## pain                                        2   3.703704
    ## Pain when you bite down                     2   3.703704
    ## Painful chewing                             6  11.111111
    ## Red and swollen gums                        6  11.111111
    ## sore throat                                 2   3.703704
    ## Tender or bleeding gums                     6  11.111111
    ## worn-down fillings or crowns                2   3.703704
    ## Yellowish discoloration                     2   3.703704

``` r
treatment_density_freq <- Data_of_teeth$Treatment
cbind(frequency = table(treatment_density_freq), percentage = prop.table(table(treatment_density_freq)) *
    100)
```

    ##                                  frequency percentage
    ## Brush your teeth with warm water         6   11.11111
    ## Chew sugar-free gum                      6   11.11111
    ## Cryotherapy                              6   11.11111
    ## Eat a well balanced diet                 6   11.11111
    ## mouthwash                                6   11.11111
    ## Tooth polishing                         24   44.44444

## Measures of Distribution/Dispersion/Spread/Scatter/Variability

``` r
summary(Data_of_teeth)
```

    ##   Symptom 1          Symptom 2          Symptom 3           Disease         
    ##  Length:54          Length:54          Length:54          Length:54         
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##   Treatment           ...6        
    ##  Length:54          Mode:logical  
    ##  Class :character   NA's:54       
    ##  Mode  :character

## changing the symptom into numeric values

``` r
# Coding scheme for symptoms
symptom_coding <- c(`a cracked tooth` = 1, `Bad breath` = 2, `Black, white, or brown tooth stains` = 3,
    bleeding = 4, `Cracked or chipped teeth` = 5, `Difficulty chewing or swallowing` = 6,
    `Dramatic weight loss` = 7, `Ear Pain` = 8, `Grooves on your teeth’s surface` = 9,
    `gum disease` = 10, `Holes or pits in your teeth` = 11, pain = 12, `Pain when you bite down` = 13,
    `Painful chewing` = 14, `Red and swollen gums` = 15, `sore throat` = 16, `Tender or bleeding gums` = 17,
    `worn-down fillings or crowns` = 18, `Yellowish discoloration` = 19)

# Applying coding scheme to create a new column
teeth_Num <- Data_of_teeth
teeth_Num$symptom1 <- symptom_coding[Data_of_teeth$"Symptom 1"]
teeth_Num$symptom2 <- symptom_coding[Data_of_teeth$"Symptom 2"]
teeth_Num$symptom3 <- symptom_coding[Data_of_teeth$"Symptom 3"]
```

## univariate plots

### Create Box and Whisker Plots for Each Numeric Attribute

``` r
boxplot(teeth_Num[, 7], main = names(teeth_Num)[7])
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%207%20Code%20Chunk-1.png)<!-- -->

``` r
boxplot(teeth_Num[, 8], main = names(teeth_Num)[8])
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%207%20Code%20Chunk-2.png)<!-- -->

``` r
boxplot(teeth_Num[, 9], main = names(teeth_Num)[9])
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%207%20Code%20Chunk-3.png)<!-- -->

### Create Bar Plots for Each Categorical Attribute

``` r
barplot(table(teeth_Num[, 4]), main = names(teeth_Num)[4])
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%208%20Code%20Chunk-1.png)<!-- -->

### Create a Missingness Map to Identify Missing Data

``` r
missmap(Data_of_teeth, col = c("red", "grey"), legend = TRUE)
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%209%20Code%20Chunk-1.png)<!-- -->

## multivariate plots

### Create a Correlation Plot

Correlation plots can be used to get an idea of which attributes change
together. The function “corrplot()” found in the package “corrplot” is
required to perform this. The larger the dot in the correlation plot,
the larger the correlation. Blue represents a positive correlation
whereas red represents a negative correlation.

``` r
corrplot(cor(teeth_Num[, 7:9]), method = "circle")
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2010%20Code%20Chunk-1.png)<!-- -->

Alternatively, the ‘ggcorrplot::ggcorrplot()’ function can be used to
plot a more visually appealing plot.

``` r
ggcorrplot(cor(teeth_Num[, 7:9]))
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2011%20Code%20Chunk-1.png)<!-- -->

# preprocessing and data transformation

## Confirm the “missingness” in the Dataset before Imputation

Are there missing values in the dataset?

``` r
any_na(Data_of_teeth)
```

    ## [1] TRUE

``` r
any_na(teeth_Num)
```

    ## [1] TRUE

How many?

``` r
n_miss(Data_of_teeth)
```

    ## [1] 54

``` r
n_miss(teeth_Num)
```

    ## [1] 54

What is the percentage of missing data in the entire dataset?

``` r
prop_miss(Data_of_teeth)
```

    ## [1] 0.1666667

``` r
prop_miss(teeth_Num)
```

    ## [1] 0.1111111

How many missing values does each variable have?

``` r
Data_of_teeth %>%
    is.na() %>%
    colSums()
```

    ## Symptom 1 Symptom 2 Symptom 3   Disease Treatment      ...6 
    ##         0         0         0         0         0        54

``` r
teeth_Num %>%
    is.na() %>%
    colSums()
```

    ## Symptom 1 Symptom 2 Symptom 3   Disease Treatment      ...6  symptom1  symptom2 
    ##         0         0         0         0         0        54         0         0 
    ##  symptom3 
    ##         0

What is the number and percentage of missing values grouped by each
variable?

``` r
miss_var_summary(Data_of_teeth)
```

    ## # A tibble: 6 × 3
    ##   variable  n_miss pct_miss
    ##   <chr>      <int>    <dbl>
    ## 1 ...6          54      100
    ## 2 Symptom 1      0        0
    ## 3 Symptom 2      0        0
    ## 4 Symptom 3      0        0
    ## 5 Disease        0        0
    ## 6 Treatment      0        0

``` r
miss_var_summary(teeth_Num)
```

    ## # A tibble: 9 × 3
    ##   variable  n_miss pct_miss
    ##   <chr>      <int>    <dbl>
    ## 1 ...6          54      100
    ## 2 Symptom 1      0        0
    ## 3 Symptom 2      0        0
    ## 4 Symptom 3      0        0
    ## 5 Disease        0        0
    ## 6 Treatment      0        0
    ## 7 symptom1       0        0
    ## 8 symptom2       0        0
    ## 9 symptom3       0        0

remove the column that has misssing data

``` r
Data_of_teeth <- Data_of_teeth[-6]
teeth_Num <- teeth_Num[-6]
```

remove the symptom columns that have character values

``` r
teeth_Num <- teeth_Num[, -1:-3]
```

remove the treatment columns that have character values

``` r
teeth_Num <- teeth_Num[-2]
```

confirm if there is missing data

``` r
any_na(Data_of_teeth)
```

    ## [1] FALSE

``` r
any_na(teeth_Num)
```

    ## [1] FALSE

# Selection of model

## Split the dataset

Define a 75:25 train:test data split of the dataset. That is, 75% of the
original data will be used to train the model and 25% of the original
data will be used to test the model.

``` r
train_index <- createDataPartition(teeth_Num$Disease, p = 0.75, list = FALSE)
teeth_disease_train <- teeth_Num[train_index, ]
teeth_disease_test <- teeth_Num[-train_index, ]
```

## 1\. Decision tree for a classification problem with caret

``` r
### Train the model
set.seed(7)
# We apply the 5-fold cross validation resampling method
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_rpart <- train(Disease ~ ., data = teeth_Num, method = "rpart",
    metric = "Accuracy", trControl = train_control)

# Display the model's details
print(teeth_caret_model_rpart)
```

    ## CART 
    ## 
    ## 54 samples
    ##  3 predictor
    ##  6 classes: 'cavity', 'dentin hypersensitivity', 'Mouth Sores', 'Oral Cancer', 'Periodontitis', 'Tooth Erosion' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 43, 44, 43, 44, 42 
    ## Resampling results across tuning parameters:
    ## 
    ##   cp    Accuracy   Kappa    
    ##   0.00  0.5381818  0.3276063
    ##   0.05  0.5381818  0.3276063
    ##   0.10  0.5181818  0.2488184
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was cp = 0.05.

``` r
# Make predictions
predictions <- predict(teeth_caret_model_rpart, teeth_disease_test[, 2:4], type = "raw")

# Display the model's evaluation metrics
table(predictions, teeth_disease_test$Disease)
```

    ##                          
    ## predictions               cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       1                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                0                       1           1
    ##   Tooth Erosion                0                       0           0
    ##                          
    ## predictions               Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             0
    ##   Periodontitis                     0             6             1
    ##   Tooth Erosion                     0             0             0

``` r
confusion_matrix <- caret::confusionMatrix(predictions, as.factor(teeth_disease_test[,
    1:4]$Disease))
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##                          Reference
    ## Prediction                cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       1                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                0                       1           1
    ##   Tooth Erosion                0                       0           0
    ##                          Reference
    ## Prediction                Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             0
    ##   Periodontitis                     0             6             1
    ##   Tooth Erosion                     0             0             0
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.7273          
    ##                  95% CI : (0.3903, 0.9398)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.1829          
    ##                                           
    ##                   Kappa : 0.4923          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                1.00000                        0.00000
    ## Specificity                1.00000                        1.00000
    ## Pos Pred Value             1.00000                            NaN
    ## Neg Pred Value             1.00000                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.09091                        0.00000
    ## Detection Prevalence       0.09091                        0.00000
    ## Balanced Accuracy          1.00000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            1.00000               0.4000
    ## Pos Pred Value                      NaN            1.00000               0.6667
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.09091               0.8182
    ## Balanced Accuracy               0.50000            1.00000               0.7000
    ##                      Class: Tooth Erosion
    ## Sensitivity                       0.00000
    ## Specificity                       1.00000
    ## Pos Pred Value                        NaN
    ## Neg Pred Value                    0.90909
    ## Prevalence                        0.09091
    ## Detection Rate                    0.00000
    ## Detection Prevalence              0.00000
    ## Balanced Accuracy                 0.50000

## 2\. Naïve Bayes

``` r
#### Train the model ---- We apply the 5-fold cross validation resampling
#### method
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_nb <- train(Disease ~ ., data = teeth_disease_train, method = "nb",
    metric = "Accuracy", trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_nb)
```

    ## Naive Bayes 
    ## 
    ## 43 samples
    ##  3 predictor
    ##  6 classes: 'cavity', 'dentin hypersensitivity', 'Mouth Sores', 'Oral Cancer', 'Periodontitis', 'Tooth Erosion' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 35, 34, 34, 34, 35 
    ## Resampling results across tuning parameters:
    ## 
    ##   usekernel  Accuracy   Kappa    
    ##   FALSE      0.4638889  0.1858009
    ##    TRUE      0.7194444  0.6113501
    ## 
    ## Tuning parameter 'fL' was held constant at a value of 0
    ## Tuning
    ##  parameter 'adjust' was held constant at a value of 1
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were fL = 0, usekernel = TRUE and adjust
    ##  = 1.

``` r
#### Make predictions ----
predictions <- predict(teeth_caret_model_nb, teeth_disease_test[, 2:4])

#### Display the model's evaluation metrics ----
confusion_matrix <- caret::confusionMatrix(predictions, as.factor(teeth_disease_test[,
    1:4]$Disease))
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##                          Reference
    ## Prediction                cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       0                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                1                       1           1
    ##   Tooth Erosion                0                       0           0
    ##                          Reference
    ## Prediction                Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             0
    ##   Periodontitis                     0             6             0
    ##   Tooth Erosion                     0             0             1
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.7273          
    ##                  95% CI : (0.3903, 0.9398)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.1829          
    ##                                           
    ##                   Kappa : 0.4923          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                0.00000                        0.00000
    ## Specificity                1.00000                        1.00000
    ## Pos Pred Value                 NaN                            NaN
    ## Neg Pred Value             0.90909                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.00000                        0.00000
    ## Detection Prevalence       0.00000                        0.00000
    ## Balanced Accuracy          0.50000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            1.00000               0.4000
    ## Pos Pred Value                      NaN            1.00000               0.6667
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.09091               0.8182
    ## Balanced Accuracy               0.50000            1.00000               0.7000
    ##                      Class: Tooth Erosion
    ## Sensitivity                       1.00000
    ## Specificity                       1.00000
    ## Pos Pred Value                    1.00000
    ## Neg Pred Value                    1.00000
    ## Prevalence                        0.09091
    ## Detection Rate                    0.09091
    ## Detection Prevalence              0.09091
    ## Balanced Accuracy                 1.00000

## 3\. kNN for a classification problem with CARET’s train function

``` r
set.seed(7)
train_control <- trainControl(method = "cv", number = 10)
teeth_caret_model_knn <- train(Disease ~ ., data = teeth_Num, method = "knn", metric = "Accuracy",
    preProcess = c("center", "scale"), trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_knn)
```

    ## k-Nearest Neighbors 
    ## 
    ## 54 samples
    ##  3 predictor
    ##  6 classes: 'cavity', 'dentin hypersensitivity', 'Mouth Sores', 'Oral Cancer', 'Periodontitis', 'Tooth Erosion' 
    ## 
    ## Pre-processing: centered (3), scaled (3) 
    ## Resampling: Cross-Validated (10 fold) 
    ## Summary of sample sizes: 50, 49, 48, 47, 47, 48, ... 
    ## Resampling results across tuning parameters:
    ## 
    ##   k  Accuracy   Kappa    
    ##   5  0.5633333  0.2768057
    ##   7  0.5633333  0.2160556
    ##   9  0.5633333  0.2160556
    ## 
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final value used for the model was k = 9.

``` r
#### Make predictions ----
predictions <- predict(teeth_caret_model_knn, teeth_disease_test[, 2:4])

#### Display the model's evaluation metrics ----
confusion_matrix <- caret::confusionMatrix(predictions, as.factor(teeth_disease_test[,
    1:4]$Disease))
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##                          Reference
    ## Prediction                cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       0                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                1                       1           1
    ##   Tooth Erosion                0                       0           0
    ##                          Reference
    ## Prediction                Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             0
    ##   Periodontitis                     0             6             1
    ##   Tooth Erosion                     0             0             0
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.6364          
    ##                  95% CI : (0.3079, 0.8907)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.3853          
    ##                                           
    ##                   Kappa : 0.2667          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                0.00000                        0.00000
    ## Specificity                1.00000                        1.00000
    ## Pos Pred Value                 NaN                            NaN
    ## Neg Pred Value             0.90909                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.00000                        0.00000
    ## Detection Prevalence       0.00000                        0.00000
    ## Balanced Accuracy          0.50000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            1.00000               0.2000
    ## Pos Pred Value                      NaN            1.00000               0.6000
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.09091               0.9091
    ## Balanced Accuracy               0.50000            1.00000               0.6000
    ##                      Class: Tooth Erosion
    ## Sensitivity                       0.00000
    ## Specificity                       1.00000
    ## Pos Pred Value                        NaN
    ## Neg Pred Value                    0.90909
    ## Prevalence                        0.09091
    ## Detection Rate                    0.00000
    ## Detection Prevalence              0.00000
    ## Balanced Accuracy                 0.50000

## 4\. SVM Classifier for a classification problem with CARET

``` r
#### Train the model ----
set.seed(7)
train_control <- trainControl(method = "cv", number = 5)
teeth_caret_model_svm_radial <- # nolint: object_length_linter.
  train(Disease ~ ., data = teeth_disease_train, method = "svmRadial",
        metric = "Accuracy", trControl = train_control)

#### Display the model's details ----
print(teeth_caret_model_svm_radial)
```

    ## Support Vector Machines with Radial Basis Function Kernel 
    ## 
    ## 43 samples
    ##  3 predictor
    ##  6 classes: 'cavity', 'dentin hypersensitivity', 'Mouth Sores', 'Oral Cancer', 'Periodontitis', 'Tooth Erosion' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (5 fold) 
    ## Summary of sample sizes: 35, 34, 34, 34, 35 
    ## Resampling results across tuning parameters:
    ## 
    ##   C     Accuracy   Kappa    
    ##   0.25  0.4166667  0.0000000
    ##   0.50  0.5333333  0.2452381
    ##   1.00  0.5333333  0.2452381
    ## 
    ## Tuning parameter 'sigma' was held constant at a value of 0.3597508
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were sigma = 0.3597508 and C = 0.5.

``` r
#### Make predictions ----
predictions <- predict(teeth_caret_model_svm_radial,
                       teeth_disease_test[, 2:4])

#### Display the model's evaluation metrics ----
table(predictions, teeth_disease_test$Disease)
```

    ##                          
    ## predictions               cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       0                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                1                       1           1
    ##   Tooth Erosion                0                       0           0
    ##                          
    ## predictions               Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             0
    ##   Periodontitis                     0             6             1
    ##   Tooth Erosion                     0             0             0

``` r
confusion_matrix <-
  caret::confusionMatrix(predictions,
                         as.factor(teeth_disease_test[, 1:4]$Disease))
print(confusion_matrix)
```

    ## Confusion Matrix and Statistics
    ## 
    ##                          Reference
    ## Prediction                cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       0                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                1                       1           1
    ##   Tooth Erosion                0                       0           0
    ##                          Reference
    ## Prediction                Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             0
    ##   Periodontitis                     0             6             1
    ##   Tooth Erosion                     0             0             0
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.6364          
    ##                  95% CI : (0.3079, 0.8907)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.3853          
    ##                                           
    ##                   Kappa : 0.2667          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                0.00000                        0.00000
    ## Specificity                1.00000                        1.00000
    ## Pos Pred Value                 NaN                            NaN
    ## Neg Pred Value             0.90909                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.00000                        0.00000
    ## Detection Prevalence       0.00000                        0.00000
    ## Balanced Accuracy          0.50000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            1.00000               0.2000
    ## Pos Pred Value                      NaN            1.00000               0.6000
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.09091               0.9091
    ## Balanced Accuracy               0.50000            1.00000               0.6000
    ##                      Class: Tooth Erosion
    ## Sensitivity                       0.00000
    ## Specificity                       1.00000
    ## Pos Pred Value                        NaN
    ## Neg Pred Value                    0.90909
    ## Prevalence                        0.09091
    ## Detection Rate                    0.00000
    ## Detection Prevalence              0.00000
    ## Balanced Accuracy                 0.50000

\#model performance comparison

``` r
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

### CART ----
set.seed(7)
teeth_model_cart <- train(Disease ~ ., data = teeth_Num, method = "rpart", trControl = train_control)

### KNN ----
set.seed(7)
teeth_model_knn <- train(Disease ~ ., data = teeth_Num, method = "knn", trControl = train_control)

### SVM ----
set.seed(7)
teeth_model_svm <- train(Disease ~ ., data = teeth_Num, method = "svmRadial", trControl = train_control)

### naive bayes ----
set.seed(7)
teeth_model_nb <- train(Disease ~ ., data = teeth_Num, method = "nb", trControl = train_control)
```

## Call the `resamples` Function

We then create a list of the model results and pass the list as an
argument to the `resamples` function.

``` r
results <- resamples(list(CART = teeth_model_cart, KNN = teeth_model_knn, SVM = teeth_model_svm,
    NB = teeth_model_nb))
```

## Display the Results

### 1\. Table Summary

This is the simplest comparison. It creates a table with one model per
row and its corresponding evaluation metrics displayed per column.

``` r
summary(results)
```

    ## 
    ## Call:
    ## summary.resamples(object = results)
    ## 
    ## Models: CART, KNN, SVM, NB 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##           Min.   1st Qu.    Median      Mean 3rd Qu. Max. NA's
    ## CART 0.1428571 0.4071429 0.5000000 0.5219841     0.6  0.8    0
    ## KNN  0.4000000 0.5000000 0.5357143 0.5709524     0.6  1.0    0
    ## SVM  0.4000000 0.5000000 0.5000000 0.5642857     0.6  1.0    0
    ## NB   0.4000000 0.6666667 0.7500000 0.7392063     0.8  1.0    0
    ## 
    ## Kappa 
    ##       Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
    ## CART -0.05 0.1750000 0.2679426 0.2837909 0.4088235 0.5833333    0
    ## KNN   0.00 0.1428571 0.3076923 0.3013094 0.4088235 1.0000000    0
    ## SVM   0.00 0.0000000 0.2800000 0.2466772 0.3750000 1.0000000    0
    ## NB    0.00 0.4736842 0.6136163 0.5929589 0.7331871 1.0000000    0

### 2\. Box and Whisker Plot

This is useful for visually observing the spread of the estimated
accuracies for different algorithms and how they relate.

``` r
scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%20266%20Code%20Chunk-1.png)<!-- -->

### 3\. Dot Plots

They show both the mean estimated accuracy as well as the 95% confidence
interval (e.g. the range in which 95% of observed scores fell).

``` r
scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2027%20Code%20Chunk-1.png)<!-- -->

### 4\. Scatter Plot Matrix

This is useful when considering whether the predictions from two
different algorithms are correlated. If weakly correlated, then they are
good candidates for being combined in an ensemble prediction.

``` r
splom(results)
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%20277%20Code%20Chunk-1.png)<!-- -->

### 5\. Pairwise xyPlots

You can zoom in on one pairwise comparison of the accuracy of
trial-folds for two models using an xyplot.

``` r
# xyplot plots to compare models
xyplot(results, models = c("KNN", "SVM"))
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2028%20Code%20Chunk-1.png)<!-- -->

``` r
# xyplot plots to compare models
xyplot(results, models = c("SVM", "CART"))
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2028%20Code%20Chunk-2.png)<!-- -->

``` r
# xyplot plots to compare models
xyplot(results, models = c("KNN", "CART"))
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2028%20Code%20Chunk-3.png)<!-- -->

``` r
# xyplot plots to compare models
xyplot(results, models = c("KNN", "NB"))
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2028%20Code%20Chunk-4.png)<!-- -->

``` r
# or xyplot plots to compare models
xyplot(results, models = c("NB", "CART"))
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2028%20Code%20Chunk-5.png)<!-- -->

### 6\. Statistical Significance Tests

This is used to calculate the significance of the differences between
the metric distributions of the various models.

Upper Diagonal The upper diagonal of the table shows the estimated
difference between the distributions. If we think that LDA is the most
accurate model from looking at the previous graphs, we can get an
estimate of how much better it is than specific other models in terms of
absolute accuracy.

Lower Diagonal The lower diagonal contains p-values of the null
hypothesis. The null hypothesis is a claim that “the distributions are
the same”. A lower p-value is better (more significant).

``` r
diffs <- diff(results)

summary(diffs)
```

    ## 
    ## Call:
    ## summary.diff.resamples(object = diffs)
    ## 
    ## p-value adjustment: bonferroni 
    ## Upper diagonal: estimates of the difference
    ## Lower diagonal: p-value for H0: difference = 0
    ## 
    ## Accuracy 
    ##      CART      KNN       SVM       NB       
    ## CART           -0.048968 -0.042302 -0.217222
    ## KNN  0.04209              0.006667 -0.168254
    ## SVM  0.08219   1.00000             -0.174921
    ## NB   5.144e-09 1.394e-06 1.553e-06          
    ## 
    ## Kappa 
    ##      CART      KNN       SVM       NB      
    ## CART           -0.01752   0.03711  -0.30917
    ## KNN  1.00000              0.05463  -0.29165
    ## SVM  1.00000   0.01158             -0.34628
    ## NB   8.658e-07 1.359e-07 1.979e-07

# Stacking

The “caretEnsemble” package allows you to combine the predictions of
multiple caret models.

caretEnsemble::caretStack() Given a list of caret models, the
“caretStack()” function (in the “caretEnsemble” package) can be used
to specify a higher-order model to learn how to best combine together
the predictions of sub-models.

caretEnsemble::caretList() The “caretList()” function provided by the
“caretEnsemble” package can be used to create a list of standard caret
models.

## Example of Stacking algorithms

``` r
train_index <- createDataPartition(teeth_Num$Disease, p = 0.75, list = FALSE)
teeth_disease_train <- teeth_Num[train_index, ]
teeth_disease_test <- teeth_Num[-train_index, ]
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = "final",
    classProbs = F)
set.seed(7)

sapply(teeth_disease_train, class)
```

    ##     Disease    symptom1    symptom2    symptom3 
    ## "character"   "numeric"   "numeric"   "numeric"

``` r
teeth_disease_train$Disease <- as.factor(teeth_disease_train$Disease)
sapply(teeth_disease_train, class)
```

    ##   Disease  symptom1  symptom2  symptom3 
    ##  "factor" "numeric" "numeric" "numeric"

``` r
algorithm_list <- c("knn", "rpart", "svmRadial")
models <- caretList(Disease ~ ., data = teeth_disease_train, trControl = train_control,
    methodList = algorithm_list)

# Summarize results before stacking
results <- resamples(models)
summary(results)
```

    ## 
    ## Call:
    ## summary.resamples(object = results)
    ## 
    ## Models: knn, rpart, svmRadial 
    ## Number of resamples: 30 
    ## 
    ## Accuracy 
    ##           Min.  1st Qu.    Median      Mean   3rd Qu. Max. NA's
    ## knn       0.00 0.350000 0.5000000 0.5048413 0.6666667    1    0
    ## rpart     0.00 0.297619 0.3333333 0.3950794 0.5000000    1    0
    ## svmRadial 0.25 0.500000 0.5000000 0.5603968 0.6666667    1    0
    ## 
    ## Kappa 
    ##           Min. 1st Qu.     Median      Mean   3rd Qu.      Max. NA's
    ## knn       -0.2       0 0.09401709 0.1876858 0.3645833 1.0000000    0
    ## rpart     -0.5       0 0.14285714 0.1188706 0.2105263 0.4117647    1
    ## svmRadial  0.0       0 0.22222222 0.2072797 0.3750000 1.0000000    1

``` r
dotplot(results)
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2030%20Code%20Chunk-1.png)<!-- -->

The predictions made by the sub-models that are combined using stacking
should have a low-correlation (for diversity amongst the sub-models,
i.e., different sub-models are accurate in different ways). If the
predictions for the sub-models were highly correlated (\> 0.75) then
they would be making the same or very similar predictions most of the
time reducing the benefit of combining the predictions.

``` r
# correlation between results
modelCor(results)
```

    ##                 knn     rpart svmRadial
    ## knn       1.0000000 0.2369722 0.4812045
    ## rpart     0.2369722 1.0000000 0.7432532
    ## svmRadial 0.4812045 0.7432532 1.0000000

``` r
splom(results)
```

![](Lab-Submission-Markdown_files/figure-gfm/Your%2031%20Code%20Chunk-1.png)<!-- -->

# \<You can Provide Another Appropriate Title Here if you wish\>

``` r
# yes working
```

Describe the code chunk here:

``` r
# Fill this with R related code that will be executed when the R markdown file
```

## \<You Can Have a Sub-Title Here if you wish\>

``` r
# Fill this with other R related code that will be executed when the R markdown
```

## \<You Can Have Another Sub-Title Here if you wish\>

``` r
# Fill this with other R related code that will be executed when the R markdown
```

**etc.** as per the lab submission requirements. Be neat and communicate
in a clear and logical manner.
