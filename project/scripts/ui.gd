extends CanvasLayer

@onready var mobile_gamepad: Node2D = $mobile_gamepad
@onready var score_label: Label = $ScoreLabel
var score = 0

@onready var joystick: Node2D = $mobile_gamepad/joystick
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
func _ready():
	mobile_gamepad.visible = _isMobile()
	
	joystick.connect("pressed", func(): label.text = "Pressed: true")
	joystick.connect("released", func(): label.text = "Pressed: false")
	joystick.connect("pointer_position_changed", func(event):
		var thisPosition = ""
		if "position" in event:
			thisPosition = str(event.position)
		label_2.text = "Pointer Position: " + thisPosition
	)

func _isMobile() -> bool:
	return true
	var osName = OS.get_name()
	
	return osName == "Android" || osName == "iOS" || OS.has_feature("web_android") or OS.has_feature("web_ios")

func add_point():
	score += 1
	print("+1 coin!. Score is: ", score)
	score_label.text = "Score: " + str(score)
