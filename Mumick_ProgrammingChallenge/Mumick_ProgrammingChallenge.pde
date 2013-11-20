// all the global varibles
PImage galaxy; //background
PImage ufo; // image for UFO

PVector ufo1Pos;
PVector ufo1Speed;
PVector ufo2Pos;
PVector ufo2Speed;
float scaleGalaxy = .20; //.25; // resize the background
float scaleUfo = .05; // resize the UFO
boolean showUFO1 = true; // keeps track of whether UFO 1 appears or not 
boolean showUFO2 = true; // keeps track of whether UFO 2 appears or not 

int levelNumber = 1;
int penaltyNumber = 0;

// void setup() 
// sets up the image, no inputs, returns nothing
void setup() {
  // set up background
  galaxy = loadImage("galaxy.jpg");
  galaxy.resize(int(galaxy.width * scaleGalaxy), int(galaxy.height * scaleGalaxy));

  //set size of screen
  size(galaxy.width, galaxy.height);

  // set the UFOs
  // load images for UFO
  ufo = loadImage("ufo.png");
  ufo.resize(int(ufo.width * scaleUfo), int(ufo.height * scaleUfo));
  // initial setup for UFO 1
  ufo1Pos = new PVector(random(ufo.width, width-ufo.width), random(ufo.height, height-ufo.height));
  ufo1Speed = new PVector(2, 2); 
  // initial setup for UFO 2
  ufo2Pos = new PVector(random(ufo.width, width-ufo.width), random(ufo.height, height-ufo.height));
  ufo2Speed = new PVector(1, 1); 

  // show the level number
  textAlign(CENTER);
  textSize(72);
  fill(255, 0, 0);
  text("Level " + levelNumber, width / 2, height / 2);
  //  }
}

// void draw()
// called frame, no inputs, returns nothing
void draw() {
  // draw background

  background(galaxy);
  //whever mouse is clicked, background flashes white
  if (mousePressed) {
    background(255);
  }
  //if more than 10 penalties, game is over
  if (penaltyNumber >= 10) {
    textAlign(CENTER);
    textSize(72);
    text("Game Over: Level " + levelNumber, width / 2, height / 2);
    return;
  }
  //level number is displayed in center of screen
  textAlign(CENTER);
  textSize(72);
  text("Level " + levelNumber, width / 2, height / 2);
  textSize(50);
  textAlign(LEFT);
  text("Penalty: " + penaltyNumber, 20, 50);
  // draw UFO 1 if it should be shown
  if (showUFO1) {
    move(ufo1Pos, ufo1Speed, 1);
  }
  // draw UFO 2 if it should be shown
  if (showUFO2) {
    move(ufo2Pos, ufo2Speed, 2);
  }


  // if both UFOs are no longer on screen, put them back and make their speed faster
  if (!showUFO1 && !showUFO2) {
    levelNumber += 1;
    background(galaxy);
    int initialTime = millis();
    textAlign(CENTER);
    textSize(72);
    fill(255, 0, 0);


    //    while (millis() - initialTime <= 2000) {}
    ufo1Pos = new PVector(random(ufo.width, width-ufo.width), random(ufo.height, height-ufo.height));
    ufo2Pos = new PVector(random(ufo.width, width-ufo.width), random(ufo.height, height-ufo.height));
    ufo1Speed = new PVector(ufo1Speed.x + random(1, 2), ufo1Speed.y + random(1, 2));
    ufo2Speed = new PVector(ufo2Speed.x + random(1, 2), ufo2Speed.y + random(1, 2));
    showUFO1 = true;
    showUFO2 = true;
  }
}

// void move(int xImg, int yImg, int speed.xImg, int speed.yImg, _________)
// move the image on screen
void move(PVector position, PVector speed, int ufoNum) {
  // change x position
  position.x += speed.x;
  // change y position
  position.y += speed.y;

  // if the image is going off screen, reverse the velocities
  if (position.x >= width - ufo.width || position.x <= 0) {
    speed.x *= -1;
  }
  if (position.y >= height - ufo.height || position.y <= 0) {
    speed.y *= -1;
  }

  // set the x and y positions to the global variables so the program remembers the position we are at
  if (ufoNum == 1) {
    ufo1Pos.x = position.x;
    ufo1Pos.y = position.y;
    ufo1Speed.x = speed.x;
    ufo1Speed.y = speed.y;
  } 
  else {
    ufo2Pos.x = position.x;
    ufo2Pos.y = position.y;
    ufo2Speed.x = speed.x;
    ufo2Speed.y = speed.y;
  }

  // draw the new image
  image(ufo, position.x, position.y);
}

// void mousePressed()
// called when mouse is pressed
void mousePressed() {

  // if you click on a ufo, the ufo should dissapear
  if (mouseX >= ufo1Pos.x && mouseX <= ufo1Pos.x + ufo.width && mouseY >= ufo1Pos.y && mouseY <= ufo1Pos.y + ufo.height) {
    showUFO1 = false;
  }
  else if (mouseX >= ufo2Pos.x && mouseX <= ufo2Pos.x + ufo.width && mouseY >= ufo2Pos.y && mouseY <= ufo2Pos.y + ufo.height) {
    showUFO2 = false;
  }
  else {
    penaltyNumber += 1;
  }
}

