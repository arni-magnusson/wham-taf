# WHAM assessment in TAF format

## How to Run

Open R in the main working directory and run three commands:

```
library(TAF)
taf.boot()
source.all()
```

## Introduction to TAF

This repo demonstrates what a WHAM assessment looks like in TAF format. The
example is from [Ex
1](https://timjmiller.github.io/wham/articles/ex1_basics.html), included in the
`wham` package vignette.

---

The main goals of TAF are to:

1. Provide a standard format for a very wide variety of assessments that
   improves reviewability and reproducibility.

2. Provide a basic container that only includes the final assessment model run
   and the required input files, thus clearly distinguishing it from earlier
   development model runs and other explorations.

3. Provide metadata (background information) for the initial input data,
   describing where they originated from and the general contents of each data
   file.

4. Provide a standard sequence of scripts (data-model-output-report) that divide
   the analysis into reviewable parts and can be rerun by anyone to produce the
   same exact results.

---

The data and results are easy to find and view for advisory/scientific committee
members and other interested parties, without requiring technical expertise in
specific stock assessment platforms.

The CSV format allows opening the data and results in a spreadsheet to browse
and quickly calculate averages, range, and other summary statistics.

The CSV files inside the `data` and `output` folders contain the data and
results in full precision, while the tables inside the `report` folder have been
rounded to the precision used in the assessment report.

---

When conducting an update assessment a year later, the TAF repo provides a
convenient starting point. In many cases, only minimal changes are required for
the TAF scripts to run the new assessment.

When a new stock assessor inherits a previous assessment, the TAF repo provides
a lightweight and digestible analysis to study and rerun the previous
assessment, before examining the larger archive of development model runs and
other explorations.
