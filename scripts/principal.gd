extends Node2D
## Estação: solta a horda de fantasmas, mostra o placar e decide o fim da partida.

@export var cena_inimigo: PackedScene
## Máximo de fantasmas na estação ao mesmo tempo.
@export var max_fantasmas: int = 6

var abates := 0

@onready var horda: Timer = $Horda
@onready var relogio: Timer = $Relogio
@onready var mundo: Node2D = $Navegacao/Mundo
@onready var jogador := $Navegacao/Mundo/Jogador
@onready var saida: Area2D = $Navegacao/Mundo/Saida
@onready var texto_vida: Label = $HUD/Vida
@onready var texto_tempo: Label = $HUD/Tempo


func _process(_delta: float) -> void:
	texto_vida.text = "Vida: %d   Abates: %d" % [jogador.vida, abates]
	if saida.visible:
		texto_tempo.text = "A saída abriu!"
	else:
		texto_tempo.text = "Tempo: %d" % ceil(relogio.time_left)


func inimigo_morreu(_inimigo: Node2D) -> void:
	abates += 1


func _on_horda_timeout() -> void:
	# Estação cheia: só nasce outro fantasma quando algum for derrotado.
	if get_tree().get_nodes_in_group("inimigo").size() >= max_fantasmas:
		return

	var inimigo := cena_inimigo.instantiate()
	# Vai para dentro do Mundo para entrar no y-sort junto com o jogador e os objetos.
	mundo.add_child(inimigo)
	inimigo.global_position = $Nascedouros.get_children().pick_random().global_position

	# A horda aperta: cada inimigo chega um pouco mais cedo que o anterior.
	horda.wait_time = max(2.5, horda.wait_time * 0.98)


# Fuga: aguentou o tempo, a saída aparece e passa a perceber o jogador.
func _on_relogio_timeout() -> void:
	saida.visible = true
	saida.monitoring = true


func _on_saida_body_entered(_body: Node2D) -> void:
	vencer()


# call_deferred: troca de cena só no fim do quadro, quando a física terminou.
func vencer() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/vitoria.tscn")


func perder() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/derrota.tscn")
