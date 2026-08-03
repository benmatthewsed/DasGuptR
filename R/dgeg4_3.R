#' Das Gupta Example 4.3
#'
#' @description
#' Crude Birth Rate per 1,000 as a Function of Three Vector-Factors: Taiwan, 1960 and 1970
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 14 rows and 5 variables:
#' \describe{
#'   \item{agegroup}{Age group: 1 = `[15,19]`, 2 = `[20,24]`, ..., 6 = `[40,44]`, 7 = `[45,49]`}
#'   \item{pop}{Population indicator}
#'   \item{bm}{Age-specific marital fertility rates per 1000 women}
#'   \item{mw}{Proportion of married women among total women in age group i}
#'   \item{wp}{Total women in age group i as a proportion of the total population}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg4_3)
#' dgnpop(dgeg4_3,
#'        pop = "pop",
#'        factors = c("bm", "mw", "wp"),
#'        ratefunction = "sum(bm*mw*wp)") |>
#'   dg_table()
#'
"dgeg4_3"
