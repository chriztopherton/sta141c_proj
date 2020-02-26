#' Test function
#' @export
test <- function() {

  library(nycflights13)
  set.seed(141)
  m <- 10
  groups <- sample(seq_len(m), nrow(flights), replace = TRUE)
  dir.create("flights/", showWarnings = FALSE)
  for (i in seq_len(m)) {
    write_csv(filter(flights, groups == i), str_c("flights/", i, ".csv"))
  }

  file_names <- file.path("flights", list.files("flights"))
  mean_list <- file_names %>% map(~ mean(read_csv(.)$dep_delay, na.rm = TRUE))
  (mean_dep_delay <- mean_list %>% reduce(`+`) / m)

  ci_list <- file_names %>% map(~ t.test(read_csv(.)$dep_delay)$conf.int)
  (mean_ci <- ci_list %>% reduce(`+`) / m)

  r <- 10  # r should be at least a few thousands, we are using 10 for demo
  n <- nrow(flights)
  each_boot <- function(i, data) {
    mean(sample(data, n, replace = TRUE), na.rm = TRUE)
  }
  ci_list <- file_names %>% map(~ {
    sub_dep_delay <- read_csv(.)$dep_delay
    map_dbl(seq_len(r), each_boot, data = sub_dep_delay) %>%
      quantile(c(0.025, 0.975))
  })
  reduce(ci_list, `+`) / length(ci_list)
}
