extends Node2D

var posVector: Vector2
@onready var touch_screen_button_overwrite: TouchScreenButtonOverwrite = $TouchScreenButtonOverwrite

signal pointer_position_changed(event: InputEvent)
signal pressed()
signal released()

func _ready() -> void:
	touch_screen_button_overwrite.pointer_position_changed.connect(func(event): pointer_position_changed.emit(event))
	touch_screen_button_overwrite.pressed.connect(func(): pressed.emit())
	touch_screen_button_overwrite.released.connect(func(): released.emit())
