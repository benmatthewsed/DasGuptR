library(testthat)

test_that("split_popstr works from 1 to 5 factors", {

  for(nfactors in 2:5){
    # nfactors <- sample(2:5,1)
    nflevel <- rep(3,nfactors)#round(runif(nfactors,2,5))
    df <- expand.grid(lapply(1:nfactors, \(x) 1:nflevel[x]))
    df$n <- round(runif(nrow(df),10,1e3))

    # split popstr
    result <- split_popstr(df, id_vars = paste0("Var",1:nfactors), nvar = "n")

    # check output
    expect_equal(nrow(result), nrow(df))
    expect_equal(ncol(result), nfactors)
    expect_false(any(is.na(result)))
  }

})

test_that("DG.eg5.3", {
  eg5.3 <- data.frame(
    race = rep(rep(1:2, e = 11), 2),
    age = rep(rep(1:11, 2), 2),
    pop = rep(c(1985, 1970), e = 22),
    size = c(
      3041, 11577, 27450, 32711, 35480, 27411, 19555, 19795, 15254, 8022, 2472,
      707, 2692, 6473, 6841, 6547, 4352, 3034, 2540, 1749, 804, 236,
      2968, 11484, 34614, 30992, 21983, 20314, 20928, 16897, 11339, 5720, 1315,
      535, 2162, 6120, 4781, 3096, 2718, 2363, 1767, 1149, 448, 117
    ),
    rate = c(
      9.163, 0.462, 0.248, 0.929, 1.084, 1.810, 4.715, 12.187, 27.728, 64.068, 157.570,
      17.208, 0.738, 0.328, 1.103, 2.045, 3.724, 8.052, 17.812, 34.128, 68.276, 125.161,
      18.469, 0.751, 0.391, 1.146, 1.287, 2.672, 6.636, 15.691, 34.723, 79.763, 176.837,
      36.993, 1.352, 0.541, 2.040, 3.523, 6.746, 12.967, 24.471, 45.091, 74.902, 123.205
    )
  )

  result <- dgnpop(eg5.3,
         pop = "pop", factors = c("rate"),
         id_vars = c("race", "age"),
         crossclassified = "size"
  )
  dg_table(result)
  expect_equal(result$rate[result$factor=="age_struct"&result$pop==1970], 8.385, tolerance = 1e-3)
  expect_equal(result$rate[result$factor=="race_struct"&result$pop==1970], 9.136, tolerance = 1e-3)
  expect_equal(result$rate[result$factor=="rate"&result$pop==1970], 10.258, tolerance = 1e-3)
  expect_equal(result$rate[result$factor=="age_struct"&result$pop==1985], 9.907, tolerance = 1e-3)
  expect_equal(result$rate[result$factor=="race_struct"&result$pop==1985], 9.156, tolerance = 1e-3)
  expect_equal(result$rate[result$factor=="rate"&result$pop==1985], 8.030, tolerance = 1e-3)

})

