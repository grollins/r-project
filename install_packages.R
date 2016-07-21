install.packages(c("dplyr", "tidyr", "magrittr", "ggplot2", "ggthemes",
                   "ReporteRs", "rstan", "rstanarm", "broom", "devtools"))

devtools::install_github("rstudio/sparklyr")
library(sparklyr)
spark_install(version = "1.6.1")
