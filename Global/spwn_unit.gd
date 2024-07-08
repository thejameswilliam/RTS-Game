extends Node2D

@onready var worker = preload("res://units/worker.tscn")
@onready var warrior = preload("res://units/warrior.tscn")

func _on_create_worker_pressed():

	var unitPath = get_tree().get_root().get_node("World/Units")
	var worldPath = get_tree().get_root().get_node("World")
	var worker1 = worker.instantiate()

	if _check_resource_cost(worker1):
		worker1.position = _get_random_starting_location()
		unitPath.add_child(worker1)
	else :
		pass
	
	
	worldPath.get_units()




func _on_create_warrior_pressed():
	
	var unitPath = get_tree().get_root().get_node("World/Units")
	var worldPath = get_tree().get_root().get_node("World")
	var warrior1 = warrior.instantiate()
	
	if _check_resource_cost(warrior1):
		warrior1.position = _get_random_starting_location()
		unitPath.add_child(warrior1)
	else :
		pass

	
	worldPath.get_units()


func _get_random_starting_location():
	var random = RandomNumberGenerator.new()
	random.randomize()
	return Vector2((0 + random.randi_range(-40, 40)),(0 + random.randi_range(-40, 40)))


func _check_resource_cost(unit):
	var can_purchase = true
	for i in unit.cost:
		var resource = unit.cost[i]
		#print(str(i) + ": " + str(resource))
		if resource > 0:
			if Game.Resources[i] < resource:
				print("cant afford it")
				can_purchase = false
	
	if can_purchase:
		for i in unit.cost:
			var resource = unit.cost[i]
			if resource > 0:
				Game.Resources[i] -= resource
		
		print('can purchase')
	
	return true


func _on_close_pressed():
	var housePath = get_tree().get_root().get_node("World/Houses")
	for i in housePath.get_child_count():
		if housePath.get_child(i).Selected == true:
			housePath.get_child(i).Selected = false
	queue_free()
