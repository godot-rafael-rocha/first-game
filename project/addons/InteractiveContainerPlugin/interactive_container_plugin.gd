@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("InteractiveContainer", "InteractiveContainer", preload("interactive_container.gd"), preload("res://icon.svg"))


func _exit_tree() -> void:
	remove_custom_type("InteractiveContainer")
