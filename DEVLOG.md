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

## Aula 10 — Inimigo que contorna obstáculos e o ataque

O que fiz:
- Criei a `Navegacao` (NavigationRegion2D) e coloquei dentro dela as camadas do TileMap (Chao, Detalhes e o Mundo com os Objetos). Desenhei o contorno do mapa e fiz o Bake: o chão livre ficou com buracos nas paredes, bancos e objetos.
- O fantasma ganhou um NavigationAgent2D (Path e Target Desired Distance em 4). Agora ele calcula a rota e dá a volta nos objetos, em vez de empurrar a parede.
- Ataque: ação `atacar` no Espaço, uma Area2D `Ataque` em volta da protagonista (Mask só na camada 3) e um clarão branco (`Golpe`) que aparece por 0,1 s. Entre um golpe e outro há 0,4 s de recarga.
- O fantasma tem vida 1 e some ao levar o golpe; a estação conta os abates e o HUD mostra "Vida" e "Abates".
- Objetivo do meu tipo (Fuga): quando o relógio de 60 s acaba, a porta de saída aparece no canto de cima, à esquerda, e o HUD avisa "A saída abriu!". Encostando nela, vence.

O que travou:
- A camada Objetos precisava ficar dentro do Mundo por causa do y-sort (a protagonista passar atrás/na frente dos objetos), mas a Navegacao só enxerga a colisão do que está dentro dela.
- Os meus personagens e tiles são de 48 px, bem maiores que os do exemplo da aula, então os valores da folha ficavam pequenos.

Como resolvi:
- Coloquei o Mundo inteiro dentro da Navegacao, junto com o Chao e os Detalhes. O y-sort continua funcionando e a navegação enxerga os objetos.
- Aumentei o Agent Radius para 16 (a colisão do fantasma é um quadrado de 24 px) e o raio do ataque para 40, com o clarão de 80 x 80.
- Com o fantasma desviando dos obstáculos, não dava para aguentar os 60 s: a horda soltava uns 87 fantasmas. Deixei a horda mais leve: começa com 1 fantasma a cada 3 s (antes 2 s), acelera 3% por fantasma (antes 5%) e para em 1 a cada 1,5 s (antes 0,5 s). São uns 30 fantasmas na partida. Também deixei os fantasmas mais lentos: velocidade de 100 para 70.
- Ainda aparecia fantasma demais. Diminuí de novo: o primeiro sai depois de 4 s, a horda acelera só 2% por fantasma e para em 1 a cada 2,5 s. Também coloquei um limite (`max_fantasmas`, 6): com 6 fantasmas na estação, só nasce outro quando algum for derrotado.