extends Node2D
@onready var main_path: Path2D = $"../mainPath"
@onready var gap_timer: Timer = $gapTimer

var active:bool = false
#Preloads all the enemies
#Ball Enemies:
var orangeBallEnemy = preload("res://Scenes/orange_ball_enemy.tscn")
var redBallEnemy = preload("res://Scenes/red_ball_enemy.tscn")
var bossBall = preload("res://Scenes/boss_ball.tscn")
#Split Enemies:
var tinySplitEnemy = preload("res://Scenes/tiny_spliter_enemy.tscn")
var mediumSplitEnemy= preload("res://Scenes/medium_spliter_enemy.tscn")
var bigSplitEnemy = preload("res://Scenes/big_spliter_enemy.tscn")
var bossSplitEnemy = preload("res://Scenes/boss_spliter.tscn")
#Blocker Enemies:
var mediumBlocker = preload("res://Scenes/blocker.tscn")

#Exports the wavecount for trouble shooting
@export var waveCount:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#resets the active variable once everything is dead, or has made it
	if(main_path.get_child_count()<=0):
			active = false
	pass
	
#All the enemy spawn Functions
func spawnEnemy(amount:int,type:PackedScene):
	#repeats the folowing code per the amount parameter
	for i in amount:
		#Spawns in a weak enemy 
		var instance = type.instantiate()
		main_path.add_child(instance)
		#Adds in a slight randomess in the gap, for more variety
		var originalGap = gap_timer.wait_time
		gap_timer.wait_time+=randf_range(0,.1)
		gap_timer.start()
		await(gap_timer.timeout)
		gap_timer.wait_time = originalGap
func nextWave():
	#Only lets it start a new wave if the old one is done
	if active == false:
		active=true
		#Adds one to the wave
		waveCount+=1
		$"../HUD/waveCount".text = str(waveCount)
		#Controls amount, types and frequency 
		#of enemies based on wave number
		#Folowing statements define each grouping of waves
		if waveCount<=5:
			gap_timer.wait_time=1
			spawnEnemy(waveCount*2,orangeBallEnemy)
		elif waveCount<=10:
			gap_timer.wait_time=1
			await spawnEnemy(waveCount,redBallEnemy)
			await spawnEnemy(waveCount,orangeBallEnemy)
			spawnEnemy(waveCount-7,tinySplitEnemy)
		elif waveCount <=15:
			gap_timer.wait_time=.8
			#Multiplied by 1.5, to make more ememies than *1, but less than *2
			await(spawnEnemy(waveCount*1.5,redBallEnemy))
			spawnEnemy(waveCount-10,mediumSplitEnemy)
		elif waveCount ==16:
			gap_timer.wait_time =.1
			spawnEnemy(100,orangeBallEnemy)
		elif waveCount <=19:
			gap_timer.wait_time=.8
			await(spawnEnemy(waveCount*2,redBallEnemy))
			spawnEnemy(waveCount-16,bigSplitEnemy)
		elif waveCount ==20:
			gap_timer.wait_time=.5
			await(spawnEnemy(5,redBallEnemy))
			await spawnEnemy(1,mediumBlocker)
			spawnEnemy(5,redBallEnemy)
		elif waveCount <=25:
			gap_timer.wait_time=.8
			spawnEnemy(1,tinySplitEnemy)
		elif waveCount ==30:
			gap_timer.wait_time=.8
			spawnEnemy(1,bossBall)
		else:
			print("no more waves!")
		pass
