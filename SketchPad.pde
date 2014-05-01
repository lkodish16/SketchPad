// draw a pixel, and make it blink to indicate that it is the cursor. *
// add direction variables, so the player can move the cursor around. *
// press the A button to light up the pixel the cursor is standing on. When the cursor moves onto another pixel, the pixel that it was standing on remains lit. 
// press the B button while standing on a pixel to reset that pixel and have it no longer be lit.
// create a custom color maker that starts at full-on (255,255,255) and have the cursor (which starts out at full-on) also act as the custom color maker.
// if player holds down the A button and presses (or holds) down the Left button, the red RGB value increases.
// if player holds down the A button and presses (or holds) down the Up button, the green RGB value increases.
// if player holds down the A button and presses (or holds) down the Right button, the blue RGB value increases.
// if player holds down the A button and presses (of holds) down the Down button, then all RGB values decrease.
// if player holds down the B button and presses (or holds) down the Left button, the red RGB value decreases.
// if player holds down the B button and presses (or holds) down the Up button, the green RGB value decreases.
// if player holds down the B button and presses (or holds) down the Right button, the blue RGB value decreases.
// if player holds down the B button and presses (or holds) down the Down button, then all RGB values decrease.
// player can remove cursor from screen (if they want to admire their artwork without seeing the blinking dot) by pressing A and B buttons at the same time. They can bring the cursor back by doing the same thing.
// find a way for the player to save their drawing.


#include <MeggyJrSimple.h>  // required code, line 1 of 2.

void setup() {
  MeggyJrSimpleSetup();  // required code, line 1 of 2.
}

int xcoord = 4;  // initial x-coordinate of cursor.
int ycoord = 4;  // initial y-coordinate of cursor.
boolean lit = false;


void loop() {
  DrawPx(xcoord,ycoord,15);
  EditColor(CustomColor0, 255,255,255);
  moveCursor();
  checkLimits();
  DisplaySlate();
  ClearSlate();
  delay(100);
}

void moveCursor() {  // use direction buttons to move cursor.
  CheckButtonsPress(); 
  CheckButtonsDown();
  
  if (Button_Up) {  // increases y-coordinate of cursor if Up button is pressed.
    ycoord++;
  }
  if (Button_Down) {  // decreases y-coordinate of cursor if Down button is pressed.
    ycoord--;
  }
  if (Button_Right) {  // increases x-coordinate of cursor if Right button is pressed.
    xcoord++;
  }
  if (Button_Left) {  // decreases y-coordinate of cursor if Left button is pressed.
    xcoord--;
  }
}

void checkLimits() {  // contains cursor within the boundaries of the 8x8 screen.
  if (xcoord > 7) {  // cursor can't go past the right side of the screen.
    xcoord = 7;
  }
  if (xcoord < 0) {  //  cursor can't go past the left side of the screen.
    xcoord = 0;
  }
  if (ycoord > 7) {  // cursor can't go past the top side of the screen.
    ycoord = 7;
  }
  if (ycoord < 0) {  // cursor can't go past the bottom side of the screen.
    ycoord = 0;
  }
}





 




    
      
  






