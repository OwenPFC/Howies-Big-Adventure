extends Node2D

var heat = 0.0001

var letterIndex = 0
var numSentences = 0

var sc26:String = "And here’s my building, another successful walk with my milk kept at a safe temperature"
var sc266 = "I’ll now head into the lobby, get on the escalator, and enjoy the rest of my 1 hour paid lunch break"
var sc27:String = "Cheers"
var sc28 = "_"

var endText = [sc26,sc266,sc27,sc28]

var song = preload("res://assets/sounds/alegretto.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_global_speed(2)
	$music.stream = song
	$music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var isInSun = Global.get_global_inSun()
	if(isInSun):
		$howie.heat_up(heat)
	
	if(Input.is_action_just_pressed("Type")||Input.is_action_just_pressed("Type_More")|| Input.is_action_just_pressed("interact")):
		if($winScreen.visible):
			letterIndex = 0
			numSentences +=1
			$winScreen/Label.text = ""
	if(numSentences<len(endText)):
		if(letterIndex<len(endText[numSentences])):
			$winScreen/Label.text = $winScreen/Label.text + endText[numSentences][letterIndex]
			letterIndex+=1
	
	if($winScreen/Label.text == sc28):
		$winScreen/Label.text = ""
		$Button.visible = true
		$Button.disabled = false

func _on_bottom_boundary_body_entered(body):
	body.queue_free()

func _on_cloud_killer_body_entered(body):
	body.queue_free()


func _on_restart_pressed():
	Global.global_restart()
	get_tree().reload_current_scene()


func _on_howie_temperature_fail(which):
	$restart.visible = true
	$restart.disabled = false
	if(which == "Howie"):
		$restart/text.text = "Howie burned alive!!!!"
	else:
		$restart/text.text = "The milk got too hot :("

func _on_typing_win():
	$winScreen.visible = true


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_music_finished():
	$music.stream = song
	$music.play()
