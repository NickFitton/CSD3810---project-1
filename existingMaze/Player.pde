class Player {
  PVector position;
  PVector previousPosition;
  PVector size = new PVector(5, 5);
  int speed = 1;

  Player(PVector position) {
    this.position = position;
    this.previousPosition = position;
  }

  void draw() {
    rectMode(CORNER);
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(position.x, position.y, size.x, size.y);
  }

  void move() {
    previousPosition = position.copy();
    if (holdUp) {
      player.position.y = player.position.y - player.speed;
    }
    if (holdRight) {
      player.position.x = player.position.x + player.speed;
    }
    if (holdDown) {
      player.position.y = player.position.y + player.speed;
    }
    if (holdLeft) {
      player.position.x = player.position.x - player.speed;
    }
  }

  void collide(PImage path) {
    boolean touchUp = path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black;
    boolean touchRight = path.get(floor(player.position.x + player.size.x), floor(player.position.y + (player.size.y/2))) == black; 
    boolean touchDown = path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black; 
    boolean touchLeft = path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black; 

    print(touchUp);
    print(touchRight);
    print(touchDown);
    print(touchLeft);
    println();

    if (touchRight || touchLeft ) {
      position.x = previousPosition.x;
    }
    if (touchUp || touchDown ) {
      position.y = previousPosition.y;
    }
  }
}
