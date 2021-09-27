[Propensity score matching versus cardinality matching]
=============

<img src="https://img.shields.io/badge/Study%20Status-Repo%20Created-lightgray.svg" alt="Study Status: Results Available">

- Analytics use case(s): **Population-Level Estimation**
- Study type: **Methods**
- Tags: **-**
- Study lead: **Stephen Fortin**
- Study lead forums tag: **[stephenfortin](https://forums.ohdsi.org/u/stephenfortin/)**
- Study start date: **-**
- Study end date: **-**
- Protocol: **-**
- Publications: **-**
- Results explorer: **-**

Description
==========

The current study compares the performance of PSM vs. CM (non-large scale) in terms of post-match sample retention, matching and observed covariate balance, and residual confounding. Residual confounding is measured based on the expected absolute sysematic error (EASE) of negative control outcome experiments. 

How to run
==========

Download all of the scripts necessary to run the study [here](https://github.com/ohdsi-studies/PsmVsCm/tree/master/Code). The code required to conduct the study is contained in the file named generateData.R.

1. Make sure that you have Java installed. If you don't have Java already installed on your computed (on most computers it already is installed), go to java.com to get the latest version. (If you have trouble building with rJava below, be sure on Windows that your Path variable includes the path to jvm.dll (Windows Button --> type "path" --> Edit Environmental Variables --> Edit PATH variable, add to end ;C:/Program Files/Java/jre/bin/server) or wherever it is on your system).

2. The study will require a Gurobi license. Make sure Gurobi is installed on you local machine to perform cardinality matching. In R, use the following code to install Gurobi from your local machine:

```r
if (!require('gurobi')){install.packages("/gurobi_9.0-1.zip", repos = NULL)} # Update gurobi version and file path as necesssary

```

3. In R, use the following code to install the study package's dependencies:

```r
install.packages("devtools")

library(devtools)
devtools::install_github("tidyverse/ggplot2",ref = "v3.2.0")
devtools::install_github("OHDSI/CohortMethod", ref="v3.1.1", args="--no-multiarch")
devtools::install_github("OHDSI/FeatureExtraction", ref="v2.2.5", args="--no-multiarch")
devtools::install_github("OHDSI/DatabaseConnector", ref="v3.0.0", args="--no-multiarch")
devtools::install_github("OHDSI/Cyclops", ref="v2.0.3", args="--no-multiarch")
devtools::install_github("OHDSI/SqlRender", ref="v1.6.4", args="--no-multiarch")

if (!require("pacman")) install.packages("pacman")
pacman::p_load(devtools, drat, CohortMethod, SqlRender, DatabaseConnector, grid, reshape2, dplyr,
               designmatch, caret, rdist, gurobi, EmpiricalCalibration, caTools, openxlsx, MatchIt,
               CohortDiagnostics)
```
      
4. Once installed, you can define parameters using the following code:

Line 37

```r
connectionDetails <- createConnectionDetails(
  dbms = "",
  server = "",
  extraSettings = "",
  port = 123,
  user = "",
  password = ""
)
```

Line 54

```r
# Set working directory
wd <- ""
setwd(wd)

# Set parameter settings
cohortDatabaseSchema <- ""  
cdmDatabaseSchema <- "" 
cdmVersion <- "5"
oracleTempSchema <- NULL
ohdsiSchema <- ""
cohortOutcomeTable <- ""
cohortTable <- ""
cohortAttributeTable <- ""
attributeDefinitionTable <- ""
cmDataFolder <- paste0(wd, "/cmData")
splitRatio <- 
num_cohorts <- 

# Define cohort ids
cohort_id_1 <-      # Comparator 1
cohort_id_2 <-       # Comparator 2
cohort_id_3 <-       # Outcome

# Define negative control concept ids
ncs <- c(434165,436409,199192,4088290,4092879,44783954,75911,137951,77965,
         376707,4103640,73241,133655,73560,434327,4213540,140842,81378,
         432303,4201390,46269889,134438,78619,201606,76786,4115402,
         45757370,433111,433527,4170770,4092896,259995,40481632,4166231,
         433577,4231770,440329,4012570,4012934,441788,4201717,374375,
         4344500,139099,444132,196168,432593,434203,438329,195873,4083487,
         4103703,4209423,377572,40480893,136368,140648,438130,4091513,
         373478,46286594,439790,81634,380706,141932,36713918,
         443172,81151,72748,378427,437264,194083,140641,440193,4115367,
         36713926,79864,36717682,438120,440704,441277,436373,4002818,
         73754,136773,376382,439776,4248728,440021,434626,4241530,
         3671469,36717115,437969,4119307,195590,42873170,80502,
         436785,74464,72404,439935,437092,442306,378424)
```

- For details on how to configurecreateConnectionDetails in your environment type this for help:
 ?createConnectionDetails
- cdmDatabaseSchema should specify the schema name where your patient-level data in OMOP CDM format resides. Note that for Redshift, this should include the database name, for example 'cdm_data'.
- oracleTempSchema should be used in Oracle to specify a schema where the user has write privileges for storing temporary tables.
- cmDataFolder (created in the next step) specifies the location where data on the study population is stored
- splitRatio specifies the percent of the study population to place in each subsample draw of each sample group
- num_cohorts the number of subsample draws for the given sample group

5. To execute the study, run all code subsequent to line 101. 
