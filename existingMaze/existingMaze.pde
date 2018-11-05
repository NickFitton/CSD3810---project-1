import http.requests.*;

PImage path;

/*
CONFIG PARAMETERS
 */
boolean loopActions = false; // If true, loops back to the first action in the queue once queue is complete
int speed = 1; // If 1, goes slowly, if 2 completes an action every frame, if 3 completes all actions in first frame, default is to act as 1
int actionStepLength = 16; // Dictates the stride of the entity, the smaller the number, the less it moves per action


/*
OTHER PARAMETERS
 */
boolean holdUp = false;
boolean holdRight = false;
boolean holdDown = false;
boolean holdLeft = false;

boolean playing = false;

color black = color(0, 0, 0);
Block[] actions;
int actionPosition;
PShape pauseShape;
PShape arrow;
PShape greenArrow;

Player player;
Actions actions;

void setup() {
  actions = new Block[0];
  addMovement("right");
  addMovement("down");
  addMovement("left");
  addMovement("down");
  Block[] ifBlocks = new Block[1];
  try {
    ifBlocks[0] = new Movement("right");
  } 
  catch (IOException e) {
    println("Not a valid movement");
  }
  addIf(new CanMoveRight(), ifBlocks);
  actionPosition = 0;
  
  smooth();
  frameRate(120);
  size(800, 663);
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


  pauseShape = createShape();
  pauseShape.beginShape();
  pauseShape.fill(0, 255, 0);
  pauseShape.noStroke();
  pauseShape.vertex(0, 0);
  pauseShape.vertex(20, 12.5);
  pauseShape.vertex(0, 25);
  pauseShape.endShape(CLOSE);

  arrow = createShape();
  arrow.beginShape();
  arrow.fill(0);
  arrow.noStroke();
  arrow.vertex(0, 7);
  arrow.vertex(8, 7);
  arrow.vertex(8, 0);
  arrow.vertex(20, 10);
  arrow.vertex(8, 20);
  arrow.vertex(8, 13);
  arrow.vertex(0, 13);
  arrow.endShape(CLOSE);

  greenArrow = createShape();
  greenArrow.beginShape();
  greenArrow.fill(0, 255, 0);
  greenArrow.noStroke();
  greenArrow.vertex(0, 7);
  greenArrow.vertex(8, 7);
  greenArrow.vertex(8, 0);
  greenArrow.vertex(20, 10);
  greenArrow.vertex(8, 20);
  greenArrow.vertex(8, 13);
  greenArrow.vertex(0, 13);
  greenArrow.endShape(CLOSE);
}


void draw() {
  background(230);
  noStroke();
  fill(230);
  fill(0, 255, 0);
  rect(308, 642, 42, 21);
  image(path, 0, 0);
  stroke(0);
  strokeWeight(3);
  line(0, 0, 500, 0);

//  if (actionPosition >= actions.length) {
//    //actionPosition=0;
//    text("No moves left", width/2, height/2);
//  } else {
//    if (actions[actionPosition] instanceof Movement) {
//      switch (actions[actionPosition].actionName) {
//      case "right":
//        if (!(path.get(floor(player.position.x + player.size.x + player.speed), floor(player.position.y + (player.size.y/2))) == black)) {
//          moveRight();
//        } else {
//          actionPosition++;
//        }
//        break;
//      case "down":
//        if (!(path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y) + player.speed) == black)) {
//          moveDown();
//        } else {
//          actionPosition++;
//        }
//        break;
//      case "left":
//        if (!(path.get(floor(player.position.x - player.speed), floor(player.position.y + (player.size.y/2))) == black)) {
//          moveLeft();
//        } else {
//          actionPosition++;
//        }
//        break;
//      case "up":
//        if (!(path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y - player.speed)) == black)) {
//          moveUp();
//        } else {
//          actionPosition++;
//        }
//        break;
//      }
//    }
//  }
//  player.draw();
//
//  //player.move();
//  //player.collide(path);
//  //player.draw();
//}
//
//void addMovement(String type) {
//  try {
//    actions = (Block[]) append(actions, new Movement(type));
//  } 
//  catch (IOException e) {
//    println("Given action was not valid and was not added to the queue");
//  }
//}
//
//void addIf(Query query, Block[] blocks) {
//  
//  actions = (Block[]) append(actions, new DevBlock(actionName));
//  println("WARNING: A dev block is added, this should not happend in demo!!!!");

  if (playing) {
    actions.executeAction();
  }
  player.draw();

  drawActions();
}

void drawActions() {
  pushMatrix();
  translate(660, 20);
  if (playing) {
    noStroke();
    fill(0, 255, 0);
    rect(-8.5, -12.5, 7, 25);
    rect(4.5, -12.5, 7, 25);
  } else {
    shape(pauseShape, 0, 0);
  }
  translate(0, 35);
  shapeMode(CENTER);
  for (int i=0; i<actions.actions.length; i++) {
    pushMatrix();
    switch(actions.actions[i]) {
    case "up":
      rotate(TWO_PI*0.75);
      break;
    case "down":
      rotate(TWO_PI*0.25);
      break;
    case "left":
      rotate(TWO_PI*0.5);
      break;
    default:
    }

    if (actions.currentAction == i) {
      shape(greenArrow, 0, 0);
    } else {
      shape(arrow, 0, 0);
    }
    popMatrix();
    translate(0, 25);
  }
  popMatrix();
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
  if (key == ' ') {
    playing = !playing;
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
