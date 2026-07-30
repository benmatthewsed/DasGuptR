#' Das Gupta Example 6.5
#'
#' @description
#' Illegitimacy Ratio as a Function of Four Vector-Factors: United States, White Population, 1963, 1968, 1973, 1978, and 1983.
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented, but recognise that some of the terminology and classifications no longer align with current practices*
#'
#' @format A data frame with 30 rows and 6 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{agegroup}{Age group:`[15,19]`, `[20,24]`, ..., `[35,39]`, `[40,44]`}
#'   \item{A}{Age-structure of women in childbearing ages (number of women in age group as a proportion of total women age 15-44)}
#'   \item{B}{Marital status structure within childbearing age groups (proportion of women in age group i who are unmarried)}
#'   \item{C}{Age-specific nonmarital fertility rate (proportion of unmarried women in age group i giving birth)}
#'   \item{D}{Age-specific marital fertility rate (proportion of married women in age group i giving birth)}
#' }
#'
#' @source "Standardization and decomposition of rates: A user’s manual", Das Gupta (1993)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg6_5)
#'
#' dgnpop(dgeg6_5,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "1000*sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))") |>
#'   dg_table()
#'
#' dgnpop(dgeg6_5,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "1000*sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))") |>
#'   dg_plot()
#'
"dgeg6_5"
