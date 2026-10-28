extends Control
## Tela de fim (vitória ou derrota): Enter volta para a estação.


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/principal.tscn")
