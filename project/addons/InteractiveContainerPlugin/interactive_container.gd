extends MarginContainer
class_name InteractiveContainer

var lastInputEventMouseButton: InputEventMouseButton
var lastInputEventMouseMotion: InputEventMouseMotion
var inputEventScreenTouchDictionary = {}
var inputEventScreenDragDictionary = {}

signal is_pressed_state_change(value: bool)
signal pressed_position_change(value: bool)

func _input(event: InputEvent) -> void:
	_handleEvent(event)

func is_hovering(position: Vector2):
	var isInsideX = position.x >= global_position.x && position.x <= global_position.x + size.x
	var isInsideY = position.y >= global_position.y && position.y <= global_position.y + size.y
	return isInsideX && isInsideY

func _handleEvent(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed() && is_hovering(event.position):
			lastInputEventMouseButton = event
		elif !event.is_pressed() && lastInputEventMouseButton && "is_pressed" in lastInputEventMouseButton && lastInputEventMouseButton.is_pressed():
			lastInputEventMouseButton = event
	elif event is InputEventScreenTouch:
		if event.is_pressed() && is_hovering(event.position):
			inputEventScreenTouchDictionary[event.index] = event
		elif !event.is_pressed():
			inputEventScreenTouchDictionary.erase(event.index)
			inputEventScreenDragDictionary.erase(event.index)
			
	_updatePressedState()
	
	if is_pressed():
		var isMousePressed = lastInputEventMouseButton && "is_pressed" in lastInputEventMouseButton && lastInputEventMouseButton.is_pressed()
		if isMousePressed && event is InputEventMouseMotion:
			lastInputEventMouseMotion = event
		elif !isMousePressed && event is InputEventScreenDrag:
			if inputEventScreenTouchDictionary.has(event.index):
				inputEventScreenDragDictionary[event.index] = event
			else:
				inputEventScreenDragDictionary.erase(event.index)
		
		if event is InputEventScreenTouch || event is InputEventMouseButton || event is InputEventMouseMotion || event is InputEventScreenDrag:
			_update_pressing_position()
	else:
		inputEventScreenDragDictionary.clear()
		inputEventScreenTouchDictionary.clear()

var _is_pressed_state = false
func _updatePressedState() -> void:
	var isMousePressed = lastInputEventMouseButton && lastInputEventMouseButton.is_pressed()
	var newPressedValue = isMousePressed || inputEventScreenTouchDictionary.size() > 0
	
	if _is_pressed_state != newPressedValue:
		print('is_pressed_state_change from: ', _is_pressed_state, " to: ", newPressedValue)
		_is_pressed_state = newPressedValue
		emit_signal("is_pressed_state_change", _is_pressed_state)

func is_pressed() -> bool:
	return _is_pressed_state

var _pressing_position: Vector2

func _update_pressing_position() -> void:
	var new_pressing_position_value: Vector2

	if is_pressed():
		var isMousePressed = lastInputEventMouseButton && lastInputEventMouseButton.is_pressed()
		if isMousePressed:
			new_pressing_position_value = get_global_mouse_position()
		else:
			var getLowestIndexPosition = func(dictionary: Dictionary) -> bool:
				if dictionary.size() > 0:
					var lowestIndex: int
					
					for index in dictionary.keys():
						var isIndexInt = typeof(index) == TYPE_INT
						var isLowestIndexInt = typeof(lowestIndex) == TYPE_INT
						if isIndexInt && isLowestIndexInt && index < lowestIndex:
							lowestIndex = index
					
					var event = dictionary.get(lowestIndex)
					
					if event && "position" in event:
						new_pressing_position_value = event.position
						return true
				return false
			
			getLowestIndexPosition.call(inputEventScreenDragDictionary) || getLowestIndexPosition.call(inputEventScreenTouchDictionary)
	
	if new_pressing_position_value && new_pressing_position_value != _pressing_position:
		print('pressed_position_change from: ', _pressing_position, " to: ", new_pressing_position_value)
		_pressing_position = new_pressing_position_value
		emit_signal("pressed_position_change", _pressing_position)