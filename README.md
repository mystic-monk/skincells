# skincells
Case study for assignment of MATH9903 - PG Certificate in Applied Statistics TUD

# Introduction
Researchers in the Radiation and Environmental Science Centre are conducting research into
the effect of solar radiation on the mortality of human skin cells. Colonies of human skin cells
are placed in medium and transferred to wells on experimental plates. These plates are then
exposed to radiation in a solar simulator for various amounts of time from 0 (control) to 3.5
minutes. After exposure, the number of live cells in a sample are counted under a microscope
and the total number of live cells in the colony is extrapolated from the sample result. The
purpose of this experiment is to assess the effect of the varying times of exposure to radiation
on cell death. Due to inherent variability in the response of cells, the researchers replicate
their experiments a number of times. There was also concern that environmental conditions
within the lab from day to day may have an impact on the results. Therefore, the experiment is
repeated over a number of days. Initially the experiment is designed with complete balance; i.e.
the same number of replications at each exposure time on each day. But due to experimental
loss, complete balance was not reflected in the final data (e.g. some plates were contaminated
and had to be discarded).

# Variable Description
day       : The day (number code) that observation was recorded.
time      : The amount of radiation exposure in minutes the colony was
exposed to in the solar simulator.
logcells  : The logarithm (base 2) of the number of live cells in the
colony extrapolated from the sample result under the microscope.

1. Using an R programme read these data into a data.frame and obtain basic descriptive
statistics/plots of the data. Present salient features from this exploratory data analysis
in your report.

2. Using an R programme, analyse these data considering the two predictors, i.e. time
(continuous) and day (categorical) and the response logcells. You should consider the
possibility of interactions between the predictors. Submit your complete R programme
code with suitable explanatory in-code comments.

3. Report your findings (4 pages maximum excluding R-code): summarise the relationship
between predictor(s) and the response(what are the average effects, confidence intervals,
results of tests of hypotheses etc.). Present plots where appropriate.
