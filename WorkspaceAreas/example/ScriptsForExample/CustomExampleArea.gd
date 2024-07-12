extends WorkspaceArea
class_name CustomWorkspaceAreaExample

@onready var textureRect = %TextureRect

var checkboxButton : CheckBox
var modulateButton : ColorPickerButton

func _ready()->void:
	setupWorkspaceArea()
	checkboxButton = CheckBox.new()
	checkboxButton.button_pressed = true
	checkboxButton.toggled.connect(toggleVisibility)
	areaOptionsContainer.add_child(checkboxButton)
	
	modulateButton = ColorPickerButton.new()
	modulateButton.custom_minimum_size.x = 20
	modulateButton.color = Color.WHITE
	modulateButton.color_changed.connect(changeTextureColor)
	areaOptionsContainer.add_child(modulateButton)
	modulateButton.size_flags_horizontal = Control.SIZE_EXPAND

func changeTextureColor(newColor : Color)->void:
	textureRect.self_modulate = newColor

func toggleVisibility(state : bool)->void:
	textureRect.visible = state

func _mouse_entered()->void:
	CurrentMouseHoverArea = self
	if debugCurrentHoverArea:
		modulate = Color.MAGENTA

func _mouse_exited()->void:
	CurrentMouseHoverArea = null
	if debugCurrentHoverArea:
		modulate = Color.WHITE
