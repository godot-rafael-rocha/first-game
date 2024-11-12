@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("TouchScreenButtonOverwrite", "TouchScreenButtonOverwrite", preload("touch_screen_button_overwrite.gd"), preload("res://icon.svg"))


func _exit_tree() -> void:
	remove_custom_type("TouchScreenButtonOverwrite")
