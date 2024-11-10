extends Node2D

func _on_button_button_down() -> void:
	Input.action_press("jump")


func _on_button_button_up() -> void:
	Input.action_release("jump")
