extends Area2D

@onready var main_path: Path2D = $"../mainPath"
@onready var hud: Node2D = $"../HUD"

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Enemy"):
		#life losing
		hud.takeDamage(body.damage)
		#deletes the enemy from the scene
		body.get_parent().queue_free()
		#Ends the game if you end the wave with <= 0 health
		if hud.health<= 0:
			#Deletes all the enemies on the path, to avoid errors about 
			#removing children during physics callbacks
			for i in get_parent().get_child_count():
				#Makes sure to not delete the enemy objective
				if i <7:
					get_parent().get_child(i).call_deferred("queue_free")
			$EndDelay.start()
		
		
		#For whatever reason, it deletes the enemy after the if,
		#so instead of adding delay, it just chcks for <= 1 enemy
		if(main_path.get_child_count()<=1):
			#gives the amount of coins for winning a wave
			body.waveCheck()
			

		

#Takes you to the game over screen once the timer runs out
func _on_end_delay_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
