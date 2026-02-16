extends CharacterBody3D
class_name Player

var can_move: bool = false
var axis: Vector2
var rot: Vector3
var angle: float

#Variables para el doble salto
var jump_count: int = 0
const MAX_JUMPS: int = 1

const SPEED = 12
const GRAVITY = 2
const JUMP = 30

func _process(_delta):
	# Si estamos en el suelo, reiniciamos el contador de saltos
	if is_on_floor():
		jump_count = 0
		
	match can_move:
		true:
			motion_ctrl()

func _input(event):
	#Lógica del salto
	if event.is_action_pressed("ui_accept"):
		# Saltamos si estamos en el suelo O si llevamos menos saltos que el máximo
		if is_on_floor() or jump_count < MAX_JUMPS:
			velocity.y = JUMP
			jump_count += 1 # Sumamos un salto al contador
			$AudioJump.play()
			
			#Si es el segundo salto y quieres reiniciar la animación para que se note
			if jump_count > 1:
				$AnimationPlayer.stop()
				$AnimationPlayer.play("Jump")

func get_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()
	
func motion_ctrl() -> void:
	velocity.x = get_axis().x * SPEED 
	velocity.y -= GRAVITY
	velocity.z = get_axis().y * -SPEED 
	
	if not get_axis().x == 0 or not get_axis().y == 0:
		angle = atan2(get_axis().x, -get_axis().y)
		rot = get_rotation()
		rot.y = angle
		set_rotation(rot)
	move_and_slide()
	
	match is_on_floor():
		true:
			if not get_axis().x == 0 or not get_axis().y == 0:
				$AnimationPlayer.play("Run")
				$GPUParticles3D.emitting = true
			else:
				$AnimationPlayer.play("Idle")
				$GPUParticles3D.emitting = false
		false:
			if velocity.y > 0:
				$AnimationPlayer.play("Jump")
				$GPUParticles3D.emitting = false
			
func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Wave":
			can_move = true
