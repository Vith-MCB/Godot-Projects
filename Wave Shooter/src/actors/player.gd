extends Sprite

export var speed = 150

signal hit
var dead = false

var shot = preload("res://src/actors/shot.tscn")
var canShot = true


func _ready():
	Global.player = self
	
func _exit_tree():
	Global.player = null

#Function that gets the input from the player and return a vector
func playerInput() -> Vector2: 
	var _velocity: = Vector2.ZERO
	_velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	_velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
		
	return _velocity.normalized()

#Moving player
func _process(delta):
	var newVelocity:= playerInput()
	if newVelocity.length() > 0: #Player is walking
		newVelocity = newVelocity * speed
	
	if dead == false:
		position += newVelocity * delta #Moving the player 
	
	#Limits of player moviment
	position.x = clamp(position.x, 24, 616)
	position.y = clamp(position.y, 24, 336)

	
	#Shooting
	if Input.is_action_pressed("shoot") and Global.createParentNode != null and canShot and dead == false:
		Global.instanceNode(shot, global_position, Global.createParentNode)
		canShot = false
		$shotCoolDown.start()


func _on_shotCoolDown_timeout():
	canShot = true

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		visible = false
		dead = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
