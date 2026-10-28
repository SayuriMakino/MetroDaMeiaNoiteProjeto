class_name Jogador
extends CharacterBody2D
## Personagem visto de cima: anda nas quatro direções, sem gravidade.

@export var velocidade := 260.0
@export var vida: int = 3

## Última direção em que o jogador andou (vai servir para o ataque).
var direcao_olhar := Vector2.DOWN
var invencivel := false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox


func _process(_delta: float) -> void:
	# Tem inimigo encostando em mim?
	if not invencivel and hurtbox.has_overlapping_bodies():
		levar_dano()


func _physics_process(_delta: float) -> void:
	# get_vector já normaliza: andar na diagonal não fica mais rápido.
	var direcao := Input.get_vector("mover_esquerda", "mover_direita", "mover_cima", "mover_baixo")
	velocity = direcao * velocidade
	move_and_slide()

	if direcao == Vector2.ZERO:
		anim.stop()
		return

	direcao_olhar = direcao
	if abs(direcao.x) > abs(direcao.y):
		if direcao.x > 0:
			anim.play("direita")
		else:
			anim.play("esquerda")
	else:
		if direcao.y > 0:
			anim.play("baixo")
		else:
			anim.play("cima")


func levar_dano() -> void:
	vida -= 1
	if vida <= 0:
		invencivel = true
		get_tree().current_scene.perder()
		return

	# Um segundo de invencibilidade, meio transparente.
	invencivel = true
	modulate.a = 0.4
	await get_tree().create_timer(1.0).timeout
	modulate.a = 1.0
	invencivel = false
