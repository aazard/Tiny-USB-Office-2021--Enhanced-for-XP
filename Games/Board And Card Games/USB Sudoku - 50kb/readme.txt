USB Sudoku Pre-Alpha Release # 2 - Usage

Following is a list of the keyboard and mousing actions available in-game:

o Navigating around the grid (highlighting a specific cell) (keyboard):
  o Left, right, up, and down arrow keys will move the cell "cursor" by single
    cell increments, wrapping as necessary (up/down do not wrap, left/right will
    wrap unless the cell cursor is within the top-left or bottom-right cell)
  o Tab will move the cell cursor "forward" by a sub-grid, wrapping as
    necessary)
  o Shift tab will move the cell cursor "backward" by a sub-grid (wrapping as
    necessary)
  o Home will move the cell cursor to the top-left     cell
  o End  will move the cell cursor to the bottom-right cell

o Navigating around the grid (highlighting a specific cell) (mouse):
  o Left single-click on a cell will highlight it
  o You may also left double-click or right single-click as noted below

o Setting a highlighted cell to a specific number (keyboard):
  o Use the 0-9 keys (0 clears a cell)
  o The space bar will run a cell through the lowest available value within its
    sub-grid, up to the highest available, wrapping as necessary
  o Enter will bring up a context menu from which you can choose from various
    cell settings (0-9, mark as possible emphasized/de-emphasized, unmark as
    possible, etc.)
  o The "context menu" button will mimic the Enter key action

o Setting a highlighted cell to a specific number (mouse):
  o Left double-click will run a cell through the lowest available value
    within its sub-grid, up to the highest available, wrapping as necessary
  o Right single-click will bring up a context menu from which you can select
    a number to be entered, or select 0 (clear) to "blank out" the cell
  o Left single-click followed by a delayed left single-click will mimic the
    right single-click action (the delay must be longer than the system's
    double-click time)

o Marking/unmarking a cell "possible" number (keyboard):
  o Shift   1-9 will toggle a cell's possible number mark (emphasized)
  o Control 1-9 will toggle a cell's possible number mark (de-emphasized)
  o + followed by a number will mimic the "shift   + 1-9" action
  o - followed by a number will mimic the "control + 1-9" action
  o For the +N and -N actions, the key sequences =N and _N are equivalent to
    the +N and -N actions, respectively

o Marking/unmarking a cell "possible" number (mouse):
  o Right single-click will bring up a context menu from which you can choose
    to mark or unmark a number (check mark or unmark as appropriate and then
    select the possible number for the action)
  o Left single-click followed by a delayed left single-click will mimic the
    right single-click action (the delay must be longer than the system's
    double-click time)

Following is a list of the keyboard shortcut keys available for specific
actions:

o L   - Load     game (re-loads the last saved game's settings and grid)
o S   - Save     game (this also automatically occurs when quitting)
o P   - Previous game
o N   - Next     game
o D   - Random   game
o U   - Enter    game #
o R   - Restart  game
o ESC - Quit USB Sudoku
o B   - Restart  game using beginner difficulty level
o E   - Restart  game using easy     difficulty level
o M   - Restart  game using medium   difficulty level
o H   - Restart  game using hard     difficulty level
o X   - Restart  game using extreme  difficulty level
o A   - Adjust   game difficulty levels
o C   - Check    game for errors
o V   - Show     game's blank cell's possible values
o F1  - Help  box
o A   - About box

Left single-click on the status bar's time pane will toggle it between the
current local time and the current game's elapsed time.

You may replace the toolbar icons by placing the appropriate icon file in the
USB Sudoku startup directory (these are given in the same order that they
appear on the toolbar, from left to right):

o exit.ico       - Quit USB Sudoku
o prev.ico       - Previous game
o next.ico       - Next     game
o restart.ico    - Restart  game
o solve.ico      - Solve    game
o difficulty.ico - Changing and selecting difficulty level settings
o check.ico      - Check    game for errors
o possibles.ico  - Show     game's blank cell's possible values

You may replace the puzzle grid bitmaps by placing the appropriate bitmap file
in the USB Sudoku startup directory:

o cellempty.bmp - non-highlighted cell with no number assigned to it yet
o cellfixed.bmp - non-highlighted cell that was uncovered prior to game start
o cellhlite.bmp - highlighted cell (the cell that is currently "active")
o cellsolve.bmp - the background for all cells when the game is won
o cellcheck.bmp - a cell marked as empty    when the "Check game" toggle is on
o cellerror.bmp - a cell marked as in error when the "Check game" toggle is on
