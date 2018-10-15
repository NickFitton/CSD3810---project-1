PImage path;

boolean holdUp = false;
boolean holdRight = false;
boolean holdDown = false;
boolean holdLeft = false;

color black = color(0, 0, 0);
      
Player player;

void setup() {
  size(642, 663);
  path = loadImage("path.png");
  player = new Player(new PVector(5, 5));
}


void draw() {
  background(255);
  noStroke();
  fill(230);
  rect(0, 642, width, 21);
  fill(0, 255, 0);
  rect(308, 642, 42, 21);
  image(path, 0, 0);

  player.move();
  player.collide(path);
  player.draw();
}

void keyPressed() {
  if (keyCode == UP) {
    holdUp = true;
  }
  if (keyCode == RIGHT) {
    holdRight = true;
  }
  if (keyCode == DOWN) {
    holdDown = true;
  }
  if (keyCode == LEFT) {
    holdLeft = true;
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
