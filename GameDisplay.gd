extends Viewport


func _ready():
	set_size_override(true, Vector2(240, 240))
	set_size_override_stretch(true)
	
	get_texture().flags = Texture.FLAG_FILTER
	get_parent().texture = get_texture()
