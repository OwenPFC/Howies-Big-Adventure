extends Node2D

var smallNS = preload("res://small_building_ns.tscn")
var mediumNS = preload("res://medium_building_ns.tscn")
var largeNS = preload("res://large_building_ns.tscn")

var right_buildings = [smallNS,mediumNS,largeNS]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.get_global_speed() == 0):
		$Timer.set_paused(true)
	else:
		$Timer.set_paused(false)

func spawner():
	var right_building = right_buildings[randi_range(0,2)].instantiate()
	add_child(right_building)
	right_building.global_position.x -= randi_range(-50,150)

func _on_timer_timeout():
	if(Global.get_global_speed() != 0):
		spawner()
