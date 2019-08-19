library(readr)
library('tidyverse')

#### path to replicate model runs ####
path1<-"D:/temp/"
path2<-"D:/temp/test/"

#### for each replicate need to import all CSVs into a list separately
## creates a list of tibbles of all CSVs in directory
files <- list.files(path = path1, pattern = '.csv$', full.names = T) %>%
  map(read_csv)
# adds a new ID column with original ID and replicate concatenated
for (e in 1:length(files)){
  files[[e]]$test1<-rep(e, length(files[[e]]$ID))
  files[[e]]$test<-paste(files[[e]]$ID,files[[e]]$test1, sep="_")
  }

##
files2 <- list.files(path = path2, pattern = '.csv$', full.names = T) %>%
  map(read_csv)
# adds a new ID column with original ID and replicate concatenated
for (e in 1:length(files2)){
  files2[[e]]$test1<-rep(e, length(files2[[e]]$ID))
  files2[[e]]$test<-paste(files2[[e]]$ID,files2[[e]]$test1, sep="_")
}

##
files3 <- list.files(path = path3, pattern = '.csv$', full.names = T) %>%
  map(read_csv)
# adds a new ID column with original ID and replicate concatenated
for (e in 1:length(files3)){
  files3[[e]]$test1<-rep(e, length(files3[[e]]$ID))
  files3[[e]]$test<-paste(files3[[e]]$ID,files3[[e]]$test1, sep="_")
}


#### combine tibbles from different lists into DF ####
for (f in 1:length(files1)){
  nam <- paste("A", f, sep = "")
  outDF<-rbind(files[[f]], files2[[f]]) # combine tibbles from different lists into DF
  outDF2<-select(outDF, -test1, -ID) # drop intermediate columns
  outDF2<-rename(outDF2, ID=test) # rename new ID column
  outDF2<-select(outDF2, Run, Step, Population, ID, everything()) # put new ID column in same location as old
  assign(nam, outDF2) # name DF based on order in CSV list
  }

