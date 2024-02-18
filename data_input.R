## Preprocess data, create input object

## Before: ex1_SNEMAYT.dat (boot/data)
## After:  input.rds (data)

library(TAF)
library(wham)

mkdir("data")

# Read data in ASAP format
dat <- read_asap3_dat("boot/data/ex1_SNEMAYT.dat")

# Create input object
input <-
  prepare_wham_input(
    dat, recruit_model=2, model_name="Ex 1: SNEMA Yellowtail Flounder",
    selectivity=list(model=rep("age-specific", 3),
                     re=rep("none", 3),
                     initial_pars=list(c(0.5, 0.5, 0.5, 1, 1, 0.5),
                                       c(0.5, 0.5, 0.5, 1, 0.5, 0.5),
                                       c(0.5, 1, 1, 1, 0.5, 0.5)),
                     fix_pars=list(4:5, 4, 2:4)),
    NAA_re=list(sigma="rec+1", cor="iid"),
    age_comp="logistic-normal-miss0")

# Save object
saveRDS(input, "data/input.rds")
