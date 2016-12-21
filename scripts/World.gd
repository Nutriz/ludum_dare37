extends Spatial

func _ready():
	set_process_input(true)
	
func _input(event):
	# Quit the game:
	if Input.is_action_pressed("quit"):
		var menuScene = preload("res://scenes/menu.tscn")
		var menu = menuScene.instance()
		get_tree().get_root().add_child(menu)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		queue_free()