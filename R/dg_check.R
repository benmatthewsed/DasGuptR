#' Performs some initial checks of the input data for dgnpop(), providing messages where issues are flagged
#' @param x dgo output from `dgnpop()`
#' @param x dataframe or tibble object, with columns specifying 1) population, 2) each rate-factor to be considered, and (optionally) 3) variables indicating underlying subpopulations
#' @param pop name (character string) of variable indicating population
#' @param factors names (character vector) of variables indicating compositional factors
#' @param id_vars character vector of variables indicating sub-populations
#' @param crossclassified character string of variable indicating size of sub-population. If specified, the proportion of each population in a given sub-population (e.g. each age-sex combination) is re-expressed as a product of symmetrical expressions representing the different variables (age, sex) constituting the sub-populations. These expressions are then used as compositional factors in the standardisation. If NULL, then providing a single variable as a compositional factor that represents the proportion of the population in each given sub-population will combine the contribution of all sub-population variables.
#' @return
#' error message processing
#' @export
dg_check <- function(x,
                     pop,
                     factors,
                     id_vars = NULL,
                     crossclassified = NULL) {

  ## missingness
  if(anyNA(x[,c(pop,factors,id_vars,crossclassified)])){
    stop("Das Gupta's methods cannot handle missing data.")
  }

  ## fully cross-classified
  if(!is.null(crossclassified)){
    poptabs <- lapply(split(x, x[[pop]]), \(p) table(p[id_vars]))
    if(length(unique(poptabs))!=1){
      stop("For cross-classified data structures, all populations must have same combinations of levels of variables indicating the population structure.")
    }

    marg_combs <- combn(id_vars, length(id_vars)-1)
    if(any(
      apply(marg_combs, 2, \(is) {
        ccgroups = x[, c(pop, is), drop = FALSE]
        any(ave(x[[crossclassified]], ccgroups, FUN = sum) == 0)
      })
    )){
      stop("All marginal totals calculated over combinations of j-1 variables specified in id_vars must be greater than zero for cross-classified structures.")
    }
  }

}
