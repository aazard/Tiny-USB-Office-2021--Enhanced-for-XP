You can create your own maps by downloading Tiled Map Editor ( http://www.mapeditor.org/ ).

Setup: After installing Tiled Map Editor, go to menu option Edit->Preferences, and change "Store tile layer data as:" to "CSV" (this is the only encoding currently supported).

To edit an existing map, simply load the tmx file.

To create a new map, go to File->New. The options should be set as follows:
    Orientation: set to Orthogonal.
    Map size width, height: whatever you want the size of the game world to be.
    Tile size width, height: both set to 64.

You then need to add a tileset for the terrain. Go to Map->Add External Tileset, and select the "Conquests Tiles.tsx" file (in conquests/data/maps/).

You can then use Tiled to create your world by painting the terrain onto the map.

Save the map in conquests/data/maps/, and it will be available in the game. You can also save in the following locations in your user space:
* On Windows, in "%APPDATA%\conquests\usermaps"
* On Linux, in $HOME/.config/conquests/usermaps
These locations are also where maps are stored when you save the map whilst playing a game in Conquests. (Note, if you want to edit these saved maps in Tiled Map Editor, you'll need to copy the files "Conquests Tiles.tsx" and "terrain_tiles.png" to the usermaps folder.)

Notes:

* Any squares left blank are assumed to be Ocean.
* Make sure that there are enough land (non-mountain) squares to allow for starting places for all the civilizations.
* At the moment, all maps are assumed to be "round" rather than "flat". (May change in future.)
* Bonuses are allocated randomly on the map, and can't be specified yet. (May change in future.)

If you create some interesting maps, feel free to send them to me so I can include them with the game.
