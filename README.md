 ░█▀▀▀█ ░█▀▀▀ ─█▀▀█ 　 ░█▀▀█ ─█▀▀█ ▀▀█▀▀ ▀▀█▀▀ ░█─── ░█▀▀▀ 
 ─▀▀▀▄▄ ░█▀▀▀ ░█▄▄█ 　 ░█▀▀▄ ░█▄▄█ ─░█── ─░█── ░█─── ░█▀▀▀ 
 ░█▄▄▄█ ░█▄▄▄ ░█─░█ 　 ░█▄▄█ ░█─░█ ─░█── ─░█── ░█▄▄█ ░█▄▄▄



For compilation you can use 'make'. And start game with command './main',
or use in path './Runner/main' (mb will do chmod 755 for file).
In game both field filling automatically.
If you play in console (not build in IDE), your console will clearing every step. 
You can off it in settings. 
Also in settings you can off your first step - enemy attack first.


Realization:

1. Menu - can start game, change settings and exit game.

2. Settings - choose who step first, and clear console every step.

3. Fill map - random dot and bool value 'isVertical', if we can't put 
    ship in place, we shift dot while ship is not put.

4. Player - every player has personal map with ship and empty field
    for marks shot.

5. AI - Search in field temp symbol, if not, Randoming dot and check her 
    for empting, if empty - shot there, if hit - place around temp symbol.

6. Color - color print game. And print fields horisontal^^

To Do:

1. Need filling map take out in game class, for print map when manual filling.

2. Need recieve class map on printer.

3. Add manual filling.

4. Refactoring parse and validate user input. + Add exit to menu.

5. Change color in settings, + add possibility choose background for all game.
