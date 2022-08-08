extends actor

export var stompImpulse = 1000.0

func _on_EnemyDetector_area_entered(area):
	velocity = calculateStompVelocity(velocity, stompImpulse)
	
func _on_EnemyDetector_body_entered(body):
	queue_free()

func _physics_process(delta: float)-> void:
	
	#var used to check if the player released the jump key
	var isJumpInterrupted: = Input.is_action_just_released("jump") and velocity.y < 0
	
	var dir:= getDirection() #direction of the moviment (defined by user's input)
	
	#calculating the movimet depending on the direction
	velocity = calculateMoveVelocity(velocity, dir, speed, isJumpInterrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL) #adds the floor normal (Vector2.UP)

func getDirection() -> Vector2:
	#The move variable gets the input from user
	var move:= Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	var pJump:= -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	return Vector2(move, pJump) #Set the direction of the movement

#function used to calculate the velocity
func calculateMoveVelocity(
	linearVelocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	jumpInterrupted: bool
	) -> Vector2: 
	var newVelocity = linearVelocity
	newVelocity.x = speed.x * direction.x #calculating the horizontal speed
		
	newVelocity.y += gravity * get_physics_process_delta_time() # Here, the gravity is added to velocity y axis
		
	if direction.y == -1.0: #Checks the jump input
		newVelocity.y = speed.y * direction.y #If jump input is true, it makes the player actually jump
		
	if jumpInterrupted : #Checks if the player still holding the jump button
		newVelocity.y = 0.0 #If the button is released, the jump action stops
	return newVelocity

func calculateStompVelocity(linearVelocity: Vector2, impulse:float) -> Vector2:
	var out: = linearVelocity
	out.y = -impulse
	return out
	
