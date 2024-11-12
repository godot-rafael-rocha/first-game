extends CanvasLayer

@onready var mobile_gamepad: Node2D = $mobile_gamepad
@onready var score_label: Label = $ScoreLabel
var score = 0

func _ready():
	mobile_gamepad.visible = _isMobile()

func _isMobile() -> bool:
	#return true
	var osName = OS.get_name()
	
	return osName == "Android" || osName == "iOS" || OS.has_feature("web_android") or OS.has_feature("web_ios")

func add_point():
	score += 1
	print("+1 coin!. Score is: ", score)
	score_label.text = "Score: " + str(score)
