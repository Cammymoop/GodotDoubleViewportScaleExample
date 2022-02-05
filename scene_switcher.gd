extends Node

var cur_scene = "1ViewportB"

var scenes = {
	"1ViewportA": "res://1Viewport.tscn",
	"1ViewportB": "res://1Viewport.tscn",
	"1ViewportC": "res://1Viewport.tscn",
	"2Viewport": "res://2Viewport.tscn",
	"3Viewport": "res://3Viewport.tscn",
}

var filtered_tex = preload("res://kirby_n_friends_filtered.png")
var filtered = false
var hide = false

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	update_stretch_mode()
	update_label()

func switch_scene(reverse=false):
	match cur_scene:
		"1ViewportB":
			if reverse:
				filtered = not filtered
			cur_scene = "3Viewport" if reverse else "1ViewportC"
		"1ViewportC":
			cur_scene = "1ViewportB" if reverse else "2Viewport"
		"2Viewport":
			cur_scene = "1ViewportC" if reverse else "3Viewport"
		"3Viewport":
			if not reverse:
				filtered = not filtered
			cur_scene = "2Viewport" if reverse else "1ViewportB"
	
	
	update_stretch_mode()
	
	get_tree().change_scene(scenes[cur_scene])
	update_label()

func update_label() -> void:
	yield(get_tree(), "idle_frame")
	var scn = get_tree().get_current_scene()
	var label = scn.find_node("Label")
	
	if cur_scene == "1ViewportB":
		label.text += "\nStretch: 2D"
	elif cur_scene == "1ViewportC":
		label.text += "\nStretch: Viewport"
	
	if filtered:
		label.text += "\nFiltered Sprite"
		var sprite = scn.find_node("Sprite")
		sprite.texture = filtered_tex

func update_stretch_mode() -> void:
	var min_size = Vector2(240, 240)
	
	if cur_scene == "1ViewportB":
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, min_size)
	elif cur_scene == "1ViewportC":
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, min_size)
	elif cur_scene == "2Viewport":
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_IGNORE, min_size)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_KEEP, min_size)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		switch_scene()
	elif Input.is_action_just_pressed("ui_cancel"):
		switch_scene(true)
	
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
	
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
	
	if Input.is_action_just_pressed("hide"):
		hide = not hide
		get_tree().get_current_scene().find_node("BGSprite").visible = not hide
