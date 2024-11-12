extends TouchScreenButton
class_name TouchScreenButtonOverwrite

var _debug = false
var pointerDictionary = {}
enum pointerDictionaryPropertiesName {
	pointerPosition,
	fingerIndex
}
signal pointer_position_changed(event: InputEvent)

func _ready() -> void:
	if _debug:
		self.pointer_position_changed.connect(func (event): print("pointer_position_changed: ", event))
		self.pressed.connect(func (): print("pressed"))
		self.released.connect(func (): print("released"))

func _update_pointer_position(event: InputEvent):
	var lastPointerPosition = pointerDictionary.get(pointerDictionaryPropertiesName.pointerPosition);
	var lastfingerIndex = pointerDictionary.get(pointerDictionaryPropertiesName.fingerIndex);
	var newpointerPosition: Vector2
	var newfingerIndex: int
	if is_pressed():
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
		
	if is_pressed() && newpointerPosition && newpointerPosition != lastPointerPosition:
		pointerDictionary[pointerDictionaryPropertiesName.pointerPosition] = newpointerPosition
		pointerDictionary[pointerDictionaryPropertiesName.fingerIndex] = newfingerIndex
		emit_signal("pointer_position_changed", event)

func _input(event: InputEvent) -> void:
	_update_pointer_position(event)

func get_pointer_position() -> Vector2:
	var result = pointerDictionary.get(pointerDictionaryPropertiesName.pointerPosition)
	
	if result is Vector2:
		return result
	return Vector2.ZERO
