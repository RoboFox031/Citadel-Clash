extends Area2D
class_name Projectile

@export var speed = 5
var attackPoint = Vector2(0,0)
var attackOffset:Vector2 = Vector2(0,-10)

var damage = 1
var target
var startPoint:Vector2
var startRot




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Makes it posible to hit enemy
	body_entered.connect(hitEnemy)
	#Makes it start with the tower position, and rotation
	global_position=startPoint
	rotation =startRot
	speed+=((target.get_child(0).SPEED*target.get_child(0).speedMultiplier)/20)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Makes it only run if a target exsists
	if target != null:
		#The rotate line is only for visuals, the projectile still moves correctly without it
		#The +pi/2 in the rotate is a rotation offset
		rotate(get_angle_to(target.global_position+attackOffset)+(3.14159265358979/2))
		#Sets the attack point to a point between you and the target
		attackPoint = (target.global_position+attackOffset)-global_position
		#nomralize maintans directon, while setting distance to 1
		attackPoint.normalized()
		#Moves the projectile in the direction of the target
		global_position+=attackPoint*speed*delta
		
	#If there is no target, the projectile deletes
	else:
		queue_free()
func hitEnemy(body):
	if body is Enemy:
		body.takeDamage(damage)
		queue_free()
	
