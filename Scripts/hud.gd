extends Node2D
var health = 100
var wealth = 0
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var coin_count: Label = $CoinCount

var arrowTower = preload("res://Scenes/arrow_tower.tscn")
var meleeTower = preload("res://Scenes/melee_tower.tscn")
var lightningTower= preload("res://Scenes/lightning_tower.tscn")

@export var startingCash:int = 40

@export var arrowCost:int = 35
@export var meleeCost:int = 60
@export var lightningCost:int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Sets starting cash and prices of all towers
	addCoins(startingCash)
	$"BuildArrow/Price".text=str("x ",arrowCost)
	$"BuildMelee/Price".text=str("x ",meleeCost)
	$"BuildLightning/Price".text=str("x ",lightningCost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_wave_pressed() -> void:
	$"../WaveController".nextWave()


func addCoins(amount):
	wealth+=amount
	coin_count.text = str("x ",wealth)
	
func takeDamage(amount):
	health-=amount
	progress_bar.value =health
	$ProgressBar/Label.text = str(progress_bar.value)


#Depending on the button pressed, it creates an istance of that tower
# and sets that tower to buidling mode
func placeArrow():
	if wealth>=arrowCost:
		var instance = arrowTower.instantiate()
		get_parent().add_child(instance)
		instance.building=true
		instance.price = arrowCost
	pass
func placeMelee():
	
	if wealth>=meleeCost:
		var instance = meleeTower.instantiate()
		get_parent().add_child(instance)
		instance.building=true
		instance.price = meleeCost
func placeLightning():
	if wealth>=lightningCost:
		var instance = lightningTower.instantiate()
		get_parent().add_child(instance)
		instance.building=true
		instance.price = lightningCost
