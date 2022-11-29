extends Sprite

export(int) var speed = 75
var moviment = Vector2.ZERO

var gotHit = false

export(int) var recoil = 600
export(int) var enemyHP = 3

onready var actualCollor = modulate

var bloodParticle = preload("res://src/actors/enemyBlood.tscn")

func basicMove(delta):
	if Global.player != null and gotHit == false:
		moviment = global_position.direction_to(Global.player.global_position)
		global_position += moviment * delta * speed
	elif gotHit:
		moviment = lerp(moviment, Vector2.ZERO, 0.3)
		global_position += moviment * delta
	
	

func _process(delta):
	if enemyHP <= 0 and Global.createParentNode != null:
		if Global.camera != null:
			Global.camera.screenShake(50,0.1)
		Global.points += 10
		var bloodInstance = Global.instanceNode(bloodParticle, global_position, Global.createParentNode)
		bloodInstance.rotation = moviment.angle()
		bloodInstance.modulate = Color.from_hsv(actualCollor.h, 1,0.35)
		queue_free()
		
	
func _on_hitbox_area_entered(area):
	if area.is_in_group("damage") and gotHit == false:
		modulate = Color.white
		area.get_parent().queue_free()
		gotHit = true
		moviment = -moviment * recoil
		enemyHP -= 1
		$colorRestore.start()
		

func _on_colorRestore_timeout():
	modulate = actualCollor
	gotHit = false
