extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Enemy"):
		#life losing goes here
		body.queue_free()
		print("Enemy has made it!")
