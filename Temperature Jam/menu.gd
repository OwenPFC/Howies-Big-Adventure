extends Node2D

var song = preload("res://assets/sounds/andante.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	$music.stream = song
	$music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://typing_intro.tscn")


func _on_credits_pressed():
	$credit_screen.visible = true

func _on_button_pressed():
	$credit_screen.visible = false
