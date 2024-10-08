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
var blocker = preload("res://Scenes/blocker.tscn")

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
		if waveCount<=2:
			gap_timer.wait_time=1
			spawnEnemy(waveCount*2,orangeBallEnemy)
		elif waveCount<=5:
			gap_timer.wait_time=.6
			spawnEnemy(waveCount*2,tinySplitEnemy)
		elif waveCount<=10:
			gap_timer.wait_time=1
			await spawnEnemy(waveCount-5,redBallEnemy)
			await spawnEnemy(waveCount*2,orangeBallEnemy)
			spawnEnemy(waveCount-7,tinySplitEnemy)
		elif waveCount <=15:
			gap_timer.wait_time=.8
			#Multiplied by 1.5, to make more ememies than *1, but less than *2
			await(spawnEnemy(waveCount*1.5,redBallEnemy))
			spawnEnemy(waveCount-10,mediumSplitEnemy)
		elif waveCount ==16:
			gap_timer.wait_time =.08
			spawnEnemy(150,tinySplitEnemy)
		elif waveCount <=20:
			gap_timer.wait_time=.8
			await(spawnEnemy(waveCount*2,redBallEnemy))
			spawnEnemy(waveCount-16,bigSplitEnemy)
		elif waveCount <=29:
			gap_timer.wait_time=.5
			await(spawnEnemy(waveCount/4,redBallEnemy))
			await spawnEnemy(waveCount/6,blocker)
			spawnEnemy(waveCount/4,redBallEnemy)
		elif waveCount ==30:
			gap_timer.wait_time=.8
			spawnEnemy(1,bossBall)
		elif waveCount <=39:
			gap_timer.wait_time=.6
			await spawnEnemy(waveCount/8,bigSplitEnemy)
			spawnEnemy(waveCount,redBallEnemy)
		elif waveCount ==40:
			spawnEnemy(1,bossSplitEnemy)
		elif waveCount <=49:
			gap_timer.wait_time=.3
			await spawnEnemy(waveCount/8,redBallEnemy)
			await spawnEnemy(waveCount,tinySplitEnemy)
			await spawnEnemy(waveCount/8,mediumSplitEnemy)
		#Every wave above 50 picks one of the 4 random senecrios to do
		#Until the player looses
		else:
			var choice= randf()
			if choice<=.25:
				#LOTS OF ENEMIES
				gap_timer.wait_time=.4
				for i in waveCount:
					#Repeats the flowing code for 1/5 of the wavecount
					if i%5==0:
						await spawnEnemy(waveCount/10,orangeBallEnemy)
						await spawnEnemy(2,blocker)
						spawnEnemy(waveCount/10,orangeBallEnemy)
				
			elif choice<=.5:
				#Strong enemies
				gap_timer.wait_time=1.2
				for i in waveCount:
				#Repeats the flowing code for 1/12 of the wavecount
					if i%12==0:
						await spawnEnemy(1,bossBall)
						spawnEnemy(1,bossSplitEnemy)
			elif choice<=.75:
				#Spliters with sheilds
				gap_timer.wait_time=.8
				for i in waveCount:
				#Repeats the flowing code for 1/10 of the wavecount
					if i%10==0:
						await spawnEnemy(waveCount/20,bigSplitEnemy)
						await spawnEnemy(1,blocker)
						await spawnEnemy(waveCount/20,bigSplitEnemy)
						await spawnEnemy(1,blocker)
						spawnEnemy(waveCount/5,mediumSplitEnemy)
			else:
				#blocker swarm
				gap_timer.wait_time=.6
				for i in waveCount:
				#Repeats the flowing code for 1/10 of the wavecount
					if i%5==0:
						await spawnEnemy(waveCount/20,blocker)
						spawnEnemy(waveCount/20,mediumSplitEnemy)
				pass
		pass
