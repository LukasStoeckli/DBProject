library("DBI")
library("RMySQL")

source("Utils.R")

startTime <- proc.time()

cat("\n\t#-#-#-#-#-#-#-#-#-#-#-#-#\n")
cat("\t# Upload terror frames  #\n")
cat("\t#-#-#-#-#-#-#-#-#-#-#-#-#\n\n")

#-------------------------------------------------------
# DB
#-------------------------------------------------------

# db connection
con <- dbConnect(
MySQL(),
user="dbProject",
password="db2018",
db="dbProject",
host="127.0.0.1",)

# empty db
emptyDB <- function() {
    dbSendQuery(con, "SET FOREIGN_KEY_CHECKS = 0")
    dbSendQuery(con, "TRUNCATE TABLE TerrorAttack;")
    dbSendQuery(con, "TRUNCATE TABLE TerrorEvent;")
    dbSendQuery(con, "TRUNCATE TABLE TerrorLocation;")
    dbSendQuery(con, "TRUNCATE TABLE TerrorRelation;")
    dbSendQuery(con, "TRUNCATE TABLE TerrorTarget;")
    dbSendQuery(con, "TRUNCATE TABLE TerrorWeapon;")
    dbSendQuery(con, "SET FOREIGN_KEY_CHECKS = 1")
    cat("Truncated Terror entries", "\n");
}



#-------------------------------------------------------
# GET DATA
#-------------------------------------------------------

cat("Reading data frames","\n")

attackFile <- "../data/frames/terrorAttack.csv"
eventFile <- "../data/frames/terrorEvent.csv"
locationFile <- "../data/frames/terrorLocation.csv"
relationFile <- "../data/frames/terrorRelation.csv"
targetFile <- "../data/frames/terrorTarget.csv"
weaponFile <- "../data/frames/terrorWeapon.csv"

terrorAttack <- read.csv(attackFile, header= TRUE, sep = ",")
terrorEvent <- read.csv(eventFile, header= TRUE, sep = ",")
terrorLocation <- read.csv(locationFile, header= TRUE, sep = ",")
terrorRelation <- read.csv(relationFile, header= TRUE, sep = ",")
terrorTarget <- read.csv(targetFile, header= TRUE, sep = ",")
terrorWeapon <- read.csv(weaponFile, header= TRUE, sep = ",")



#-------------------------------------------------------
# UPLOAD DATA
#-------------------------------------------------------

emptyDB()
#dbListTables(con)

cat("Uploading data frames","\n")

dbWriteTable(con, "TerrorAttack", terrorAttack, append = TRUE, row.names = FALSE)
dbWriteTable(con, "TerrorEvent", terrorEvent, append = TRUE, row.names = FALSE)
dbWriteTable(con, "TerrorLocation", terrorLocation, append = TRUE, row.names = FALSE)
dbWriteTable(con, "TerrorRelation", terrorRelation, append = TRUE, row.names = FALSE)
dbWriteTable(con, "TerrorTarget", terrorTarget, append = TRUE, row.names = FALSE)
dbWriteTable(con, "TerrorWeapon", terrorWeapon, append = TRUE, row.names = FALSE)




endTime <- proc.time()
elapsedTime <- getTime(startTime, endTime)
cat("Finished terror data upload in ", elapsedTime,"\n")


#---------------------

on.exit(dbDisconnect(con))
