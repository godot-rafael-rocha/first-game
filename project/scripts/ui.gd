extends CanvasLayer

@onready var mobile_gamepad: Node2D = $mobile_gamepad
@onready var score_label: Label = $ScoreLabel
@onready var game_menu: Node2D = $GameMenu
#@onready var game_play_scenes: Node2D = $"../GamePlayScenes"
var score = 0
var _debug = false
var _show_game_menu = false

@onready var joystick: Node2D = $mobile_gamepad/joystick
@onready var label: Label = $Debug/Label
@onready var label_2: Label = $Debug/Label2
@onready var debug_node: Node2D = $Debug

signal pause_menu_visible_state_changed(visible: bool)

func _ready():
	mobile_gamepad.visible = _isMobile()
	game_menu.visible = _show_game_menu
	
	debug_node.visible = _debug
	if (_debug):
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

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("game_menu"):
		_show_game_menu = !_show_game_menu
		
		mobile_gamepad.visible = !_show_game_menu
		score_label.visible = !_show_game_menu
		game_menu.visible = _show_game_menu
		pause_menu_visible_state_changed.emit(_show_game_menu)
		get_tree().paused = _show_game_menu
