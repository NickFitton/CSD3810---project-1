class Player {
  PVector position;
  PVector previousPosition;
  PVector size = new PVector(5, 5);
  int scale;

  Player(PVector position) {
    this.position = position;
    previousPosition = position;
    scale = 1;
  }

  void move() {
    previousPosition = position.copy();
  }

  void moveUp() {
    move();
    position.add(new PVector(0, -scale));
    if (path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveDown() {
    move();
    position.add(new PVector(0, scale));
    if (path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveLeft() {
    move();
    position.add(new PVector(-scale, 0));
    if (path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void moveRight() {
    move();
    position.add(new PVector(scale, 0));
    if (path.get(floor(player.position.x + player.size.x), floor(player.position.y + (player.size.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void draw() {
    rectMode(CORNER);
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(position.x, position.y, size.x, size.y);
  }
}
