extends CharacterBody2D
## Fantasma que persegue o jogador pela estação, contornando os obstáculos.

@export var velocidade: float = 70.0
@export var vida: int = 1

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var agente: NavigationAgent2D = $NavigationAgent2D


func _physics_process(_delta: float) -> void:
	var jogador := get_tree().get_first_node_in_group("player") as Node2D
	if jogador == null:
		return

	# O agente calcula o caminho; o fantasma só anda até o próximo ponto dele.
	agente.target_position = jogador.global_position
	var proximo := agente.get_next_path_position()
	velocity = global_position.direction_to(proximo) * velocidade
	move_and_slide()

	# Vira o fantasma para o lado em que ele está andando.
	if abs(velocity.x) > abs(velocity.y):
		anim.play("direita" if velocity.x > 0 else "esquerda")
	else:
		anim.play("baixo" if velocity.y > 0 else "cima")


func levar_golpe() -> void:
	vida -= 1
	if vida <= 0:
		get_tree().current_scene.inimigo_morreu(self)
		queue_free()
