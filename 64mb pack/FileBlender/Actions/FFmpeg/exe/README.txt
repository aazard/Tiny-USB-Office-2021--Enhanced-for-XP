These are automated unofficial FFmpeg Win32 builds made by Ramiro Polla.

Automated FFmpeg builds and source code, along with all external libraries'
binaries and source code, and developer packages with include and lib files,
and all build instructions can be found at:
    http://ffmpeg.arrozcru.org/autobuilds

If you experience any problems with this build, please report them to:
http://ffmpeg.arrozcru.org/forum

FFmpeg revision number: 18709
swscale revision number: 29241
FFmpeg license: GPL

FFmpeg configuration:
--enable-memalign-hack
--prefix=/mingw
--cross-prefix=i686-mingw32- --cc=ccache-i686-mingw32-gcc
--target-os=mingw32 --arch=i686 --cpu=i686
--enable-avisynth
--enable-gpl
--enable-zlib
--enable-bzlib
--enable-libgsm
--enable-libfaac
--enable-libfaad
--enable-pthreads
--enable-libvorbis
--enable-libtheora
--enable-libspeex
--enable-libmp3lame
--enable-libopenjpeg
--enable-libxvid
--enable-libschroedinger
--enable-libx264

gcc:
Using built-in specs.
Target: i686-mingw32
Configured with: ../configure --target=i686-mingw32 --disable-nls --enable-languages=c,c++ --prefix=/usr
Thread model: win32
gcc version 4.2.4

binutils:
GNU ld (GNU Binutils) 2.19

mingw32-runtime:
3.15.2

w32api:
3.13

nasm:
NASM version 2.03.01 compiled on Jun 19 2008

yasm:
yasm 0.7.1.2093
Compiled on Jul 12 2008.
Copyright (c) 2001-2008 Peter Johnson and other Yasm developers.
Run yasm --license for licensing overview and summary.


Extra libraries included:
zlib 1.2.3
    http://www.zlib.net/
bzip2 1.0.5
    http://www.bzip.org/
libgsm 1.0.13
    http://kbs.cs.tu-berlin.de/~jutta/toast.html
libfaac 1.28
    http://www.audiocoding.com/
libfaad2 2.7
    http://www.audiocoding.com/
pthreads-win32 CVS 10/01/2009 02:11
    http://sourceware.org/pthreads-win32/
libvorbis 1.2.0
    http://www.xiph.org/
libtheora 1.0
    http://www.xiph.org/
speex 1.2rc1
    http://www.xiph.org/
lame 3.98.2
    http://lame.sourceforge.net/
libopenjpeg 1.3
    http://www.openjpeg.org/
xvidcore 1.2.1
    http://www.xvid.org
liboil 0.3.16
    http://liboil.freedesktop.org
libschroedinger 1.0.6
    http://diracvideo.org/
libx264 0.67.1139 1024283
    http://www.videolan.org/developers/x264.html
SDL 1.2.13
    http://www.libsdl.org/
