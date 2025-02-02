tool
class_name CollapsibleContainer
extends VBoxContainer

export var text := "" setget _set_text
export var visible_content := false setget _set_visible_content


func _ready() -> void:
	_set_visible($Button.pressed)
	for child in get_children():
		if not child is CanvasItem or child == $Button:
			continue
		child.connect("visibility_changed", self, "_child_visibility_changed", [child])


func _set_text(value: String) -> void:
	text = value
	$Button/Label.text = value


func _set_visible_content(value: bool) -> void:
	visible_content = value
	$Button.pressed = value


func _on_Button_toggled(button_pressed: bool) -> void:
	_set_visible(button_pressed)


func _set_visible(pressed: bool) -> void:
	if pressed:
		$Button/TextureRect.rect_rotation = 0
	else:
		$Button/TextureRect.rect_rotation = -90
	for child in get_children():
		if not child is CanvasItem or child == $Button:
			continue
		child.visible = pressed


# Checks if a child becomes visible from another sure and ensures
# it remains invisible if the button is not pressed
func _child_visibility_changed(child: CanvasItem) -> void:
	if not $Button.pressed:
		child.visible = false
