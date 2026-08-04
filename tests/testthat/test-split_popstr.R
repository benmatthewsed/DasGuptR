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
  data(dgeg5_3)

  result <- dgnpop(dgeg5_3,
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

