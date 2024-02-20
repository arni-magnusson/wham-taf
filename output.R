## Extract results of interest, write TAF output tables

## Before: model.rds (model)
## After:  fatage.csv, natage.csv, summary.csv (output)

library(TAF)

mkdir("output")

# Read model results
model <- readRDS("model/model.rds")

# Dims
years <- model$years
ages <- model$ages.lab

# Extract results of interest
fatage <- model$rep$FAA_tot
dimnames(fatage) <- list(years, ages)
fatage <- xtab2taf(fatage)

natage <- model$rep$NAA
dimnames(natage) <- list(years, ages)
natage <- xtab2taf(natage)

summary <- data.frame(Year=model$years, Rec=natage$"1", SSB=model$rep$SSB,
                      Catch=model$rep$pred_catch, Ffull=model$rep$F)

# Write TAF tables
write.taf(fatage, dir="output")
write.taf(natage, dir="output")
write.taf(summary, dir="output")
