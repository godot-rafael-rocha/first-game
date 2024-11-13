extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ui: CanvasLayer = $"../../../UI"

func _on_body_entered(_body: Node2D) -> void:
	ui.add_point()
	animation_player.play("pickup")
