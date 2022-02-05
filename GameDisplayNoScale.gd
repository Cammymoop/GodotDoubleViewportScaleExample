extends Viewport


func _ready():
	get_parent().texture = get_texture()
