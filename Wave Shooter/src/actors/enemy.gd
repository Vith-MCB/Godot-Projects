extends Sprite

var speed = 75
var moviment = Vector2.ZERO

var gotHit = false
var recoil = 5
var enemyHP = 3

func _process(delta):
	if Global.player != null and gotHit == false:
		moviment = global_position.direction_to(Global.player.global_position)
	elif gotHit:
		moviment = lerp(moviment, Vector2.ZERO, 0.3)
	
	global_position += moviment * delta * speed
	
	if enemyHP <= 0:
		queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("damage"):
		modulate = Color.white
		area.get_parent().queue_free()
		gotHit = true
		moviment = -moviment * recoil
		enemyHP -= 1
		$colorRestore.start()
		

func _on_colorRestore_timeout():
	modulate = Color("e06565")
	gotHit = false
