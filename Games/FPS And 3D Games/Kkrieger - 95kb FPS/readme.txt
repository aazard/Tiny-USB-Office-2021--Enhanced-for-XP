
.kkrieger, chapter I - Beta Version 
.a game in 96k 
by .theprodukkt
(released at breakpoint 2004)

www.theprodukkt.com 



1. about .kkrieger
------------------ 

  The project was started two years ago and since then many, many hours of our spare time went 
into developing .kkrieger. Still, in the end we didn´t have time for the most important thing: 
gameplay. So expect some major improvements in our next releases. 
However, we enjoyed making .kkrieger a lot and are quite satisfied with the end result and now we 
are eagerly awaiting your comments :) So if you have any feedback, may it be acclaim, critique or 
bug reports - please feel free to write us. Every email is highly appreciated! 
(No, wait - don´t send us bugs until the final version - we know enough already ;) 

We will definitely release an uncut "final" version with some more kb, enhanced content and less 
bugs, soon. (The first thing we'll do after this release is relax for some time, though :). 

  .kkrieger is designed as a trilogy. At the moment we can not tell if and when we will find the 
time to develop the next chapters, though. We will keep you informed on our homepage... 


2. controls 
----------- 

W - forward 
S - backward 
A - left 
D - right 
[Space] - Jump 
Left mouse - shoot 
1-5 - switch weapon 

Press M1 - M9 to respawn at the different respawn points (also helps when caught in collision ;) 


3. system requirements 
---------------------- 

  .kkrieger requires a relatively high-end machine to run properly. To be
precise: 

- A 1.5GHz Pentium3/Athlon or faster.
- 512MB of RAM (or more)
- A Geforce4Ti (or higher) or ATI Radeon8500 (or higher) graphics card
  supporting pixel shaders 1.3, preferably with 128MB or more of VRAM.
- Some kind of sound hardware
- DirectX 9.0b 

  We've done some testing to ensure it runs on all hardware meeting those
requirements we could get, and we checked it runs on all major supported
configurations with current drivers, but with some graphics card/driver
combinations it might screw up. In case you have problems, please try
getting the most recent driver release from your vendor, and only if the
problem persists contact us (refer to the contact section).


4. detailed credits 
------------------- 

.theprodukkt:
- Thomas "fiver2" Mahlke: Concept, Direction, Textures, Level geometry and lighting. 
- Dierk "Chaos" Ohlerich: Editor, Texture generator, Game, Physics, Collision, 'lekktor'. 
- Christoph "giZMo" Muetze: Character design, Animation, Weapons, Items, Special FX. 
- Fabian "ryg" Giesen: Mesh generator, Material/Lighting systems, 3d Engine, 'kkrunchy'. 

freelancers:
- Sebastian "wayfinder" Grillmaier: Music, Sound design, Sound effects.
- Tammo "kb" Hinrichs: Sound synthesizer.


5. contact 
---------- 

  web site: http://www.theprodukkt.com 
  contact:  fanmail@theprodukkt.com  (fanmail, flames and cooking recipes) 
 

6. disclaimer
-------------

  .kkrieger is freeware. Permission to spread the archive in its original, unmodified
format is generally given, as long as there is no fee charged for .kkrieger itself. We
want to encourage everyone to send the file around, link to it on webpages, and we also
want to allow printed magazines to include .kkrieger on supplementary CDs and similar
media, within the conditions stated in this disclaimer. Public presentation of .kkrieger
is hereby explicitly allowed and encouraged. We require that proper credit is given to
.theprodukkt in all forms of public presentation or publication of .kkrieger.

  .kkrieger comes with absolutely no warranty. It has been carefully written, but still
we can make absolutely no guarantees that .kkrieger runs properly on every configuration.
.theprodukkt can not be made liable for any kind of damage or data loss caused either
directly or indirectly by .kkrieger.


7. technical FAQ 
----------------

  In general, if you have any technical questions concerning .kkrieger, either refer to our 
web site or contact us via email. However past experience shows that there are some rumours 
and misunderstandings about our work that are very hard to correct, so we'll state the truth
here, in written form, for all the world to see :) 

- We do .not. have some kind of magical data compression machine that is able to squeeze
  hundreds of megabytes of mesh/texture and sound data into 96k. We merely store the
  individual steps employed by the artists to produce their textures and meshes, in a very
  compact way. This allows us to get .much. higher data density than is achievable with
  normal data compression techniques, at some expense in artistic freedom and loading times.
- .kkrieger is not written in 100% assembler/machine language. Not even nearly. Like the
  vast majority of game projects being developed today, .kkrieger was mostly written in
  C++, with some tiny bits of assembler where it is actually advantageous (notably, there
  are a lot of MMX optimisations in the texture generator). 
- A kilobyte is, historically, defined to be 1024 (2^10) bytes, not 1000. Thus .kkrieger is
  a game in 96k even though it's actually 98304 bytes. 
- The concept of the texture/mesh generators was developed by fiver2. We do .not. want to
  claim that the techniques we used to develop .kkrieger are new inventions. It´s rather a 
  selection of useful operations and their parameters to optimise the results. 
