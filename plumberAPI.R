
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Introduction ----

# We can create an API to access the model from outside R using a package
# called Plumber.

# STEP 1. Install and Load the Required Packages ----
## plumber ----
if (require("plumber")) {
  require("plumber")
} else {
  install.packages("plumber", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Create a REST API using Plumber ----
# REST API stands for Representational State Transfer Application Programming
# Interface. It is an architectural style and a set of guidelines for building
# web services that provide interoperability between different systems on the
# internet. RESTful APIs are widely used for creating and consuming web
# services.

# This requires the "plumber" package that was installed and loaded earlier in
# STEP 1. The commenting below makes R recognize the code as the definition of
# an API, i.e., #* comments.


loaded_teeth_caret_model_svm_radial <- readRDS("./models/saved_teeth_caret_model_svm_radial.rds")
#* @apiTitle gum disease Prediction Model API

#* @apiDescription Used to predict what a patient has in gum disease .

#* @param arg_symptomOne The symptom one the patient has had
#* @param arg_symptomTwo The symptom two the patient has had
#* @param arg_symptomThree The symptom thre the patient has had


#* @get /gumDisease

predict_diabetes <-
  function(arg_symptomOne, arg_symptomTwo, arg_symptomThree) {
    # Create a data frame using the arguments
    to_be_predicted <-
      data.frame(symptom1 = as.numeric(arg_symptomOne),
                 symptom2 = as.numeric(arg_symptomTwo),
                 symptom3 = as.numeric(arg_symptomThree))
    # Make a prediction based on the data frame
    predict(loaded_teeth_caret_model_svm_radial, to_be_predicted)
  }

# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.
# renv::snapshot() # nolint