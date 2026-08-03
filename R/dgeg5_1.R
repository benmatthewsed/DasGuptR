#' Das Gupta Example 5.1
#'
#' @description
#' Population Sizes (Percents) and Household Headship Rates per 100 by Age Groups: United States, 1970 and 1985
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 26 rows and 4 variables:
#' \describe{
#'   \item{age_group}{Age group: 1 = `[15,19]`, 2 = `[20,24]`, ..., 11 = `[65,69]`, 12 = `[70,74]`, 13 = `[75,Inf)`}
#'   \item{pop}{Population indicator}
#'   \item{size}{Percentage of population in age group i}
#'   \item{rate}{Age-specific household headship rate}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg5_1)
#'
#' ## Option 1: create separate factor of sub-group size as a proportion:
#' dgeg5_1$age_str <- dgeg5_1$size / 100
#'
#' dgnpop(dgeg5_1,
#'        pop = "pop",
#'        factors = c("age_str", "rate"),
#'        id_vars = "age_group",
#'        ratefunction = "sum(age_str*rate)") |>
#'   dg_table()
#'
#' ## Option 2: sub-group proportion created within rate function
#' dgnpop(dgeg5_1,
#'        pop = "pop",
#'        factors = c("size", "rate"),
#'        id_vars = "age_group",
#'        ratefunction = "sum( (size/sum(size)) * rate )") |>
#'   dg_table()
#'
#' ## Option 3: use crossclassified to indicate sub-groups
#' dgnpop(dgeg5_1,
#'        pop = "pop",
#'        factors = c("rate"),
#'        id_vars = "age_group",
#'        crossclassified = "size") |>
#'   dg_table()
#'
"dgeg5_1"
