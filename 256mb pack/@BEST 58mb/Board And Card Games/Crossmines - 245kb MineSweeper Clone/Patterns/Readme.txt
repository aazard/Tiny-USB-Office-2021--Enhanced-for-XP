This readme.txt describes the format of the Pattern files (*.pat)

For help on Crossmines, see http://www.johnvalentine.co.uk/k00006.html
_ _ _

Contents:
1. About the registered IDs
2. Line by line, the .pat file format
3. Characters used in the Pattern Grid
_ _ _

1. About the Registered IDs.

Line 1 (Registered ID)
Registered IDs must be unique to the pattern you design.are very easy to obtain, and you don't have to give any information.
Registered IDs are allocated at http://www.johnvalentine.co.uk/m00011a.html


2. Line by line, the .pat format is as follows:

Line   Field               Example data
 1     Registered ID       1
 2     Author              John Valentine (comp-sci)
 3     Title               4 and 8
 4     Description         All squares. Some have 4 neighbours, some have 8 neighbours.
 5     Rec Field Size X    48
 6     Rec Field Size Y    48
 7     Large Grid Size X   12
 8     Large Grid Size Y   12
 9     Repeat Size X       10
10     Repeat Size Y       10
11+ Large Grid Line  1     ......5555..
    Large Grid Line  2     ,,....5555..
    Large Grid Line  3     2222335555..
    Large Grid Line  4     2222335555..
    Large Grid Line  5     2222444411..
    Large Grid Line  6     2222444411..
    Large Grid Line  7     ..8844447777
    Large Grid Line  8     ..8844447777
    Large Grid Line  9     ..6666997777
    Large Grid Line 10     ..6666997777
    Large Grid Line 11     ..6666......
    Large Grid Line 12     ..6666......


3. Characters used in the Pattern Grid

The Pattern grid defines the shapes of the cells in the Crossmines minefield.
In the above example, you can see a block of '2's (4 wide, 4 high). When numbers
are grouped together like this, it means that a larger cell is formed from 
squares having the same number. To the right of the 4x4 block of '2's is a 2x2 block of '3's, and a 4x4 block of
'4's.

You will need a different number for each cell within the pattern. For cells
bigger than 1 square (as all the cells are in the above example), start with
the number '1'. After '9', start at 'A', and continue to 'Z'. This gives you 36
cells, which should be enough.

You can use other characters for other purposes:

0  Use this to signify a cell that is a single square (1x1 in size). You can use
   several '0' squares, and each will become a different cell.

.  The pattern is 'stamped' across the minefield, and full stops '.' are used to
   denote 'transparency', where the other side of the pattern will interlock.
   The 'Repeat Size' fields set the spacing of the 'stamping' across the minefield,
   Where shapes do not fully tessellate, holes will be left.

-  Use this to signify a hole. Holes play no part in the minefield, and are simply
   inaccessible and give no information to the player. These holes are the same as
   the holes created by the New Game option 'Holes'.

#  Denotes a Bridge. This helps overcome a shortcoming of the square geometry
   of Crossmines. When the player hovers over a cell adjacent to a Bridge, the
   Bridge will always be included as part of that cell. The file 'BigHex.pat'
   uses # to enable four hexagons to meet at a square.

_ _ _

[end]