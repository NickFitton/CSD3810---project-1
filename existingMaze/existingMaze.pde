PImage path;

/*
CONFIG PARAMETERS
 */
boolean loopActions = false; // If true, loops back to the first action in the queue once queue is complete
int speed = 2; // If 1, goes slowly, if 2 completes an action every frame, if 3 completes all actions in first frame, default is to act as 1
int actionStepLength = 16; // Dictates the stride of the entity, the smaller the number, the less it moves per action


/*
OTHER PARAMETERS
 */
boolean holdUp = false;
boolean holdRight = false;
boolean holdDown = false;
boolean holdLeft = false;

color black = color(0, 0, 0);

Player player;
Actions actions;

void setup() {
  frameRate(120);
  size(642, 663);
  path = loadImage("path.png");
  player = new Player(new PVector(325, 630));
  actions = new Actions();
  try {
    /* 
     This string of actions moves the entity from the start to the exit
     Comment this out of you want to control the entity initially
     */
    actions.addMovements("left", "up", "left", "up", "right", "right", "right", "up", "up", "right", "right", "right", "up", "up", "up", "right", "down", "right", "down", "left", "down", "down", "right", "down", "down", "down", "right", "up", "right", "down", "right", "up", "right", "down", "right", "up", "right", "up", "up", "right", "up", "right", "right", "up", "left", "left", "up", "up", "up", "up", "left", "down", "left", "left", "up", "right", "up", "right", "right", "up", "left", "up", "right", "up", "left", "up", "left", "down", "left", "left", "up", "left", "left", "down", "down", "left", "up", "up", "left", "down", "left", "up", "up", "right", "up", "right", "right", "right", "down", "right", "up", "up", "left", "up", "left", "down", "left", "left", "left", "down", "left", "down", "down", "down", "left", "up", "up", "up", "left", "up", "right", "right", "up", "up", "left", "down", "left", "left", "left", "up", "left", "left", "left", "up", "left", "left", "left", "down", "left", "up", "up", "left", "up", "up", "up", "right", "up", "left", "up", "up", "up", "right", "right", "up", "left", "up", "left", "up", "up", "right", "right", "up", "left", "left", "up", "right", "right", "right", "right", "up", "right", "up", "left", "left", "down", "left", "left", "up", "left", "left", "left", "left", "up", "right", "up", "up", "right", "right", "right", "down", "right", "right", "down", "right", "up", "right", "right", "right", "right", "right", "up", "left", "up");
  } 
  catch (IOException e) {
    println("Given movement was not valid");
  }
}


void draw() {
  background(255);
  noStroke();
  fill(230);
  rect(0, 642, width, 21);
  fill(0, 255, 0);
  rect(308, 642, 42, 21);
  image(path, 0, 0);

  actions.executeAction();
  player.draw();
  //player.move();
  //player.collide(path);
  //player.draw();
}

void keyPressed() {
  if (keyCode == UP && holdUp == false) {
    holdUp = true;
    try {
      actions.addMovement("up");
    } 
    catch (IOException e) {
      println("Added movement was not valid");
    }
  }
  if (keyCode == RIGHT && holdRight == false) {
    holdRight = true;
    try {
      actions.addMovement("right");
    } 
    catch (IOException e) {
      println("Added movement was not valid");
    }
  }
  if (keyCode == DOWN && holdDown == false) {
    holdDown = true;
    try {
      actions.addMovement("down");
    } 
    catch (IOException e) {
      println("Added movement was not valid");
    }
  }
  if (keyCode == LEFT && holdLeft == false) {
    holdLeft = true;
    try {
      actions.addMovement("left");
    } 
    catch (IOException e) {
      println("Added movement was not valid");
    }
  }

  if (key == 'p') {
    actions.printActions();
  }
}

void keyReleased() {
  if (keyCode == UP) {
    holdUp = false;
  }
  if (keyCode == RIGHT) {
    holdRight = false;
  }
  if (keyCode == DOWN) {
    holdDown = false;
  }
  if (keyCode == LEFT) {
    holdLeft = false;
  }
}
