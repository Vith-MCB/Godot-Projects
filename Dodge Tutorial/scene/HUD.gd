extends CanvasLayer

signal startGame

func showMessage(text):
	$messageLabel.text = text
	$messageLabel.show()
	$messageTimer.start()
	
func gameOver():
	showMessage("Game Over!")
	yield($messageTimer, "timeout")
	
	$messageLabel.text = "Dodge and survive the monsters attack"
	$messageLabel.show()

	yield(get_tree().create_timer(1), "timeout")
	$startButton.show()
	
func scoreAtt(score):
	$scoreLabel.text = str(score)

func _on_startButton_pressed():
	$startButton.hide()
	emit_signal("startGame")

func _on_messageTimer_timeout():
	$messageLabel.hide()
