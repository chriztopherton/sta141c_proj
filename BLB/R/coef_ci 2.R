library(tidyverse)
library(readr)

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
  plan(multiprocess, workers = 4)
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
