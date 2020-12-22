PERMISSION NOTICE:


You are allowed to create your own graphical modifications based on UnReal World tiles under these simple terms:

1. You are not allowed to use these tiles or create modifications of them for any other game/project than UnReal World.
2. Modifications based on these UnReal World tiles can be used with UnReal World game only. 

If you distribute modified tiles that are based on or derivate works of UnReal World tiles include the following
permission notice within your work in reasonable manner:

"This work contains modifications based on UnReal World tiles and may be used with UnReal World game only. 
 Using these tiles in any way for any other game/project is forbidden."

***

TILE FORMAT:

* Tiles must be in .png format, and the filename extension .png written in lower-case. 

* Tiles in grouped as follows:

  av-*.png -- animals
  npc-*.png -- NPCs
  ter-*.png -- terrain tiles (trees, walls, ground etc.)
  gui-*.png and cur-*.png -- graphical user interface and cursor tiles
  pc-*.png - character avatars
  The rest are items, plants etc. 

* Maximum tilename length excluding the extension is 12 characters. 
  Exception to this rule are npc and avatar tiles which have maximum length 10 of character excluding the extension.

* Background color (which appears transparent in action) is not fixed and is derived from the upper left pixel (0,0). 
  Don't use image built-in transparency, but just make sure that the upper left pixel is of the color 
  you want to be transparent.

* Each tile has 1 pixel border area around the actual tile. Looking at vanilla tiles you'll see the border area 
  sometimes containing marker pixels or lines. The border area can contain anything, it's not drawn. Just remember
  that the upper left pixel (0,0) is of the background color.

* Tile size can vary. It can be 16x16, 32x32 or 64x64 depending on how large canvas is required. With 1 pixel
  border are the actual canvas sizes are 18x18, 34x34 and 66x66. 

* Tile center where (the upright items meet the ground) is in the middle of the tile. 
  With 32x32 tiles the center is at 16x16, and so on.


***

PLANT TILES:

Plant tiles have multiple columns as follows. See vanilla plants (flo-*.png or ber-*.png) and you'll get the idea.
Column 0 is the first column on the left. 

0 - harvestable part.
   For mushrooms it's the mushroom. For root vegetables and root producing plants it's the root.
  
1 - young sprout, or berry shrub/bush after the winter

2 - growing plant, more than 30 days old
    berry shrubs are flowering now, flowers have little buds and so on. 

3 - fully grown plant
    for flowering plants the flowers are blooming now
    for berry shrubs the berries are ripe now.
    for grain crops the grains are starting to ripen, but not harvestable yet.

4 - past flowering plant 
    for seed producing flowering plants there are seeds now
    for flowering but not seed producing plants the flowers have withered
    for root vegetables and berry shrubs just copy tile no 3 here.
    for grain crops the crops is fully ripened and harvestable now.
  
5 - picked or withered plant
    berry shrubs: grown plant without berries (e.g. use tile no 3 but remove the berries)
    other plants, the grown stalk without leaves/flowers (tile no 3 or 4 edited)

6 - leaves of the plant (if it yields any)

7 - seeds of the plant (if it yields any)

8 - flowers of the plant (if it yields any)

***

NPC AND ANIMALS TILES:

These have multiple columns as follows. See vanilla tiles (av-*.png or npc-*.png) and you'll get the idea.

0-7   - Walking creature. 
        Tile format allows creatures to drawn to eight facing directions, if you want to go for that then
        the directions are:  e, ne, n, nw, w, sw, s, se
        To go with easy 2-facing directions then it's: e, e, w, w, w, w, e, e
8-9   - fallen/sleeping/dead creature facing east and west.
10    - tracks
11-18 - Swimming creature. Rules for facing directions are the same as with walking tile.

***

