PImage path;

/*
CONFIG PARAMETERS
 */
boolean loopActions = false; // If true, loops back to the first action in the queue once queue is complete
int speed = 1; // If 1, goes slowly, if 2 completes an action every frame, if 3 completes all actions in first frame, default is to act as 1
int stepCount = 16; // Dictates the stride of the entity, the smaller the number, the less it moves per action


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
  frameRate(120);
  size(800, 663);
  path = loadImage("path.png");
  player = new Player(new PVector(325, 630));
  actions = new Actions();

  ForLoop loopB = new ForLoop(new Block[0], 2);
  loopB.addBlock(new Left());
  loopB.addBlock(new Up());

  ForLoop loopA = new ForLoop(new Block[0], 2);
  loopA.addBlock(new Up());
  loopA.addBlock(loopB);

  actions.addBlock(loopA);
  actions.addBlock(new Up());
}


void draw() {
  background(230);
  noStroke();
  fill(230);
  fill(0, 255, 0);
  rect(308, 642, 42, 21);
  image(path, 0, 0);

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
  for (Block block: blocks) {
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
      ellipse(0,0,20,20);
      translate(20,0);
      try {
        drawBlocks(block.getSubBlocks()); 
      } catch (IOException e) {
        println("[ERROR]: Given for loop did not have sub blocks");
      }
      translate(-20, 0);
      break;
    default:
    }
  }
}
