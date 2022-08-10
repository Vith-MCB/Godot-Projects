extends Sprite

export var speed = 150

signal hit

var shot = preload("res://src/actors/shot.tscn")
var canShot = true

var screenSize

func _ready():
	screenSize = get_viewport_rect().size
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
		
	position += newVelocity * delta #Moving the player 
	
	#Limits of player moviment
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)

	
	#Shooting
	if Input.is_action_pressed("shoot") and Global.createParentNode != null and canShot:
		Global.instanceNode(shot, global_position, Global.createParentNode)
		canShot = false
		$shotCoolDown.start()


func _on_shotCoolDown_timeout():
	canShot = true
