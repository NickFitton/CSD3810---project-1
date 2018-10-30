import http.requests.*;

PImage path;

GetRequest maze;

boolean holdUp = false;
boolean holdRight = false;
boolean holdDown = false;
boolean holdLeft = false;

color black = color(0, 0, 0);

Block[] actions;
int actionPosition;

Player player;

void setup() {
  size(642, 663);
  path = loadImage("path.png");
  player = new Player(new PVector(5, 5));

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
}


void draw() {
  background(255);
  noStroke();
  fill(230);
  rect(0, 642, width, 21);
  fill(0, 255, 0);
  rect(308, 642, 42, 21);
  image(path, 0, 0);
  stroke(0);
  strokeWeight(3);
  line(0, 0, 500, 0);

  if (actionPosition >= actions.length) {
    //actionPosition=0;
    text("No moves left", width/2, height/2);
  } else {
    if (actions[actionPosition] instanceof Movement) {
      switch (actions[actionPosition].actionName) {
      case "right":
        if (!(path.get(floor(player.position.x + player.size.x + player.speed), floor(player.position.y + (player.size.y/2))) == black)) {
          moveRight();
        } else {
          actionPosition++;
        }
        break;
      case "down":
        if (!(path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y) + player.speed) == black)) {
          moveDown();
        } else {
          actionPosition++;
        }
        break;
      case "left":
        if (!(path.get(floor(player.position.x - player.speed), floor(player.position.y + (player.size.y/2))) == black)) {
          moveLeft();
        } else {
          actionPosition++;
        }
        break;
      case "up":
        if (!(path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y - player.speed)) == black)) {
          moveUp();
        } else {
          actionPosition++;
        }
        break;
      }
    }
  }
  player.draw();

  //player.move();
  //player.collide(path);
  //player.draw();
}

void addMovement(String type) {
  try {
    actions = (Block[]) append(actions, new Movement(type));
  } 
  catch (IOException e) {
    println("Given action was not valid and was not added to the queue");
  }
}

void addIf(Query query, Block[] blocks) {
  
  actions = (Block[]) append(actions, new DevBlock(actionName));
  println("WARNING: A dev block is added, this should not happend in demo!!!!");
}

void keyPressed() {
  if (keyCode == UP && holdUp == false) {
    holdUp = true;
    addMovement("up");
  }
  if (keyCode == RIGHT && holdRight == false) {
    holdRight = true;
    addMovement("right");
  }
  if (keyCode == DOWN && holdDown == false) {
    holdDown = true;
    addMovement("down");
  }
  if (keyCode == LEFT && holdLeft == false) {
    holdLeft = true;
    addMovement("left");
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
