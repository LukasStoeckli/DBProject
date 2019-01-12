import mysql.connector
import matplotlib.pyplot as plt

pi = 3.14159265359

"""
returns the table for the query
"""


def getTable(query):
	data = []
	cursor.execute(query)
	for row in cursor:
		data.append(tuple(row))
	data = map(list, zip(*data))

	return data


"""
return two lists with the number of events (first list) for each type (second list)
"""


def getLists(query):
	table = getTable(query)

	number_of_events = table[0]
	types = table[1]

	return [number_of_events, types]


"""
exports a stardiagram plot as pdf with the types according to their occurrences, contained in number_of_events
"""


def plot(number_of_events, types, label, relation):
	title = ""

	if "Rain" in relation:
		if "Weapon" in relation:
			title = "Used weapons at " + label + " mm of rain per day"
		elif "Attack" in relation:
			title = "Attack types at " + label + " mm of rain per day"
		elif "Target" in relation:
			title = "Target group at " + label + " mm of rain per day"
		else:
			exit(1)
	elif "Temp" in relation:
		if "Weapon" in relation:
			title = "Used weapons at " + label + " $^\circ$C mean temperature of day"

			if label == "< -10.0":
				types.insert(0, "Arson/Fire")
				number_of_events.insert(0, 0)

		elif "Attack" in relation:
			title = "Attack types at " + label + " $^\circ$C mean temperature of day"
		elif "Target" in relation:
			title = "Target group at " + label + " $^\circ$C mean temperature of day"
		else:
			exit(1)

	N = len(types)

	x_as = [n / float(N) * 2 * pi for n in range(N)]

	# Because our chart will be circular we need to append a copy of the first
	# value of each list at the end of each list with data

	number_of_events.append(number_of_events[0])
	x_as += x_as[:1]

	# Set color of axes
	plt.rc('axes', linewidth=0.5, edgecolor="#888888")

	# Create polar plot
	ax = plt.subplot(111, polar=True)

	# Set clockwise rotation. That is:
	ax.set_theta_offset(pi / 2)
	ax.set_theta_direction(-1)

	# Set position of y-labels
	ax.set_rlabel_position(30)

	# Set color and linestyle of grid
	ax.xaxis.grid(True, color="#888888", linestyle='solid', linewidth=0.5)
	ax.yaxis.grid(True, color="#888888", linestyle='solid', linewidth=0.5)

	# Set number of radial axes and remove labels
	plt.xticks(x_as[:-1], [])

	# Set axes limits
	limit = max(number_of_events)
	plt.ylim(0, limit)

	# Set yticks
	ticks = [limit / 5, 2 * limit / 5, 3 * limit / 5, 4 * limit / 5, limit]
	plt.yticks(ticks, ticks)

	# Plot data
	ax.plot(x_as, number_of_events, linewidth=0, linestyle='solid', zorder=3)

	# Fill area
	ax.fill(x_as, number_of_events, 'b', alpha=0.3)

	plt.title(title)

	plt.tight_layout()

	# Draw ytick labels to make sure they fit properly
	for i in range(N):
		angle_rad = i / float(N) * 2 * pi

		if angle_rad == 0:
			ha, distance_ax = "center", 1
		elif 0 < angle_rad < pi:
			ha, distance_ax = "left", 1
		elif angle_rad == pi:
			ha, distance_ax = "center", 1
		else:
			ha, distance_ax = "right", 1

		ax.text(angle_rad, limit / 20 + limit + distance_ax, types[i], size=8,
		        horizontalalignment=ha, verticalalignment="center")

	plt.savefig("../Output/" + relation + "/" + ("rain" if "Rain" in relation else "temp") + str.strip(
		str.replace(label, ".", "")) + "_starDiagram", format="pdf",
	            bbox_inches='tight')

	plt.clf()


"""
finames: ranges which are used in the filename and title
relation: same name as folders with format Weather-Type (e.g. Rain-Weapon)
"""


def executeQueries(fignames, relation):
	print(relation)
	queries = open("Queries/" + relation + ".txt")
	fignames.reverse()

	for query in queries:
		if query == "":
			continue

		[number_of_events, types] = getLists(query)

		for i in range(len(types)):
			if types[i] == "":
				types[i] = "Unknown"

		label = fignames.pop()

		plot(number_of_events, types, label, relation)


if __name__ == '__main__':
	try:
		# db setup
		db = mysql.connector.connect(
			user='dbProject',
			password='db2018',
			host='192.168.178.35',
			# host="n1yd5rann1iy3jwo.myfritz.net",
			database='dbProject')

	except Exception, e:
		print('[-] failed to connect to db')
		print(str(e))

	cursor = db.cursor()

	# fignames_rain = ["0.1-1", "1.1-5", "5.1-20", ">20.1", "0"]
	# fignames_temp = ["< -10.0", "-10.1 - 0", "1 - 10.0", "10.1 - 20.0", "20.1 - 30.0", "> 30.1"]
	#
	# executeQueries(fignames_temp, "Temp-Attack")
	# executeQueries(fignames_rain, "Rain-Attack")

	# fignames_rain = ["0.1-1", "1.1-5", "5.1-20", ">20.1", "0"]
	# fignames_temp = ["< -10.0", "-10.1 - 0", "1 - 10.0", "10.1 - 20.0", "20.1 - 30.0", "> 30.1"]
	#
	# executeQueries(fignames_temp, "Temp-Weapon")
	# executeQueries(fignames_rain, "Rain-Weapon")

	fignames_rain = ["0.1-1", "1.1-5", "5.1-20", ">20.1", "0"]
	fignames_temp = ["< -10.0", "-10.1 - 0", "1 - 10.0", "10.1 - 20.0", "20.1 - 30.0", "> 30.1"]

	executeQueries(fignames_temp, "Temp-Target")
	executeQueries(fignames_rain, "Rain-Target")



