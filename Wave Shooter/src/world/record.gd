extends Label


func _ready():
	text = String(Global.record)

func _process(delta):
	if Global.points > Global.record:
		Global.record = Global.points
