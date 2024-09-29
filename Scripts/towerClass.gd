extends Node2D
class_name Tower
@export var range:float = 5
@export var damage: int =1
@export var price: int = 10
@export var projectile:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#nearest_po2()
	pass
	
func placeTower():
	pass
func fireProj():
	pass
