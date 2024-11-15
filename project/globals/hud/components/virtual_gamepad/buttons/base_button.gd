extends Node2D

func _on_touch_screen_button_overwrite_pressed() -> void:
	Input.action_press("jump")


func _on_touch_screen_button_overwrite_released() -> void:
	Input.action_release("jump")
