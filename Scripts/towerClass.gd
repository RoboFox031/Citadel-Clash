extends Node2D
class_name Tower
@export var attackRange:float = 5
@export var damage: int =1
@export var attackCD:float=2
@export var projectile:PackedScene
@export var rangeBox: Area2D
@export var placeBox: Area2D
@export var rangeButton: Button

#This variable is changed by the button to build it
var price: int = 10


#Makes an array of the enemies that are in range
var inRangeEnemies:Array[CharacterBody2D] = []
var attackTimer:Timer = Timer.new()

#A building variable, to stop you from building multiple towers at once
var building:bool = true

#A variable that stores the number of things the tower is touching
var coliding:int =0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Sets the range to the attack range varable
	rangeBox.scale = Vector2(attackRange,attackRange)
	rangeBox.body_entered.connect(addToRange)
	rangeBox.body_exited.connect(removeFromRange)
	rangeBox.get_child(0).disabled=true
	#Sets up the timer
	add_child(attackTimer)
	attackTimer.one_shot=true
	attackTimer.wait_time=attackCD
	attackTimer.timeout.connect(fireProj)
	#Makes shadow invisible while building
	$Shadow.visible=false
	#Connects the placement hitbox to a signal
	placeBox.area_entered.connect(invalidPlace)
	placeBox.area_exited.connect(validPlace)
	#Connects the Rangebutton to the rangeVisible function
	rangeButton.toggled.connect(rangeVisible)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func placeTower():
	if coliding == 0:
		#Charges player cost of tower
		$"../HUD".addCoins(-price)
		#Disables building mode
		building=false
		#Allows tower to see enemies
		rangeBox.get_child(0).disabled=false
		#Adds Shadow
		$Shadow.visible=true
		#Removes range preview/enables button
		rangeBox.visible=false
		rangeButton.disabled=false
	else:
		queue_free()


func _physics_process(delta: float) -> void:
	if building==true:
		global_position=get_global_mouse_position()
		if Input.is_action_just_pressed("Click"):
			placeTower()
	
func fireProj():
	#Makes sure the target is still in range
	if inRangeEnemies != []:
		#Plays the attakc animation
		$Weapon.play("Attack")
		#await $Weapon.frame_changed
		#Double checks in case the enemy died during the animation
		if inRangeEnemies != []:
			#Makes Projectile
			attackTimer.start()
			#Makes Projectile
			var instance = projectile.instantiate()
			get_parent().add_child.call_deferred(instance)
			instance.damage = damage
			instance.target = inRangeEnemies[0].get_parent()
			instance.startPoint = $Weapon.global_position
			instance.startRot = $Weapon.rotation
	
#Adds the enemy to the array
func addToRange(body:Node2D):
	if(body is Enemy):
		inRangeEnemies.append(body)
		#Makes it instantly fire if this is the only enemy to enter it
		if inRangeEnemies[0] == body and attackTimer.is_stopped()==true:
			fireProj()
		#If it's not the only enemy, attack as normal
		else:
			#Makes sure the timer isn't currently running
			if attackTimer.time_left<=0:
				attackTimer.start()
		
#remove the enemy from the array
func removeFromRange(body:Node2D):
	if(body is Enemy):
		inRangeEnemies.erase(body)
		
#Changes the placeable varable based on if the tower 
#is in a placeable psotion
func invalidPlace(area):
		coliding+=1
		#Makes tower red
		modulate.r=50

func validPlace(area):
		coliding-=1
		#Makes the tower not red
		modulate.r=1
func rangeVisible(toggled_on):
	print("uo")
	rangeBox.visible=toggled_on
	
