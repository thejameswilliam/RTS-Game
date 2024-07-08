extends Node


@onready var spawn = preload("res://Global/spawn_unit.tscn")

var Wood: int = 20
var Food: int = 0

var WorkerStats = {
					"pos" = Vector2(300,300),
					"unit_type" = "worker",
					"resource_type" = "Wood",
					"cost"= 10
				}

func spawnUnitPanel():
	var path = get_tree().get_root().get_node("World/UI")
	var hasSpawn = false
	for i in path.get_child_count():
		if "SpwnUnit" in path.get_child(i).name:
			hasSpawn = true
	if hasSpawn == false:
		var spawnUnit = spawn.instantiate()
		
		path.add_child(spawnUnit)
 
