source("Utils.R")


cat("\n\t#-#-#-#-#-#-#-#-#-#\n")
cat("\t# Metal frames    #\n")
cat("\t#-#-#-#-#-#-#-#-#-#\n\n")

startTime <- proc.time()


# read and clean metal file
cat("Reading file...\n")
file = "/Users/Lukas/unibas/sem5/databases/project/datasets/metal-bands-by-nation/metal_bands_2017.csv"
rawData <- read.csv(file, header= TRUE, sep = ",", quote = "\"")
# adapt colnames to db
colnames(rawData) <- sub("band_name", "bandName", colnames(rawData))
# remove duplicates (1:50 == 51:100)
oldRows <- dim(rawData)[1]
rawData <- unique(rawData[, 2:dim(rawData)[2]])
cat("Removed ", (oldRows - dim(rawData)[1]), "duplicates\n")
# also the first occurrence of michael schenker's temple of rock is renamed
# as it is michael schenker group


# METALBANDS
cat("Metal band frame","\n")
metalData <- rawData[,c("bandName","fans","formed","origin","split")]
write.csv(metalData, file="../data/frames/metalBand.csv", row.names=FALSE)


# METALSTYLES
cat("Metal style frame","\n")
styleData <- data.frame()
rows <- nrow(rawData)
for (line in 1:rows) {
    entry <- rawData[line,]
    styles <- unlist(strsplit(as.character(unlist(entry['style'])), ","))
    if (length(unlist(styles)) > 0) {
        for (i in 1:length(unlist(styles))) {
            newEntry <- data.frame(bandName = entry['bandName'], style = styles[i])
            styleData <- rbind(styleData, newEntry)
        }
    }
    time <- getTime(startTime, proc.time())
    printProgressBar(time, line, rows, "metal style")
}
# add row index as primary key
styleData <- data.frame(SID = 1:nrow(styleData), styleData)
# save frame
write.csv(styleData, file="../data/frames/metalStyle.csv", row.names=FALSE)
