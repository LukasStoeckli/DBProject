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
* R
  * R script interpreter required
  * library *digest* required (uncomment first line in *./src/TerrorFrames.R*)
* data
  * create *./data/raw/* and *./data/frames/*
  * place raw data files in *./data/raw/*
* in *./src/* run
  * *$Rscript TerrorFrames.R*
  * *$Rscript MetalFrames.R*
  * *$Rscript CountryFrames.R*
  * *$Rscript WeatherFrames.R*
  * or place existing frames in *./data/frames/*
* set up db with *./sql/createProject.sql*
* in *./src/* run *$Rscript DataImport.py*


### Analysis ###
* create views with *./sql/views.sql*
* run *$python ./src/analyze.py* to get the plots


### Global Terrorism Map 1970 - 2017 ###
![Alt text](Output/911.jpg?raw=true "Global Terror")
* Open *.map/map.html*
* use range slider to select year
* mouse over location to get details
