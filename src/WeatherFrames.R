# ----------------------- stations mapping ------------------
# get station closest to terrorLocations
library(geosphere)

te <- read.csv("terrorEvent.csv")
gt <- read.csv("globalterrorismdb_0718dist.csv")

# list with all stations, their locaiton and time range
stations <- read.csv("ghcnd-inventory.txt", sep="")

# get relevant stations
stations <- stations[stations$element == "PRCP",]
stations <- stations[which(stations$stop >= 1970),]
stations <- stations[which(stations$start <= 2018),]

# coordinates of stations
coords <- data.frame(stations$lon, stations$lat)
weather <- data.frame(matrix(nrow=0, ncol=4))

# create data.frame with necessary informatoin for station mapping
locations <- data.frame(te$LID, gt$longitude, gt$latitude, gt$iyear, te$eventDate)
colnames(locations) <- c("LID", "longitude", "latitude", "year", "date")

# remomve entries with missing location values
locations <- locations[complete.cases(locations),]

# locations <- locations[1:44283,]

counter <- 0

pt <- proc.time()

# loop through every event wit a given location
for(i in 1:nrow(locations)) {
	# get distance on earht between point and every station
	d <- distm(c(locations$longitude[i], locations$latitude[i]), coords, fun=distGeo)
	d <- d[complete.cases(d)]
	d_sort <- sort(d)
	
	# loop through the sorted list and map a station if it is within 50km radius
	for (j in 1:length(d)) {
		min <- d_sort[j]
		if (min > 50000) {
			counter <- counter + 1
			break
		}
		
		# check if measurements took place at event date
		if (stations$start[which(min == d)] <= locations$year[i]
		 && stations$stop[which(min == d)] >= locations$year[i]) {
		 
		 	id <- as.character(stations$id[which(min == d)])
		 	tmp <- data.frame(locations$LID[i], locations$date[i], 
		 	-1, id)
		 	
		 	colnames(tmp) <- c("LID", "date", "rain", "station")
		 	weather <- rbind(weather, tmp)
		 	
		 	break
		}
	}
	et <- proc.time() - pt
	etStr <- strsplit(as.character(et['elapsed']/60), "[.]")
	cat(etStr[[1]][1], ".",substring(etStr[[1]][2], 1, 2), "/", format(round((et['elapsed']/(60*i))*nrow(locations), 2), nsmall=2), " minutes     ", "\r", sep="")
}

print("")
print(paste("Number of stations farther away than 50 km:", counter))

# ------------------ get weather data -----------------------
# order table by station to enable 
weather <- weather[order(weather$station),]

# extract day, month and year
weather$year <- as.numeric(sub(weather$date, pattern="^(\\d{4}).*", replacement="\\1"))
weather$month <- as.numeric(sub(weather$date, pattern="^\\d{4}-(\\d{2}).*", replacement="\\1"))
weather$day <- as.numeric(sub(weather$date, pattern=".*(\\d{2})$", replacement="\\1"))
weather$tavg <- -1

weather <- weather[,c(1:2,4,3,8,5:7)]

tmp <- ""

pt <- proc.time()

# loop through weather table and get weather information for each entry if possible
for(i in 1:nrow(weather)) {
	if (tmp != weather$station[i]) {
		# open dly file (widths defines the length of the entry in the columns)
		station <- read.fwf(paste0("ghcnd_all/", weather$station[i], ".dly"), 
		widths=c(11, 4, 2, 4, rep(c(5,1,1,1), 31)))
	}
	
	# get rain and average temperature information
	weather$rain[i] <- station[which(station$V2 == weather$year[i] & station$V3 == weather$month[i]
				  & station$V4 == "PRCP"),][1 + (as.numeric(weather$day[i]) * 4)]
	weather$tavg[i] <- station[which(station$V2 == weather$year[i] & station$V3 == weather$month[i]
				  & station$V4 == "TAVG"),][1 + (as.numeric(weather$day[i]) * 4)]
				  
	et <- proc.time() - pt
	etStr <- strsplit(as.character(et['elapsed']/60), "[.]")
	cat(etStr[[1]][1], ".",substring(etStr[[1]][2], 1, 2), "/", format(round((et['elapsed']/(60*i))*nrow(weather), 2), nsmall=2), " minutes | entry: ", i, "/", nrow(weather), "\r", sep="")
	
	tmp <- weather$station[i]
}

# clean rain and tavg columns
weather$rain[which(weather$rain == "integer(0)")] <- -9999
weather$tavg[which(weather$tavg == "integer(0)")] <- -9999

# only select entries where rain and/or tavg is present
weather <- weather[weather$rain != -9999 | weather$tavg != -9999,]

write.csv(weather, "weather.csv", row.names=FALSE)
