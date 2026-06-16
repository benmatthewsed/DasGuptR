#' Das Gupta equation 5.36 for a single population: Decomposes cross-classified population structures into a set of symmetric proportions indicating contribution of individual structural variables.
#' @param x dataframe consisting of one population, including variables indicating cross-classified structure, and a variable indicating size of each cell
#' @param id_vars character vector of variables indicating cross-classified structure.
#' @param nvar variable name (character string) containing cell sizes
#' @return inputted data.frame is returned with the addition of variables for each of the the cross-classified variables representing the contribution to the population size.
#' @importFrom stats ave
#' @importFrom utils combn
#' @export
split_popstr <- function(x, id_vars, nvar) {
  tmpdf <- as.data.frame(x)
  np <- length(id_vars)

  # sum Ns over set of id_vars.
  # returns vector same length, replaced by sums of groups
  # ave() is handy! didn't know about this.
  .findn_v <- function(ivars) {
    if (length(ivars) == 0) return(rep(sum(tmpdf[[nvar]]), nrow(tmpdf)))
    ave(tmpdf[[nvar]], tmpdf[ivars], FUN = sum)
  }

  # LOOP OVER ID VARIABLES A,B,...,K (i.e., "factors" in DG speak)
  pop_str <- lapply(id_vars, function(ix) {
    # I can't think of a way to avoid row-wise operations here
    sapply(seq_len(nrow(tmpdf)), function(tr) {

      # this is the first bit, N_abc,,k / N_bc,,k
      # just for the given row
      p1 <- .findn_v(id_vars)[tr] / .findn_v(setdiff(id_vars, ix))[tr]

      # this is the last bit, N_abc,,k / N_....
      # just for the given row
      pp <- c()
        if(np > 2) { pp <- .findn_v(ix)[tr] / sum(tmpdf[[nvar]]) }

      # specifically when more than 2 factors, we have middle bits!
      # so we have essentially got fractions p2 up to p-kminus1, for each of 2 up to K-1 of the
      # set of factors *other* than the one being considered here (A).
      # within each fraction P, we need to consider each combination of K-x factors to hold constant
      # so with A,B,C,D we need to hold ACD,ABD,ABC constant and then AB,AC,AD
      p2_pkm1 <- c()
      if (np > 2) {
        # go from y=2 to y=K-1
        p2_pkm1 <- sapply(2:(np - 1), \(y) {
          # get each combination C of y factors in set K-A
          prod(apply(combn(setdiff(id_vars, ix), np - y), 2,
                     # for each combination C, take N_aC.. / N_C..
                     \(constFs) .findn_v(c(ix, constFs))[tr] / .findn_v(constFs)[tr])
          ) # and calc product
        })
      }

      # here are the various ratios
      ratios <- c(p1, p2_pkm1, pp)
      # and we need the powers. this is p * choose(p-1, r) in the eq.
      powers <- c(np, if (np > 1) sapply(1:(np - 1), \(k) (np * choose(np - 1, k))) else c())
      # product:
      prod(ratios ^ (1 / powers))
    })
  })

  # output to append _struct to these new decomposed factors
  names(pop_str) <- paste0(id_vars, "_struct")
  return(as.data.frame(pop_str))
}
