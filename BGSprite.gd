extends Sprite

func _ready():
	if SceneSwitcher.hide:
		visible = false
