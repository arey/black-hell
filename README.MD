BLACK HELL
==========
Version 1.1  - Copyright (C) 1995 Antoine Rey



Presentation
------------

Black Hell is a 1995 vertical scrolling shooter video game, developed in Turbo Pascal and x86 assembly language.

This Git repository contains :
 - [BIN](BIN): binary and image resources. The place to launch the game: BH.EXE
 - [SRC](SRC): the Turbo Pascal source files. Borland Turbo Pascal uses ASCII CP437 encoding. 
 In order to preserve readability, the source files in this repository were converted to UTF-8 encoding.
 To compile them, you may need to convert them back to CP866 (thanks to [Web Utils](http://www.webutils.pl/Charset-Converter)).
 - [IMG](IMG): some readable images: sprites, artworks, screenshots
 
 
![Black Hell main menu](IMG/BH01.png?raw=true)


Installation
-------------

- Install [DOSBox](https://www.dosbox.com/), the x86 emulator with Microsoft DOS.
- Execute the following command lines:
```
git clone https://github.com/arey/black-hell.git /tmp/black-hell
// Open the DOSBox command line interface 
// For french people, you may switch to the azerty keyboard
keyb fr
mount c: /tmp/black-hell/bin
c:
BH.EXE
```

For 2 players mode, use Ctrl+F12 to increase CPU speed to 7500 cycles.


Screenshots
-----------

![Solo player mode](IMG/SCREENSHOT1P.png?raw=true)

![2 players mode](IMG/SCREENSHOT2P.png?raw=true)

Fench original presentation
---------------------------

Ce progamme est un FREEWARE et est en libre utilisation.
N' hesitez pas à le difuser en le donnant à des amis, le téléchargant sur des BBS, l'envoyant à des revues spécialisées , ... 

C'est le premier (et donc pas le dernier : lisez la suite) du longue série  de jeux en libre circulation de ma concetion.
On peut classer ce jeu comme un  Shoot'em Up (en effet, on doit tirer sur tout ce qui bouge).
La version 2 joueurs est intéressante car je pense qu'on s'amuse plus à 2, et qu'il est  plus intéressant de jouer f
ace à un humain et non contre une intelligence "artificielle" (vive les jeux en réseaux, sur modem ou même, comme le mien,
sur le même écran = l'avenir leur appartient).
J'ai atteint ce niveau en  moins de 2 ans en ayant des "périodes" de programmation sans jamais passer tout mon temps 
sur mon ordinateur. La 1ère année a été plus une année d'initiation à la programmation plus que de programmation 
(à cause de mon  prof de lycée à qui je dédicace cette phrase). La seconde annèe a donc été  une annèe de perfectionement 
et d'application.

Je vise de programmer prochainement une Démo (voir même des démos); j'en profite pour signaler mon admiration aux 
Démo-Makers tels Future Crew . 
Je souhaite étendre mon expérience personelle à d'autres types de jeux et je prépare un jeu ressemblant (fortement) 
à Zelda (à l'heure où j'écrit le  scénario global est déjà écrit ainsi que l'intro du jeu, l'interface des 
décors et la gestion des persos en est à 60% de leur développement et le jeu devrait sortir avant mi-95).
Je souhaite programmer un logiciel de dessin assez performant sur divers points (exemple : gestion de la palette) 
dont je me suis apperçu avoir besoin lors de getion de sprites et de décors en vue de programmation notement; 
il aura une interface style Deluxe Paint et s'appellera  ? (Surprise). 

Je pense que chaque tentative de programmation est une bonne expérience qui met en pratique nos connaissances : 
faire un jeu (un très très bon)  n'est pas si facile que celà (J'ai mis plusieurs fois des heures à trouver
un bug caché ou un bug du Turbo-Pascal. j'en profite pour raconter une  petite anecdote assez sympathique : 
figurez-vous que lors d'une tentative de programmation, un bug se produisait et faisait sortir du programme en 
bloquant le clavier. C'est après de longues heures de méditations sans succés, que je me suis lancer dans un sorte 
de "J'essaye tout !" et eu enfin la révélation que Turbo Pascal avait quelque part quelque défauts
(et même de nombreux défauts). La solution de  mon problème fut grossièrement de placer à un endroit bien précis 
la commande i:=i; (affectation d'une variable à elle même). "?????!!!!!!"  me direz-vous. "Magique" répondrais-je.

Enfin, je voudrais féliciter tous les petits groupes indépendants qui programment, dessinent, composent, écrivent 
par loisir et diffusent leurs  productions librement. Je suis révolté par tous les jeux commerciaux qui
ont de nombreuses séquences en images de synthèses mais un scénario approximatif, une lenteur phénoménale, 
une interractivité lamentable, une originalité ...
Il faut se mettre dans la tête que tous les jeux en 3D mappée ne sont pas tous formidables et qu'il existe des j
eux sans effets spéciaux sur lesquels  on passe bien plus de temps 
(comparer Phantasmagoria : 2 heures vs Dune 2 : + de 200 heures sans se lasser). Enfin chacun ses goûts. 

Veuillez m'escuser de ne pas avoir fini les différente s options du menu.
Peut-être y seront-ils dans une prochaine version. Cette version de ce jeu ne possède pas la gestion du timer qui lui 
permettrait d'aller à la même vitesse sur tous les PC. En attendant vous pourrez sélectioner avec l'installation la
vitesse de jeu convanable pour votre ordinateur allant de :
- 0..4 du 386 DX 25  au 486 DX 33
- 5.. 50 pour les P90
Vous pourrez de toute manière changer de vitesse en cours de jeu en pressant les touches "-" et "+" du pavé numérique 
pour ralentir ou accélérer le jeu.  Il est possible d'enlever les ombres lors du jeu 1 joueur en appuyant 
sur les touches "Alt D". 

Ouvrages utilisés pour créer ce programme :
- BIBLE PC Programmation System Ed.4 par Michael Tischer de Micro Apllication 
- ASSEMBLEUR Facile  par Philippe Mercier de Marabout Informatique

Utilitaires utilisés :
- TURBO PASCAL V 6.0 et 7.0
- DELUXE PAINT ANIMATION (le meilleur logiciel de dessin à mon goût)
- (POV et 3DS)
- Vistapro 3.12

Configuration nécessaire :
-  486 SX 25 < CPU nécessaire < 486 DX2 66 
-  bonne carte vidéo (VLB ou PCI)
-  2 Mo RAM (XMS)
-  Carte Vesa


Problèmes :
- Si vous avez un problème lors du menu "Options" en SVGA, essayer de lancer un driver pour votre carte vidéo ou lancer le jeu "BH -VGA" 
- Si vous vous ennuyez lorsque vous jouez, faites un "del.", votre problème sera résolu aussi vite que possible.

Je remecie 
- Patrick alias Styx pour tout ce qu'il m'a apris jusqu'à présent sur l'informatique, sans qui vous ne seriez jamais 
entrain de lire ce fichier.
- Jean-Baptiste pour son assistance et ses conseils sur la présentation et l'esthétique de ce jeu.
- Nicolas alias CPC6128 pour ses inlassables discussions délirantes.
- Et tous ceux qui me connaissent et m'apprécient.

A bientôt !

Antoine


Mes jeux préférés :
- Zelda(s)  (1,2 et 3 ansi que celui sur Game-Boy)
- Doom 2
- Dune 2 et Command & Conquer 
- Mario(s)
- Ultima (7,8, Underworld 1 et 2) 
- Worms
- Settlers
