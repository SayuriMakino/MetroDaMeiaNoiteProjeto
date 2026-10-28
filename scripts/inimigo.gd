extends CharacterBody2D
## Fantasma que persegue o jogador pela estação.

@export var velocidade: float = 100.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	var jogador := get_tree().get_first_node_in_group("player") as Node2D
	if jogador == null:
		return

	velocity = global_position.direction_to(jogador.global_position) * velocidade
	move_and_slide()

	# Vira o fantasma para o lado em que ele está andando.
	if abs(velocity.x) > abs(velocity.y):
		anim.play("direita" if velocity.x > 0 else "esquerda")
	else:
		anim.play("baixo" if velocity.y > 0 else "cima")
