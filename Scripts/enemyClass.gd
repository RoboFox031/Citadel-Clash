extends CharacterBody2D
class_name Enemy

const SPEED = 60.0

enum enemyType {Ball,Spliter,Support}
@export var health : int = 1
@export var speedMultiplier :float =1
@export var damage : int = 1
@export var type: enemyType
@export var splitAmount: int =0
#adds in enemies it can split into
@export var splitInto: PackedScene



func _ready() -> void:
	#Makes faster ones animate faster
	$AnimatedSprite2D.speed_scale = speedMultiplier
	#Makes them not rotate on the curves
	get_parent().rotates=false
	get_parent().rotation=0
	
func _physics_process(delta):
	get_parent().progress += delta*SPEED*speedMultiplier
	#moves enemy on path
	if Input.is_action_just_pressed("ui_text_backspace"):
		takeDamage(1)
func split():
	if enemyType.Spliter:
		var parentProgress:float = get_parent().progress
		print("parent Progress:", parentProgress)
		for i in splitAmount:
			#adds randomness of how far apart they spawn
			var spawnOffset = randf_range(20,25)
			if parentProgress-abs((i+1)*spawnOffset)>0:
				var instance = splitInto.instantiate()
				get_parent().get_parent().add_child(instance)
				instance.progress = parentProgress-(i+1)*spawnOffset
				print(i,",",instance.progress)
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
