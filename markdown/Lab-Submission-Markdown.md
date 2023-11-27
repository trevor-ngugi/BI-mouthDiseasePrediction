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
      - [Measures of Distribution/Dispersion/Spread/Scatter/Variability
        —-](#measures-of-distributiondispersionspreadscattervariability--)
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
# yes working
```

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

## Measures of Distribution/Dispersion/Spread/Scatter/Variability —-

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

# \<You can Provide Another Appropriate Title Here if you wish\>

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
