library(tidyverse)
library(readr)

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
  plan(multiprocess, workers = 4)
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
  reduce(ci_list, `+`)/length(ci_list)
}
