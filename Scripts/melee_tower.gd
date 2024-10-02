extends Tower

@onready var attack: AnimatedSprite2D = $Attack
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	super._ready()
	#Makes the scale of the animaation equal to the scale of the damage area
	attack.scale= rangeBox.scale/4.2

#Since this tower has no projectile, it deals direct damage with it's hitbox for aiming
func fireProj():
	#Makes sure the target is still in range
	if inRangeEnemies != []:
		#Plays the attack animation
		$Weapon.play("Attack")
		await $Weapon.animation_finished
		$Weapon.play("Idle")
		#Double checks in case the enemy died during the animation
		if inRangeEnemies != []:
			#Makes Projectile
			print("bam!")
			#Makes Projectile
			attackTimer.start()
			#Makes the attack animation visible and plays the animation
			attack.visible=true
			attack.play("Attack")
			#The animation player makes the hitbox move more smothely with the animation
			animation_player.play("Attack")
			await attack.animation_finished
			#Makes the animation invisible again
			attack.visible=false
			#Once the animation is done, it deals damage to all enemies affected
			#for i in inRangeEnemies:
				#i.takeDamage(damage)
			


func _on_attack_box_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.takeDamage(damage)
