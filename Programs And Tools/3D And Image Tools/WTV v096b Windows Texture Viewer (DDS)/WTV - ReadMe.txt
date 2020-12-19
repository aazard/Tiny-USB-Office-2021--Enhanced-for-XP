WTV - DDS file viewer

Overview
--------
WTV was developed for simple and fast DDS viewing, especially for those DDS files with alpha channel,
because there were no free or even commercial viewers/browsers that could show an image modulated by it's alpha channel.

Supported DDS pixel formats
---------------------------
* 8888
* 888
* 565
* 555
* 1555
* 4444
* DXT1/A
* DXT3
* DXT5
* DXT5_NM
* V8U8
* x8 ( G8, B8 not tested yet )
* R16F
* G16R16F
* A16B16G16R16F
* R32F
* G32R32F
* A32B32G32R32F
* ATI1N, ATI2N
* G16R16
* R11G11B10F
* BC6H_UF16

Supported map types
-------------------
* 2D
* Cube
* Volume

Installation
-----------
Copy WTV.EXE to a permanent destination (e.g. C:\Utils\Wtv\ in my case)
From version 0.58b, you can associate WTV with DDS files through the menu option "Help->Associate DDS file with WTV"
If it doesn't work, try manual association. This way has been tested with WinXP:
- right click on any DDS file
- select "Open With"
- select "Choose program..."
- click on "Browse" button and find the WTV app.
- click on "Open" button
- check "Always use the selected program to open this kind of file"
- click on "OK" button

How to use WTV
--------------
The fastest way of using WTV is to associate it with DDS files.
Then, simply double-click or press enter on any DDS file to view it.
Another way is to use Drag&Drop or the good old "File->Open..."
By default, the image will be modulated by it's alpha channel ( if there is one ).
If you want to disable that function, press "U" or click on menu->options->Use alpha channel.
Background color is pink by default ( can be changed ), so transparent pixels will be pink.
To view alpha channel only press "A" or click on menu->options->Show alpha channel.
You can browse through all DDS files in the same folder by the mouse wheel rotation, up/down or pgup/pgdn keys.
+/- keys or mouse wheel zooms the image. When the mouse cursor is changed to drag, the image is bigger than window and can be moved
by right-mouse button + mouse move.
Left/right keys change current mipmap and Z/X keys change current side/layer for cube/volume maps.
Image opened in WTV window can by Drag&Dropped to another program (E.g. Photoshop, Paint.net etc.) 

Control keys overview
---------------------
Up/Down, PgUp/PgDn -> previous/next picture
Home -> first picture in the folder
End -> last picture in the folder
Delete -> deletes current file and move to the next one
Mouse wheel -> previous/next picture or zoom. Depends on settings
Left/Right -> change mipmap
+/- -> zoom in / zoom out
* -> reset zoom to 100%
A -> show/hide alpha channel. Use alpha to blend if any other channel is shown.
R -> show/hide red channel
G -> show/hide green channel
B -> show/hide blue channel
U -> show just alpha or RGB
B -> specify background color
C -> ON/OFF window clipping to nearest monitor work area
Z/X -> change side (cube maps) or change layer (volume maps)
Right mouse button press + mouse move -> move image that is bigger than the window
CTRL/SHIFT +/- -> scales RGB values on supported pixel formats (currently BC6H-UF16 only)
CTRL/SHIFT * -> reset scale to the detected base = 1/(maxLum - minLum)

Status bar information
----------------------
Type - is fixed to DDS in current version.
Format - pixel format of the current DDS file
Size - size of the current file mipmap
Layer/Side - LAYER = current volume layer / layer count, SIDE = current cube map side / sides used
MipMap - current mipmap / mipmap count
Mem - memory used by current mipmap / memory used by all mipmaps together

FAQ
---
1)	Q: WTV is runnig, but doens't appear on screen.
		A: It is usually rendered offcreen. Please delete (or set to 0) saved registry key (HKEY_CURRENT_USER\Software\Woody's Texture Viewer\WindowPos)

Contact
-------
Tomas (Woody) Blaho
woodypwx@gmail.com

!! Any suggestions will be appreciated. !!
