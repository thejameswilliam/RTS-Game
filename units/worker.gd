extends CharacterBody2D

@export var selected: bool = false
@onready var box: Panel = $Box
@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var target = position
var folow_cursor: bool = false
var speed = 60
var cost = {
	"Wood": 0,
	"Food": 10
}

func _ready():
	set_selected(selected)
	add_to_group("workers", true)
	add_to_group("units", true)

func set_selected(_selected: bool):
	selected = _selected
	box.visible = _selected


func _input(event):
	if event.is_action_pressed("RightClick"):
		folow_cursor = true
	if event.is_action_released("RightClick"):
		folow_cursor = false


func _physics_process(_delta):
	if folow_cursor:
		if selected:
			target = get_global_mouse_position()
			animation.play("Walk Down")
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 20:
		move_and_slide()
	else:
		animation.stop()



func _on_selection_area_selection_toggled(selection):
	set_selected(selection)
	pass # Replace with function body.
