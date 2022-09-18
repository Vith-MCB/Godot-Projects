extends Camera2D

var shake = 0
var initShake = false

func _process(delta):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	if initShake:
		global_position += Vector2(rand_range(-shake,shake), rand_range(-shake,shake)) * delta

func screenShake(intensity, time):
	zoom = Vector2(1,1) - Vector2(intensity*0.002, intensity*0.002)
	shake = intensity
	$cameraTimer.wait_time = time
	$cameraTimer.start()
	initShake = true
	
func _ready():
	Global.camera = self
	
func _exit_tree():
	Global.camera = null

func _on_cameraTimer_timeout():
	initShake = false
