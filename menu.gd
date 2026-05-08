extends Control

#inicia el juego
func _on_botonplay_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/explicacioncontroles.tscn")
	
#salir del juego
func _on_botonsalir_pressed() -> void:
	get_tree().quit()

#cambiar de color un poco al pasar por encima del botonplay
func _on_botonplay_mouse_entered() -> void:
	$MarginContainer/ContenedorBotones/botonplay.modulate = "ffae42"

#volver al color original rl botonplay
func _on_botonplay_mouse_exited() -> void:
	$MarginContainer/ContenedorBotones/botonplay.modulate = "ffffff"

#cambiar de color el otro boton del menu
func _on_botonsalir_mouse_entered() -> void:
	$MarginContainer/ContenedorBotones/botonsalir.modulate = "ffae42"

func _on_botonsalir_mouse_exited() -> void:
	$MarginContainer/ContenedorBotones/botonsalir.modulate = "ffffff"
