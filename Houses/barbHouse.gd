extends StaticBody2D

var mouseEntered = false
@onready var select = get_node("Selected")
var Selected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	select.visible = Selected
	pass

func _input(event):
	if event.is_action_pressed("LeftClick"):
		print(mouseEntered)
		if mouseEntered == true:
			Selected = !Selected
			if Selected == true:
				Game.spawnUnit(position)
			


func _on_barb_house_mouse_entered():
	mouseEntered = true

func _on_barb_house_mouse_exited():
	mouseEntered = false
