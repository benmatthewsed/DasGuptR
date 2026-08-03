#' Das Gupta Example 6.6: US Population Birth Rates
#'
#' @description
#' Population and Birth Rates by Nine Age-Sex Groups: United States, 1940 to 1990
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 459 rows and 4 variables:
#' \describe{
#'   \item{year}{Population indicator}
#'   \item{agebin}{Age-sex group: `F [10,14]`, `F [15,19]`, `F [20,24]`, `F [25,29]`, `F [30,34]`, `F [35,39]`, `F [40,44]`, `F [45,49]`, `Remainder (F [0,10), F [50, Inf), M [0,Inf)`)}
#'   \item{thous}{Population (in thousands) in age-sex group i}
#'   \item{birthrate}{Age-sex-specific birth rates (per 1000 population)}
#' }
#'
#' @source "Standardization and decomposition of rates: A user’s manual", Das Gupta (1993)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg6_6)
#'
#' dgo_us <- dgnpop(dgeg6_6,
#'                  pop = "year",
#'                  factors = c("birthrate"),
#'                  id_vars = "agebin",
#'                  crossclassified = "thous")
#'
#' dg_plot(dgo_us)
#'
#' # Recreating Figure 1 (p.112) from Das Gupta 1993
#' # crude rates
#' plot(x = 1940:1990,
#'      y = by(dgeg6_6, dgeg6_6$year,
#'             \(x) sum(x$birthrate * (x$thous/sum(x$thous)))),
#'      type = "l", ylim = c(13,33))
#' # rates with 1940 as standard
#' baseline = dgeg6_6[dgeg6_6$year == 1940, ]
#' lines(x = 1940:1990,
#'       y = by(dgeg6_6, dgeg6_6$year,
#'              \(x) sum(x$birthrate * (baseline$thous/sum(baseline$thous)))),
#'       lty = "dotted")
#' # rates with 1990 as standard
#' baseline = dgeg6_6[dgeg6_6$year == 1990, ]
#' lines(x = 1940:1990,
#'       y = by(dgeg6_6, dgeg6_6$year,
#'              \(x) sum(x$birthrate * (baseline$thous/sum(baseline$thous)))),
#'       lty = "dashed")
#' # rates standardised with Das Gupta's method
#' lines(x = 1940:1990,
#'       y = dgo_us$rate[dgo_us$factor=="birthrate"],
#'       lty = "longdash", col = "red")
#'
"dgeg6_6"
