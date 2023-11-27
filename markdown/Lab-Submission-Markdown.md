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
  - [saving the model](#saving-the-model)
      - [Test the Model](#test-the-model)
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

## plumber ----
if (require("plumber")) {
  require("plumber")
} else {
  install.packages("plumber", dependencies = TRUE,
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
    ##   cavity                       0                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  1                       0           1
    ##   Periodontitis                0                       1           0
    ##   Tooth Erosion                0                       0           0
    ##                          
    ## predictions               Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             1
    ##   Periodontitis                     0             6             0
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
    ##   cavity                       0                       0           0
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  1                       0           1
    ##   Periodontitis                0                       1           0
    ##   Tooth Erosion                0                       0           0
    ##                          Reference
    ## Prediction                Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             1
    ##   Periodontitis                     0             6             0
    ##   Tooth Erosion                     0             0             0
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.6364          
    ##                  95% CI : (0.3079, 0.8907)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.3853          
    ##                                           
    ##                   Kappa : 0.4133          
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
    ## Specificity                     1.00000            0.70000               0.8000
    ## Pos Pred Value                      NaN            0.25000               0.8571
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.36364               0.6364
    ## Balanced Accuracy               0.50000            0.85000               0.9000
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
    ##   FALSE      0.4666667  0.1741855
    ##    TRUE      0.7416667  0.6475088
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
    ##   cavity                       1                       0           1
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                0                       1           0
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
    ##                Accuracy : 0.8182          
    ##                  95% CI : (0.4822, 0.9772)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.0615          
    ##                                           
    ##                   Kappa : 0.7067          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                1.00000                        0.00000
    ## Specificity                0.90000                        1.00000
    ## Pos Pred Value             0.50000                            NaN
    ## Neg Pred Value             1.00000                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.09091                        0.00000
    ## Detection Prevalence       0.18182                        0.00000
    ## Balanced Accuracy          0.95000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            1.00000               0.8000
    ## Pos Pred Value                      NaN            1.00000               0.8571
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.09091               0.6364
    ## Balanced Accuracy               0.50000            1.00000               0.9000
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
    ##   1.00  0.4666667  0.1741855
    ## 
    ## Tuning parameter 'sigma' was held constant at a value of 0.1785134
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were sigma = 0.1785134 and C = 0.5.

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

# saving the model

We print a summary of what caret has done

``` r
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
    ##   1.00  0.4666667  0.1741855
    ## 
    ## Tuning parameter 'sigma' was held constant at a value of 0.1785134
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were sigma = 0.1785134 and C = 0.5.

``` r
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
    ##   FALSE      0.4666667  0.1741855
    ##    TRUE      0.7416667  0.6475088
    ## 
    ## Tuning parameter 'fL' was held constant at a value of 0
    ## Tuning
    ##  parameter 'adjust' was held constant at a value of 1
    ## Accuracy was used to select the optimal model using the largest value.
    ## The final values used for the model were fL = 0, usekernel = TRUE and adjust
    ##  = 1.

``` r
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

We then print the details of the model that has been created

``` r
print(teeth_caret_model_svm_radial$finalModel)
```

    ## Support Vector Machine object of class "ksvm" 
    ## 
    ## SV type: C-svc  (classification) 
    ##  parameter : cost C = 0.5 
    ## 
    ## Gaussian Radial Basis kernel function. 
    ##  Hyperparameter : sigma =  0.178513433186644 
    ## 
    ## Number of Support Vectors : 37 
    ## 
    ## Objective Function Value : -4.601 -4.7862 -4.2919 -4.7069 -4.5506 -4.6872 -3.2545 -4.8692 -4.8171 -3.5166 -4.932 -4.7747 -3.3726 -3.1853 -4.8076 
    ## Training error : 0.465116

``` r
print(teeth_caret_model_knn$finalModel)
```

    ## 9-nearest neighbor model
    ## Training set outcome distribution:
    ## 
    ##                  cavity dentin hypersensitivity             Mouth Sores 
    ##                       6                       6                       6 
    ##             Oral Cancer           Periodontitis           Tooth Erosion 
    ##                       6                      24                       6

``` r
print(teeth_caret_model_nb$finalModel)
```

    ## $apriori
    ## grouping
    ##                  cavity dentin hypersensitivity             Mouth Sores 
    ##               0.1162791               0.1162791               0.1162791 
    ##             Oral Cancer           Periodontitis           Tooth Erosion 
    ##               0.1162791               0.4186047               0.1162791 
    ## 
    ## $tables
    ## $tables$symptom1
    ## $tables$symptom1$cavity
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 0.9736
    ## 
    ##        x                  y            
    ##  Min.   : 0.07925   Min.   :5.119e-05  
    ##  1st Qu.: 4.03962   1st Qu.:4.537e-03  
    ##  Median : 8.00000   Median :3.527e-02  
    ##  Mean   : 8.00000   Mean   :6.301e-02  
    ##  3rd Qu.:11.96038   3rd Qu.:9.918e-02  
    ##  Max.   :15.92075   Max.   :1.940e-01  
    ## 
    ## $tables$symptom1$`dentin hypersensitivity`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 3.894
    ## 
    ##        x                  y            
    ##  Min.   :-10.6830   Min.   :0.0002301  
    ##  1st Qu.: -0.5915   1st Qu.:0.0066567  
    ##  Median :  9.5000   Median :0.0244934  
    ##  Mean   :  9.5000   Mean   :0.0247295  
    ##  3rd Qu.: 19.5915   3rd Qu.:0.0436925  
    ##  Max.   : 29.6830   Max.   :0.0488429  
    ## 
    ## $tables$symptom1$`Mouth Sores`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 1.947
    ## 
    ##        x                y            
    ##  Min.   :-1.842   Min.   :0.0004606  
    ##  1st Qu.: 4.079   1st Qu.:0.0144841  
    ##  Median :10.000   Median :0.0331564  
    ##  Mean   :10.000   Mean   :0.0421498  
    ##  3rd Qu.:15.921   3rd Qu.:0.0755700  
    ##  Max.   :21.842   Max.   :0.0970064  
    ## 
    ## $tables$symptom1$`Oral Cancer`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 0.4868
    ## 
    ##        x              y           
    ##  Min.   :4.54   Min.   :0.001841  
    ##  1st Qu.:5.77   1st Qu.:0.050646  
    ##  Median :7.00   Median :0.205948  
    ##  Mean   :7.00   Mean   :0.202861  
    ##  3rd Qu.:8.23   3rd Qu.:0.360453  
    ##  Max.   :9.46   Max.   :0.394462  
    ## 
    ## $tables$symptom1$Periodontitis
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (18 obs.);  Bandwidth 'bw' = 0.9419
    ## 
    ##        x                 y            
    ##  Min.   :-0.8258   Min.   :0.0000000  
    ##  1st Qu.: 4.3371   1st Qu.:0.0001397  
    ##  Median : 9.5000   Median :0.0152544  
    ##  Mean   : 9.5000   Mean   :0.0483441  
    ##  3rd Qu.:14.6629   3rd Qu.:0.0885276  
    ##  Max.   :19.8258   Max.   :0.1892684  
    ## 
    ## $tables$symptom1$`Tooth Erosion`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 4.187
    ## 
    ##        x                y            
    ##  Min.   :-7.561   Min.   :0.0002294  
    ##  1st Qu.: 2.220   1st Qu.:0.0055731  
    ##  Median :12.000   Median :0.0284270  
    ##  Mean   :12.000   Mean   :0.0255156  
    ##  3rd Qu.:21.780   3rd Qu.:0.0407478  
    ##  Max.   :31.561   Max.   :0.0530324  
    ## 
    ## 
    ## $tables$symptom2
    ## $tables$symptom2$cavity
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 3.377
    ## 
    ##        x                 y            
    ##  Min.   :-7.1306   Min.   :0.0005304  
    ##  1st Qu.: 0.4347   1st Qu.:0.0085903  
    ##  Median : 8.0000   Median :0.0392604  
    ##  Mean   : 8.0000   Mean   :0.0329772  
    ##  3rd Qu.:15.5653   3rd Qu.:0.0494280  
    ##  Max.   :23.1306   Max.   :0.0692892  
    ## 
    ## $tables$symptom2$`dentin hypersensitivity`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 5.546
    ## 
    ##        x                y            
    ##  Min.   :-15.64   Min.   :0.0003234  
    ##  1st Qu.: -3.07   1st Qu.:0.0050760  
    ##  Median :  9.50   Median :0.0230529  
    ##  Mean   :  9.50   Mean   :0.0198485  
    ##  3rd Qu.: 22.07   3rd Qu.:0.0329512  
    ##  Max.   : 34.64   Max.   :0.0357577  
    ## 
    ## $tables$symptom2$`Mouth Sores`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 3.501
    ## 
    ##        x                y            
    ##  Min.   :-6.502   Min.   :0.0002646  
    ##  1st Qu.: 1.749   1st Qu.:0.0064950  
    ##  Median :10.000   Median :0.0328511  
    ##  Mean   :10.000   Mean   :0.0302458  
    ##  3rd Qu.:18.251   3rd Qu.:0.0498775  
    ##  Max.   :26.502   Max.   :0.0614004  
    ## 
    ## $tables$symptom2$`Oral Cancer`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 0.6523
    ## 
    ##        x               y           
    ##  Min.   :4.043   Min.   :0.002751  
    ##  1st Qu.:5.522   1st Qu.:0.043216  
    ##  Median :7.000   Median :0.195923  
    ##  Mean   :7.000   Mean   :0.168751  
    ##  3rd Qu.:8.478   3rd Qu.:0.280986  
    ##  Max.   :9.957   Max.   :0.297346  
    ## 
    ## $tables$symptom2$Periodontitis
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (18 obs.);  Bandwidth 'bw' = 3.128
    ## 
    ##        x                y            
    ##  Min.   :-7.383   Min.   :0.0003709  
    ##  1st Qu.: 1.058   1st Qu.:0.0096994  
    ##  Median : 9.500   Median :0.0232565  
    ##  Mean   : 9.500   Mean   :0.0295654  
    ##  3rd Qu.:17.942   3rd Qu.:0.0392458  
    ##  Max.   :26.383   Max.   :0.0852167  
    ## 
    ## $tables$symptom2$`Tooth Erosion`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 4.649
    ## 
    ##        x                y            
    ##  Min.   :-8.948   Min.   :0.0003853  
    ##  1st Qu.: 1.526   1st Qu.:0.0061340  
    ##  Median :12.000   Median :0.0280353  
    ##  Mean   :12.000   Mean   :0.0238201  
    ##  3rd Qu.:22.474   3rd Qu.:0.0366694  
    ##  Max.   :32.948   Max.   :0.0483652  
    ## 
    ## 
    ## $tables$symptom3
    ## $tables$symptom3$cavity
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 3.142
    ## 
    ##        x                 y           
    ##  Min.   :-6.4257   Min.   :0.000354  
    ##  1st Qu.: 0.7871   1st Qu.:0.007956  
    ##  Median : 8.0000   Median :0.040026  
    ##  Mean   : 8.0000   Mean   :0.034597  
    ##  3rd Qu.:15.2129   3rd Qu.:0.053056  
    ##  Max.   :22.4257   Max.   :0.074127  
    ## 
    ## $tables$symptom3$`dentin hypersensitivity`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 4.381
    ## 
    ##        x                 y            
    ##  Min.   :-12.143   Min.   :0.0002047  
    ##  1st Qu.: -1.322   1st Qu.:0.0053793  
    ##  Median :  9.500   Median :0.0236097  
    ##  Mean   :  9.500   Mean   :0.0230609  
    ##  3rd Qu.: 20.322   3rd Qu.:0.0413397  
    ##  Max.   : 31.143   Max.   :0.0446001  
    ## 
    ## $tables$symptom3$`Mouth Sores`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 3.957
    ## 
    ##        x                y            
    ##  Min.   :-7.871   Min.   :0.0004521  
    ##  1st Qu.: 1.064   1st Qu.:0.0071216  
    ##  Median :10.000   Median :0.0326888  
    ##  Mean   :10.000   Mean   :0.0279209  
    ##  3rd Qu.:18.936   3rd Qu.:0.0437994  
    ##  Max.   :27.871   Max.   :0.0552602  
    ## 
    ## $tables$symptom3$`Oral Cancer`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 0.4868
    ## 
    ##        x              y           
    ##  Min.   :4.54   Min.   :0.001841  
    ##  1st Qu.:5.77   1st Qu.:0.050646  
    ##  Median :7.00   Median :0.205948  
    ##  Mean   :7.00   Mean   :0.202861  
    ##  3rd Qu.:8.23   3rd Qu.:0.360453  
    ##  Max.   :9.46   Max.   :0.394462  
    ## 
    ## $tables$symptom3$Periodontitis
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (18 obs.);  Bandwidth 'bw' = 0.3768
    ## 
    ##        x                 y            
    ##  Min.   : 0.8697   Min.   :0.000e+00  
    ##  1st Qu.: 5.1848   1st Qu.:0.000e+00  
    ##  Median : 9.5000   Median :1.409e-05  
    ##  Mean   : 9.5000   Mean   :5.785e-02  
    ##  3rd Qu.:13.8152   3rd Qu.:8.576e-02  
    ##  Max.   :18.1303   Max.   :3.039e-01  
    ## 
    ## $tables$symptom3$`Tooth Erosion`
    ## 
    ## Call:
    ##  density.default(x = xx, adjust = ..1)
    ## 
    ## Data: xx (5 obs.);   Bandwidth 'bw' = 1.947
    ## 
    ##        x                 y            
    ##  Min.   :-0.8415   Min.   :0.0004605  
    ##  1st Qu.: 5.5792   1st Qu.:0.0086213  
    ##  Median :12.0000   Median :0.0289675  
    ##  Mean   :12.0000   Mean   :0.0388676  
    ##  3rd Qu.:18.4208   3rd Qu.:0.0697068  
    ##  Max.   :24.8415   Max.   :0.0970082  
    ## 
    ## 
    ## 
    ## $levels
    ## [1] "cavity"                  "dentin hypersensitivity"
    ## [3] "Mouth Sores"             "Oral Cancer"            
    ## [5] "Periodontitis"           "Tooth Erosion"          
    ## 
    ## $call
    ## NaiveBayes.default(x = x, grouping = y, usekernel = TRUE, fL = param$fL, 
    ##     adjust = param$adjust)
    ## 
    ## $x
    ##     symptom1 symptom2 symptom3
    ## X1        10        1       18
    ## X2        10       18        1
    ## X3         1       18       10
    ## X4        18       10        1
    ## X5        18        1       10
    ## X6         3       13       11
    ## X7        11        3       13
    ## X8        11       13        3
    ## X9        13        3       11
    ## X10       13       11        3
    ## X11       19        5        9
    ## X12       19        9        5
    ## X13        5       19        9
    ## X14        9       19        5
    ## X15        9        5       19
    ## X16        4       12       16
    ## X17       12        4       16
    ## X18       12       16        4
    ## X19       16        4       12
    ## X20       16       12        4
    ## X21        8        7        6
    ## X22        8        6        7
    ## X23        7        8        6
    ## X24        7        6        8
    ## X25        6        8        7
    ## X26        2       14       15
    ## X27        2       15       14
    ## X28        2       17       14
    ## X29        2       15       17
    ## X30       14        2       15
    ## X31       14       17       15
    ## X32       14       15       17
    ## X33       14       17        2
    ## X34       15        2       14
    ## X35       15       14        2
    ## X36       15       17       14
    ## X37       15        2       17
    ## X38       15       14       17
    ## X39       17       14        2
    ## X40       17       14       15
    ## X41       17        2       15
    ## X42       17        2       14
    ## X43       17       15        2
    ## 
    ## $usekernel
    ## [1] TRUE
    ## 
    ## $varnames
    ## [1] "symptom1" "symptom2" "symptom3"
    ## 
    ## $xNames
    ## [1] "symptom1" "symptom2" "symptom3"
    ## 
    ## $problemType
    ## [1] "Classification"
    ## 
    ## $tuneValue
    ##   fL usekernel adjust
    ## 2  0      TRUE      1
    ## 
    ## $obsLevels
    ## [1] "cavity"                  "dentin hypersensitivity"
    ## [3] "Mouth Sores"             "Oral Cancer"            
    ## [5] "Periodontitis"           "Tooth Erosion"          
    ## attr(,"ordered")
    ## [1] FALSE
    ## 
    ## $param
    ## list()
    ## 
    ## attr(,"class")
    ## [1] "NaiveBayes"

``` r
print(teeth_caret_model_rpart$finalModel)
```

    ## n= 54 
    ## 
    ## node), split, n, loss, yval, (yprob)
    ##       * denotes terminal node
    ## 
    ## 1) root 54 30 Periodontitis (0.11 0.11 0.11 0.11 0.44 0.11)  
    ##   2) symptom1< 13.5 30 24 cavity (0.2 0.13 0.13 0.2 0.2 0.13)  
    ##     4) symptom1>=2.5 22 16 cavity (0.27 0.091 0.18 0.27 0 0.18)  
    ##       8) symptom1>=9.5 8  4 cavity (0.5 0.25 0.25 0 0 0) *
    ##       9) symptom1< 9.5 14  8 Oral Cancer (0.14 0 0.14 0.43 0 0.29) *
    ##     5) symptom1< 2.5 8  2 Periodontitis (0 0.25 0 0 0.75 0) *
    ##   3) symptom1>=13.5 24  6 Periodontitis (0 0.083 0.083 0 0.75 0.083) *

## Test the Model

``` r
# We can test the model
set.seed(9)
predictions <- predict(teeth_caret_model_nb, newdata = teeth_disease_test)
confusionMatrix(predictions, as.factor(teeth_disease_test$Disease))
```

    ## Confusion Matrix and Statistics
    ## 
    ##                          Reference
    ## Prediction                cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       1                       0           1
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  0                       0           0
    ##   Periodontitis                0                       0           0
    ##   Tooth Erosion                0                       1           0
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
    ##                Accuracy : 0.8182          
    ##                  95% CI : (0.4822, 0.9772)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.0615          
    ##                                           
    ##                   Kappa : 0.725           
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                1.00000                        0.00000
    ## Specificity                0.90000                        1.00000
    ## Pos Pred Value             0.50000                            NaN
    ## Neg Pred Value             1.00000                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.09091                        0.00000
    ## Detection Prevalence       0.18182                        0.00000
    ## Balanced Accuracy          0.95000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            1.00000               1.0000
    ## Pos Pred Value                      NaN            1.00000               1.0000
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.09091               0.5455
    ## Balanced Accuracy               0.50000            1.00000               1.0000
    ##                      Class: Tooth Erosion
    ## Sensitivity                       1.00000
    ## Specificity                       0.90000
    ## Pos Pred Value                    0.50000
    ## Neg Pred Value                    1.00000
    ## Prevalence                        0.09091
    ## Detection Rate                    0.09091
    ## Detection Prevalence              0.18182
    ## Balanced Accuracy                 0.95000

``` r
set.seed(9)
predictions <- predict(teeth_caret_model_svm_radial, newdata = teeth_disease_test)
confusionMatrix(predictions, as.factor(teeth_disease_test$Disease))
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

``` r
set.seed(9)
predictions <- predict(teeth_caret_model_knn, newdata = teeth_disease_test)
confusionMatrix(predictions, as.factor(teeth_disease_test$Disease))
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

``` r
set.seed(9)
predictions <- predict(teeth_caret_model_rpart, newdata = teeth_disease_test)
confusionMatrix(predictions, as.factor(teeth_disease_test$Disease))
```

    ## Confusion Matrix and Statistics
    ## 
    ##                          Reference
    ## Prediction                cavity dentin hypersensitivity Mouth Sores
    ##   cavity                       0                       0           1
    ##   dentin hypersensitivity      0                       0           0
    ##   Mouth Sores                  0                       0           0
    ##   Oral Cancer                  1                       0           0
    ##   Periodontitis                0                       1           0
    ##   Tooth Erosion                0                       0           0
    ##                          Reference
    ## Prediction                Oral Cancer Periodontitis Tooth Erosion
    ##   cavity                            0             0             0
    ##   dentin hypersensitivity           0             0             0
    ##   Mouth Sores                       0             0             0
    ##   Oral Cancer                       1             0             1
    ##   Periodontitis                     0             6             0
    ##   Tooth Erosion                     0             0             0
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.6364          
    ##                  95% CI : (0.3079, 0.8907)
    ##     No Information Rate : 0.5455          
    ##     P-Value [Acc > NIR] : 0.3853          
    ##                                           
    ##                   Kappa : 0.4133          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: cavity Class: dentin hypersensitivity
    ## Sensitivity                0.00000                        0.00000
    ## Specificity                0.90000                        1.00000
    ## Pos Pred Value             0.00000                            NaN
    ## Neg Pred Value             0.90000                        0.90909
    ## Prevalence                 0.09091                        0.09091
    ## Detection Rate             0.00000                        0.00000
    ## Detection Prevalence       0.09091                        0.00000
    ## Balanced Accuracy          0.45000                        0.50000
    ##                      Class: Mouth Sores Class: Oral Cancer Class: Periodontitis
    ## Sensitivity                     0.00000            1.00000               1.0000
    ## Specificity                     1.00000            0.80000               0.8000
    ## Pos Pred Value                      NaN            0.33333               0.8571
    ## Neg Pred Value                  0.90909            1.00000               1.0000
    ## Prevalence                      0.09091            0.09091               0.5455
    ## Detection Rate                  0.00000            0.09091               0.5455
    ## Detection Prevalence            0.00000            0.27273               0.6364
    ## Balanced Accuracy               0.50000            0.90000               0.9000
    ##                      Class: Tooth Erosion
    ## Sensitivity                       0.00000
    ## Specificity                       1.00000
    ## Pos Pred Value                        NaN
    ## Neg Pred Value                    0.90909
    ## Prevalence                        0.09091
    ## Detection Rate                    0.00000
    ## Detection Prevalence              0.00000
    ## Balanced Accuracy                 0.50000

save the model with following code

``` r
saveRDS(teeth_caret_model_svm_radial, "../models/saved_teeth_caret_model_svm_radial.rds")
```

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
