# WorkspaceAreas
Godot 4 addon that allows making WorkspaceArea or Docks just like in blender in a fast and easy way
<br>**IMPORTANT**<br>
Currently this addon is in it's very rough stages, many features aren't implemented yet, or there are other issues with some functionalities.

<br>**How to install?**
<br>
Clone this repository or download zip file and extract it. And copy the folder "WorkspaceArea" from folder addons into your project's addons folder.<br>
Then in project settings in the plugins tab enable the addon.
Tbh I think most of Godot users won't even need this installation guide but whatever :p

<br>**How to use it?**
<br>
First you need to create AreaSplitContainer
Currently it's required to have it as a root of all WorkspaceAreas because you can't split them by draging it's corners.<br>
![obraz](https://github.com/user-attachments/assets/451f4f7a-86dd-48bb-8551-71282f0ec6e1)

There are two ways of creating your own WorkspaceAreas.
If you want just the very barebones functionality then you can create new WorkspaceArea node from the selector<br>
![obraz](https://github.com/user-attachments/assets/a96c7f95-2b85-46d2-aa94-347c4d64b019)

Add a control node as it's child and then to this control node you can add anything you want.
You can also need specify "Workspace Area Icon" in the inspector. This will be the icon that will be displayer in the top left corner of WorkspaceArea.<br>
![obraz](https://github.com/user-attachments/assets/29125015-79aa-4484-b39d-b31a8dfb2c81)<br>
![obraz](https://github.com/user-attachments/assets/7b7805d2-1cad-4a4e-a8a4-d12097b2097e)
<br>**Note**<br>
if your icon is too big or not sizing correctly try to use the built in example theme that is inside res://addons/WorkspaceArea/example/Themes
Currently WorkspaceArea does not support theme override options so you need to use a theme to prevent icon like default godot icon.svg from being too big.
You can now duplicate this WorkspaceArea so there will be two of them and change the "Split Offset" in the AreaSplitContainer's inspector to change the position of the line split.

**The second** and the more proper way of making custom WorkspaceAreas is by making custom class that inherits from WorkspaceArea.
In your custom script class you need to add method "SetupWorkspaceArea()" at the beggining of the _ready() function. This will initialize properly all the functionality of your custom area.

you also need to add two more funtions as following:
```
func _mouse_entered()->void:
	CurrentMouseHoverArea = self
	if debugCurrentHoverArea:
		modulate = Color.MAGENTA

func _mouse_exited()->void:
	CurrentMouseHoverArea = null
	if debugCurrentHoverArea:
		modulate = Color.WHITE
```
This tells addon over which WorkspaceArea is mouse currently hovering. It's usefull if Area B needs to check if mouse is hovering over any other WorkspaceArea of the same type, or any other functionalities might benefit from that.
There is also a bit of code that that runs when WorkspaceArea.debugCurrentHoverArea is set to true. It enables debug mode that changes the color of the currently hovering area. Useful to debug if area is actually registering the mouse entering function
It it's not the case experiment with mouse_filter of your control nodes inside your custom workspace.
And you can make a new scene that inherits from Control node and assign your custom script or directly create new scene with a root node as your custom class.
all of the other things apply exactly the same as in the first option of creating custom WorkspaceAreas.
BUT this second way isn't prefer because of it's obscurity, it's because you can add your own custom buttons and other control nodes to the options toolbar.<br>
![obraz](https://github.com/user-attachments/assets/1336a8d5-3b30-4a31-95c0-25585eb752ad)<br>
In the image we can see that CheckButton and ColorPickerButton were added to the toolbar.
You add those control nodes as any other control node. And you add_child() those control nodes into the WorkspaceArea.areaOptionsContainer
Here is small part of script that is available in the example folder res://addons/WorkspaceArea/example/ScriptsForExample/CustomExampleArea.gd
```
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
```

If you want to make your WorkspaceArea look more like those in Blender you can replace your WorkspaceAreas with Panel node instead of just a control node.<br>
![obraz](https://github.com/user-attachments/assets/a54ef0f1-aeec-4f4c-a07f-b9dd9ec227b9)<br>
Because WorkspaceArea inherits from Control node it means there is high chance that it will work on most of the Control nodes. and Panel node is not an exception
Then you can inside the theme editor or in theme overrides change corner radius to 10. And in WorkspaceArea's inspector in visibility/Clip_children you can enable it to "Clip + draw" so your control will be hidden by the rounded corners of the workspace.

You can always check the theme and example scene inside example folder to learn more.
