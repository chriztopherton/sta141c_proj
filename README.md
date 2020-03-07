#Package: 
- BLB

#Type: 
- Package

#Title: 
- Bag of Little Bootstrapped Regressions


#Author: 
- Christopher Ton, Zhuoheng Han, Samuel Krut

#Maintainer:  chrton@ucdavis.edu

#Description: 
    
    - The package takes in a numeric dataframe as input and predicts a response variable defined by the user as "y".
    Assuming that the data is signifcantly large enough, either parallel or distributed computing will be chosen to aid 
    computation time and power. Bootstrapped subsamples are delegated to respective multiregression models at once and an 
    overall confidence interval for the regression coefficients are determined. Furthermore, the package would
    also estimate the confidence interval for prediction, given a row vector and matrix of explanatory input variables.

#License: 
- GPL-3

#Encoding: 
- UTF-8

#LazyData: 
- true

#RoxygenNote: 
- 7.0.2

#Suggests: 
    - knitr,
    rmarkdown,
    parallel,
    tidyverse,
    furrr

#VignetteBuilder: 
- knitr
