#' Prithwis Das Gupta's 1993 standardisation and decomposition of rates over K rate-factors and N populations.
#'
#' @description
#' Prithwis Das Gupta's 1993 standardisation and decomposition of rates over K rate-factors and N populations.
#' @details
#' Population rates are often composed of various different compositional factors. Standardisation techniques calculate the rate were a set of factors to be held constant (either with a specific population as standard, or at the average of the populations). Decomposition methods quantify the amount of the difference between two population crude rate that is due to differences in population characteristics.
#'
#' Das Gupta's general solution for the decomposition of two rates can be written as:
#'
#' \deqn{ \Delta\text{crude-}r = \sum\limits_{\vec{\alpha} \in K}Q(\vec{\alpha}^p) - Q(\vec{\alpha}^{p'}) }
#'
#' Where \eqn{K} is the set of factors \eqn{\alpha, \beta, ..., \kappa}, which may take the form of vectors over sub-populations \eqn{i}. \eqn{Q(\vec{\alpha}^p)} denotes the rate in population \eqn{p} holding all factors other than \eqn{\alpha} --- \eqn{K \setminus \alpha} --- equal (standardised across populations \eqn{p} and \eqn{p'}). The total crude rate difference is the sum of all standardised-rate differences, and the standardisation \eqn{Q} is expressed as:
#'
#' \deqn{Q(\vec{\alpha}^p) = \sum\limits_{j=1}^{\lfloor \frac{|K|}{2} \rfloor} \frac{ \sum\limits_{L \in {K \setminus \{\alpha\} \choose j-1}}f(\{L^p,(K\setminus L)^{p'},\vec{\alpha}^p\}) + f(\{L^{p'},(K\setminus L)^p,\vec{\alpha}^p\})} { |K| {|K| -1\choose j-1} } }
#'
#' Where \eqn{f(K)} is the function that defines the calculation of the rate
#'
#' @param x dataframe or tibble object, with columns specifying 1) population, 2) each rate-factor to be considered, and (optionally) 3) variables indicating underlying subpopulations
#' @param pop name (character string) of variable indicating population
#' @param factors names (character vector) of variables indicating compositional factors
#' @param id_vars character vector of variables indicating sub-populations
#' @param crossclassified character string of variable indicating size of sub-population. If specified, the proportion of each population in a given sub-population (e.g. each age-sex combination) is re-expressed as a product of symmetrical expressions representing the different variables (age, sex) constituting the sub-populations. These expressions are then used as compositional factors in the standardisation. If NULL, then providing a single variable as a compositional factor that represents the proportion of the population in each given sub-population will combine the contribution of all sub-population variables.
#' @param ratefunction user defined character string in R syntax that when evaluated specifies the function defining the rate as a function of factors. if NULL then will assume rate is the product of all factors. When sub-populations are provided, this should aggregate to a summary value (e.g., for the simple product rate this should be provided as `"sum(A*B*C*)"`.). User-defined functions can also be provided, as whatever string is given here will be parsed and evaluated as any other R code (see example eg4.4).
#' @param agg logical indicating whether, when cross-classified data is used, to output should be aggregated up to the population level
#' @param baseline baseline population to standardise against. if NULL then will do Das Gupta's full N-population standardisation.
#' @param quietly logical indicating whether interim messages should be outputted indicating progress through the K factors and N populations
#' @param diffs logical indicating whether to return list of standardised rates and rate-differences, or just the standardised rates.
#' @return
#' data.frame containing K-a standardised rates (or differences) for each population.
#'
#' - `rate`: standardised rate such that factor a is from population p and all other factors are averaged across populations, f(a^p,...)
#' - `pop`: population p for which factor a is taken from
#' - `std.set`: set of N populations (minus p) across which the standardisation has been performed
#' - `factor`: name of factor a that is being considered, such that for the set of factors K, the \{K-a\}-standardised rate is returned
#' @importFrom utils combn
#' @export
#' @examples
#' ## 2 populations, R=ab
#' data(dgeg2_1)
#'
#' dgnpop(dgeg2_1,
#'        pop = "pop",
#'        factors = c("avg_earnings", "earner_prop")) |>
#'   dg_table()
#'
#' ## 2 populations, R=abc
#' data(dgeg2_2)
#'
#' dgnpop(dgeg2_2,
#'        pop = "pop",
#'        factors = c("birthsw1549", "propw1549", "propw")) |>
#'   dg_table()
#'
#' ## 2 populations, R=abcd
#' data(dgeg2_3)
#'
#' dgnpop(dgeg2_3,
#'    pop = "pop",
#'    factors = c("birth_preg", "preg_actw", "actw_prop", "w_prop" )) |>
#'   dg_table()
#'
#' ## 2 populations, R=abcde
#' data(dgeg2_4)
#'
#' dgnpop(dgeg2_4,
#'        pop = "pop",
#'        factors = c("prop_m", "noncontr", "abort", "lact", "fecund")) |>
#'   dg_table()
#'
#' ## 2 populations, vector factors, R=sum(abc)
#' data(dgeg4_3)
#'
#' dgnpop(dgeg4_3,
#'        pop = "pop",
#'        factors = c("bm", "mw", "wp"),
#'        ratefunction = "sum(bm*mw*wp)") |>
#'  dg_table()
#'
#' ## 2 populations, R=f(ab)
#' data(dgeg3_1)
#'
#' dgnpop(dgeg3_1,
#'        pop = "pop",
#'        factors = c("crude_birth", "crude_death"),
#'        ratefunction = "crude_birth-crude_death") |>
#'   dg_table()
#'
#' ## 2 populations, vector factors, R=f(abcd)
#' data(dgeg4_4)
#'
#' dgnpop(dgeg4_4,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))") |>
#'   dg_table()
#'
#' #### alternatively:
#' myratef <- function(a, b, c, d) {
#'  return(sum(a * b * c) / (sum(a * b * c) + sum(a * (1 - b) * d)))
#' }
#'
#' dgnpop(dgeg4_4,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "myratef(A,B,C,D)") |>
#'   dg_table()
#'
#' ## 2 populations, 1 sub-population variable
#' data(dgeg5_1)
#'
#' ### Option 1:
#' dgnpop(dgeg5_1,
#'        pop = "pop",
#'        factors = c("size","rate"),
#'        ratefunction = "sum( (size/sum(size)) * rate )") |>
#'   dg_table()
#'
#' ### Option 2:
#' dgnpop(dgeg5_1,
#'        pop = "pop",
#'        factors = c("rate"),
#'        id_vars = "age_group",
#'        crossclassified = "size") |>
#'   dg_table()
#'
#' ## 2 cross-classified variables, 2 populations, R=sum(w*r)
#' data(dgeg5_3)
#'
#' dgnpop(dgeg5_3,
#'        pop = "pop",
#'        factors = c("rate"),
#'        id_vars = c("race", "age"),
#'        crossclassified = "size") |>
#'   dg_table()
#'
#' ## 5 populations, R = f(abcd)
#' data(dgeg6_5)
#'
#' dgres <- dgnpop(dgeg6_5,
#'        pop = "pop",
#'        factors = c("A", "B", "C", "D"),
#'        id_vars = "agegroup",
#'        ratefunction = "1000*sum(A*B*C) / (sum(A*B*C) + sum(A*(1-B)*D))")
#'
#' dg_table(dgres)
#' dg_plot(dgres)
#'
dgnpop <- function(x,
                   pop,
                   factors,
                   id_vars = NULL,
                   crossclassified = NULL,
                   ratefunction = NULL,
                   agg = TRUE,
                   baseline = NULL,
                   quietly = TRUE,
                   diffs = FALSE) {

  tmpdf <- as.data.frame(x)

  dg_check(tmpdf,pop,factors,id_vars,crossclassified)


  # population names mustn't be contained in factor names
  # and factor names mustn't be contained in population names.
  # this is probs the messiest bit
  while (sapply(tmpdf[[pop]], \(x) grepl(x, c(factors, id_vars))) |> any() |
         sapply(factors, \(x) grepl(x, tmpdf[[pop]])) |> any()) {
    tmpdf[[pop]] <- paste0("pop.", tmpdf[[pop]])
    names(tmpdf)[names(tmpdf)%in%factors] <-
      paste0("factor.", names(tmpdf)[names(tmpdf)%in%factors])
    factors <- paste0("factor.", factors)
  }

  tmpdf[[pop]] <- factor(tmpdf[[pop]])
  allpops <- unique(tmpdf[[pop]])
  nfact <- length(factors)


  ##########
  # Rate functions
  ##########
  user_RF <- TRUE
  if (is.null(ratefunction)) {
    user_RF <- FALSE
    ratefunction <- paste(factors, collapse = "*")
  }
  if (!is.null(crossclassified)) {
    ratefunction_crude <- paste0("sum(", crossclassified, "/sum(", crossclassified, ")*", ratefunction, ")")
  } else {
    ratefunction_crude <- ratefunction
  }

  ##########
  # CHECK
  ##########
  # TODO
  # check names of pop, id_vars, crossclassified, in x
  # check missingness


  # stops if crossclassified
  output_agg <- TRUE
  if (!is.null(crossclassified)) {
    if (length(eval(parse(text = ratefunction), envir = as.list(tmpdf))) == 1) {
      stop("when the size of cross-classified sub-populations is provided alongside a user defined rate function, the function should NOT summarise over the sub-populations into a single value. e.g., use 'rate' instead of 'sum(rate)'.")
    }
    if (crossclassified %in% factors) {
      stop("for cross-classified data, the variable indicating size of sub-populations should be included in the 'crossclassified' argument OR as a compositional factor when crossclassified = NULL, not both")
    }
    output_agg <- agg
  }
  if (!is.null(id_vars) & is.null(crossclassified)) {
    if (length(eval(parse(text = ratefunction), envir = as.list(tmpdf))) > 1) {
      message("ratefunction does not summarise over sub-populations into a single value (e.g., 'sum(A*B*C)'), and individual sub-population specific standardised rates are returned.")
      output_agg <- FALSE
    }
  }
  if (!agg & !is.null(crossclassified)) {
    message("for cross-classified data, when agg = FALSE then individual sub-population specific standardised rates are returned.")
    output_agg <- FALSE
  }


  .makepopdf <- function(x) {
    popdf <- tmpdf[tmpdf[[pop]] %in% x, ]
    popdf[[pop]] <- factor(popdf[[pop]], levels = x, ordered = T)
    popdf
  }


  ##########
  # CRUDE RATES
  ##########
  if (output_agg) {
    cr_dat <- lapply(allpops, \(x) .makepopdf(x))
    crude <-
      data.frame(
        rate = sapply(cr_dat, \(x) eval(parse(text = ratefunction_crude), envir = as.list(x))),
        pop = allpops,
        std.set = NA,
        factor = "crude"
      )
  }

  ##########
  # THE DAS GUPTA METHOD
  ##########
  if (output_agg) {
    message(
      paste0("\nDG decomposition being conducted with R = ", ratefunction, "\n")
    )
  }
  if (!output_agg) {
    message(
      paste0("\nDG decomposition being conducted with R_i = ", ratefunction, "\n")
    )
  }


  pairwise_pops <- combn(as.character(allpops), 2)

  pairwise_est <- apply(pairwise_pops, 2, \(x) .makepopdf(x))


  if (length(allpops) <= 2) {
    # ONLY 2 populations, use dg2pop directly.
    if (!is.null(crossclassified)) {
      ## XC
      DG_OUT <- ccwrap(pairwise_est[[1]],
        pop = pop, factors = factors,
        id_vars = id_vars, crossclassified = crossclassified, agg = output_agg,
        ratefunction = ratefunction, quietly = quietly
      )


      if (output_agg) {
        DG_OUT <- DG_OUT[, c("rate", "pop", "std.set", "factor")]
        DG_OUT <- rbind(crude, DG_OUT)
      } else {
        DG_OUT <- DG_OUT[, c("rate", "pop", "std.set", "factor", id_vars)]
      }
    } else {
      ## NOT XC
      DG_OUT <- dg2pop(pairwise_est[[1]],
        pop = pop, factors = factors, id_vars = id_vars,
        ratefunction = ratefunction, quietly = quietly
      )
      DG_OUT <- do.call(rbind, DG_OUT)

      if (output_agg) {
        # remove diff for 2-pop only, add crude if agg
        DG_OUT <- DG_OUT[, c("rate", "pop", "std.set", "factor")]
        DG_OUT <- rbind(crude, DG_OUT)
      } else {
        DG_OUT <- DG_OUT[, c("rate", "pop", "std.set", "factor", id_vars)]
      }
      row.names(DG_OUT) <- NULL
    }
    # final output
    dgo <- DG_OUT
  } else {
    ##### N population standardisation
    if (!quietly) {
      print("Standardising and decomposing for all pairwise comparisons...")
    }

    if (!is.null(baseline)) {
      pairwise_est <- pairwise_est[sapply(pairwise_est, \(x) baseline %in% x[[pop]])]
    }

    if (!is.null(crossclassified)) {
      ## XC
      dgNp_res <- lapply(pairwise_est, \(x)
      ccwrap(x,
        pop = pop, factors = factors,
        id_vars = id_vars, crossclassified = crossclassified,
        agg = output_agg, ratefunction = ratefunction, quietly = quietly
      ))
      dgNp_res <- do.call(rbind, dgNp_res)
      row.names(dgNp_res) <- NULL
    } else {
      ## NOT XC
      dgNp_res <- lapply(pairwise_est, \(x)
      dg2pop(x,
        pop = pop, factors = factors, id_vars = id_vars,
        ratefunction = ratefunction, quietly = quietly
      ))
      dgNp_res <- lapply(dgNp_res, \(x) do.call(rbind, x))
      dgNp_res <- do.call(rbind, dgNp_res)
      row.names(dgNp_res) <- NULL
    }

    DG_OUT.rates <- list()
    DG_OUT.diffs <- list()

    for (f in unique(dgNp_res[["factor"]])) {
      dgNp_rates <- dgNp_res[dgNp_res$factor == f, ]
      if (!is.null(baseline)) {
        standardized_rates <- dgNp_rates[
          dgNp_rates$std.set == baseline,
          c("rate", "pop", "std.set", "factor")
        ]

        # NOT NEEDED
        difference_effects = dgNp_rates[dgNp_rates$std.set == baseline,
                  c("diff","pop","factor")]
      } else {
        # std_rates
        if (!quietly) {
          print(paste0("Standardizing K-", f, " across N pops..."))
        }

        # these are the standardized rate for factor f in each year, standardized over all Ys.

        # IF NOT AGGREGATED:
        if (!output_agg) {
          subpops <- unique(tmpdf[, id_vars])
          standardized_rates <- list()
          for (sp_i in seq_len(nrow(subpops))) {
            # filter to sub-pop
            dgNp_rates_sp <- dgNp_rates[apply(dgNp_rates[, id_vars], 1, \(x) all(x == subpops[sp_i, id_vars])), ]
            # std rates across N
            sp_std_rates <- lapply(allpops, \(x) dg611(dgNp_rates_sp, allpops, x, f))
            sp_std_rates <- do.call(rbind, sp_std_rates)
            sp_std_rates[, id_vars] <- subpops[sp_i, id_vars]
            standardized_rates[[sp_i]] <- sp_std_rates
          }
          standardized_rates <- do.call(rbind, standardized_rates)
        } else {
          standardized_rates <- lapply(allpops, \(x) dg611(dgNp_rates, allpops, x, f))
          standardized_rates <- do.call(rbind, standardized_rates)
        }


        if (!quietly) {
          print(paste0("Getting decomposition effects for K-", f, " standardised rates..."))
        }

        pairwise_pops <- combn(allpops, 2, simplify = F)

        difference_effects <- lapply(pairwise_pops, \(x) dg612(dgNp_rates, allpops, x, f))
        difference_effects <- do.call(rbind, difference_effects)
      }
      DG_OUT.rates[[f]] <- standardized_rates
      DG_OUT.diffs[[f]] <- difference_effects
    }

    # tidy rates and add crude
    DG_OUT.rates <- do.call(rbind, DG_OUT.rates)
    if (output_agg) {
      DG_OUT.rates <- rbind(crude, DG_OUT.rates)
    }
    row.names(DG_OUT.rates) <- NULL
    # tidy diffs
    DG_OUT.diffs <- do.call(rbind, DG_OUT.diffs)
    row.names(DG_OUT.diffs) <- NULL

    # final output
    if(diffs){
      dgo <- list(rates = DG_OUT.rates, diffs = DG_OUT.diffs)
    } else { dgo <- DG_OUT.rates }

  }
  return(dgo)
}
