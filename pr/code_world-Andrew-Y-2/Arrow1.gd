extends Label

func _ready():
	
#	update_fireball()
	set_process(true)
	pass

#func update_fireball():
func _process(delta):
	if global.throwFire >= 0:
		set_text("x" + str(global.throwFire))