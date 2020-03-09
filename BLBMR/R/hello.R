#' 'Finds the CI for regression coefficients'
#'
#' @description confidence interval for betas, multivariate regression coefficients
#'
#' @param data with y = input$response, and x = input$subsetted_columns
#'
#' @export
#'
#' @examples y= flights$time
#' x = flights[,c(1:3)]
#' data  = data.frame(y,x)
#' coef_ci(data)
coef_ci <- function(data){
  set.seed(141)
  m <- 10
  n <- nrow(data)
  group <- sample(seq_len(m), n, replace = TRUE)
  map(seq_len(m), ~write_csv(data[group ==., ],str_c("part",.,".csv")))

  calc_slope_blb <- function(subsample, freqs){
    as.matrix(summary(lm(y ~ ., weights = freqs, data = subsample))$coef[,1])
  }

  library(furrr)
  plan(multiprocess)
  B <- 10

  each_boot <-function(i, ind_part){
    subsample <- read_csv(str_c("part", ind_part,".csv"))
    freqs <- rmultinom(1, n, rep(1, nrow(subsample)))
    calc_slope_blb(subsample, freqs)
  }
  for (i in 1:ncol(data)){
    ci_list <- future_map(seq_len(m), ~{
      map(seq_len(B), each_boot, ind_part =.) %>%
        lapply(function(x) x[i,]) %>% unlist %>% quantile(c(0.025,0.975))
    })
    print (reduce(ci_list, `+`)/length(ci_list))
  }
}

#' 'Finds the CI for new prediction'
#'
#' @description confidence interval for new prediction
#'
#' @param data same data used as input for coef_ci
#'
#' @param newdata a dataframe with test input values for the explanatory columns
#'
#' @export
#'
#' @examples newdata = data.frame(dep_delay = c(2,3), arr_delay = c(13,-15), distance = c(450,500))
#' pred_ci(data,newdata)

pred_ci <- function(data, newdata){
  set.seed(141)
  m <- 10
  n <- nrow(data)
  group <- sample(seq_len(m), n, replace = TRUE)
  map(seq_len(m), ~write_csv(data[group ==., ],str_c("part",.,".csv")))

  calc_slope_blb <- function(subsample, freqs){
    predict(lm(y ~ ., weights = freqs, data = subsample),newdata)
  }

  library(furrr)
  plan(multiprocess)
  B <- 10

  each_boot <-function(i, ind_part){
    subsample <- read_csv(str_c("part", ind_part,".csv"))
    freqs <- rmultinom(1, n, rep(1, nrow(subsample)))
    calc_slope_blb(subsample, freqs)
  }
  ci_list <- future_map(seq_len(m), ~{
    map_dbl(seq_len(B), each_boot, ind_part =.) %>%
      quantile(c(0.025,0.975))
  })
  print( reduce(ci_list, `+`)/length(ci_list))
}
