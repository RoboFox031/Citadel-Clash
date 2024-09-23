extends Node2D
@onready var main_path: Path2D = $"../mainPath"
@onready var gap_timer: Timer = $gapTimer
#Preloads all the enemies
#Ball Enemies:
var orangeBallEnemy = preload("res://Scenes/orange_ball_enemy.tscn")
var redBallEnemy = preload("res://Scenes/red_ball_enemy.tscn")
var bossBall = preload("res://Scenes/boss_ball.tscn")
#Split Enemies:
var bigSplitEnemy = preload("res://Scenes/big_spliter_enemy.tscn")

#Exports the wavecount for trouble shooting
@export var waveCount:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		nextWave()
	pass
	
#All the enemy spawn Functions
func spawnEnemy(amount,type:PackedScene):

	#repeats the folowing code per the amount parameter
	for i in amount:
		#Spawns in a weak enemy 
		var instance = type.instantiate()
		main_path.add_child(instance)
		instance.rotates=false
		instance.rotation=0
		gap_timer.start()
		await(gap_timer.timeout)
func nextWave():
	#Adds one to the wave
	waveCount+=1
	print(waveCount)
	#Controls amount, types and frequency 
	#of enemies based on wave number
	#Folowing statements define each grouping of waves
	if waveCount<=5:
		gap_timer.wait_time=2
		spawnEnemy(waveCount*2,orangeBallEnemy)
	elif waveCount<=9:
		await spawnEnemy(waveCount,orangeBallEnemy)
		spawnEnemy(waveCount-3,redBallEnemy)
	elif waveCount ==10:
		await spawnEnemy(10,redBallEnemy)
		spawnEnemy(1,bossBall)
	elif waveCount <=15:
		spawnEnemy(1,bigSplitEnemy)
	else:
		print("no more waves!")
	pass
