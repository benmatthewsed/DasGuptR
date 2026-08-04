#' Das Gupta Example 5.3
#'
#' @description
#' Population (in thousands) and Death Rates (per 1,000 Population) by Age and Race: United States, 1970 and 1985
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 44 rows and 5 variables:
#' \describe{
#'   \item{race}{race group: 1 = White, 2 = non-White}
#'   \item{age}{Age group: 1 = `[0,1)`, 2 = `[1,4]`, 3 = `[5,14]`, 4 = `[15,24]`, ..., 9 = `[65,74]`, 10 = `[75,84]`, 11 = `[85,Inf)`}
#'   \item{pop}{Population indicator}
#'   \item{size}{Number of people in age-race-group i}
#'   \item{rate}{Age-race-specific death rate (deaths per 1000 people)}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg5_3)
#'
#' dgnpop(dgeg5_3,
#'        pop = "pop",
#'        factors = c("rate"),
#'        id_vars = c("race", "age"),
#'        crossclassified = "size") |>
#'   dg_table()
#'
"dgeg5_3"
