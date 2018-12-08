# Databases project #

Authors:  
Manuel Rickli,
Lukas Stöckli


### Data sources ###


Name            | source
--------------- | -------------
Terrorism       | https://www.kaggle.com/START-UMD/gtd
Metal Bands     | https://www.kaggle.com/mrpantherson/metal-by-nation#metal\_bands\_2017.csv
Population      | https://www.kaggle.com/mrpantherson/metal-by-nation#world\_population\_1960\_2015.csv
Weather Station | https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-inventory.txt
Weather Data    | https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd\_all.tar.gz



### Getting started ###
* (install R language, uncomment first line in *./src/DataImport.R*)
* place data files in *./data/raw/*
* run *$Rsrcipt TerrorFrames.R* in *./src/*
* as this takes a while (bit more than an hour), set up the db with *./sql/createProject.sql*
* run *$Rscript DataImport.R* in *./src/*
