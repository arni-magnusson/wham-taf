# WHAM assessment in TAF format

This repo demonstrates what a WHAM assessment looks like in TAF format. The
example is from [Ex
1](https://timjmiller.github.io/wham/articles/ex1_basics.html), included in the
`wham` package vignette.

---

## Browse data and results

On GitHub, view CSV files found inside the [`data`](data), [`output`](output),
and especially [`report`](report) folder, which also contains PNG and PDF files.

Alternatively, download the full analysis as a zip file, using the green `Code`
button above. This allows opening the CSV files as spreadsheets for further
examination and reference.

Look up important WHAM model settings in the `prepare_wham_input` call inside
[`data.R`](https://github.com/arni-magnusson/wham-taf/blob/3e4c290/data.R#L18-L28),
where recruitment, selectivity, numbers-at-age, and age composition settings are
specified.

## Run analysis

Open R in the main working directory containing the R scripts and run the
following three commands:

```
library(TAF)
taf.boot()
source.all()
```

The resulting files will appear in folders `data`, `model`, `output`, and
`report`. These folders can be removed, as they are easy to generate, using the
command:

```
clean()
```

## Introduction to TAF

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
assessment. The inherent complexity of the stock assessment process means that
when examining the larger archive of earlier development model runs and other
explorations, things may not always be straightforward to understand or rerun.

## Open science

A TAF repo on GitHub can be made private or public. In some cases, a stock
assessment repo is kept private while the analysis is developed and then made
public when the assessment report is published, as an online technical annex.

For many stock assessments, the data and results are available online, along
with the general software used to conduct the analysis. By also making the
scripts and model settings available in a standard format that is easy to run,
TAF aims for the highest level of open science as the basis of sustainable
fisheries management.

## TAF and ICES TAF

[ICES](https://ices.dk) created TAF in 2016-2020 as a strategic initiative to
support the highest quality fisheries science for its member countries. The
design is completely general and is neither specific to ICES nor fisheries.
Therefore, TAF can be practical for managing any nontrivial workflow that begins
with input and ends with output.

Two related R packages are maintained on CRAN:

[TAF](https://cran.r-project.org/package=TAF): The general framework and
functions to develop and run a TAF workflow. With a focus on stability and
reproducible analyses, TAF is designed to have no package dependencies.

[icesTAF](https://cran.r-project.org/package=icesTAF): A layer on top of TAF
that provides a collection of utilities that are either ICES-specific or
introduce package dependencies.

## See also

- [ICES TAF landing page](https://taf.ices.dk)
- [ICES TAF documentation](https://github.com/ices-taf/doc)
- Tutorial [video](https://www.youtube.com/watch?v=FweJbr9hfdY) and [annotated
  transcript](https://github.com/ices-taf/doc/tree/master/tutorial-1#readme)
- [TAF package](https://cran.r-project.org/package=TAF) help pages
- ICES TAF stock assessment examples:
  - [2015 Spotted ray](https://github.com/ices-taf/2015_rjm-347d) in the Eastern
    Channel
  - [2015 Haddock](https://github.com/ices-taf/2015_had-iceg) in Icelandic
    waters
  - [2016 Plaice](https://github.com/ices-taf/2016_ple-eche) in the Eastern
    Channel
  - [2016 Cod](https://github.com/ices-taf/2016_cod-347d) in the North Sea
  - [2019 Sandeel](https://github.com/ices-taf/2019_san.sa.6) in Area 6
