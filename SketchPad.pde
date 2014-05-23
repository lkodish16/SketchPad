// draw a pixel, and make it blink to indicate that it is the cursor. *
// add direction variables, so the player can move the cursor around. *
// press the A button to stamp the pixel the cursor is standing on. When the cursor moves onto another pixel, the pixel that it was standing on remains lit. *
// create a custom color maker that and have the cursor also act as the custom color configurer. *
// the cursor can move on to other already lit pixels and still keep its color. *
// pressing the B button cycles through the available colors. Dark is included for those who want to erase a previously drawn pixel.
// if player holds down the A button and presses (or holds) down the Left button, the red RGB value increases. *
// if player holds down the A button and presses (or holds) down the Up button, the green RGB value increases. *
// if player holds down the A button and presses (or holds) down the Right button, the blue RGB value increases. *
// if player holds down the B button and presses (or holds) down the Left button, the red RGB value decreases. *
// if player holds down the B button and presses (or holds) down the Up button, the green RGB value decreases. *
// if player holds down the B button and presses (or holds) down the Right button, the blue RGB value decreases. *


#include <MeggyJrSimple.h>  // required code, line 1 of 2. 

void setup() {
  MeggyJrSimpleSetup();  // required code, line 1 of 2.
  Serial.begin(9600);
}

int xcoord = 4;  // starting x-coordinate of cursor.
int ycoord = 4;  // starting y-coordinate of cursor.
int counter = 2;  // counter for blink method. 
int savedColor;  // holds the value of the color of the last pixel the cursor was standing on. 
int colorCounter = 1;  // for changing the color of the cursor.

int dotArray[][64] = {{0,0,0,0,0,0,0,0},  // array that holds integer values for the color of every one of the 64 pixels.
                      {0,0,0,0,0,0,0,0},
                      {0,0,0,0,0,0,0,0},
                      {0,0,0,0,0,0,0,0},
                      {0,0,0,0,0,0,0,0},
                      {0,0,0,0,0,0,0,0},
                      {0,0,0,0,0,0,0,0},
                      {0,0,0,0,0,0,0,0}
};


                                                                               
void loop() {
  for (int i = 0; i < 8; i++) {  // draws all of the pixels saved onto to myArray.
    for (int j = 0; j < 8; j++) {
      DrawPx(i,j, myArray[i][j]);
    }
  } 
  moveCursor();  // can move the cursor with the directional buttons.
  checkLimits();  // contains cursor within the boundaries of the 8x8 screen.
  colorConfig();  // changes color of cursor
  blink();  // blinks the cursor.
  stamp();  // if A is pressed, send the coordinates and the color of the cursor to the corresponding spot in myArray.
  DisplaySlate();
  ClearSlate();
  delay(150);
  counter = counter+1;  
}

void blink() {  // blinks the cursor.
  if (counter % 4 == 0) {  // blinks the custom color is counter is even.
    DrawPx(xcoord,ycoord, savedColor);
  } 
  else {
    DrawPx(xcoord,ycoord, colorCounter);  // otherwise blinks the color of the pixel it's standing on. 
  }
}

void moveCursor() {  // use direction buttons to move cursor.
  CheckButtonsDown(); 
  
  if (!Button_B && Button_Up) {  // if up button is pressed, and B button isn't being pressed, move cursor up one. 
    savedColor = ReadPx(xcoord, ycoord+1);  // holds the color of the pixel the cursor is moving from.
    ycoord = ycoord + 1;
  }  
  if (!Button_B && Button_Down) {  // if down button is pressed, and B button isn't being pressed, move cursor down one. 
    savedColor = ReadPx(xcoord, ycoord-1);
    ycoord = ycoord - 1;
  } 
  if (!Button_B && Button_Right)  { // if right button is pressed, and B button isn't being pressed, move cursor one to the right. 
    savedColor = ReadPx(xcoord+1, ycoord);
    xcoord = xcoord + 1;
  } 
  if (!Button_B && Button_Left){  // if left button is pressed, and B button isn't being pressed, move cursor one to the left.
    savedColor = ReadPx(xcoord-1, ycoord);
    xcoord = xcoord - 1;
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

void colorConfig() {  // pressing B cycles through 9 colors. 
    if (Button_B) {  
      colorCounter = colorCounter + 1;  
      DrawPx(xcoord,ycoord, colorCounter);  // the value of colorCounter corresponds to a color. 
    }
    if (colorCounter == 8) {  // instead of dimRed, draw full on.
      colorCounter = 15;
    }
    if (colorCounter == 16) {  // after full on, draw dark. Dark can be used to delete a dot. 
      colorCounter = 0;
    }
}

void stamp() {  // if A is pressed, send the coordinates and the color of the cursor to the corresponding spot in myArray. 
  if (Button_A) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        myArray[xcoord][ycoord] = ReadPx(xcoord,ycoord);
      }
    }
  }
}
  
  



    


  
  

    







 




    
      
  






