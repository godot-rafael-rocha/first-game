extends Sprite2D

@onready var parent: Node2D = $".."

var pressing = false

enum moveActionEnum {
	LEFT,
	RIGHT,
	IDLE
}

const moveActionValues = [
	"move_left",
	"move_right",
	null
]

@export var maxLength = 9
@export var deadzone = 5
var lastAction: moveActionEnum = moveActionEnum.IDLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxLength *= parent.scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var newAction: moveActionEnum = moveActionEnum.IDLE
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle) * maxLength
			global_position.y = parent.global_position.y + sin(angle) * maxLength
		calculateVector()
		if parent.posVector.x > 0:
			newAction = moveActionEnum.RIGHT
		elif parent.posVector.x < 0:
			newAction = moveActionEnum.LEFT 
	else:
		global_position = lerp(global_position, parent.global_position, delta * 50)
		parent.posVector = Vector2(0, 0)
		
	InputAction(newAction)

func InputAction(newAction: moveActionEnum):
	if newAction != lastAction:
		if moveActionValues[lastAction] && Input.is_action_pressed(moveActionValues[lastAction]):
			print("action_release: ", moveActionValues[lastAction])
			Input.action_release(moveActionValues[lastAction])
		if moveActionValues[newAction] && !Input.is_action_pressed(moveActionValues[newAction]):
			print("action_press: ", moveActionValues[newAction])
			Input.action_press(moveActionValues[newAction])
		lastAction = newAction


func calculateVector():
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x)/maxLength
	if abs((global_position.y - parent.global_position.y)) >= deadzone:
		parent.posVector.y = (global_position.y - parent.global_position.x)/maxLength

func _on_button_button_down() -> void:
	print("Button Down!")
	pressing = true


func _on_button_button_up() -> void:
	print("Button UP!")
	pressing = false
