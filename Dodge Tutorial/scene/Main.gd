extends Node

export (PackedScene) var Enemy 
var score

func _ready():
	randomize()
	
func gameOver():
	$music.stop()
	$deadSound.set_volume_db(-5)
	$deadSound.play()
	$pointsTimer.stop()
	$spawnTimer.stop()
	$HUD.gameOver()
	
func newGame():
	score = 0
	$Player.startPosition($initPosition.position)
	$initTimer.start()
	$HUD.showMessage("Be prepaired")
	$HUD.scoreAtt(score)
	$music.set_volume_db(-15)
	$music.play()

#Initialize game
func _on_initTimer_timeout():
	$spawnTimer.start()
	$pointsTimer.start()

#Point system
func _on_pointsTimer_timeout():
	score += 1
	$HUD.scoreAtt(score)

#Spawner system
func _on_spawnTimer_timeout():
	$enemyPath/spawnEnemy.offset = randi()
	var _enemy = Enemy.instance()
	add_child(_enemy)
	
	var direction = $enemyPath/spawnEnemy.rotation+ PI/2
	_enemy.position = $enemyPath/spawnEnemy.position
	direction += rand_range(-PI/4, PI/4)
	
	_enemy.rotation = direction
	_enemy.linear_velocity = Vector2(rand_range(_enemy.minSpeed,_enemy.maxSpeed),0.0)
	_enemy.linear_velocity = _enemy.linear_velocity.rotated(direction)
