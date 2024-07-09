extends StaticBody2D


var totalTreeHealth: float = 40
var treeHealth: float
var unitsCount: int = 0
var state = "growing"


@onready var bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $chopTimer

func _ready():
	treeHealth = totalTreeHealth
	bar.max_value = totalTreeHealth
	timer.start()


func _process(_delta):
	if treeHealth <= 0:
		tree_chopped()
		

func _on_chop_area_body_entered(body):
	#var group = body.get_groups()
	if body.is_in_group("workers"):
		unitsCount += 1
		start_chopping()
	

func _on_chop_area_body_exited(body):
	if body.is_in_group("workers"):
		unitsCount -= 1
		if unitsCount <= 0:
			end_chopping()	
			


func _on_timer_timeout():

	if state == "chopping" :
		var shopSeed = 1 * unitsCount
		treeHealth -= shopSeed
		Game.Resources.Wood += shopSeed
	elif state == "growing" :
		if treeHealth < totalTreeHealth:
			treeHealth += 0.25
	else :
		pass	

	bar.value = treeHealth



func tree_chopped():
	Game.Resources.Wood += 5
	state = "dead"
	queue_free()


func start_chopping():
	state = "chopping"

func end_chopping():
	state = "growing"

