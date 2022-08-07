extends "res://src/actors/actor.gd"

#function used to determine the start direction
func _ready() -> void:
	velocity.x = -speed.x;

#Function used to move the enemy
func _physics_process(delta:float) -> void:
	velocity.y = gravity * delta #Simple gravity
	if is_on_wall(): #Checks if enemy collides with the wall
		velocity *= -1
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
