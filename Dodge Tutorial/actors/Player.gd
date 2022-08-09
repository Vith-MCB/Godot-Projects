extends Area2D

export var speed:= 400
var screenSize

signal hit

func _ready():
	hide()
	screenSize = get_viewport_rect().size
	

func _process(delta):
	var _velocity = Vector2.ZERO #Velocity vector
	
	#Getting the input from the player
	if Input.is_action_pressed("up"):
		_velocity.y -= 1
		
	if Input.is_action_pressed("down"):
		_velocity.y += 1
		
	if Input.is_action_pressed("left"):
		_velocity.x -= 1
		
	if Input.is_action_pressed("right"):
		_velocity.x += 1  
	
	if _velocity.length() > 0: #Player is walking
		_velocity = _velocity.normalized() * speed
		$AnimatedSprite.play()
		$trail.emitting = true
	else:
		$AnimatedSprite.stop()
		$trail.emitting = false
		
	if _velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_h = _velocity.x < 0
		
	if _velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = _velocity.y > 0
		
	position += _velocity * delta #Moving the player 
	
	#Limits of player moviment
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)

func startPosition(_position):
	show()
	position = _position
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled",true)
