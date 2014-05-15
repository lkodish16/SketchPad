// draw a pixel, and make it blink to indicate that it is the cursor. *
// add direction variables, so the player can move the cursor around. *
// press the A button to stamp the pixel the cursor is standing on. When the cursor moves onto another pixel, the pixel that it was standing on remains lit. 
// press the B button while standing on a pixel to reset that pixel and have it no longer be lit.
// create a custom color maker that and have the cursor also act as the custom color configurer. *
// the cursor can move on to other already lit pixels and still keep its color. *
// if player holds down the A button and presses (or holds) down the Left button, the red RGB value increases. *
// if player holds down the A button and presses (or holds) down the Up button, the green RGB value increases. *
// if player holds down the A button and presses (or holds) down the Right button, the blue RGB value increases. *
// if player holds down the B button and presses (or holds) down the Left button, the red RGB value decreases. *
// if player holds down the B button and presses (or holds) down the Up button, the green RGB value decreases. *
// if player holds down the B button and presses (or holds) down the Right button, the blue RGB value decreases. *
// player can remove cursor from screen (if they want to admire their artwork without seeing the blinking dot) by pressing A and B buttons at the same time. They can bring the cursor back by doing the same thing.
// find a way for the player to save their drawing.


#include <MeggyJrSimple.h>  // required code, line 1 of 2.

void setup() {
  MeggyJrSimpleSetup();  // required code, line 1 of 2.
  Serial.begin(9600);
}

int xcoord = 4;  // initial x-coordinate of cursor.
int ycoord = 4;  // initial y-coordinate of cursor.
boolean lit = false;
int dir = 1;
int r = 5;
int g = 5;
int b = 5;
int counter = 2;
int savedColor;

int myArray[][64] = {{0,0,0,0,0,0,0,0},
                     {0,0,0,0,0,0,0,0},
                     {0,0,0,0,0,0,0,0},
                     {0,0,0,0,0,0,0,0},
                     {1,1,2,2,CustomColor1,0,0,0},
                     {0,0,0,0,0,0,0,0},
                     {0,0,0,0,0,0,0,0},
                     {0,0,0,0,0,0,0,0}
};
                  
                     
                               
void loop() {
  DrawPx(3,4, 2);
  DrawPx(2,4, 2);
  DrawPx(1,4, 1);
  DrawPx(0,4, 1); 
  DrawPx(0,5,CustomColor1);
  moveCursor();
  checkLimits();
  colorConfig();
  blink();
  DisplaySlate();
  ClearSlate();
  delay(300);
  counter = counter+1;
}


void blink() {  // blinks the cursor.
  if (counter % 2 == 0) {  // blinks the custom color is counter is even, otherwise blinks the color of the pixel it's standing on. 
    DrawPx(xcoord,ycoord, CustomColor1);
  } 
  else {
    DrawPx(xcoord,ycoord, savedColor);
  }
}

void moveCursor() {  // use direction buttons to move cursor.
  CheckButtonsPress(); 
  CheckButtonsDown();
  
  if ((!Button_A && Button_Up) && (!Button_B && Button_Up)) {  // if up button is pressed, and A button and B button aren't pressed, reassign dir to 0.
    savedColor = ReadPx(xcoord, ycoord+1);
    dir = 0; 
  }  
  if ((!Button_A && Button_Down) && (!Button_B && Button_Down)) {  // if down button is pressed, and A button and B button aren't pressed, reassign dir to 180.
    savedColor = ReadPx(xcoord, ycoord-1);
    dir = 180;

  } 
  if ((!Button_A && Button_Right) && (!Button_B && Button_Right))  { // if right button is pressed, and A button and B button aren't pressed, reassign dir to 90. 
    savedColor = ReadPx(xcoord+1, ycoord);
    dir = 90;
  } 
  if ((!Button_A && Button_Left) && (!Button_B && Button_Left)){  // if left button is pressed, and A button and B button aren't pressed, reassign dir to 270.
    savedColor = ReadPx(xcoord-1, ycoord);
    dir = 270;
  } 
  
  if (dir == 0) {  // increases y-coordinate of cursor if Up button is pressed.
    ycoord = ycoord+1;    // moves the cursor up by one.
    dir = 1;  // resets dir to 1 so the pixel only moves once. 
  }
  if (dir == 180) {  // decreases y-coordinate of cursor if Down button is pressed.
    ycoord = ycoord-1;
    dir = 1;
  } 
  if (dir == 90) {  // increases x-coordinate of cursor if Right button is pressed.
    xcoord = xcoord+1;  // moves the cursor left by one.
    dir = 1;
  }
  if (dir == 270) {  // decreases y-coordinate of cursor if Left button is pressed. 
    xcoord = xcoord-1;
    dir = 1;
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

void colorConfig() {
  EditColor(CustomColor1, r,g,b);
  if (Button_B && Button_Left) {  // increases red RGB value
    r++;
    if (r > 15) {  // caps red at max level of shading.
      r = 15;
    }
  }
  if (Button_B && Button_Up) {  // increases green RGB value.
    g++;
    if (g > 15) {  // caps green at max level of shading.
      g = 15;
    }
  }
  if (Button_B && Button_Right) {  // increases blue RGB value,
    b++;
    if (b > 15) {  // caps blue at max level of shading.
      b = 15;
    }
  }
  
  if (Button_B && Button_Down) {
    r = 0;
    g = 0;
    b = 0;
  }
}
  /*
  
  if (Button_B && Button_Left) {  // decreases red RGB value.
    r--;
    if (r < 0) {  // caps red at min level of shading.
      r = 0;
    }
  }
  if (Button_B && Button_Up) {  // decreases green RGB value.
    g--;
    if (g < 0) {  // caps green at min level of shading.
      g = 0;
    }
  }
  if (Button_B && Button_Right) {  // decreases blue RGB value.
    b--;
    if (b < 0) {  // caps blue at min level of shading.
      b = 0;
    }
  }
}
*/

  
  
  



    


  
  

    







 




    
      
  






