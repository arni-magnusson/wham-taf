## Preprocess data, write TAF data tables

## Before: ex1_SNEMAYT.dat (boot/data)
## After:  catage.csv, catch.csv, input.rds, maturity.csv, natmort.csv,
##         survey_fall_catage.csv, survey_fall_index.csv,
##         survey_spring_catage.csv, survey_spring_index.csv, wcatch.csv,
##         wstock.csv (data)

library(TAF)

mkdir("data")
library(wham)

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

# Dims
years <- input$years
ages <- input$ages.lab

# Extract and format data
natmort <- input$asap3$M
dimnames(natmort) <- list(years, ages)
natmort <- xtab2taf(natmort)

maturity <- input$data$mature
dimnames(maturity) <- list(years, ages)
maturity <- xtab2taf(maturity)

catch <- data.frame(Year=years, Catch=input$data$agg_catch,
                    Sigma=input$data$agg_catch_sigma)

catage <- drop(input$data$catch_paa)
dimnames(catage) <- list(years, ages)
catage <- xtab2taf(catage)

survey.spring.index <- data.frame(Year=years, Index=input$data$agg_indices[,1],
                                  Sigma=input$data$agg_index_sigma[,1])

survey.spring.catage <- input$data$index_paa[1,,]
dimnames(survey.spring.catage) <- list(years, ages)
survey.spring.catage <- xtab2taf(survey.spring.catage)

survey.fall.index <- data.frame(Year=years, Index=input$data$agg_indices[,2],
                                Sigma=input$data$agg_index_sigma[,2])

survey.fall.catage <- input$data$index_paa[2,,]
dimnames(survey.fall.catage) <- list(years, ages)
survey.fall.catage <- xtab2taf(survey.fall.catage)

wcatch <- input$data$waa[1,,]
dimnames(wcatch) <- list(years, ages)
wcatch <- xtab2taf(wcatch)

wstock <- input$data$waa[3,,]
dimnames(wstock) <- list(years, ages)
wstock <- xtab2taf(wstock)

# Write TAF tables
saveRDS(input, "data/input.rds")
write.taf(natmort, dir="data")
write.taf(maturity, dir="data")
write.taf(catch, dir="data")
write.taf(catage, dir="data")
write.taf(survey.spring.index, dir="data")
write.taf(survey.spring.catage, dir="data")
write.taf(survey.fall.index, dir="data")
write.taf(survey.fall.catage, dir="data")
write.taf(wcatch, dir="data")
write.taf(wstock, dir="data")
