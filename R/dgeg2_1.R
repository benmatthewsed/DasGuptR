#' Das Gupta Example 2.1
#'
#' @description
#' Mean Earnings as the Product of Two Factors for Black Males and White Males, 18 Years and Over: United States, 1980
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 2 rows and 3 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{avg_earnings}{Mean earnings based on those who earned}
#'   \item{earner_prop}{Proportion of persons who earned}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
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
