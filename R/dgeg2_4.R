#' Das Gupta Example 2.4
#'
#' @description
#' Total Fertility Rate as the Product of Five Factors: South Korea, 1960 and 1970
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented, but recognise that some of the terminology and classifications no longer align with current practices*
#'
#' @format A data frame with 2 rows and 6 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{prop_m}{Index of proportion married}
#'   \item{noncontr}{Index of noncontraception}
#'   \item{abort}{Index of induced abortion}
#'   \item{lact}{Index of lactational infecundability}
#'   \item{fecund}{Total fecundity rate}
#' }
#'
#' @source "Standardization and decomposition of rates: A user’s manual", Das Gupta (1993)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg2_4)
#' dgnpop(dgeg2_4,
#'        pop = "pop",
#'        factors = c("prop_m", "noncontr", "abort", "lact", "fecund")) |>
#'   dg_table()
#'
"dgeg2_4"
