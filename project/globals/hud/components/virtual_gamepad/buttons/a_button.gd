extends Node2D

#@export var actionName: String

#func _ready() -> void:
	#assert(InputMap.has_action(actionName), "Action Name is required to base_button")

func _on_touch_screen_button_overwrite_pressed() -> void:
	Input.action_press("jump")


func _on_touch_screen_button_overwrite_released() -> void:
	Input.action_release("jump")
