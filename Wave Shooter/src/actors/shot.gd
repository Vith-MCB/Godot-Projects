extends Sprite

var mov:=Vector2(1,0)
export var shotSpeed:= 250
var uniqueDirection = true

func _process(delta):
	if uniqueDirection:
		look_at(get_global_mouse_position())
		uniqueDirection = false
	
	global_position += mov.rotated(rotation) * shotSpeed * delta

#Destroy the shot if it is outside of the room
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

