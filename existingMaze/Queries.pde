abstract class Query {
  Query() {
  }

  abstract boolean execute();
}

class CanMoveUp extends Query {
  boolean execute() {
    return path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black;
  }
}

class CanMoveDown extends Query {
  boolean execute() {
    return path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black;
  }
}

class CanMoveLeft extends Query {
  boolean execute() {
    return path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black;
  }
}

class CanMoveRight extends Query {
  boolean execute() {
    return canMoveRight();
  }
}

boolean canMoveRight() {
  for (int i=0; i< 20; i++) {
    if (path.get(floor(player.position.x + player.size.x + (player.speed * i)), floor(player.position.y + (player.size.y/2))) == black) {
      return false;
    }
  }
  return true;
}
