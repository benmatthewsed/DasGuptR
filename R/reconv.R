#' Scottish Reconvictions data 2004-2016
#'
#' @description
#' Official statistics on reconvictions in Scotland, 2004 to 2016 inclusive, split by sex and 6 age groups
#'
#'
#' @format A data frame with 130 rows and 8 variables:
#' \describe{
#'   \item{year}{Population indicator}
#'   \item{Sex}{Sex group (Female, Male)}
#'   \item{Age}{Age group: `(0,20]`, `[21,25]`, `[26,30]`, `[31,40]`, `(40,Inf)`}
#'   \item{convicted_population}{Total number of offenders who either received a non-custodial conviction or were released from a custodial sentence in a given year}
#'   \item{offenders}{Number of offenders in a given age-sex group}
#'   \item{reconvicted}{Number of people in a given age-sex group who were reconvicted one or more times}
#'   \item{reconvictions}{Number of reconvictions in a given age-sex group}
#'   \item{prev_rate}{age-sex specific reconviction rate: percentage of offenders in a given age-sex group who were reconvicted one or more times}
#' }
#'
#' @source [Scottish Government (2019) Reconviction rates in Scotland: 2016-2017 offender cohort, Main publication tables](https://www.gov.scot/publications/reconviction-rates-scotland-2016-17-offender-cohort/)
#'
#' @keywords datasets
#'
#' @examples
#' data(reconv)
#'
#' # dgnpop(reconv,
#' #        pop="year",
#' #        factors=c("prev_rate"),
#' #        id_vars=c("Sex","Age"),
#' #        crossclassified="offenders") |>
#' #   dg_plot()
#'
"reconv"
