# DasGuptR 2.2.0 (2026-08-04)


- split_popstr() rewritten to improve computation speed for crossclassified structures

- Data for Das Gupta's original examples now included as part of the package

- uspop dataset renamed to dgeg6_6 to avoid conflicts with {datasets}

- dgnpop() now performs checks of input data prior to decomposition, to provide user with more informative messages for the requirements. this is done via internally calling dg_check(), which checks for missing data, unequal population structures, and any marginal sums for the size of crossclassified structures being zero. 


# DasGuptR 2.1.0 (2025-03-17)

- added in functionality for managing cross-classified data

- ability to function on vector factors

- removed all tidyverse dependencies
