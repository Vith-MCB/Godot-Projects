extends "res://src/actors/actor.gd"

#function used to determine the start direction
func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x;

#Function used to see if player stomped the enemy
func _on_StompDetector_body_entered(body):
	if (body.global_position.y > get_node("StompDetector").global_position.y):
		return
	#get_node("StompDetector").get_node("CollisionShape2D") (The "$" work as)
	$CollisionShape2D.disabled = true
	queue_free()

#Function used to move the enemy
func _physics_process(delta:float) -> void:
	velocity.y = gravity * delta #Simple gravity
	if is_on_wall(): #Checks if enemy collides with the wall
		velocity *= -1
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
