extends Node2D
var health = 100
var wealth = 0
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var coin_count: Label = $CoinCount


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_wave_pressed() -> void:
	$"../WaveController".nextWave()


func addCoins(amount):
	wealth+=amount
	coin_count.text = str("x ",wealth)
	
func takeDamage(amount):
	print("ow",amount)
	health-=amount
	progress_bar.value =health
	$ProgressBar/Label.text = str(progress_bar.value)
