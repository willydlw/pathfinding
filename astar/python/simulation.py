""" A* search algorithm

https://en.wikipedia.org/wiki/A*_search_algorithm

https://www.geeksforgeeks.org/a-search-algorithm/


"""

import matplotlib.pyplot as plt 

class Point(object):
	''' Define a point at x, y'''
	def __init__(self, x=0, y=0):
		self.x = x
		self.y = y

	def display(self):
		print('x: ' + str(self.x) + ", y: " + str(self.y))

def main():
	print(__file__ + " A* Simulation")

	# start and goal position
	start = Point(3, 10)
	goal = Point(15, 15)

	# scale the map
	gridSize = 1.0		# meters
	robotSize = 1.0		# meters

	gridRows = 20
	gridCols = 20

	# create an empty list to store obstacles
	obstacle = []

	# fill map boundaries with obstacles

	#fill left boundary
	for i in range(gridRows):
		obstacle.append(Point(i,0))

    # fill right boundary
	for i in range(gridRows):
		obstacle.append(Point(gridRows-1, i))

	# fill top row
	for i in range(gridCols):
		obstacle.append(Point(0, i))

	# fill bottom row
	for i in range(gridCols):
		obstacle.append(Point(i, gridCols-1))

	# create a vertical line of obstacles
	for i in range(int(gridCols*2/3)):
		obstacle.append(Point(int(gridRows*2/3),i))

	for i in range(int(gridCols*2/3)):
		obstacle.append(Point(int(gridRows*1/3), int(gridRows-1-i)))




	#for point in obstacle:
	#	point.display()


	xvalues = [px.x for px in obstacle]
	yvalues = [py.y for py in obstacle]

	plt.plot(xvalues, yvalues, ".k")
	plt.plot(goal.x, goal.y, "xb")
	plt.plot(start.x, start.y, "xr")
	plt.grid(True)
	#plt.axis("equal")
	plt.show()



	

if __name__ == '__main__':
	main()