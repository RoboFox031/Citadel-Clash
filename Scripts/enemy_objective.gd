extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Enemy"):
		#life losing goes here
		print(body.get_parent().get_child_count())
		if(body.get_parent().get_child_count()==0):
			print("All Enemies Defeated")
		body.get_parent().queue_free()
		#deletes the enemy from the scene
		print("Enemy has made it!")
		print(body.get_parent().get_children())

		
