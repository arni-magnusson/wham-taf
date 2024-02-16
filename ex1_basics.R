library(wham)

if(!exists("write.dir"))
  write.dir <- getwd()
if(!dir.exists(write.dir))
  dir.create(write.dir)
setwd(write.dir)

wham.dir <- find.package("wham")
file.copy(file.path(wham.dir, "extdata", "ex1_SNEMAYT.dat"), write.dir,
          overwrite=TRUE)

asap3 <- read_asap3_dat("ex1_SNEMAYT.dat")

# ------------------------------------------------------------------------------
# Model 1
# recruitment: random about mean
# numbers at age: independent random effects
# selectivity: age-specific (sel=1 for ages 4-5 in fishery, age 4 in index1, and
#              ages 2-4 in index2)
input1 <-
  prepare_wham_input(
    asap3, recruit_model=2, model_name="Ex 1: SNEMA Yellowtail Flounder",
    selectivity=list(model=rep("age-specific", 3),
                     re=rep("none", 3),
                     initial_pars=list(c(0.5, 0.5, 0.5, 1, 1, 0.5),
                                       c(0.5, 0.5, 0.5, 1, 0.5, 0.5),
                                       c(0.5, 1, 1, 1, 0.5, 0.5)),
                     fix_pars=list(4:5, 4, 2:4)),
    NAA_re=list(sigma="rec", cor="iid"))
m1 <- fit_wham(input1, do.osa=FALSE)  # turn off OSA residuals to save time

# Check that m1 converged (m1$opt$convergence should be 0, and the maximum
# gradient should be < 1e-06)
check_convergence(m1)

# ------------------------------------------------------------------------------
# Model 2
# as m1, but change age comp likelihoods to logistic normal (treat 0
# observations as missing)
input2 <-
  prepare_wham_input(
    asap3, recruit_model=2, model_name="Ex 1: SNEMA Yellowtail Flounder",
    selectivity=list(model=rep("age-specific", 3),
                     re=rep("none", 3),
                     initial_pars=list(c(0.5, 0.5, 0.5, 1, 1, 0.5),
                                       c(0.5, 0.5, 0.5, 1, 0.5, 0.5),
                                       c(0.5, 1, 1, 1, 0.5, 0.5)),
                     fix_pars=list(4:5, 4, 2:4)),
    NAA_re=list(sigma="rec", cor="iid"),
    age_comp="logistic-normal-miss0")
m2 <- fit_wham(input2, do.osa=FALSE)  # turn off OSA residuals to save time
check_convergence(m2)

# ------------------------------------------------------------------------------
# Model 3
# full state-space model, numbers at all ages are random effects
# (NAA_re$sigma = "rec+1")
input3 <-
  prepare_wham_input(
    asap3, recruit_model=2, model_name="Ex 1: SNEMA Yellowtail Flounder",
    selectivity=list(model=rep("age-specific", 3),
                     re=rep("none", 3),
                     initial_pars=list(c(0.5, 0.5, 0.5, 1, 1, 0.5),
                                       c(0.5, 0.5, 0.5, 1, 0.5, 0.5),
                                       c(0.5, 1, 1, 1, 0.5, 0.5)),
                     fix_pars=list(4:5, 4, 2:4)),
    NAA_re=list(sigma="rec+1", cor="iid"))
m3 <- fit_wham(input3, do.osa=FALSE)  # turn off OSA residuals to save time
check_convergence(m3)

# ------------------------------------------------------------------------------
# Model 4
# as m3, but change age comp likelihoods to logistic normal
input4 <-
  prepare_wham_input(
    asap3, recruit_model=2, model_name="Ex 1: SNEMA Yellowtail Flounder",
    selectivity=list(model=rep("age-specific", 3),
                     re=rep("none", 3),
                     initial_pars=list(c(0.5, 0.5, 0.5, 1, 1, 0.5),
                                       c(0.5, 0.5, 0.5, 1, 0.5, 0.5),
                                       c(0.5, 1, 1, 1, 0.5, 0.5)),
                     fix_pars=list(4:5, 4, 2:4)),
    NAA_re=list(sigma="rec+1", cor="iid"),
    age_comp="logistic-normal-miss0")
m4 <- fit_wham(input4, do.osa=TRUE)  # do OSA residuals and show that output
check_convergence(m4)

# ------------------------------------------------------------------------------
# Save list of all fit models
mods <- list(m1=m1, m2=m2, m3=m3, m4=m4)
save("mods", file="ex1_models.RData")

# Compare models by AIC and Mohn's rho
res <- compare_wham_models(mods, table.opts=list(fname="ex1_table", sort=TRUE))
res$best

# Project best model, m4
# Use default values:
# 3-year projection, use average selectivity, M, etc. from last 5 years
m4_proj <- project_wham(m4)

# WHAM output plots for best model with projections
plot_wham_output(m4)  # default is png
plot_wham_output(mod=m4_proj, out.type='html')
