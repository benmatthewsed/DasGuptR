#' Das Gupta Example 2.2
#'
#' @description
#' Crude Birth Rates as the Product of Three Factors: Austria and Chile, 1981
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented, but recognise that some of the terminology and classifications no longer align with current practices*
#'
#' @format A data frame with 2 rows and 4 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{birthsw1549}{Births per 1000 women aged 15-49}
#'   \item{propw1549}{Proportion of women aged 15-49}
#'   \item{propw}{Proportion of women out of total population}
#' }
#'
#' @source "Standardization and decomposition of rates: A user’s manual", Das Gupta (1993)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg2_2)
#' dgnpop(dgeg2_2,
#'        pop = "pop",
#'        factors = c("birthsw1549", "propw1549", "propw")) |>
#'   dg_table()
#'
"dgeg2_2"
