extends RigidBody2D

export var minSpeed: = 150.0
export var maxSpeed: = 300.0

func _ready():
	#Generating random enemies
	var enemyType = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = enemyType[randi() % enemyType.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
