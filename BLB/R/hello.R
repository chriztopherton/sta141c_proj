#' Test function
#' @exportB
blb <- function(processing_type) {

  library(nycflights13)
  library(tidyverse)

  set.seed(141)
  m <- 10
  groups <- sample(seq_len(m), nrow(flights), replace = TRUE)
  dir.create("flights/", showWarnings = FALSE)
  for (i in seq_len(m)) {
    write_csv(filter(flights, groups == i), str_c("flights/", i, ".csv"))
  }

  file_names <- file.path("flights", list.files("flights"))


  r <- 10  # r should be at least a few thousands, we are using 10 for demo
  n <- nrow(flights)
  

  each_boot2 <- function(i, data) {
    non_missing_data <- data[!is.na(data)]
    freqs <- rmultinom(1, n, rep(1, length(non_missing_data)))
    sum(non_missing_data * freqs) / n
  }


 # TODO error if processing type isn't specified or we can have a default
  if (processing_type == "parallel") {
    print("we're going to be using parallel processing")
  } else {
    print("user didn't specify processing type")
  }

  library(furrr)
  plan(multiprocess)

  ci_list <- file_names %>% future_map(~ {
    sub_dep_delay <- read_csv(.)$dep_delay
    map_dbl(seq_len(r), each_boot2, data = sub_dep_delay) %>%
      quantile(c(0.025, 0.975))
  })
  reduce(ci_list, `+`) / length(ci_list)

}

blb("parallel")
