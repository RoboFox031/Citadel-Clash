extends Area2D
@onready var sheild_duration: Timer = $SheildDuration
var duriation = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sheild_duration.wait_time = duriation+randf_range(0,1.5)
	sheild_duration.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_parent().progress_ratio>.85:
		queue_free()
	


func _on_sheild_duration_timeout() -> void:
	get_parent().blockTimer.start()
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	#Deletes any projectiles in the sheild
	#if body is projectile:
	#	var projCount+=body.damage
	#	body.queue_free()
	#Adds a way to delete sheild, if it's shot enoguh
	#	if projCount >=50:
	#	_on_sheild_duration_timeout()
	pass # Replace with function body.
