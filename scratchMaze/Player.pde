class Player {
  PVector position;
  PVector previousPosition;
  PVector size = new PVector(5, 5);
  int scale;
  LinkedList<PVector> previousPositions;

  Player(PVector position) {
    this.position = position;
    previousPosition = position;
    previousPositions = new LinkedList();
    scale = 1;
  }

  Player copy() {
    return new Player(this.position.copy());
  }

  void move() {
    previousPosition = position.copy();
    previousPositions.add(position.copy());
  }
  
  int getPositionX() {
    return floor(player.position.x - imagePosition.x);
  }
  
  int getPositionY() {
    return floor(player.position.y - imagePosition.y);
  }

  void moveUp() {
    move();
    position.add(new PVector(0, -scale));
    if (collision && path.get(floor(getPositionX() + (player.size.x/2)), getPositionY()) == black) {
      position.y = previousPosition.y;
    }
    if (previousPositions.size() > 10) {
      println("removing");
      previousPositions.remove(0);
    }
  }

  void moveDown() {
    move();
    position.add(new PVector(0, scale));
    if (collision && path.get(floor(getPositionX() + (player.size.x/2)), floor(getPositionY() + player.size.y)) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveLeft() {
    move();
    position.add(new PVector(-scale, 0));
    if (collision && path.get(getPositionX(), floor(getPositionY() + (player.size.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void moveRight() {
    move();
    position.add(new PVector(scale, 0));
    if (collision && path.get(floor(getPositionX() + player.size.x), floor(getPositionY() + (player.size.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void collide(PImage path) {
    boolean touchUp = path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black;
    boolean touchRight = path.get(floor(player.position.x + player.size.x), floor(player.position.y + (player.size.y/2))) == black; 
    boolean touchDown = path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black; 
    boolean touchLeft = path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black; 

    if (touchRight || touchLeft ) {
      position.x = previousPosition.x;
    }
    if (touchUp || touchDown ) {
      position.y = previousPosition.y;
    }
  }

  void draw() {
    noStroke();
    fill(238, 130, 238);
    rectMode(CORNER);
    rect(position.x, position.y, size.x, size.y);
  }
}
