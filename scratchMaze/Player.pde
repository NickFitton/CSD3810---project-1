class Player {
  private PVector position;
  private PVector previousPosition;
  PVector size = new PVector(5, 5);
  int scale;
  CanGoUp up;
  CanGoDown down;
  CanGoLeft left;
  CanGoRight right;
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

  boolean canGoUp() {
    for (int i=0; i<stepCount; i++) {
      if (path.get(getPositionX(), floor(getPositionY()-i)) == black ||
        path.get(floor(getPositionX() + player.size.x), floor(player.position.y-i)) == black) {
        return false;
      }
    }
    return true;
  }

  boolean canGoDown() {
    for (int i=0; i<stepCount; i++) {
      if (path.get(getPositionX(), floor(getPositionY() + player.size.y + i)) == black ||
        path.get(floor(getPositionX() + player.size.x), floor(getPositionY() + player.size.y + i)) == black) {
        return false;
      }
    }
    return true;
  }

  boolean canGoRight() {
    for (int i=0; i<stepCount; i++) {
      if (path.get(floor(getPositionX() + player.size.x + i), getPositionY()) == black ||
        path.get(floor(getPositionX() + player.size.x + i), floor(getPositionY() + player.size.y)) == black) {
        return false;
      }
    }
    return true;
  }

  boolean canGoLeft() {
    for (int i=0; i<stepCount; i++) {
      if (path.get(floor(getPositionX() - i), getPositionY()) == black ||
        path.get(floor(getPositionX() - i), floor(getPositionY() + player.size.y)) == black) {
        return false;
      }
    }
    return true;
  }

  void draw() {
    noStroke();
    fill(238, 130, 238);
    rectMode(CORNER);
    rect(position.x, position.y, size.x, size.y);
  }
}
