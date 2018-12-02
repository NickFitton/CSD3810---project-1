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
    move();
    position.add(new PVector(0, -scale));
    if (collision && path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveDown() {
    move();
    position.add(new PVector(0, scale));
    if (collision && path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black) {
      position.y = previousPosition.y;
    }
  }

  void moveLeft() {
    move();
    position.add(new PVector(-scale, 0));
    if (collision && path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void moveRight() {
    move();
    position.add(new PVector(scale, 0));
    if (collision && path.get(floor(player.position.x + player.size.x), floor(player.position.y + (player.size.y/2))) == black) {
      position.x = previousPosition.x;
    }
  }

  void draw() {
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(position.x, position.y, size.x, size.y);
    
    fill(0,0,255);
    noStroke();
  }
}
