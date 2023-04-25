# rm(list = ls()); gc()
## Removing the entire environment and activating garbage collector to clear the memory

setwd('C:/Users/Ryan Song/Desktop/for/Data') # Set your own working directory!!
getwd()

list.files()
list.files()[1]

data = data.table::fread(list.files()[1])
summary(data)
rm(data)

data = data.frame()
for(i in 1:length(list.files())) {
  sub = read.csv(list.files()[i])
  data = rbind(data,sub)
  rm(sub)
  print(i)
}
summary(data)

readall = function(x) {
  setwd(x)
  data = data.frame()
  for(i in 1:length(list.files())) {
    sub = read.csv(list.files()[i])
    data = rbind(data,sub)
    rm(sub)
  }
  return(data)
}

x = getwd()
data2 = readall(x)
summary(data2)

save(readall, file = '../Code/readall.R')