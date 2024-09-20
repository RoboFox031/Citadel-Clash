extends CharacterBody2D
class_name enemy

const SPEED = 50.0


func _physics_process(delta):
	get_parent().progress += delta*SPEED

