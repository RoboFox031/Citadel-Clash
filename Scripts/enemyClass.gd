extends CharacterBody2D
class_name Enemy

const SPEED = 60.0

enum enemyType {Ball,Spliter,Blocker}
@export var health : int = 1
@export var speedMultiplier :float =1
@export var damage : int = 1
@export var worth: int = 10
@export var type: enemyType
@export var splitAmount: int =0
#adds in enemies it can split into
@export var splitInto: PackedScene
@export var supportFrequency:float=0

#Adds a timer for the blocker enemy to use
@export var blockTimer:Timer


func _ready() -> void:
	#Makes faster ones animate faster
	$AnimatedSprite2D.speed_scale = speedMultiplier
	#prevents enemies from looping
	get_parent().loop = false
	#Makes them not rotate on the curves
	get_parent().rotates=false
	get_parent().rotation=0
	
	blockTimer.wait_time=supportFrequency
	if type==enemyType.Blocker:
		blockTimer.wait_time = supportFrequency
		blockTimer.timeout.connect(block)
		blockTimer.start()
		pass
	
func _physics_process(delta):
	#moves enemy on path
	get_parent().progress += delta*SPEED*speedMultiplier
	#print(blockTimer.time_left)
	if Input.is_action_just_pressed("ui_text_backspace"):
		takeDamage(1)
#The function that splits spliters into other enemies
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
#The function that allows for blockers to block
func block():
	print("block!")
	apply_scale(Vector2(2,2))
	get_child(0).play("Block")
	await get_child(0).animation_finished.connect()
	print("no block")
	blockTimer.start()


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
				#Deletes the last splitter in chain (tiny one)
				get_parent().queue_free()
				print("be gone!")
				
		else:
			#deletes enemies, when they die
			get_parent().queue_free()
			print("be gone!")
			#deletes enemy if it's dead
