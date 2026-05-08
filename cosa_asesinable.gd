extends Area2D
@onready var muerte=$Personajesentadoamatar
@onready var desaparece=$Timer
@onready var cruz=$AnimatedSprite2D4

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Cristinataca"):
		muerte.play("default")
		desaparece.start()


func _on_timer_timeout() -> void:
	muerte.visible=false
	cruz.visible=false
	get_tree().change_scene_to_file("res://Escenas/finalauxiliarparaenviarproyecto.tscn")
