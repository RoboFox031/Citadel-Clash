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
#Adds support frequency and length
@export var supportFrequency:float=0
@export var supportLength:float = 5
#Adds a timer for the blocker enemy to use
@export var blockTimer:Timer
#Adds the sheild for the blocker
var sheild = preload("res://Scenes/sheild.tscn")


func _ready() -> void:
	#Makes faster ones animate faster
	$AnimatedSprite2D.speed_scale = speedMultiplier
	#prevents enemies from looping
	get_parent().loop = false
	#Makes them not rotate on the curves
	get_parent().rotates=false
	get_parent().rotation=0
	
	if type==enemyType.Blocker:
		blockTimer.wait_time = supportFrequency+ randf_range(0,1.5)
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
		for i in splitAmount:
			#adds randomness of how far apart they spawn
			var spawnOffset = randf_range(20,25)
			if parentProgress-abs((i+1)*spawnOffset)>0:
				var instance = splitInto.instantiate()
				get_parent().get_parent().add_child(instance)
				instance.progress = parentProgress-(i+1)*spawnOffset
		get_parent().queue_free()
#The function that allows for blockers to block
func block():
	if get_parent().progress_ratio<.75:
		var instance = sheild.instantiate()
		add_child(instance)
		instance.duriation = supportLength
		
#Checks if eveything has completed, or is dead
func waveCheck():
	if(get_parent().get_parent().get_child_count()<=1):
			print("All Enemies Defeated")
			#gives 5 coins for finishing the wave
			$"../../../HUD".addCoins(5)
func takeDamage (amount:int):
	health-=amount
	print(health)
	#lose healt
	if health<=0:
		#Adds coins on enemy death
		$"../../../HUD".addCoins(worth)
		#Splits the spliter enemy, and deletes the rest
		if enemyType.Spliter:
			if splitInto!= null:
				split()
			else:
				#Deletes the last splitter in chain (tiny one)
				get_parent().queue_free()
				print("be gone!")
				waveCheck()
				
		else:
			#deletes enemies, when they die
			get_parent().queue_free()
			print("be gone!")
			waveCheck()
