class_name Jogador
extends CharacterBody2D
## Personagem visto de cima: anda nas quatro direções, sem gravidade.

@export var velocidade := 260.0

## Última direção em que o jogador andou (vai servir para o ataque na aula 09).
var direcao_olhar := Vector2.DOWN

@onready var _mira: Node2D = $Mira


func _physics_process(_delta: float) -> void:
	# get_vector já normaliza: andar na diagonal não fica mais rápido.
	var direcao := Input.get_vector("mover_esquerda", "mover_direita", "mover_cima", "mover_baixo")
	velocity = direcao * velocidade
	move_and_slide()

	if direcao != Vector2.ZERO:
		direcao_olhar = direcao
		_mira.rotation = direcao_olhar.angle()
