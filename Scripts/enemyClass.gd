extends CharacterBody2D
class_name Enemy

const SPEED = 50.0

@export var speedMultiplier :int =1

func _physics_process(delta):
	get_parent().progress += delta*SPEED*speedMultiplier
