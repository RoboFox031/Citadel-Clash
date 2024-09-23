extends CharacterBody2D
class_name Enemy

const SPEED = 50.0
enum enemyType {Ball,Spliter,Potato}
@export var health : int = 1
@export var speedMultiplier :float =1
@export var damage : int = 1
@export var type: enemyType
@export var splitAmount: int =0
@export var splitInto: PackedScene
#adds in enemies it can split into

#var splitTarget = preload(splitInto)
func _ready() -> void:
	#Makes faster ones animate faster
	$AnimatedSprite2D.speed_scale = speedMultiplier
	
func _physics_process(delta):
	get_parent().progress += delta*SPEED*speedMultiplier
	#moves enemy on path
	if Input.is_action_just_pressed("ui_text_backspace"):
		takeDamage(1)	
func split():
	if enemyType.Spliter:
		for i in splitAmount:
			var instance = splitInto.instantiate()
			get_parent().add_child(instance)
			instance.rotates=false
			instance.rotation=0
			instance.progress+=(100*(i+1))
			print(instance.progress)
		get_parent().queue_free()
		
func takeDamage (amount:int):
	health-=amount
	print(health)
	#lose health
	if health<=0:
		#Splits the spliter enemy, and deletes the rest
		if enemyType.Spliter:
			if splitInto!= null:
				split()
			else:
				get_parent().queue_free()
				print("be gone!")
		else:
			get_parent().queue_free()
			#deletes enemy if it's dead
