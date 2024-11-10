extends Node2D

#func _on_button_button_down() -> void:
	#Input.action_press("jump")
#
#
#func _on_button_button_up() -> void:
	#Input.action_release("jump")

func _on_touch_screen_button_pressed() -> void:
	Input.action_press("jump")


func _on_touch_screen_button_released() -> void:
	Input.action_release("jump")
