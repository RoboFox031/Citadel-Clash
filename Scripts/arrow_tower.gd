extends Tower


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Only makes the weapon point when an enemy is in range
	if inRangeEnemies != []:
		#Sets the target to the first enemy to enter range
		var target = inRangeEnemies[0]
		#Points the weapon at the first enemy to enter the range
		$Weapon.rotation_degrees=get_angle_to(target.get_parent().global_position)*(180/3.14159265358979)+90
		
