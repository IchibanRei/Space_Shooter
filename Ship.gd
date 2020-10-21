extends Area2D

const Laser = preload("res://Laser.tscn")
const ExplosionEffect = preload("res://ExplosionEffect.tscn")

export(int) var SPEED = 100
export(int) var ARMOR = 3

signal player_death

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("ui_down"):
		position.y += SPEED * delta
	if Input.is_action_just_pressed("ui_accept"):
		fire_laser()
	

func fire_laser():
	var laser = Laser.instance()
	var main = get_tree().current_scene
	main.add_child(laser)
	laser.global_position = global_position


func _on_Ship_area_entered(area):
	ARMOR -= 1
	if ARMOR == 0:
		area.queue_free()
		queue_free() # Replace with function body.
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _exit_tree():
	var main = get_tree().current_scene
	var explosionEffect = ExplosionEffect.instance()
	main.call_deferred("add_child", explosionEffect)
	explosionEffect.global_position = global_position
	emit_signal("player_death")


