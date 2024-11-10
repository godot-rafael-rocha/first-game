extends CanvasLayer

@onready var mobile_gamepad: Node2D = $mobile_gamepad

func _ready():
	mobile_gamepad.visible = isMobile()

func isMobile() -> bool:
	var osName = OS.get_name()
	
	return osName == "Android" || osName == "iOS" || OS.has_feature("web_android") or OS.has_feature("web_ios")
