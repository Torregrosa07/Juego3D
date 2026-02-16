extends Camera3D # Debe extender de Camera3D [cite: 48]

# Variable exportada para asignar al jugador desde el editor 
@export var player : CharacterBody3D 

func _ready():
	# Establece la altura inicial en 9 unidades 
	position.y = 9

func _process(_delta):
	# Sigue al jugador en el plano horizontal [cite: 51]
	position.x = player.position.x
	# Mantiene una distancia de seguridad de 10 unidades atrás [cite: 52]
	position.z = player.position.z + 10
