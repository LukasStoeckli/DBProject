import mysql.connector
import time
import numpy as np
import matplotlib.pyplot as plt

#---------------------------
# UTILS
#---------------------------
def getData(cursor, query):
    data = []
    cursor.execute(query)
    for row in cursor:
      data.append(tuple(row))
    data = np.array(data)
    return data

def plot2(a, b, title, xLabel, yLabel1, ylabel2, pdfName):
    try:
        plt.subplot()
        plt.plot(a[:,0], a[:,1], '.-')

        plt.title(title)
        plt.xlabel(xLabel)
        plt.ylabel(yLabel1, color='b')
        plt.tick_params('y', colors='b')

        plt.twinx()
        plt.plot(b[:,0], b[:,1], 'r.-')
        plt.ylabel(ylabel2, color='r')
        plt.tick_params('y', colors='r')

        plt.savefig(pdfName+".pdf")
        plt.show()
    except Exception, e:
        with open('error.log', 'a') as errorLog:
            errorLog.write("PLOT " + str(e) + '\n')




#---------------------------
# (2) ATTACKS VS POPULATION
#---------------------------
def attacksVsPopulation(cursor):
    try:

        query = "SELECT country FROM TerrorEvent WHERE country IN (SELECT country as origin FROM Population) GROUP BY country"
        countries = getData(cursor, query)

        for nation in countries:
            query = "SELECT year(eventDate) as year, COUNT(year(eventDate)) AS cnt FROM TerrorEvent WHERE LID IN (SELECT LID FROM TerrorLocation WHERE country = '%s') GROUP BY year(eventDate) ORDER BY year" % (nation[0])
            attackData = getData(cursor, query)

            query = "SELECT year, population FROM Population WHERE country = '%s'" %  (nation[0])
            populationData = getData(cursor, query)


            title = "Terror attacks vs population in %s" % (nation[0])
            xLabel = "year"
            yLabel1 = "terror attacks"
            ylabel2 = "population"
            pdfName = "attackVsPopulation{}".format(nation[0])
            plot2(attackData, populationData, title, xLabel, yLabel1, ylabel2, pdfName)


        print "[+] Attacks vs Population"
    except Exception, e:
        with open('error.log', 'a') as errorLog:
            errorLog.write("ATTACKPOPULATION " + str(e) + '\n')


#---------------------------
# (3) GENRE VS TERRORISM
#---------------------------
def genreVsTerrorism(cursor):
    try:
        query = "SELECT origin FROM MetalBand WHERE origin IN (SELECT country as origin FROM TerrorLocation) GROUP BY origin"
        countries = getData(cursor, query)

        genres = []
        attacks = []

        for nation in countries:
            query = "SELECT style FROM MetalStyle WHERE bandName IN (SELECT bandName FROM MetalBand WHERE origin = '%s') GROUP BY style ORDER BY COUNT(style) DESC LIMIT 5" % (nation[0])
            genre = getData(cursor, query)
            #genres.append(genre[0][0])

            query = "SELECT attackType FROM TerrorAttack WHERE EID IN (SELECT EID FROM TerrorEvent WHERE LID IN (SELECT LID FROM TerrorLocation WHERE country = '%s')) GROUP BY attackType ORDER BY COUNT(attackType) DESC LIMIT 5" % (nation[0])
            attack = getData(cursor, query)
            #attacks.append(attack[0][0])

            #query = "" % (nation[0])
            #target = getData(cursor, query)

            #query = "" % (nation[0])
            #weapon = getData(cursor, query)

            print "%s\n%s\n\n%s\n---" % (nation[0], genre, attack)

        #genreCount = [[x,genres.count(x)] for x in set(genres)]
        #genreCount = sorted(genreCount, key=lambda x: x[1], reverse=True)
        #print genreCount

        #attackCount = [[x,attacks.count(x)] for x in set(attacks)]
        #attackCount = sorted(attackCount, key=lambda x: x[1], reverse=True)
        #print attackCount

        print "[+] Genre vs Terrorism"
    except Exception, e:
        with open('error.log', 'a') as errorLog:
            errorLog.write("GENRETERRORISM " + str(e) + '\n')


#---------------------------
# (4) POPULATION VS BANDS
#---------------------------
def populationVsBands(cursor):
    try:

        query = "SELECT origin FROM MetalBand WHERE origin IN (SELECT country as origin FROM Population) GROUP BY origin"
        countries = getData(cursor, query)

        for nation in countries:
            query = "SELECT year, population FROM Population WHERE country = '%s'" %  (nation[0])
            populationData = getData(cursor, query)

            query = "SELECT formed AS year, COUNT(formed) AS cnt FROM MetalBand WHERE formed != 0 AND origin = '%s' GROUP BY formed ORDER BY formed" % (nation[0])
            formedData = getData(cursor, query)

            query = "SELECT split AS year, COUNT(split) AS cnt FROM MetalBand WHERE origin = '%s' GROUP BY split ORDER BY split" % (nation[0])
            splitData = getData(cursor, query)


            print "%s %s %s %s" % (nation[0], np.shape(formedData), np.shape(splitData), np.shape(populationData))


            # mean of formed and split
            bandData = []
            bands = 0
            for year in range(1964, 2017):
                if year in formedData[:,0]:
                    index = np.where(formedData[:,0] == year)
                    bands = bands + formedData[:,1].item(index)
                if year in splitData[:,0]:
                    index = np.where(splitData[:,0] == year)
                    bands = bands - splitData[:,1].item(index)
                bandData.append([year, bands])
            bandData = np.array(bandData)

            title = "Population vs metal bands in %s" % (nation[0])
            xLabel = "year"
            yLabel1 = "population"
            ylabel2 = "existing bands"
            pdfName = "populationVsBand{}".format(nation[0])
            plot2(populationData, bandData, title, xLabel, yLabel1, ylabel2, pdfName)


        print "[+] Population vs bands"
    except Exception, e:
        with open('error.log', 'a') as errorLog:
            errorLog.write("ATTACKBAND " + str(e) + '\n')


#---------------------------
# (5) ATTACKS VS BANDS
#---------------------------
def attacksVsBands(cursor):
    try:
        query = "SELECT year(eventDate) as year, COUNT(year(eventDate)) AS cnt FROM TerrorEvent GROUP BY year(eventDate) ORDER BY year"
        attackData = getData(cursor, query)

        query = "SELECT formed AS year, COUNT(formed) AS cnt FROM MetalBand WHERE formed != 0 GROUP BY formed ORDER BY formed"
        formedData = getData(cursor, query)

        query = "SELECT split AS year, COUNT(split) AS cnt FROM MetalBand WHERE split != 0 GROUP BY split ORDER BY split"
        splitData = getData(cursor, query)

        # mean of formed and split
        bandData = []
        bands = 0
        for year in range(1964, 2017):
            if year in formedData[:,0]:
                index = np.where(formedData[:,0] == year)
                bands = bands + formedData[:,1].item(index)
            if year in splitData[:,0]:
                index = np.where(splitData[:,0] == year)
                bands = bands - splitData[:,1].item(index)
            bandData.append([year, bands])
        bandData = np.array(bandData)

        xLabel = "year"
        ylabel2 = "terror attacks"

        title = "Terror attacks per year vs formed metal bands"
        yLabel1 = "formed bands"
        pdfName = "attacksVsBandsFormed"
        plot2(formedData, attackData, title, xLabel, yLabel1, ylabel2, pdfName)

        title = "Terror attacks per year vs split metal bands"
        yLabel1 = "split bands"
        pdfName = "attacksVsBandsSplit"
        plot2(splitData, attackData, title, xLabel, yLabel1, ylabel2, pdfName)

        title = "Terror attacks per year vs existing metal bands"
        yLabel1 = "existing bands"
        pdfName = "attacksVsBandsExisting"
        plot2(bandData, attackData, title, xLabel, yLabel1, ylabel2, pdfName)

        print "[+] Terror attacks per year vs metal bands" % (title)
    except Exception, e:
        with open('error.log', 'a') as errorLog:
            errorLog.write("ATTACKBAND " + str(e) + '\n')



#---------------------------
# GLOBAL TERRORISM MAP
#---------------------------
def getMapData(cursor):
    try:
        with open('mapData.js', 'w') as mapData:
            mapData.write("var events = [")
            for year in range(1970,2018):
                if year > 1970:
                    mapData.write(",\n")
                mapData.write("[")

                query = "SELECT DISTINCT latitude, longitude FROM TerrorLocation WHERE (latitude != 0 OR longitude !=0) AND LID IN (SELECT LID FROM TerrorEvent WHERE YEAR(eventDate) = %s)" % (year)
                locations = getData(cursor, query)

                counter = 0
                for location in locations:
                    if counter > 0:
                        mapData.write(",\n")
                    latitude = location[0]
                    longitude = location[1]

                    query = "SELECT COUNT(te.EID) as cnt, t.country, t.city, SUM(te.nkill), SUM(te.nwound) FROM TerrorEvent te, (SELECT LID, country, city FROM TerrorLocation WHERE latitude LIKE '%s' AND longitude LIKE '%s') t WHERE te.LID = t.LID" % (latitude, longitude)
                    eventData = getData(cursor, query)

                    events = eventData[0][0]
                    country = eventData[0][1]
                    city = eventData[0][2]
                    killed = eventData[0][3]
                    wounded = eventData[0][4]

                    point = "{\"name\": \"%s\", \"radius\": \"1\", \"attacks\": \"%s\", \"country\": \"%s\", \"killed\":\"%s\", \"wounded\":\"%s\", \"fillKey\": \"BUBBLE\", \"latitude\": \"%s\", \"longitude\": \"%s\"}" % (city, events, country, killed, wounded, latitude, longitude)
                    mapData.write(point)

                    counter = counter + 1

                    print "\033[1A\r%s / %s : %s" % (counter, np.shape(locations)[0], year)

                mapData.write("]\n")
            mapData.write("]\n")


        print "[+] Map data"
    except Exception, e:
        with open('error.log', 'a') as errorLog:
            errorLog.write("MAPDATA " + str(e) + '\n')

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


    #attacksVsPopulation(cursor) # done
    genreVsTerrorism(cursor)
    #populationVsBands(cursor) # done
    #attacksVsBands(cursor) # done


    #getMapData(cursor)





    endTime = time.time()
    elapsedTime = endTime - startTime
    print '[+] Finished data import in %.2f s'%elapsedTime

if __name__ == '__main__':
    main()
