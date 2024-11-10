extends CanvasLayer

@onready var mobile_gamepad: Node2D = $mobile_gamepad

func _ready():
	mobile_gamepad.visible = isMobile()

func isMobile() -> bool:
	var osName = OS.get_name()
	
	return osName == "Android" or osName == "iOS";
