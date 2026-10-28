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
