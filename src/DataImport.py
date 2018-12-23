import mysql.connector
import csv
import time


#---------------------------
# COUNTRY
#---------------------------
def uploadCountryData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                country = row['country']
                try:
                    query = "INSERT INTO Country (country) VALUES (\"%s\")"%(country)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# METALBAND
#---------------------------
def uploadMetalBandData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                bandName = row['bandName'].replace('\"', '\'')
                fans = row['fans']
                formed = row['formed']
                origin = row['origin']
                split = row['split']
                try:
                    query = "INSERT INTO MetalBand (bandName, fans, formed, origin, split) VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(bandName, fans, formed, origin, split)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# METALSTYLE
#---------------------------
def uploadMetalStyleData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                SID = row['SID']
                bandName = row['bandName'].replace('\"', '\'')
                style = row['style']
                try:
                    query = "INSERT INTO MetalStyle (SID, bandName, style) VALUES (\"%s\",\"%s\",\"%s\")"%(SID, bandName, style)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# POPULATION
#---------------------------
def uploadPopulationData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                PID = row['PID']
                country = row['country']
                year = row['year']
                population = row['population']
                try:
                    query = "INSERT INTO Population (PID, country, year, population) VALUES (\"%s\",\"%s\",\"%s\",\"%s\")"%(PID, country, year, population)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# TERRORATTACK
#---------------------------
def uploadTerrorAttackData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                AID = row['AID']
                EID = row['EID']
                attackTypeID = row['attackTypeID']
                attackType = row['attackType']
                try:
                    query = "INSERT INTO TerrorAttack (AID, EID, attackTypeID, attackType) VALUES (\"%s\",\"%s\",\"%s\",\"%s\")"%(AID, EID, attackTypeID, attackType)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# TERROREVENT
#---------------------------
def uploadTerrorEventData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                EID = row['EID']
                eventDate = row['eventDate']
                approxDate = row['approxDate'].replace('\"', '\'')
                extended = row['extended']
                resolution = row['resolution']
                LID = row['LID']
                summary = row['summary'].replace('\"', '\'').replace('\\','\\\\')
                crit1 = row['crit1']
                crit2 = row['crit2']
                crit3 = row['crit3']
                doubtterr = row['doubtterr']
                alternativeID = row['alternativeID']
                alternative = row['alternative'].replace('\"', '\'')
                multiple = row['multiple']
                success = row['success']
                suicide = row['suicide']
                nkill = row['nkill']
                nkillus = row['nkillus']
                nkillter = row['nkillter']
                nwound = row['nwound']
                nwoundus = row['nwoundus']
                nwoundte = row['nwoundte']
                property = row['property']
                propextentID = row['propextentID']
                propextent = row['propextent'].replace('\"', '\'').replace('\\','\\\\')
                propvalue = row['propvalue']
                propcomment = row['propcomment'].replace('\"', '\'').replace('\\','\\\\')
                addnotes = row['addnotes'].replace('\"', '\'')
                weapdetail = row['weapdetail'].replace('\"', '\'')
                gname = row['gname'].replace('\"', '\'')
                gsubname = row['gsubname'].replace('\"', '\'')
                gname2 = row['gname2'].replace('\"', '\'')
                gsubname2 = row['gsubname2'].replace('\"', '\'')
                gname3 = row['gname3'].replace('\"', '\'')
                gsubname3 = row['gsubname3'].replace('\"', '\'')
                motive = row['motive'].replace('\"', '\'')
                guncertain1 = row['guncertain1']
                guncertain2 = row['guncertain2']
                guncertain3 = row['guncertain3']
                individual = row['individual']
                nperps = row['nperps']
                nperpcap = row['nperpcap']
                claimed = row['claimed']
                claimmodeID = row['claimmodeID']
                claimmode = row['claimmode'].replace('\"', '\'')
                claim2 = row['claim2']
                claimmode2ID = row['claimmode2ID']
                claimmode2 = row['claimmode2'].replace('\"', '\'')
                claim3 = row['claim3']
                claimmode3ID = row['claimmode3ID']
                claimmode3 = row['claimmode3'].replace('\"', '\'')
                compclaim = row['compclaim']
                ishostkid = row['ishostkid']
                nhostkid = row['nhostkid']
                nhostkidus = row['nhostkidus']
                nhours = row['nhours']
                ndays = row['ndays']
                divert = row['divert'].replace('\"', '\'')
                country = row['country'].replace('\"', '\'')
                ransom = row['ransom']
                ransomamt = row['ransomamt']
                ransomamtus = row['ransomamtus']
                ransompaid = row['ransompaid']
                ransompaidus = row['ransompaidus']
                ransomnote = row['ransomnote'].replace('\"', '\'')
                hostkidoutcomeID = row['hostkidoutcomeID']
                hostkidoutcome = row['hostkidoutcome'].replace('\"', '\'')
                nreleased = row['nreleased']
                scite1 = row['scite1'].replace('\"', '\'').replace('\\','\\\\')
                scite2 = row['scite2'].replace('\"', '\'').replace('\\','\\\\')
                scite3 = row['scite3'].replace('\"', '\'').replace('\\','\\\\')
                dbsource = row['dbsource'].replace('\"', '\'')
                INT_LOG = row['INT_LOG']
                INT_IDEO = row['INT_IDEO']
                INT_MISC = row['INT_MISC']
                INT_ANY = row['INT_ANY']
                try:
                    query = "INSERT INTO TerrorEvent (EID, eventDate, approxDate, extended, resolution, LID, summary, crit1, crit2, crit3, doubtterr, alternativeID, alternative, multiple, success, suicide, nkill, nkillus, nkillter, nwound, nwoundus, nwoundte, property, propextentID, propextent, propvalue, propcomment, addnotes, weapdetail, gname, gsubname, gname2, gsubname2, gname3, gsubname3, motive, guncertain1, guncertain2, guncertain3, individual, nperps, nperpcap, claimed, claimmodeID, claimmode, claim2, claimmode2ID, claimmode2, claim3, claimmode3ID, claimmode3, compclaim, ishostkid, nhostkid, nhostkidus, nhours, ndays, divert, country, ransom, ransomamt, ransomamtus, ransompaid, ransompaidus, ransomnote, hostkidoutcomeID, hostkidoutcome, nreleased, scite1, scite2, scite3, dbsource, INT_LOG, INT_IDEO, INT_MISC, INT_ANY) VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(EID, eventDate, approxDate, extended, resolution, LID, summary, crit1, crit2, crit3, doubtterr, alternativeID, alternative, multiple, success, suicide, nkill, nkillus, nkillter, nwound, nwoundus, nwoundte, property, propextentID, propextent, propvalue, propcomment, addnotes, weapdetail, gname, gsubname, gname2, gsubname2, gname3, gsubname3, motive, guncertain1, guncertain2, guncertain3, individual, nperps, nperpcap, claimed, claimmodeID, claimmode, claim2, claimmode2ID, claimmode2, claim3, claimmode3ID, claimmode3, compclaim, ishostkid, nhostkid, nhostkidus, nhours, ndays, divert, country, ransom, ransomamt, ransomamtus, ransompaid, ransompaidus, ransomnote, hostkidoutcomeID, hostkidoutcome, nreleased, scite1, scite2, scite3, dbsource, INT_LOG, INT_IDEO, INT_MISC, INT_ANY)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + " " + EID + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName
        with open('../logs/error.log', 'a') as errorLog:
            errorLog.write("FILE " + str(e) + '\n')


#---------------------------
# TERRORLOCATION
#---------------------------
def uploadTerrorLocationData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                LID = row['LID']
                countryID = row['countryID']
                country = row['country']
                regionID = row['regionID']
                region = row['region']
                provstate = row['provstate']
                city = row['city']
                latitude = row['latitude']
                longitude = row['longitude']
                specificity = row['specificity']
                vicinity = row['vicinity']
                location = row['location'].replace('\"', '\'').replace('\\','\\\\')
                try:
                    query = "INSERT INTO TerrorLocation (LID, countryID, country, regionID, region, provstate, city, latitude, longitude, specificity, vicinity, location) VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(LID, countryID, country, regionID, region, provstate, city, latitude, longitude, specificity, vicinity, location)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# TERRORRELATION
#---------------------------
def uploadTerrorRelationData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                RID = row['RID']
                EID = row['EID']
                related = row['related']
                try:
                    query = "INSERT INTO TerrorRelation (RID, EID, related) VALUES (\"%s\",\"%s\",\"%s\")"%(RID, EID, related)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# TERRORTARGET
#---------------------------
def uploadTerrorTargetData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                TID = row['TID']
                EID = row['EID']
                targTypeID = row['targTypeID']
                targType = row['targType'].replace('\"', '\'')
                targSubtypeID = row['targSubtypeID']
                targSubtype = row['targSubtype'].replace('\"', '\'')
                corp = row['corp'].replace('\"', '\'')
                target = row['target'].replace('\"', '\'')
                nationalityID = row['nationalityID']
                nationality = row['nationality'].replace('\"', '\'')
                try:
                    query = "INSERT INTO TerrorTarget (TID, EID, targTypeID, targType, targSubtypeID, targSubtype, corp, target, nationalityID, nationality) VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(TID, EID, targTypeID, targType, targSubtypeID, targSubtype, corp, target, nationalityID, nationality)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# TERRORWEAPON
#---------------------------
def uploadTerrorWeaponData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                WID = row['WID']
                EID = row['EID']
                weapTypeID = row['weapTypeID']
                weapType = row['weapType']
                weapSubtypeID = row['weapSubtypeID']
                weapSubtype = row['weapSubtype']
                try:
                    query = "INSERT INTO TerrorWeapon (WID, EID, weapTypeID, weapType, weapSubtypeID, weapSubtype) VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(WID, EID, weapTypeID, weapType, weapSubtypeID, weapSubtype)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#---------------------------
# WEATHER
#---------------------------
def uploadWeatherData(fileName, db):
    try:
        with open(fileName, 'r') as dataFile:
            print '[+] Importing \'%s\''%fileName
            dataReader = csv.DictReader(dataFile, delimiter=',', quotechar='"')
            counter = 0
            for row in dataReader:
                LID = row['LID']
                weatherDate = row['weatherDate']
                rain = row['rain']
                temperature = row['temperature']
                station = row['station']
                try:
                    query = "INSERT INTO Weather (LID, weatherDate, rain, temperature, station) VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(LID, weatherDate, rain, temperature, station)
                    db.cursor().execute(query)
                    db.commit()
                    counter += 1
                except Exception, e:
                    with open('../logs/error.log', 'a') as errorLog:
                        errorLog.write("INSERT " + str(e) + '\n')
            print '[+] successfully imported %d entries'%counter
    except Exception, e:
        print '[-] Failed to open \'%s\''%fileName


#-------------------------------------------------------
# MAIN
#-------------------------------------------------------

def main():
    startTime = time.time()
    try:
        # db setup
        db = mysql.connector.connect(user='dbProject',
                                     password='db2018',
                                     host='127.0.0.1',
                                     database='dbProject')
        cursor = db.cursor()
    except Exception, e:
        print '[-] failed to connect to db'
        with open('../logs/error.log', 'a') as errorLog:
            errorLog.write("CONNECT " + str(e) + '\n')
            return

    try:
        db.cursor().execute("TRUNCATE TABLE Country;")
        db.cursor().execute("TRUNCATE TABLE MetalBand;")
        db.cursor().execute("TRUNCATE TABLE MetalStyle;")
        db.cursor().execute("TRUNCATE TABLE Population;")
        db.cursor().execute("TRUNCATE TABLE TerrorAttack;")
        db.cursor().execute("TRUNCATE TABLE TerrorEvent;")
        db.cursor().execute("TRUNCATE TABLE TerrorLocation;")
        db.cursor().execute("TRUNCATE TABLE TerrorRelation;")
        db.cursor().execute("TRUNCATE TABLE TerrorTarget;")
        db.cursor().execute("TRUNCATE TABLE TerrorWeapon;")
        db.cursor().execute("TRUNCATE TABLE Weather;")
        db.commit()
        print '[+] Truncated db entries'
    except Exception, e:
        with open('../logs/error.log', 'a') as errorLog:
            errorLog.write("TRUNCATE " + str(e) + '\n')


    uploadCountryData("../data/frames/country.csv", db)
    uploadMetalBandData("../data/frames/metalBand.csv", db)
    uploadMetalStyleData("../data/frames/metalStyle.csv", db)
    uploadPopulationData("../data/frames/population.csv", db)
    uploadTerrorAttackData("../data/frames/terrorAttack.csv", db)
    uploadTerrorEventData("../data/frames/terrorEvent.csv", db)
    uploadTerrorLocationData("../data/frames/terrorLocation.csv", db)
    uploadTerrorRelationData("../data/frames/terrorRelation.csv", db)
    uploadTerrorTargetData("../data/frames/terrorTarget.csv", db)
    uploadTerrorWeaponData("../data/frames/terrorWeapon.csv", db)
    uploadWeatherData("../data/frames/weather.csv", db)

    endTime = time.time()
    elapsedTime = endTime - startTime
    print '[+] Finished data import in %.2f s'%elapsedTime

if __name__ == '__main__':
    main()
