extends Projectile
@export var chainAmount:int = 5
var chainTargets = []
var pastChain = []

func _ready() -> void:
	super._ready()
	chainTargets.append(target)

func _on_range_hitbox_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		if pastChain.has(body)==false:
			#Adds the enemy to the list of chain targets
			chainTargets.append(body)
		
func _on_range_hitbox_body_exited(body: Node2D) -> void:
	#Removes enemies from chain targets when they die
	chainTargets.erase(body)
#Readded from class in order to add chaining
func hitEnemy(body):
	if body is Enemy:
		body.takeDamage(damage)
		#Reduces chain amount by one
		chainAmount-=1
		#print(chainAmount)
		#Prevents it from bouncing to the same enemy twice
		pastChain.append(body)
		chainTargets.erase(target)
		chainTargets.erase(body)
		#Checks for other targets, if none are found, it deletes
		if chainTargets != []:
			target = chainTargets[0]
		else:
			queue_free()
		if chainAmount<=0:
			queue_free()
		
