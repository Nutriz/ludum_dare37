# Ludum Dare 37
## Theme : One Room

![screen](https://lut.im/yTMMrqQXVY/rhOMY58SX0LA8h85.png)

**A 3D fps puzzle game prototype.** Escape the room.

## Installation

This game uses the [Godot Engine](http://godotengine.org), a free/libre 2D and
3D game engine. You can import this folder (once downloaded or cloned) using the
Project Manager.

**Note that this game *requires* Godot engine 2.0 or superior to be run.**

**Binaries will come after.**

## How to play

- <kbd>Mouse movement</kbd> : Look around
- <kbd>W/A/S/D</kbd> or <kbd>Z/Q/S/D</kbd> or <kbd>↑/←/↓/→</kbd> : Move
- <kbd>Space</kbd> or <kbd>Space</kbd> : Jump
- <kbd>Escape</kbd> : Go to main menu

## Asset sources

You can find my asset sources in
[ludum_dare37/src_3d_mesh path](https://github.com/Jerome67000/ludum_dare37/tree/master/src_3d_mesh).

## License

Copyright (c) 2016 Nutr1z
Code licensed under the MIT license, see [LICENSE.md](LICENSE.md).
OpenSans font under Apache 2.0 license.


-------
## French brainstorming


### Thème : One room

* Style : puzzle game
* DA : black and white
* 3D avec godot engine

#### Game Design :
Le joueur est dans une toute petite pièce, et il doit arriver à lancer une balle à travers une ouverture dans un mur de la pièce, s’il y arrive, la pièce s'agrandit et le niveau se modifie.

A chaque niveau la gravité, le poids de la balle et sa capacité à rebondir peut varier.

Pour que l'effet "One room" se fasse ressentir, il faudrait que les murs s'éloignent avec une animation d'un level à l'autre, et que les objets apparaissent en Fade in.


#### "Histoire" :
Le joueur se retrouve enfermé dans une petite pièce style prison. Un message "Si tu arrives à lancer cette balle dans l'ouverture, tu es libre" s'affiche (explication reste à trouver). Mais une fois la chose faites, un message "tu croyais que c'était aussi simple ?" s'affiche et un autre niveau se génère etc etc pour au final à la fin du jeu faire un dé zoom vu du dessus qui montre encore pleins de niveaux, et qu'il n'arrivera jamais à sortir de sa prison.

#### Technique :
* Vue FPS à la première personne
* Souris pour regarder autour
* flèches directionnelles ou QZSD/AWSD pour déplacer le perso
* Possibilité de sauter ? -> OUI si pas trop de taff

### Idéé:
* Rajouter quelque chose pour la persistance, pour que le joueur voie qu'il reste toujours dans la même pièce
