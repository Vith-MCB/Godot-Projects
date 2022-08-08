extends KinematicBody2D
class_name actor

const FLOOR_NORMAL:= Vector2.UP

#Setting the speed
export var speed:= Vector2(300.0,1000.0) #Set the maximum speed on the two axis

#Setting the gravity
export var gravity:= 3000.0

#By default, player movimet is set to zero
var velocity:= Vector2.ZERO
