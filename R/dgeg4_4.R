#' Das Gupta Example 4.4
#'
#' @description
#' Illegitimacy Ratio as a Function of Four Vector-Factors: United States, White Population, 1963 and 1983
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 12 rows and 6 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{agegroup}{Age group: 1 = `[15,19]`, 2 = `[20,24]`, ..., 5 = `[35,39]`, 6 = `[40,44]`}
#'   \item{A}{Age-structure of women in childbearing ages (number of women in age group as a proportion of total women age 15-44)}
#'   \item{B}{Marital status structure within childbearing age groups (proportion of women in age group i who are unmarried)}
#'   \item{C}{Age-specific nonmarital fertility rate (proportion of unmarried women in age group i giving birth)}
#'   \item{D}{Age-specific marital fertility rate (proportion of married women in age group i giving birth)}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg4_4)
#'
#' ## Option 1:
#' dgnpop(dgeg4_4,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))") |>
#'   dg_table()
#'
#' ## alternatively, define a separate rate function:
#' myratef <- function(a, b, c, d) {
#'   return(sum(a * b * c) / (sum(a * b * c) + sum(a * (1 - b) * d)))
#' }
#'
#' dgnpop(dgeg4_4,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "myratef(A,B,C,D)") |>
#'   dg_table()
#'
"dgeg4_4"
