library(testthat)

test_that("check no errors DG examples", {

  expect_no_error(
    dgnpop(dgeg2_1,
         pop = "pop",
         factors = c("avg_earnings", "earner_prop"))
  )
  expect_no_error(
    dgnpop(dgeg2_2,
         pop = "pop",
         factors = c("birthsw1549", "propw1549", "propw"))
  )
  expect_no_error(
    dgnpop(dgeg2_3,
          pop = "pop",
          factors = c("birth_preg", "preg_actw", "actw_prop", "w_prop" ))
  )
  expect_no_error(
    dgnpop(dgeg2_4,
           pop = "pop",
           factors = c("prop_m", "noncontr", "abort", "lact", "fecund"))
  )
  expect_no_error(
    dgnpop(dgeg4_3,
           pop = "pop",
           factors = c("bm", "mw", "wp"),
           ratefunction = "sum(bm*mw*wp)")
  )
  expect_no_error(
    dgnpop(dgeg3_1,
           pop = "pop",
           factors = c("crude_birth", "crude_death"),
           ratefunction = "crude_birth-crude_death")
  )
  expect_no_error(
    dgnpop(dgeg4_4,
           pop = "pop",
           factors = c("A", "B", "C", "D"),
           id_vars = "agegroup",
           ratefunction = "sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))")
  )
  expect_no_error(
    dgnpop(dgeg5_1,
           pop = "pop",
           factors = c("size","rate"),
           ratefunction = "sum( (size/sum(size)) * rate )")
  )
  expect_no_error(
    dgnpop(dgeg5_1,
           pop = "pop",
           factors = c("rate"),
           id_vars = "age_group",
           crossclassified = "size")
  )
  expect_no_error(
    dgnpop(dgeg5_3,
           pop = "pop",
           factors = c("rate"),
           id_vars = c("race", "age"),
           crossclassified = "size")
  )
  expect_no_error(
    dgnpop(dgeg6_5,
            pop = "pop",
            factors = c("A", "B", "C", "D"),
            id_vars = "agegroup",
            ratefunction = "1000*sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))")
  )
})


test_that("check missingness", {

  tdf = dgeg2_1
  tdf$avg_earnings[1]<-NA
  expect_error(dgnpop(tdf,
                      pop = "pop",
                      factors = c("avg_earnings", "earner_prop"))
  )

})

test_that("check fully crossed", {

  tdf = expand.grid(pop=0:1,a=1:3,b=1:6,c=1:5)
  tdf$size = round(runif(nrow(tdf),1e2,1e3))
  tdf$rate = round(runif(nrow(tdf),0,1))
  expect_no_error(dgnpop(tdf,
                      pop = "pop",
                      factors="rate",
                      id_vars=c("a","b","c"),
                      crossclassified="size")
  )

  expect_error(dgnpop(tdf[-sample(1:nrow(tdf),1),],
                         pop = "pop",
                         factors="rate",
                         id_vars=c("a","b","c"),
                         crossclassified="size")
  )

})

