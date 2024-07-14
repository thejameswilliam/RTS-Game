extends CharacterBody2D

@export var selected: bool = false

@onready var box: Panel = $Box
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var target = position

var folow_cursor: bool = false
var movement_speed = 40
var hit_points = 100

var cost = {
	"Wood": 5,
	"Food": 10
}

func _ready():
	set_selected(selected)
	add_to_group("units", true)
	add_to_group("warriors", true)
	

func set_selected(_selected: bool):
	selected = _selected
	box.visible = _selected


func _input(event):
	if event.is_action_pressed("RightClick"):
		folow_cursor = true
	if event.is_action_released("RightClick"):
		folow_cursor = false


func _physics_process(_delta):
	look_at_point()
	if folow_cursor:
		if selected:
			target = get_global_mouse_position()
			animation.play("Walk Down")
	velocity = position.direction_to(target) * movement_speed
	if position.distance_to(target) > 20:
		move_and_slide()
	else:
		animation.stop()



func look_at_point():
	if target:
		rotation = lerp_angle(rotation, (position - target).angle(), 0.1)
		
		
func unit_death():
	pass

func _on_selection_area_selection_toggled(selection):
	set_selected(selection)


func _on_defend_box_defend(damage):
	hit_points -= damage
	if hit_points <= 0:
		unit_death()
