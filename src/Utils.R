# read in csv file
readFile <- function(fileName) {
    startTime <- proc.time()
    cat("Reading file...", "\n")
    rawData <- read.csv(file, header= TRUE, sep = ",")
    time = proc.time() - startTime
    cat("Rows:", dim(rawData)[1], "| columns:", dim(rawData)[2], "| time:", time['elapsed'], "s", "\n")
    return(rawData)
}

# get elapsed time as formated string
getTime <- function(startTime, endTime) {
    elapsedTime <- endTime - startTime
    elapsedTime <- elapsedTime['elapsed']
    sec <- floor(elapsedTime %% 60)
    elapsedTime <- elapsedTime / 60
    min <- floor(elapsedTime %% 60)
    elapsedTime <- elapsedTime / 60
    hr <- floor(elapsedTime %% 24)
    elapsedTime <- sprintf("%02.0f:%02.0f:%02.0f",hr,min,sec)
    return(elapsedTime)
}

# progress bar
printProgressBar <- function(time, done, total, label) {
    if (done == 1) { cat("\n\n") }
    width <- 75
    # info
    info <- paste(done, "of", total, "entries for", label, "data")
    pad <- width - nchar(time) - nchar(info)
    infoLine <- sprintf("%s%*s%8s", info, pad, "", time)
    # bar
    progress <- done / total
    bar <- "["
    barWidth <- width - 2 - 15 # two for '[]' and 15 for percentage
    d <- barWidth * progress
    for (i in 1:barWidth) {
        if (i <= d) { bar <- paste(bar, "#", sep="") }
        else { bar <- paste(bar, "-", sep="") }
    }
    bar <- paste(bar,"]", sep="")
    barLine <- sprintf("%s%5s%8.4f %%", bar, "", 100*progress)
    cat("\033[2A","\r",infoLine,"\n",barLine,"\n", sep="")
}
