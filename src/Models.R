#-------------------------------------------------------
# MODELS FOR ENTITIES
#-------------------------------------------------------

# Terror Location
getTerrorLocation <- function(rawData) {
    values <- rawData['country']
    colnames(values) <- sub("country", "countryID", colnames(values))
    values["country"] <- rawData['country_txt']
    values["regionID"] <- rawData['region']
    values["region"] <- rawData['region_txt']
    values["provstate"] <- rawData['provstate']
    values["city"] <- rawData['city']
    values["latitude"] <- rawData['latitude']
    values["longitude"] <- rawData['longitude']
    values["specificity"] <- rawData['specificity']
    values["vicinity"] <- rawData['vicinity']
    values["location"] <- rawData['location']
    return(values)
}

# TerrorAttack
getTerrorAttack <- function(rawData) {
    values <- rawData['eventid']
    colnames(values) <- sub("eventid", "EID", colnames(values))
    values["attackType1ID"] <- rawData['attacktype1']
    values["attackType1"] <- rawData['attacktype1_txt']
    values["attackType2ID"] <- rawData['attacktype2']
    values["attackType2"] <- rawData['attacktype2_txt']
    values["attackType3ID"] <- rawData['attacktype3']
    values["attackType3"] <- rawData['attacktype3_txt']
    return(values)
}

# TerrorTarget
getTerrorTarget <- function(rawData) {
    values <- rawData['eventid']
    colnames(values) <- sub("eventid", "EID", colnames(values))
    values["targtype1ID"] <- rawData['targtype1']
    values["targType1"] <- rawData['targtype1_txt']
    values["targSubtype1ID"] <- rawData['targsubtype1']
    values["targSubtype1"] <- rawData['targsubtype1_txt']
    values["corp1"] <- rawData['corp1']
    values["target1"] <- rawData['target1']
    values["nationality1ID"] <- rawData['natlty1']
    values["nationality1"] <- rawData['natlty1_txt']
    values["targType2ID"] <- rawData['targtype2']
    values["targType2"] <- rawData['targtype2_txt']
    values["argSubtype2ID"] <- rawData['targsubtype2']
    values["targSubtype2"] <- rawData['targsubtype2_txt']
    values["corp2"] <- rawData['corp2']
    values["target2"] <- rawData['target2']
    values["nationality2ID"] <- rawData['natlty2']
    values["nationality2"] <- rawData['natlty2_txt']
    values["targType3ID"] <- rawData['targtype3']
    values["targType3"] <- rawData['targtype3_txt']
    values["targSubtype3ID"] <- rawData['targsubtype3']
    values["targSubtype3"] <- rawData['targsubtype3_txt']
    values["corp3"] <- rawData['corp3']
    values["target3"] <- rawData['target3']
    values["nationality3ID"] <- rawData['natlty3']
    values["nationality3"] <- rawData['natlty3_txt']
    return(values)
}

# TerrorWeapon
getTerrorWeapon <- function(rawData) {
    values <- rawData['eventid']
    colnames(values) <- sub("eventid", "EID", colnames(values))
    values["weaptype1ID"] <- rawData['weaptype1']
    values["weaptype1"] <- rawData['weaptype1_txt']
    values["weapsubtype1ID"] <- rawData['weapsubtype1']
    values["weapsubtype1"] <- rawData['weapsubtype1_txt']
    values["weaptype2ID"] <- rawData['weaptype2']
    values["weaptype2"] <- rawData['weaptype2_txt']
    values["weapsubtype2ID"] <- rawData['weapsubtype2']
    values["weapsubtype2"] <- rawData['weapsubtype2_txt']
    values["weaptype3ID"] <- rawData['weaptype3']
    values["weaptype3"] <- rawData['weaptype3_txt']
    values["weapsubtype3ID"] <- rawData['weapsubtype3']
    values["weapsubtype3"] <- rawData['weapsubtype3_txt']
    values["weaptype4ID"] <- rawData['weaptype4']
    values["weaptype4"] <- rawData['weaptype4_txt']
    values["weapsubtype4ID"] <- rawData['weapsubtype4']
    values["weapsubtype4"] <- rawData['weapsubtype4_txt']
    return(values)
}

# TerrorEvent
getTerrorEvent <- function(rawData) {
    values <- rawData['eventid']
    colnames(values) <- sub("eventid", "EID", colnames(values))
    values["eventDate"] <- "-1"
    values["approxDate"] <- rawData['approxdate']
    values["extended"] <- rawData['extended']
    values["resolution"] <- rawData['resolution']
    values["LID"] <- "-1"
    values["summary"] <- rawData['summary']
    values["crit1"] <- rawData['crit1']
    values["crit2"] <- rawData['crit2']
    values["crit3"] <- rawData['crit3']
    values["doubtterr"] <- rawData['doubtterr']
    values["alternativeID"] <- rawData['alternative']
    values["alternative"] <- rawData['alternative_txt']
    values["multiple"] <- rawData['multiple']
    values["success"] <- rawData['success']
    values["suicide"] <- rawData['suicide']
    values["nkill"] <- rawData['nkill']
    values["nkillus"] <- rawData['nkillus']
    values["nkillter"] <- rawData['nkillter']
    values["nwound"] <- rawData['nwound']
    values["nwoundus"] <- rawData['nwoundus']
    values["nwoundte"] <- rawData['nwoundte']
    values["property"] <- rawData['property']
    values["propextentID"] <- rawData['propextent']
    values["propextent"] <- rawData['propextent_txt']
    values["propvalue"] <- rawData['propvalue']
    values["propcomment"] <- rawData['propcomment']
    values["addnotes"] <- rawData['addnotes']
    values["weapdetail"] <- rawData['weapdetail']
    values["gname"] <- rawData['gname']
    values["gsubname"] <- rawData['gsubname']
    values["gname2"] <- rawData['gname2']
    values["gsubname2"] <- rawData['gsubname2']
    values["gname3"] <- rawData['gname3']
    values["gsubname3"] <- rawData['gsubname3']
    values["motive"] <- rawData['motive']
    values["guncertain1"] <- rawData['guncertain1']
    values["guncertain2"] <- rawData['guncertain2']
    values["guncertain3"] <- rawData['guncertain3']
    values["individual"] <- rawData['individual']
    values["nperps"] <- rawData['nperps']
    values["nperpcap"] <- rawData['nperpcap']
    values["claimed"] <- rawData['claimed']
    values["claimmodeID"] <- rawData['claimmode']
    values["claimmode"] <- rawData['claimmode_txt']
    values["claim2"] <- rawData['claim2']
    values["claimmode2ID"] <- rawData['claimmode2']
    values["claimmode2"] <- rawData['claimmode2_txt']
    values["claim3"] <- rawData['claim3']
    values["claimmode3ID"] <- rawData['claimmode3']
    values["claimmode3"] <- rawData['claimmode3_txt']
    values["compclaim"] <- rawData['compclaim']
    values["ishostkid"] <- rawData['ishostkid']
    values["nhostkid"] <- rawData['nhostkid']
    values["nhostkidus"] <- rawData['nhostkidus']
    values["nhours"] <- rawData['nhours']
    values["ndays"] <- rawData['ndays']
    values["divert"] <- rawData['divert']
    values["country"] <- rawData['kidhijcountry']
    values["ransom"] <- rawData['ransom']
    values["ransomamt"] <- rawData['ransomamt']
    values["ransomamtus"] <- rawData['ransomamtus']
    values["ransompaid"] <- rawData['ransompaid']
    values["ransompaidus"] <- rawData['ransompaidus']
    values["ransomnote"] <- rawData['ransomnote']
    values["hostkidoutcomeID"] <- rawData['hostkidoutcome']
    values["hostkidoutcome"] <- rawData['hostkidoutcome_txt']
    values["nreleased"] <- rawData['nreleased']
    values["scite1"] <- rawData['scite1']
    values["scite2"] <- rawData['scite2']
    values["scite3"] <- rawData['scite3']
    values["dbsource"] <- rawData['dbsource']
    values["INT_LOG"] <- rawData['INT_LOG']
    values["INT_IDEO"] <- rawData['INT_IDEO']
    values["INT_MISC"] <- rawData['INT_MISC']
    values["INT_ANY"] <- rawData['INT_ANY']
    return(values)
}
