#' Das Gupta Example 4.1
#'
#' @description
#' Female Intrinsic Growth Rate per Person as a Function of Two Vector-Factors: United States, 1960 and 1965
#'
#' *To allow for direct comparison with Das Gupta's original publication we have preserved these datasets as they were originally presented*
#'
#' @format A data frame with 18 rows and 4 variables:
#' \describe{
#'   \item{age_group}{Age group: 1 = `[10,15)`, 2 = `[15,20)`, ..., 8 = `[45,50)`, 9 = `[50,55)`}
#'   \item{pop}{Population indicator}
#'   \item{Lx}{Stationary population values (5Lx)}
#'   \item{mx}{Age-specific fertility rates for females}
#' }
#'
#' @source [Das Gupta, Prithwis (1993). Standardization and Decomposition of Rates: A User's Manual. U.S. Bureau of the Census, Current Population Reports, Series P23-186. U.S. Government Printing Office, Washington, DC.](https://www.census.gov/library/publications/1993/demo/p23-186.html)
#'
#' @keywords datasets
#'
#' @examples
#' data(dgeg4_1)
#' ## rate function:
#' RF4.1 <- function(A, B) {
#'   idx <- seq_len(length(A))
#'   mu0 <- sum(A * B / 100000)
#'   mu1 <- sum((5 * idx + 7.5) * A * B / 100000)
#'   r1 <- log(mu0) * (mu0 / mu1)
#'   while (TRUE) {
#'     Nr1 <- 0
#'     Dr1 <- 0
#'     Nr1 <- Nr1 + sum(exp(-r1 * (5 * idx + 7.5)) * A * (B / 100000))
#'     Dr1 <- Dr1 - sum((5 * idx + 7.5) * exp(-r1 * (5 * idx + 7.5)) * A * (B / 100000))
#'     r2 <- r1 - ((Nr1 - 1) / Dr1)
#'     if (abs(r2 - r1) <= .0000001) {
#'       break
#'     }
#'     r1 <- r2
#'   }
#'   return(r2)
#' }
#'
#' ## crude rates:
#' RF4.1(A = dgeg4_1$Lx[1:9], B = dgeg4_1$mx[1:9])
#' RF4.1(A = dgeg4_1$Lx[10:18], B = dgeg4_1$mx[10:18])
#'
#' ## decomposition:
#' dgnpop(dgeg4_1,
#'        pop = "pop",
#'        factors = c("Lx", "mx"),
#'        id_vars = "age_group",
#'        ratefunction = "RF4.1(Lx,mx)") |>
#'   dg_table()
#'
"dgeg4_1"
