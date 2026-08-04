#' Das Gupta Example 2.3
#'
#' @description
#' Percentage Having Nonmarital Live Births as the Product of Four Factors for White Women Aged 15 to 19: United States, 1971 and 1979
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 2 rows and 5 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{birth_preg}{Number of nonmarital live births per 100 nonmarital pregnancies}
#'   \item{preg_actw}{Nonmarital pregnancy rate among sexually active single women}
#'   \item{actw_prop}{Proportion of single women who are sexually active}
#'   \item{w_prop}{Proportion of total women who are single}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg2_3)
#' dgnpop(dgeg2_3,
#'        pop = "pop",
#'        factors = c("birth_preg", "preg_actw", "actw_prop", "w_prop")) |>
#'   dg_table()
#'
"dgeg2_3"
