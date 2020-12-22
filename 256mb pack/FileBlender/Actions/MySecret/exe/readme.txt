MySecret Blowfish Encryption Utility

Version 3.1.1 Released 9 June 2007.

TO INSTALL

    1. Copy the file MYSECRET.EXE into a directory on your PC's path,
       e.g. C:\Windows or C:\WINNT
    2. That's it!
    
SYNTAX

Usage: MySecret [OPTIONS] [-p password] [[-i] infile [[-o] outfile]]
OPTIONS:
-?|-h display this Help
-e|-d force Encrypt/Decrypt
-n do Not ask to confirm password
-w Warn before overwriting existing outfile
-2 use v2.0 algorithm (no compression)
-@ use stdin/stdout pipes if in/outfile not given
-L display licence conditions
EXAMPLES:
MySecret                (=clipboard-mode, prompts for password)
MySecret -p "my pass phrase"
MySecret infile outfile (=file-mode)
MySecret -@ infile      (output to stdout)
MySecret -@ -o outfile  (input from stdin)
MySecret -@             (input from stdin/output to stdout)
For more information go to <http://www.di-mgt.com.au/mysecret.html>

TERMS AND CONDITIONS

MySecret is copyright (C) 2002-7 DI Management Services Pty Ltd, all rights
reserved. MySecret is freeware. Install and use entirely at your own risk. This
Program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. By using the Program YOU EXPRESSLY AGREE to these
conditions. If you do not agree to these conditions, DO NOT USE THE PROGRAM.

THE PROGRAM

MySecret.exe is written in ANSI C and has been compiled using Microsoft Visual
C++ 5.0. The first version was published on 8 February 2002.    

Report bugs to <www.di-mgt.com.au>.
===
Copyright (C) 2002-7 DI Management Services Pty Limited ABN 78 083 210 584 
Sydney, Australia. www.di-mgt.com.au. All rights reserved.
