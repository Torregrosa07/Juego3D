extends CanvasLayer # [cite: 476]

func _process(_delta):
	$Container/Score.text = "Score: " + str(GLOBAL.score) # [cite: 478]
	
func _on_animation_player_animation_started(anim_name): # 
	match anim_name: # [cite: 481]
		"FadeOut": # [cite: 483]
			get_tree().paused = true # [cite: 484]
			$AudioGameOver.play() # [cite: 484]

func _on_animation_player_animation_finished(anim_name): # [cite: 485]
	match anim_name: # [cite: 487]
		"FadeIn": # [cite: 487]
			get_tree().paused = false # [cite: 487]
			
func _on_audio_game_over_finished(): # [cite: 488]
	get_tree().reload_current_scene() # [cite: 489]
