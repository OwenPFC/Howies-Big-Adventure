extends Node2D

var small = preload("res://small_building.tscn")
var medium = preload("res://medium_building.tscn")
var large = preload("res://large_building.tscn")

var left_buildings = [small,medium,large]

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
	#var obs = obstacle.instantiate()
	var left_building = left_buildings[randi_range(0,2)].instantiate()
	add_child(left_building)
	left_building.global_position.x += randi_range(-100,300)

func _on_timer_timeout():
	if(Global.get_global_speed() != 0):
		spawner()
