extends Area2D

@export var turnType:String ="left"

func _on_body_entered(body:Node2D):
    print(body.get_class)
    if body.is_class("enemy") == true:
        print("yay")
