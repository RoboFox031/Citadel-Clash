extends Tower

var poweredUp:bool = false
#Re-did from class to take into account extra animations
func fireProj():
	if poweredUp ==true:
		#Double checks in case the enemy died during the animation
		if inRangeEnemies != []:
			$Weapon.play("Attack")
			#Makes Projectile
			print("bam!")
			attackTimer.start()
			#Makes Projectile
			var instance = projectile.instantiate()
			get_parent().add_child.call_deferred(instance)
			instance.damage = damage
			instance.target = inRangeEnemies[0].get_parent()
			instance.startPoint = $Weapon.global_position
			instance.startRot = $Weapon.rotation
			
#Used to help aid animations
func addToRange(body:Node2D):
	super.addToRange(body)
		#Makes it play power up when first enemy appears
	if inRangeEnemies[0] == body:
		$Weapon.play("PowerUp")
		#print("add")
		await $Weapon.animation_finished
		poweredUp=true
		fireProj()

#Used to help aid animations
func removeFromRange(body:Node2D):
	super.removeFromRange(body)
	#Makes it play the power down animation, once it has nothing to attack
	if inRangeEnemies == []:
		poweredUp=false
		$Weapon.play("PowerDown")
		await $Weapon.animation_finished
		$Weapon.play("Idle")
