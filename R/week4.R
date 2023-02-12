#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

#Data Import
import_tbl <- read_delim("../data/week4.dat",delim="-",col_names = c("casenum","parnum","stimver","datadate","qs") )
glimpse(import_tbl)
wide_tbl <- separate(import_tbl,qs, into = c("q1","q2","q3","q4","q5"), sep = " - ") 
wide_tbl[,5:9] <- sapply(wide_tbl[,5:9], as.integer)
wide_tbl$datadate <- as.POSIXct(wide_tbl$datadate, format = "%b %d %Y, %H:%M:%S")
wide_tbl[,5:9] <- sapply(wide_tbl[,5:9], na_if, 0L)




wide_tbl <- drop_na(wide_tbl,q2)
long_tbl <- pivot_longer(wide_tbl, cols = starts_with("q"), names_to = "ques",values_to = "response")
