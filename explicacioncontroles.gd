extends Control
@onready var labelz=$Label2
@onready var t=$Timer

func _ready() -> void:
	labelz.visible=false
	t.start()
		
func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("interaccion")):
		get_tree().change_scene_to_file("res://Escenas/Nivel1.tscn")
		
func _on_timer_timeout() -> void:
	labelz.visible=true
