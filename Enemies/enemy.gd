extends CharacterBody2D

@export var movement_speed = 20
@export var hit_points = 30
@onready var units = get_tree().get_nodes_in_group("units")

@onready var animation: AnimationPlayer = $AnimationPlayer

#
func _ready():
	pass
	
func _physics_process(_delta):
	var unit = get_closest_unit()
	if unit:
		var distance_to = global_position.distance_to(unit.global_position)
		var direction = global_position.direction_to(unit.global_position)
		velocity = direction * movement_speed
		
		if distance_to > 1:
			animation.play("goblin_animation")
			move_and_slide()
		else:
			animation.stop()	


func get_closest_unit():
	var closest = null
	var distance_to = 999999
	for i in units:
		var new_distance_to = global_position.distance_to(i.global_position)
		if new_distance_to < distance_to:
			distance_to = new_distance_to
			closest = i
	return closest
	


func _on_hurt_box_hurt(damage):
	hit_points -= damage
	if hit_points <= 0:
		queue_free()
