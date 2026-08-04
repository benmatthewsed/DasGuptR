#' Das Gupta Example 2.4
#'
#' @description
#' Total Fertility Rate as the Product of Five Factors: South Korea, 1960 and 1970
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
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
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
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
