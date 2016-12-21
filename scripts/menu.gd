extends Control

func _ready():
	pass

func _on_ButtonQuit_pressed():
	get_tree().quit()

func _on_ButtonPlay_pressed():
	var worldScene = preload("res://scenes/world.tscn")
	var world = worldScene.instance()
	get_tree().get_root().add_child(world)
	queue_free()

	