extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var _is_double_jump_used = false

func _physics_process(delta: float) -> void:
	# Variables
	var isJumpStarting = false
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			isJumpStarting = true
		elif !_is_double_jump_used:
			isJumpStarting = true
			_is_double_jump_used = true
	
	if is_on_floor():
		_is_double_jump_used = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if isJumpStarting:
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction != 0:
		animated_sprite.flip_h = direction < 0
	
	# Play animation
	if isJumpStarting:
		animated_sprite.play("jump")
	else:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
