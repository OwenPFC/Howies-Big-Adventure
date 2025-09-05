extends CharacterBody2D

signal increase_temp(power:float)
signal decrease_temp(power:float)

var SPEED = 300.0

func _ready():
	Global.howie_position = $".".global_position.y

func _physics_process(delta):
	Global.howie_position = $".".global_position.y
	
	if(Global.get_global_speed() == 0):
		$howie_sprites.animation = "stand"
	else:
		$howie_sprites.animation = "walk"
		$howie_sprites.play()

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$howie_sprites.animation = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#the parameter is for if its from A/C or just passive cooldown
func cool_down(power:float):
	decrease_temp.emit(power)

#the parameter is for if its from heater or the sun
func heat_up(power:float):
	increase_temp.emit(power)


func _on_typing_incorrect_letter():
	heat_up(0.01)

func _on_typing_perfect_segment():
	cool_down(3)


func _on_typing_correct_letter():
	cool_down(0.00001)
