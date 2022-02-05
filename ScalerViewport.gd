extends Viewport


func _ready():
	
	get_texture().flags = Texture.FLAG_FILTER
	get_parent().texture = get_texture()
