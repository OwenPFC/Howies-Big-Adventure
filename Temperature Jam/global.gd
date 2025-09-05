extends Node

var SPEED:float = 0
var inSun:bool = true
var howie_position = 0

var numShadowsInside = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func global_restart():
	numShadowsInside = 0
	
func get_global_numShadowsInside():
	return numShadowsInside
	
func get_global_inSun():
	return inSun
	
func set_global_inSun(torf:bool):
	inSun = torf

func set_global_speed(speed:float):
	SPEED = speed
	
func get_global_speed():
	return SPEED
