extends Area2D

signal selection_toggled(selection) 

@export var selection_action = "LeftClick"

var selected = false

func set_selected(selection):
	if selection:
		add_to_group("selected")
	else :
		remove_from_group("selected")
	selected = selection
	emit_signal("selection_toggled", selected)
	
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed(selection_action):
		set_selected(not selected)
