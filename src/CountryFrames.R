source("Utils.R")

cat("\n\t#-#-#-#-#-#-#-#-#-#\n")
cat("\t# Country frames  #\n")
cat("\t#-#-#-#-#-#-#-#-#-#\n\n")

startTime <- proc.time()

# read and clean file
cat("Process world population 1960 - 2015 data\n")
file = "./../data/raw/world_population_1960_2015.csv"
rawData <- readFile(file)
# read.csv adds 'X' to all years, also countryName has a whitespace that is turned into a '.'
colnames(rawData) <- sub("\\.", "", colnames(rawData))
colnames(rawData) <- sub("X(.*)", "\\1", colnames(rawData))
colnames(rawData) <- sub("CountryName", "country", colnames(rawData))

# COUNTRY
cat("Country frame","\n")
countryData <- data.frame(country = rawData[,"country"])
write.csv(countryData, file="../data/frames/country.csv", row.names=FALSE)


# POPULATION
cat("Population frame","\n")
populationData <- data.frame()
rows <- nrow(rawData)
columns <- ncol(rawData)
for (line in 1:rows) {
    entry <- rawData[line,]
    country <- entry["country"]
    for (i in 2:columns) {
      year <- colnames(entry)[i]
      population <- entry[1,i]
      if (is.na(population)) { next }
      newEntry <- data.frame(country = country, year = year, population = population)
      populationData <- rbind(populationData, newEntry)
    }
    time <- getTime(startTime, proc.time())
    printProgressBar(time, line, rows, "metal style")
}
# add row index as primary key
populationData <- data.frame(PID = 1:nrow(populationData), populationData)
write.csv(populationData, file="../data/frames/population.csv", row.names=FALSE)



endTime <- proc.time()
elapsedTime <- getTime(startTime, endTime)
cat("Finished country data entity creation in ", elapsedTime,"\n")
