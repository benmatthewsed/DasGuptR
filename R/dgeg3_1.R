#' Das Gupta Example 3.1
#'
#' @description
#' Crude Rate of Natural Increase as a Function of Crude Birth Rate and Crude Death Rate: United States, 1940 and 1960
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented, but recognise that some of the terminology and classifications no longer align with current practices*
#'
#' @format A data frame with 2 rows and 3 variables:
#' \describe{
#'   \item{pop}{Population indicator}
#'   \item{crude_birth}{Crude birth rate (number of births per 1000 people)}
#'   \item{crude_death}{Crude death rate (number of deaths per 1000 people)}
#' }
#'
#' @source "Standardization and decomposition of rates: A user’s manual", Das Gupta (1993)
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
