## Prepare plots and tables for report

## Before: catage.csv (data), model.rds (model),
##         fatage.csv, natage.csv, summary.csv (output)
## After:  catage.csv, fatage.csv, natage.csv, summary.csv,
##         plots_png/*/*.png, res_tables/wham_par_tables.pdf (report)

library(TAF)
library(wham)

mkdir("report")

# Read data, model object, and results
catage <- read.taf("data/catage.csv")
model <- readRDS("model/model.rds")
fatage <- read.taf("output/fatage.csv")
natage <- read.taf("output/natage.csv")
summary <- read.taf("output/summary.csv")

# Format tables
catage <- round(catage, 3)
fatage <- round(fatage, 3)
natage <- round(natage)
summary <- rnd(summary, 2:5, c(0,0,0,3))

# Write formatted CSV tables
write.taf(catage, dir="report")
write.taf(fatage, dir="report")
write.taf(natage, dir="report")
write.taf(summary, dir="report")

# Write standard WHAM output
plot_wham_output(model, dir="report")
if(file.exists("Rplots.pdf"))
  file.remove("Rplots.pdf")
