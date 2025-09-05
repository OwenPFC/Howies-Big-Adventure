extends Node2D

var cloud = preload("res://cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawner():
	#var obs = obstacle.instantiate()
	var c = cloud.instantiate()
	add_child(c)
	
func _on_timer_timeout():
	if(get_child_count(false)==1):
		print("cloud spawner, making cloud")
		spawner()
