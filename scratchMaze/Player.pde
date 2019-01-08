class Player {
  private PVector position;
  private PVector previousPosition;
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
    if (collision && path.get(floor(getPositionX() + (playerSize.x/2)), getPositionY()) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveDown() {
    move();
    position.add(new PVector(0, scale));
    if (collision && path.get(floor(getPositionX() + (playerSize.x/2)), floor(getPositionY() + playerSize.y)) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveLeft() {
    move();
    position.add(new PVector(-scale, 0));
    if (collision && path.get(getPositionX(), floor(getPositionY() + (playerSize.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void moveRight() {
    move();
    position.add(new PVector(scale, 0));
    if (collision && path.get(floor(getPositionX() + playerSize.x), floor(getPositionY() + (playerSize.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  boolean canGoUp() {
    if (!collision) {
      return true;
    }
    for (int i=0; i<stepCount; i++) {
      if (path.get(getPositionX(), floor(getPositionY()-i)) == black ||
        path.get(floor(getPositionX() + playerSize.x), floor(player.position.y-i)) == black) {
        return false;
      }
    }
    return true;
  }

  boolean canGoDown() {
    if (!collision) {
      return true;
    }
    for (int i=0; i<stepCount; i++) {
      if (path.get(getPositionX(), floor(getPositionY() + playerSize.y + i)) == black ||
        path.get(floor(getPositionX() + playerSize.x), floor(getPositionY() + playerSize.y + i)) == black) {
        return false;
      }
    }
    return true;
  }

  boolean canGoRight() {
    if (!collision) {
      return true;
    }
    for (int i=0; i<stepCount; i++) {
      if (path.get(floor(getPositionX() + playerSize.x + i), getPositionY()) == black ||
        path.get(floor(getPositionX() + playerSize.x + i), floor(getPositionY() + playerSize.y)) == black) {
        return false;
      }
    }
    return true;
  }

  boolean canGoLeft() {
    if (!collision) {
      return true;
    }
    for (int i=0; i<stepCount; i++) {
      if (path.get(floor(getPositionX() - i), getPositionY()) == black ||
        path.get(floor(getPositionX() - i), floor(getPositionY() + playerSize.y)) == black) {
        return false;
      }
    }
    return true;
  }

  void draw() {
    noStroke();
    fill(0);
    rectMode(CORNER);
    rect(position.x, position.y, playerSize.x, playerSize.y);
  }
}
