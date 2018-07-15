""" A* search algorithm

https://en.wikipedia.org/wiki/A*_search_algorithm

https://www.geeksforgeeks.org/a-search-algorithm/

http://theory.stanford.edu/~amitp/GameProgramming/AStarComparison.html 


"""

import matplotlib.pyplot as plt 

class Point(object):
	''' Define a point at x, y'''
	def __init__(self, x=0, y=0):
		self.x = x
		self.y = y

	def __str__(self):
		return 'x: ' + str(self.x) + ", y: " + str(self.y)


class Node(object):

	def __init__(self, x, y, cost):
		self.x = x
		self.y = y
		self.cost = cost 
		self.parentIndex = -1

	def __str__(self):
		''' node object string representation'''
		return str(self.x) + ", " + str(self.y) + ", " + str(self.cost)


def generateObstacles(obstacle, gridRows, gridCols):

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


def astar(start, goal):
	''' A* algorithm '''
	openset, closedSet = dict(), dict()

	startNode = Node(start.x, start.y, 0)

	openset[0] = startNode
	




def main():
	print(__file__ + " A* Simulation")

	

	# scale the map
	gridSize = 1.0		# meters
	robotSize = 1.0		# meters

	gridRows = 20
	gridCols = 20

	# start and goal position
	start = Point(3, 12)
	goal = Point(15, 5)

	# create an empty list to store obstacles
	obstacle = []
	generateObstacles(obstacle, gridRows, gridCols)


	#for point in obstacle:
	#	print(point)


	xvalues = [px.x for px in obstacle]
	yvalues = [py.y for py in obstacle]

	plt.plot(xvalues, yvalues, ".k")
	plt.plot(goal.x, goal.y, "xb")
	plt.plot(start.x, start.y, "xr")
	plt.grid(True)
	plt.show()


	astar(start, goal)



	

if __name__ == '__main__':
	main()