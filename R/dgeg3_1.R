#' Das Gupta Example 3.1
#'
#' @description
#' Crude Rate of Natural Increase as a Function of Crude Birth Rate and Crude Death Rate: United States, 1940 and 1960
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 2 rows and 3 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{crude_birth}{Crude birth rate (number of births per 1000 people)}
#'   \item{crude_death}{Crude death rate (number of deaths per 1000 people)}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg3_1)
#' dgnpop(dgeg3_1,
#'        pop = "pop",
#'        factors = c("crude_birth", "crude_death"),
#'        ratefunction = "crude_birth-crude_death") |>
#'   dg_table()
#'
"dgeg3_1"
