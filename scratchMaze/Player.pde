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

  Player copy() {
    return new Player(this.position.copy());
  }

  void move() {
    previousPosition = position.copy();
  }

  void moveUp() {
    //synchronized (position) {
      move();
      position.add(new PVector(0, -scale));
      if (collision && path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black) {
        position.y = previousPosition.y;
      }
    //}
  }

  void moveDown() {
    //synchronized (position) {
      move();
      position.add(new PVector(0, scale));
      if (collision && path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black) {
        position.y = previousPosition.y;
      }
    //}
  }

  void moveLeft() {
    //synchronized (position) {
      move();
      position.add(new PVector(-scale, 0));
      if (collision && path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black) {
        position.x = previousPosition.x;
      }
    //}
  }

  void moveRight() {
    //synchronized (position) {
      move();
      position.add(new PVector(scale, 0));
      if (collision && path.get(floor(player.position.x + player.size.x), floor(player.position.y + (player.size.y/2))) == black) {
        position.x = previousPosition.x;
      }
    //}
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
    strokeWeight(1);
    stroke(0);
    fill(255);
    rectMode(CORNER);
    rect(position.x, position.y, size.x, size.y);
  }
}
