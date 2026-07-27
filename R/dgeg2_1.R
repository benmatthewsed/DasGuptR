#' Das Gupta Example 2.1
#'
#' @description
#' Mean Earnings as the Product of Two Factors for Black Males and White Males, 18 Years and Over: United States, 1980
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented, but recognise that some of the terminology and classifications no longer align with current practices*
#'
#' @format A data frame with 2 rows and 3 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{avg_earnings}{Mean earnings based on those who earned}
#'   \item{earner_prop}{Proportion of persons who earned}
#' }
#'
#' @source "Standardization and decomposition of rates: A user’s manual", Das Gupta (1993)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg2_1)
#' dgnpop(dgeg2_1,
#'       pop = "pop",
#'       factors = c("avg_earnings", "earner_prop")) |>
#'  dg_table()
#'
"dgeg2_1"
