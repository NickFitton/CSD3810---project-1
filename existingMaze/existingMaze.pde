PImage path;

/*
CONFIG PARAMETERS
 */
boolean loopActions = false; // If true, loops back to the first action in the queue once queue is complete
int speed = 1; // If 1, goes slowly, if 2 completes an action every frame, if 3 completes all actions in first frame, default is to act as 1
int stepCount = 15; // Dictates the stride of the entity, the smaller the number, the less it moves per action
boolean collision = true;
boolean showMaze = true;

/*
OTHER PARAMETERS
 */
boolean holdUp = false;
boolean holdRight = false;
boolean holdDown = false;
boolean holdLeft = false;

boolean playing = true;

color black = color(0, 0, 0);
PShape pauseShape;
PShape arrow;


Actions actions;
Player player;

void setup() {
  smooth();
  frameRate(10);
  size(800, 663);
  path = loadImage("path.png");
  player = new Player(new PVector(325, 630));
  actions = new Actions();

  InfiniteLoop infLoop = new InfiniteLoop();
  
  IfElse elseIf = new IfElse();
  elseIf.setQuery(new CanGoUp());
  elseIf.addBlock(new Up());
  elseIf.addElseBlock(new Left());
  infLoop.addBlock(elseIf);
  //infLoop.addBlock(new Left());

  ////
  //ForLoop loop2 = new ForLoop(2);
  //loop2.addBlock(new Right());
  //ForLoop otherLoop2 = new ForLoop(2);
  //otherLoop2.addBlock(new Left());
  //infLoop.addBlocks(new Up(), new Up(), loop2, new Down(), new Down(), otherLoop2);
  //actions.addBlock(infLoop);
  ////

  ////
  //If newIf = new If();
  //infLoop.addBlock(newIf);
  //newIf.setQuery(new CanGoUp());
  //newIf.addBlock(new Up());
  //infLoop.addBlock(new Left());
  ////

  actions.addBlock(infLoop);

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
}


void draw() {
  background(230);
  noStroke();
  fill(230);
  fill(0, 255, 0);
  rect(308, 642, 42, 21);
  if (showMaze) {
    image(path, 0, 0);
  }

  if (playing) {
    try {
      actions.execute();
    } 
    catch (IOException e) {
      noLoop();
      println("[ERROR] Pointed at an invalid block");
      println("[ERROR] Pointer at: ", actions.pointer.pointer);
    }
  }
  player.draw();

  actions.printActions(660, 20);
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
  ellipseMode(CENTER);
  drawBlocks(actions.blocks);
  popMatrix();
}

void drawBlocks(Block[] blocks) {
  for (Block block : blocks) {
    translate(0, 20);
    switch(block.action) {
    case "up":
      rotate(TWO_PI*0.75);
      shape(arrow, 0, 0);
      break;
    case "down":
      rotate(TWO_PI*0.25);
      shape(arrow, 0, 0);
      break;
    case "left":
      rotate(TWO_PI*0.5);
      shape(arrow, 0, 0);
      break;
    case "for":
      ellipse(0, 0, 20, 20);
      translate(20, 0);
      try {
        drawBlocks(block.getSubBlocks());
      } 
      catch (IOException e) {
        println("[ERROR]: Given for loop did not have sub blocks");
      }
      translate(-20, 0);
      break;
    default:
    }
  }
}
