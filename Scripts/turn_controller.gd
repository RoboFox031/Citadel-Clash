extends Area2D

enum direction {Left, Right}

@export var turnDirection : direction

func _on_body_entered(body:Node2D):
	print(body.get_class)
	if body.is_class("enemy") == true:
		print("yay")
