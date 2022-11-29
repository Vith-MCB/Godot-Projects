extends Node

var createParentNode = null

var player = null

var points = 0

var record = 0;

var camera = null

func instanceNode (node, location, parent):
	var nodeInst = node.instance() #instance the node to the variable
	parent.add_child(nodeInst) #Create a new node with the instanced variable
	nodeInst.global_position = location #Define the position acording to the parameter
	return	nodeInst
