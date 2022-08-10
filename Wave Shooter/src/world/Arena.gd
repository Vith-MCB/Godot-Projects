extends Node2D

#This part of the code is used to prevent bugs that happens if player isnt created yet
func _ready():
	Global.createParentNode = self
func _exit_tree():
	Global.createParentNode = null

