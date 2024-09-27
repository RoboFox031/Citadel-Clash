extends Area2D

@onready var main_path: Path2D = $"../mainPath"

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Enemy"):
		#life losing goes here
		body.get_parent().queue_free()
		#deletes the enemy from the scene
		print("Enemy has made it!")
		print(main_path.get_child_count())
		#For whatever reason, it deletes the enemy after the if,
		#so instead of adding delay, it just chcks for <= 1 enemy
		if(main_path.get_child_count()<=1):
			print("All Enemies Defeated")

		
