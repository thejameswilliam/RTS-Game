extends Node2D

@onready var worker = preload("res://units/worker.tscn")
@onready var warrior = preload("res://units/warrior.tscn")

func _on_create_worker_pressed():

	var unitPath = get_tree().get_root().get_node("World/Units")
	var worldPath = get_tree().get_root().get_node("World")
	var worker1 = worker.instantiate()

	unitPath.add_child(worker1)
	
	worldPath.get_units()




func _on_create_warrior_pressed():
	var unitPath = get_tree().get_root().get_node("World/Units")
	var worldPath = get_tree().get_root().get_node("World")
	var warrior1 = warrior.instantiate()
	warrior1.position = Vector2(300, 300)
	unitPath.add_child(warrior1)
	
	worldPath.get_units()



func _on_close_pressed():
	var housePath = get_tree().get_root().get_node("World/Houses")
	for i in housePath.get_child_count():
		if housePath.get_child(i).Selected == true:
			housePath.get_child(i).Selected = false
	queue_free()
