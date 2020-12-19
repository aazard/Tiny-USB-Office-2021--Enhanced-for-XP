Registry Commander
------------------

Main Features
-------------
- Copy or Rename/Move entire keys and values from one key to another.
- Cut or Copy keys and values from one place and paste them into another.
- A column that displays the size in bytes of a value's data.
- Supports all 12 data types, defined in the "winnt.h" header file. Most other registry editors only handles Strings, Binary, DWord, Expanded Strings and sometimes also MultiString.
- Allows you to bookmark keys or values so you can access them more quickly. Comments can be associated with each bookmark.
- Search part of or the entire registry database, not only can you search by a keyword, but you can also search by size or data type.
- Change a value's data type. I.e. you can change a string into a binary value, without changing the content of the data.
- Ability to interpret one value for another, without modifying the data. This would allow you to view a string saved as a binary value or vice versa.
- With the reg:// protocol, you can create links to a specific key in the registry, it works the same way as http:// does.
- A history list has been added, to allow a quick jump from current key to a previously key.

Option Description
------------------
<Query Detailed Key Information>
Will show details such as number of subkeys and values as well as last modification time of keys.
Doing this slows things down a bit, so if you are looking to speed up the registry listing, disable this option.
Turning it off works especially well for HKEY_CLASSES_ROOT, which has a lot of subkeys.

<Enable reg:// Protocol>
This option will cause a registry link like "reg://HKEY_CURRENT_USER\Software\Microsoft\" to be opened in Registry Commander.

<Access the 64-bit Registry using KEY_WOW64_64KEY>
Registry Commander is a 32-bit application, and will thus normally just access the 32-bit registry.
Using this option however, it's possible to view the 64-bit from a 32-bit program.
Keyboard Shortcut: Ctrl + D

Shortcut Keys
-------------
Ctrl + D				Toggle the "Query 64-bit Registry" option
Alt + F7				Open Search Dialog
Alt + F1				Root List
Ctrl + W				Exit Registry Commander
Ctrl + \				Jump to Current Root
Alt + Down				History List
Space					Show size of selected key
Shift + Alt + Enter		Show size of all keys
Alt + F10				Display popup menu
Shift + Enter			Open key in a new Registry Commander instance

Icon Libraries (ICL)
--------------------
It is possible to customise how the data and key icons appears using an icon library.
Currently, three libraries are included: "default.icl", "squares.icl" and "regedit.icl".
To change the active icon library, open up the configurations on the Visual tab and open up the Icon Library drop down and pick one.
If you're making an icon library, data icons should have the ID's 0x100 to 0x10B and the key and up "folders" should have 0x10C and 0x10D respectively.
Feel free to send any custom ICL this way if you wish to see it included in the official releases.

Registry Commander Changes | 2015 Feb 15
----------------------------------------
- Fixed an issue with sorted bookmarks. Any action done when a list was sorted, would not act on the correct item.