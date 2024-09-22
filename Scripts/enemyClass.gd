extends CharacterBody2D
class_name Enemy

const SPEED = 50.0

@export var health : int = 1
@export var speedMultiplier :int =1

@export var hurtbox : CollisionShape2D

func _ready() -> void:
	pass
func _physics_process(delta):
	get_parent().progress += delta*SPEED*speedMultiplier
	##moves enemy on path
func takeDamage (amount:int):
	health-=amount
	print(health)
	#lose health
	if health<=0:
		queue_free()
		#deletes enemy if it's dead
