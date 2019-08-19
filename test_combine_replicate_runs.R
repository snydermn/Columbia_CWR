library(readr)
hourly1 <- read_csv("D:/Results_4Populations/gr_Columbia2040_current/gr_Columbia2040_current-[1]/Data Probe/Steelhead-[Record Accumulator Values] Hourly Status Information [ steelhead ]-accumulators.csv")
hourly2 <- read_csv("D:/Results_4Populations/gr_Columbia2040_current/gr_Columbia2040_current-[2]/Data Probe/Steelhead-[Record Accumulator Values] Hourly Status Information [ steelhead ]-accumulators.csv")
hourly3 <- read_csv("D:/Results_4Populations/gr_Columbia2040_current/gr_Columbia2040_current-[3]/Data Probe/Steelhead-[Record Accumulator Values] Hourly Status Information [ steelhead ]-accumulators.csv")

names(hourly1)
summary(hourly1$ID)
summary(hourly2$ID)
summary(hourly3$ID)


library('tidyverse')
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
for (f in 1:length(files)){
  nam <- paste("A", f, sep = "")
  outDF<-rbind(files[[f]], files2[[f]]) # combine tibbles from different lists into DF
  outDF2<-select(outDF, -test1, -ID) # drop intermediate columns
  outDF2<-rename(outDF2, ID=test) # rename new ID column
  outDF2<-select(outDF2, Run, Step, Population, ID, everything()) # put new ID column in same location as old
  assign(nam, outDF2) # name DF based on order in CSV list
  }

