extends Camera2D

#Camera Control
@export var SPEED = 20.0
@export var ZOOM_SPEED = 20.0
@export var ZOOM_MARGIN = 0.1
@export var ZOOM_MIN = 3
@export var ZOOM_MAX = 10.0


var zoomFactor = 1.0
var zoomPos = Vector2()
var zooming = false
var mousePos: Vector2 = Vector2()

var mousePosGlobal: Vector2 = Vector2()
var start: Vector2 = Vector2()
var startV: Vector2 = Vector2()
var end: Vector2 = Vector2()
var endV: Vector2 = Vector2()
var isDragging: bool = false

@onready var box: Panel = get_node("../UI/Panel")

signal area_selected
signal atart_move_selection

func _ready():
	connect("area_selected", Callable(get_parent(), "_on_area_selected"))

func _process(_delta):
	
	#Camera Controls
	var inputX = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var inputY = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	position.x = lerp(position.x, position.x + inputX*SPEED * zoom.x, SPEED * _delta)
	position.y = lerp(position.y, position.y + inputY*SPEED * zoom.y, SPEED * _delta)
	
	zoom.x = lerp(zoom.x, zoom.x * zoomFactor, ZOOM_SPEED*_delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomFactor, ZOOM_SPEED*_delta)
	
	zoom.x = clamp(zoom.x, ZOOM_MIN, ZOOM_MAX)
	zoom.y = clamp(zoom.y, ZOOM_MIN, ZOOM_MAX)
	
	if not zooming:
		zoomFactor = 1.0
	
	
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
		
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
		
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			var closest = get_closest_node_in_group("units", start)
			if closest.global_position.distance_to(mousePosGlobal) > 20:
				get_tree().call_group("units","set_selected", false)
			
			end = start
			isDragging = false
			draw_area(false)


func get_closest_node_in_group(group, pos):
	var nodes = get_tree().get_nodes_in_group(group)
	# assume the first spawn node is closest
	var closest = nodes[0]
	for node in nodes:
		if node.global_position.distance_to(pos) < closest.global_position.distance_to(pos):
			closest = node

	return closest

func _input(event):
	
	if abs(zoomPos.x - get_global_mouse_position().x) > ZOOM_MARGIN:
		zoomFactor = 1.0
	if abs(zoomPos.y - get_global_mouse_position().y) > ZOOM_MARGIN:
		zoomFactor = 1.0
		

	
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.is_action("WheelDown"):
				zoomFactor -= 0.01 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
			if event.is_action("WheelUp"):
				zoomFactor += 0.01 * ZOOM_SPEED
				zoomPos = get_global_mouse_position()
		else :
			zooming = false
	
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()


func draw_area(s: bool = true):
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)
