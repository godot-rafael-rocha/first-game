extends Area2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	self.body_entered.connect(handle_body_entered)
	timer.timeout.connect(handle_timeout)

func handle_body_entered(body: Node2D) -> void:
	var collisionShape2DBody = body.get_node("CollisionShape2D")
	if collisionShape2DBody:
		print("You died!")
		Engine.time_scale = 0.3
		collisionShape2DBody.queue_free()
		timer.start()


func handle_timeout() -> void:
	print("_on_timer_timeout")
	Engine.time_scale = 1
	get_tree().reload_current_scene()
