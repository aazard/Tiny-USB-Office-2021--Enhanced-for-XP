ROGUE - Exploring the Dungeons of Doom
ABOUT ROGUE

Rogue is an easy game to learn but a difficult one to win. It is played by
issuing commands with the keyboard. For example, to drop an item you would
type 'd', followed by a letter of the alphabet that represents an item you are
holding. Confronting you are 26 types of monsters that become progressively
more formidable, and hidden traps that increase in number, as you descend to
lower levels. The goal of the game is to retrieve the Amulet of Yendor and
ascend with it out of the cave.

GETTING STARTED

Open the file "Config.txt" in a text editor and customize the game by changing
the values following the '=' symbols.

Run the game by executing "ClassicRogue.exe", or "ClassicRogueSafeMode.exe" if
the first doesn't work. Use "-score" on the command line to display the high
score list.

At the title screen type the name you want to use for the current game and
press [Enter], or just press [Enter] or [Esc] to use the default name. If you
have used this name before, and there is a game in progress, it will be played
back to the point where you left off. During playback, using the default
configuration settings, 's' turns on stepping (each move is executed with the
press of a key) and [Esc] accelerates playback by bypassing the display of
each move.

Note that the first eight letters of a name uniquely identify a game in
progress.

GETTING HELP

For help on commands used in the game, type '?'. For help on on-screen
symbols, type '/'. Press [Space] to exit the help screen.

[Space] is also used to continue viewing messages when the word "More" is
displayed.

MOVING

You can move in eight directions:

[Left]       or  'h'  Move left
[Right]      or  'l'  Move right   
[Up]         or  'k'  Move up
[Down]       or  'j'  Move down
[Home]       or  'y'  Move up-left
[Page Up]    or  'u'  Move up-right
[End]        or  'b'  Move down-left
[Page Down]  or  'n'  Move down-right

Hold down [Shift] when typing a direction to keep moving until stopped by an
object, monster, stairway, wall, or door. Hold down [Ctrl] when typing a
direction to keep moving until adjacent to an object, monster, stairway, wall,
door, or branching passage.

FIGHTING

Wield a weapon by typing 'w', then the letter of the weapon you want to wield.
To cancel a command, press [Esc].

Wear armor by typing 'W' (note the capitalization), then the letter of the
armor you want to wear. If you are already wearing armor, take it off by
typing 'T'.

If you are wielding a melee weapon, such as a sword, walk into a monster to
attack it. If it is asleep it will awaken and attack you. If you are wielding
a range weapon, such as a bow, then you can throw arrows or other items at the
monster. To do this, type 't', then a direction, then the letter of the item
you want to throw.

After a battle, it is a good idea to rest to recover lost hit points. Type '.'
to rest one turn.

ITEMS

Along the way, you will find many items to aid or hinder you. The most
important item you will find is the Amulet of Yendor, which you must pick up
and take with you back to the entrance. Most items must be identified, either
by using an Identify scroll, or by using them. You can give some types of
items a name by typing 'c', then the letter of the item.

Walk over an item to pick it up. To walk over an item without picking it up,
type 'g' before moving.

To take an inventory of all the items you're carrying, type 'i'.

Eventually, your inventory will become full. To drop items, type 'd', then the
letter of the item.

To read a scroll, type 'r', then the letter of the scroll. If it turns out to
be a scroll of Identify, type the letter of another item to find out what it
is. Items can have good or bad properties, so it is advisable to find out
what they are before using them. Some items are cursed, and cannot be removed
once used, at least not until the curse is removed.

To drink (quaff) a potion, type 'q', then the letter of the potion.

To put on a ring, type 'P', then the letter of the ring, then the hand you
want to put it on. Type 'l' for left or 'r' for right. Remove a ring by typing
'R', then the hand it is on, if you are currently wearing two rings. Wearing
rings causes you to become hungry faster.

To eat food, type 'e', then the letter of the food. Each time you grow hungry,
you must eat or you will become weak and eventually die of starvation.

To zap a wand, type 'z', then a direction, then the letter of the wand. Wands
have limited charges, so use them wisely.

LEVELS

On each level, you will explore rooms connected by passages. There is also a
stairway going down and up. Until you find the Amulet, you may only travel
downwards--a magical barrier blocks any passage upwards. Type '>' to go down,
and '<' to go up. Each time you descend, you will lose track of the location
of the stairway.

SEARCHING

Type 's' to search the eight squares immediately adjacent to you for hidden
doors, passages, or traps. Until you become more experienced through
fighting, you will need to search multiple times before finding anything. Once
a trap is discovered, you can identify it by standing next to it, typing '^',
then a direction. There will be times when you seem to be trapped with no
passage to the next level. In such cases, there will always be one or more
hidden doors or passages.

QUITTING AND EXITING

Type 'Q' to quit and give up the current game. To exit the game for resuming
later, type [Ctrl x], or close the game window. Enter the same name you used
before at the title screen to resume a previous game. If you die, you will not
be able to go back to a previously saved position. In Rogue, death is
permanent.

ABOUT REC FILES

Files ending in ".rec" record games as they are played in real-time. The game
window can be closed at any time (intentionally or by accident) without the
player needing to worry about saving the game.

The filename for a ".rec" file is determined by taking the first eight
characters of the player's name, replacing any non-alphanumeric characters
with an underscore ('_'), and adding ".rec" at the end. Please note that the
Windows operating system does not distinguish between lower and upper case
letters in filenames.

When a player quits, dies, or wins the game, the ".rec" file is deleted
automatically before the score is recorded. If you would like a permanent copy
of a game, the ".rec" file must be backed up before it is deleted. For
example, if you were at the stairs of the first level with the amulet, a copy
could be made of the current record file ("Player.rec" to "Backup.rec", for
example) before ascending the stairs. After the copy is made, you could then
resume the game to allow the score to be recorded.

A backed up ".rec" file can be shared with others (to confirm a win, for
example). If the file is named "Backup.rec", entering "Backup" as the player's
name will play it back. Setting both PlaybackVisible and StepThroughPlayback
to 1 in the "Config.txt" file will allow each move to be viewed with the press
of a key. Remember that the ".rec" file will still be deleted, and a new score
recorded, when the player quits, dies, or wins.