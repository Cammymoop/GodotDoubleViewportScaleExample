extends Sprite

var spinning = false
var wobbling = false

var accumulative_time = 0

func _process(delta):
	if spinning:
		rotation += (PI/2) * delta
	elif wobbling:
		accumulative_time += delta
		position.x = 120 + sin(accumulative_time*PI)*9
	else:
		position.x = 120
		rotation = 0

func _on_SpinSwap_timeout():
	if wobbling:
		spinning = true
		wobbling = false
	elif spinning:
		spinning = false
	else:
		accumulative_time = 0
		wobbling = true
	
	if spinning or wobbling:
		$SpinSwap.wait_time = 4
	else:
		$SpinSwap.wait_time = 6
	$SpinSwap.start()
