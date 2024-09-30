extends Node2D
class_name Tower
@export var attackRange:float = 5
@export var damage: int =1
@export var price: int = 10
@export var attackCD:float=.8
@export var fireOffset:Vector2 =Vector2(0,0)
@export var projectile:PackedScene
@export var rangeBox: Area2D


#Makes an array of the enemies that are in range
var inRangeEnemies:Array[CharacterBody2D] = []
var attackTimer:Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Sets the range to the attack range varable
	rangeBox.scale = Vector2(attackRange,attackRange)
	rangeBox.body_entered.connect(addToRange)
	rangeBox.body_exited.connect(removeFromRange)
	#Sets up the timer
	add_child(attackTimer)
	attackTimer.one_shot=true
	attackTimer.wait_time=attackCD
	attackTimer.timeout.connect(fireProj)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func placeTower():
	pass
	
func fireProj():
	#Makes sure the target is still in range
	if inRangeEnemies != []:
		#Plays the attakc animation
		$Weapon.play("Attack")
		await $Weapon.frame_changed
		#Double checks in case the enemy died during the animation
		if inRangeEnemies != []:
			#Makes Projectile
			print("bam!")
			attackTimer.start()
			#Makes Projectile
			var instance = projectile.instantiate()
			get_parent().add_child.call_deferred(instance)
			instance.damage = damage
			instance.target = inRangeEnemies[0].get_parent()
		
	
#Adds the enemy to the array
func addToRange(body:Node2D):
	if(body is Enemy):
		inRangeEnemies.append(body)
		attackTimer.start()
		#Makes it instantly fire if this is the only enemy to enter it
		if inRangeEnemies[0] == body:
			fireProj()
#remove the enemy from the array
func removeFromRange(body:Node2D):
	if(body is Enemy):
		inRangeEnemies.erase(body)
