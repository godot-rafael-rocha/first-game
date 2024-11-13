extends TouchScreenButton
class_name TouchScreenButtonOverwrite

var _debug = false
var pointerDictionary = {}
var lastInputEvent: InputEvent
enum pointerDictionaryPropertiesName {
	pointerPosition,
	fingerIndex
}
signal pointer_position_changed(event: InputEvent)

func _ready() -> void:
	self.pressed.connect(func (): _update_pointer_position(true))
	self.released.connect(func (): _update_pointer_position(false))
	if _debug:
		self.pointer_position_changed.connect(func (event): print("pointer_position_changed: ", event))
		self.pressed.connect(func (): print("pressed"))
		self.released.connect(func (): print("released"))

func _update_pointer_position(is_pressed_arg: bool):
	var event = lastInputEvent
	var lastPointerPosition = pointerDictionary.get(pointerDictionaryPropertiesName.pointerPosition);
	var lastfingerIndex = pointerDictionary.get(pointerDictionaryPropertiesName.fingerIndex);
	var newpointerPosition: Vector2
	var newfingerIndex: int
	
	if is_pressed_arg:
		if event is InputEventMouseMotion || event is InputEventMouseButton:
			newpointerPosition = event.position
		elif !lastPointerPosition && event is InputEventScreenTouch:
			newfingerIndex = event.index
			newpointerPosition = event.position
		elif lastPointerPosition && event is InputEventScreenDrag:
			if !lastfingerIndex || lastfingerIndex == event.index:
				newfingerIndex = event.index
				newpointerPosition = event.position
			
	else:
		pointerDictionary.clear()
		
	if is_pressed_arg && newpointerPosition && newpointerPosition != lastPointerPosition:
		pointerDictionary[pointerDictionaryPropertiesName.pointerPosition] = newpointerPosition
		pointerDictionary[pointerDictionaryPropertiesName.fingerIndex] = newfingerIndex
		emit_signal("pointer_position_changed", event)

func _input(event: InputEvent) -> void:
	lastInputEvent = event
	_update_pointer_position(is_pressed())

func get_pointer_position() -> Vector2:
	var result = pointerDictionary.get(pointerDictionaryPropertiesName.pointerPosition)
	
	if result is Vector2:
		return result
	return Vector2.ZERO
