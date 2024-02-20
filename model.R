## Run analysis, write model results

## Before: input.rds (data)
## After:  convergence.txt, model.rds (model)

library(TAF)
library(wham)

mkdir("model")

# Read input data
input <- readRDS("data/input.rds")

# Run model
model <- fit_wham(input, do.osa=TRUE)
convergence <- trimws(capture.output(check_convergence(model)))

# Write results
saveRDS(model, "model/model.rds")
write(convergence, "model/convergence.txt")
