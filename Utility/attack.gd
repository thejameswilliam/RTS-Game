extends Node2D


@onready var collision = $HitCollisionShape2D
@onready var disableTimer = $DisableHitBoxTimer
@export var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("attack")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func tempdisable():
	collision.call_deferred("set", "disabled", true)
	disableTimer.start()				


func _on_disable_hit_box_timer_timeout():
	collision.call_deferred("set", "disabled", false)
	
