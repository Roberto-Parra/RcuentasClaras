library(shiny)
library(DBI)
library(RSQLite)
library(shinyalert)
library(DT)
library(dplyr)
source("modules.R")

shinyInput <- function(FUN, n, id, ...) {
        vapply(seq_len(n), function(i){
                as.character(FUN(paste0(id, i), ...))
        }, character(1))
        
}