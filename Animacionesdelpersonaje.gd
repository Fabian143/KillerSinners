extends CharacterBody2D
@export var velocidad: float
@export var lambda:float

@onready var animatedsprite=$AnimatedSprite2D
@onready var ataque1=$Area2D/ataque1
@onready var ataque2=$Area2D/ataque2
@onready var ataque3=$Area2D/ataque3

enum Estado {
	default1,default2,default3,default4
	,caminar1,caminar2,caminar3,caminar4,
	atacar1,atacar2,atacar3,atacar4
}

var estado_actual=Estado.default1
var mirarderecha=false

func _physics_process(delta: float) -> void:
	actualizar_estados()
	movimiento_del_personaje()
	actualizar_animaciones()
	move_and_slide()


func actualizar_estados():
	if(Input.is_action_pressed("Move_Down")):
		estado_actual=Estado.caminar1
	elif(Input.is_action_just_released("Move_Down")):
		estado_actual=Estado.default1
			
	if(Input.is_action_pressed("Move_Up")):
		estado_actual=Estado.caminar2
	elif(Input.is_action_just_released("Move_Up")):
		estado_actual=Estado.default2
			
	if(Input.is_action_pressed("Move_Right")):
		estado_actual=Estado.caminar3
	elif(Input.is_action_just_released("Move_Right")):
		estado_actual=Estado.default3
			
	if(Input.is_action_pressed("Move_Left")):
		estado_actual=Estado.caminar4
	elif(Input.is_action_just_released("Move_Left")):
		estado_actual=Estado.default4
	
	if(Input.is_action_pressed("Atacar")):
		#para atacar segun la dirección de movimiento
		if(estado_actual==Estado.default1 ):
			estado_actual=Estado.atacar1
		elif(estado_actual==Estado.default2 ):
			estado_actual=Estado.atacar2
		elif(estado_actual==Estado.default3 ):
			estado_actual=Estado.atacar3
		elif(estado_actual==Estado.default4):
			estado_actual=Estado.atacar4
			
	elif(Input.is_action_just_released("Atacar")):
		#para el estado parado despues de dejar de atacar
		if(estado_actual==Estado.atacar1):
			estado_actual=Estado.default1
		elif(estado_actual==Estado.atacar2):
			estado_actual=Estado.default2
		elif(estado_actual==Estado.atacar3):
			estado_actual=Estado.default3
		elif(estado_actual==Estado.atacar4):
			estado_actual=Estado.default4
	
func movimiento_del_personaje():
	var velocidadaux=velocidad
	#correr
	if(Input.is_action_pressed("Correr")):
		velocidadaux=velocidad*lambda
	elif(Input.is_action_just_released("Correr")):
		velocidadaux=velocidad
		
	#movimiento hacia arriba
	if(estado_actual==Estado.caminar1):
		velocity=Vector2(0,velocidadaux)
		
	#movimiento hacia abajo
	elif(estado_actual==Estado.caminar2):
		velocity=Vector2(0,-velocidadaux)
		
	#movimiento hacia la izquierda
	elif(estado_actual==Estado.caminar3):
		velocity=Vector2(velocidadaux,0)
	
	#movimiento hacia la derecha
	elif(estado_actual==Estado.caminar4):
		velocity=Vector2(-velocidadaux,0)
		
	#detener movimiento cuando esta quieto
	elif(estado_actual==Estado.default1 || estado_actual==Estado.default2 ||estado_actual==Estado.default3 || estado_actual==Estado.default4):
		velocity=Vector2(0,0)
		
	#detener movimiento cuando esta atacando
	elif(estado_actual==Estado.atacar1 || estado_actual==Estado.atacar2 || estado_actual==Estado.atacar3 || estado_actual==Estado.atacar4):
		velocity=Vector2(0,0)
		
	#movimiento diagonal
	if(Input.is_action_pressed("Move_Down") && Input.is_action_pressed("Move_Right")):
		velocity=Vector2(velocidadaux,velocidadaux)
	if(Input.is_action_pressed("Move_Down") && Input.is_action_pressed("Move_Left")):
		velocity=Vector2(-velocidadaux,velocidadaux)	
	if(Input.is_action_pressed("Move_Up") && Input.is_action_pressed("Move_Left")):
		velocity=Vector2(-velocidadaux,-velocidadaux)	
	if(Input.is_action_pressed("Move_Up") && Input.is_action_pressed("Move_Right")):
		velocity=Vector2(velocidadaux,-velocidadaux)	


func actualizar_animaciones():
	ataque1.disabled=true
	ataque2.disabled=true
	ataque3.disabled=true	
	match estado_actual:
		
		#parado hacia al frente
		Estado.default1:
			animatedsprite.play("default1")
			
		#parado hacia atras
		Estado.default2:
			animatedsprite.play("default2")
			
		#parado izquierda
		Estado.default3:
			mirarderecha=false
			animatedsprite.play("default3")
			
		#parado derecha
		Estado.default4:
			mirarderecha=true
			animatedsprite.play("default3")
			
		#caminar hacia al frente	
		Estado.caminar1:
			animatedsprite.play("Caminar1")
			
		#caminar hacia atras
		Estado.caminar2:
			animatedsprite.play("Caminar2")
			
		#caminar izquierda
		Estado.caminar3:
			if(mirarderecha):
				scale.x*=-1
			mirarderecha=false
			animatedsprite.play("Caminar3")
			
		#caminar derecha
		Estado.caminar4:
			if(!mirarderecha):
				scale.x*=-1
			mirarderecha=true
			animatedsprite.play("Caminar3")
			
		#atacar hacia el frente
		Estado.atacar1:
			ataque1.disabled=false
			animatedsprite.play("Atacar1")
			
		#atacar hacia atras
		Estado.atacar2:
			ataque2.disabled=false
			animatedsprite.play("Atacar2")

			
		#atacar hacia la izquierda
		Estado.atacar3:
			ataque3.disabled=false
			mirarderecha=false
			animatedsprite.play("Atacar3")
	
			
		#atacar hacia la derecha
		Estado.atacar4:
			mirarderecha=true
			ataque3.disabled=false
			animatedsprite.play("Atacar3")
	
			
