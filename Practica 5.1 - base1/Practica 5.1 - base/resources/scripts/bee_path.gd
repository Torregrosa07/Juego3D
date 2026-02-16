extends Path3D # [cite: 138]

@export var speed : int = 5 # [cite: 139]

func _process(delta): # [cite: 141]

	$PathFollow3D.progress += speed * delta #
