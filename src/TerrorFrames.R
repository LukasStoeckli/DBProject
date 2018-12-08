#install.packages('digest', repos='http://cran.us.r-project.org')
library("digest")

source("Utils.R")
source("Models.R")

#-------------------------------------------------------
# MAIN
#-------------------------------------------------------

startTime = proc.time()

cat("\n\t#-#-#-#-#-#-#-#-#-#-#-#-#\n")
cat("\t# Create terror frames  #\n")
cat("\t#-#-#-#-#-#-#-#-#-#-#-#-#\n\n")


# read file
cat("Processing Terrorism 1970 - 2017 data\n")
file = "../data/raw/globalterrorismdb_0718dist.csv"
rawData <- readFile(file)

# get data frames
locationData = getTerrorLocation(rawData)
attackData <- getTerrorAttack(rawData)
targetData <- getTerrorTarget(rawData)
weaponData <- getTerrorWeapon(rawData)
eventData <- getTerrorEvent(rawData)

# create entity data frames
cat("Creating dataframes...\n")
rows <- dim(rawData)[1]
columns <- dim(rawData)[2]


# TERRORLOCATION
cat("Creating terrorLocation dataframe" ,"\n")
# unique locations
uniqueLocationData <- unique(locationData)
cat("unique location entries:",dim(uniqueLocationData)[1],"\n")
# add row number as primary key
terrorLocation <- data.frame(LID = 1:nrow(uniqueLocationData), uniqueLocationData)
# save frame
write.csv(terrorLocation, file="../data/frames/terrorLocation.csv", row.names=FALSE)
# /TERRORLOCATION


# TERRORWEAPON
cat("Creating terrorWeapon dataframe" ,"\n")
# get the four weapon frames
w1 <- cbind(weaponData[,"EID"], weaponData[,2:5])
w2 <- cbind(weaponData[,"EID"], weaponData[,6:9])
w3 <- cbind(weaponData[,"EID"], weaponData[,10:13])
w4 <- cbind(weaponData[,"EID"], weaponData[,14:17])
weapons <- list(w1,w2,w3,w4)
# ditch entries where both ids are 'NA' and unify colnames
for (w in 1:length(weapons)) {
  weapons[[w]] <- weapons[[w]][which(!apply(weapons[[w]], 1, function(x) all(is.na(x[c(2,4)])))),]
  colnames(weapons[[w]]) <- c("EID","weapTypeID","weapType","weapSubtypeID","weapSubtype")
}
# concat frames to one frame
allWeapons <- do.call("rbind", weapons)
# add row index as primary key
terrorWeapon  <- data.frame(WID = 1:nrow(allWeapons), allWeapons)
# save frame
write.csv(terrorWeapon, file="../data/frames/terrorWeapon.csv", row.names=FALSE)
# /TERRORWEAPON


# ATTACKS
cat("Creating terrorAttack dataframe" ,"\n")
a1 <- cbind(attackData[,"EID"], attackData[,2:3])
a2 <- cbind(attackData[,"EID"], attackData[,4:5])
a3 <- cbind(attackData[,"EID"], attackData[,6:7])
attacks <- list(a1,a2,a3)
# ditch entries where id is 'NA' and unify colnames
for (w in 1:length(attacks)) {
  attacks[[w]] <- attacks[[w]][which(!apply(attacks[[w]], 1, function(x) all(is.na(x[c(2)])))),]
  colnames(attacks[[w]]) <- c("EID","attackTypeID","attackType")
}
# concat frames to one frame
allAttacks <- do.call("rbind", attacks)
# add row index as primary key
terrorAttack <- data.frame(AID = 1:nrow(allAttacks), allAttacks)
# save frame
write.csv(terrorAttack, file="../data/frames/terrorAttack.csv", row.names=FALSE)
# /TERRORATTACK


# TERRORTARGET
cat("Creating terrorTarget dataframe" ,"\n")
t1 <- cbind(targetData[,"EID"], targetData[,2:9])
t2 <- cbind(targetData[,"EID"], targetData[,10:17])
t3 <- cbind(targetData[,"EID"], targetData[,18:25])
targets <- list(t1,t2,t3)
# ditch entries where both ids are 'NA' and unify colnames
for (w in 1:length(attacks)) {
  targets[[w]] <- targets[[w]][which(!apply(targets[[w]], 1, function(x) all(is.na(x[c(2,4)])))),]
  colnames(targets[[w]]) <- c("EID","targTypeID","targType","targSubtypeID","targSubtype","corp","target","nationalityID","nationality")
}
# concat frames to one frame
allTargets <- do.call("rbind", targets)
# add row index as primary key
terrorTarget <- data.frame(TID = 1:nrow(allTargets), allTargets)
# save frame
write.csv(terrorTarget, file="../data/frames/terrorTarget.csv", row.names=FALSE)
# /TERRORTARGET


# TERRORRELATION
# ~ 40min
startRelation <- proc.time()
cat("Creating terrorRelation dataframe" ,"\n")
relationData <- data.frame()
rows <- dim(rawData)[1]
startTime = proc.time()
for (line in 1:rows) {
    EID <- rawData[line,"eventid"]
    relations <- unlist(strsplit(as.character(unlist(rawData[line,'related'])), ", "))
    if (length(unlist(relations)) > 0) {
        for (i in 1:length(unlist(relations))) {
            relation = relations[i]
            if (relation != EID) {
                relationData <- rbind(relationData, data.frame(EID = EID, related = relation))
            }
        }
    }
    time <- getTime(startRelation, proc.time())
    printProgressBar(time,line, rows, "relation")
}
cat("Frame has", dim(relationData)[1], "relations","\n")
# add row index as primary key
terrorRelation <- data.frame(RID = 1:nrow(relationData), relationData)
cat("Create csv from dataframe","\n")
write.csv(terrorRelation, file="../data/frames/terrorRelation.csv", row.names=FALSE)
# /TERRORRELATION


# TERROREVENT
startEvent <- proc.time()
cat("Creating terrorEvent dataframe" ,"\n")
# make date from year, month & day columns
eventData["eventDate"] <- paste0(rawData$iyear, "-", sub(rawData$imonth, pattern="^(\\d{1})$", replacement="0\\1"), "-", sub(rawData$iday, pattern="^(\\d{1})$", replacement="0\\1"))
# find LID for each event
cat("Hashing locations","\n")
eventLocationHash <- sapply(gsub(" ", "", apply(locationData, 1, paste, collapse=""), fixed=TRUE, useBytes=TRUE), digest, algo="md5")
locationHash <- sapply(gsub(" ", "", apply(terrorLocation[2:ncol(terrorLocation)], 1, paste, collapse=""), fixed=TRUE, useBytes=TRUE), digest, algo="md5")
cat("Mapping locations","\n")
for(i in 1:rows) {
		eventData$LID[i] <- terrorLocation[which(locationHash %in% eventLocationHash[i])[1],]$LID
    time <- getTime(startEvent, proc.time())
    printProgressBar(time , i, rows, "event")
}
cat("Create csv from dataframe","\n")
write.csv(eventData, file="../data/frames/terrorEvent.csv", row.names=FALSE)
# /TERRORRELATION







endTime <- proc.time()
elapsedTime <- getTime(startTime, endTime)
cat("Finished terror data entity creation in ", elapsedTime,"\n")
