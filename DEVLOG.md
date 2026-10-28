## Aula 08 -- 07/10 

O que fiz: a estação de metrô vista de cima com tileset 48x48, paredes com colisão e a personagem andando nas 4 direções.

O que travou:
1. O tileset que gerei com IA não tinha grade: cada tile tinha um tamanho diferente e eles ficavam espalhados, então o Godot não conseguia recortar cada um num tile só.
2. Depois de pintar o chão, apareceram linhas cor de terra entre os tiles e achei que a imagem estava errada.
3. Mesmo sem essas linhas, o piso continuava com um espaço escuro entre os quadrados.

Como resolvi:
1. Com ajuda do Claude (IA), reorganizei a imagem numa grade de 48x48, com os objetos em fundo transparente, e configurei o TileSet com Tile Size 48x48.
2. Descobri que as linhas eram só a grade do editor do Godot, que não aparece no jogo (testei com F5).
3. O espaço escuro era uma borda desenhada dentro de cada tile de piso. Gerei uma versão nova dos pisos sem essa borda e substituí a imagem com o mesmo nome, e o chão pintado se atualizou sozinho.


## Aula 09 — Inimigos, horda, vida e o objetivo do jogo (21/10/2026)

O que fiz:
- Separei as camadas de colisão: 1 mundo, 2 jogador, 3 inimigo.
- Troquei o quadrado azul do jogador pelos sprites da protagonista, com animação nas 4 direções.
- Criei o inimigo: um fantasma que persegue o jogador (grupo `player`). Ele colide com as paredes e com os outros fantasmas, mas atravessa o jogador.
- Horda: 4 pontos de nascimento na estação e um timer que começa em 2 s e diminui 5% a cada fantasma (mínimo de 0,5 s).
- Vida: o jogador tem 3 vidas e uma Hurtbox que percebe o toque dos fantasmas. Depois de levar dano, fica 1 s invencível e meio transparente.
- Fim da partida: telas "Você perdeu!" e "Você venceu!", e o Enter recomeça. Aguentando 60 s, vence.
- HUD com a vida e o tempo restante.

O que travou:
- Os fantasmas ficaram rápidos demais e era quase impossível fugir.

Como resolvi:
- Baixei a velocidade dos fantasmas de 150 para 100. O jogador anda a 260.
