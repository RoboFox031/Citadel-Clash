extends Area2D

enum hDirection {Left, Right}
enum vDirection {Down,Up}
@export var turnH : hDirection
@export var turnV : vDirection
#Exports diffent directions for me to confiure each controler to 

func _on_body_entered(body:Node2D):
	if body.name=="Enemy":
	#Makes sure it's an enemy
		if turnH == hDirection.Left:
			body.get_child(0).flip_h= false
		elif turnH == hDirection.Right:
			body.get_child(0).flip_h= true
		if turnV == vDirection.Up:
			body.get_child(0).play("Up")
		elif turnV == vDirection.Down:
			body.get_child(0).play("Down")
	#Each line above flips the sprite and/or
