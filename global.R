library(shiny)
library(DBI)
library(RSQLite)
library(shinyalert)
library(DT)
library(dplyr)
source("modules.R")

shinyInput <- function(FUN, n, id, ...) {
        
        # for each of n, create a new input using the FUN function and convert
        # to a character
        vapply(seq_len(n), function(i){
                as.character(FUN(paste0(id, i), ...))
        }, character(1))
        
}