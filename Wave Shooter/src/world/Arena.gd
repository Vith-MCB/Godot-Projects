extends Node2D


export(Array, PackedScene) var enemys

#This part of the code is used to prevent bugs that happens if player isnt created yet
func _ready():
	Global.createParentNode = self
	Global.points = 0
func _exit_tree():
	Global.createParentNode = null



func _on_enemySpawner_timeout():
	var enemyPos = Vector2(rand_range(-160,670), rand_range(-90, 390))
	
	while enemyPos.x < 640 and enemyPos.x > -80 and enemyPos.y < 360 and enemyPos.y > -45:
		enemyPos = Vector2(rand_range(-160,670), rand_range(-90, 390))
		
	var enemyNumber = round(rand_range(0,enemys.size()-1))
	Global.instanceNode(enemys[enemyNumber], enemyPos, self)
	
func _process(delta):
	$UI/Control/points.text = str(Global.points)


func _on_difficultyTimer_timeout():
	if $enemySpawner.wait_time > 0.5:
		$enemySpawner.wait_time -= 0.025
