abstract class Query {
  boolean execute(Player player, PImage path) {
    boolean clear = pathClear(player.position.copy(), player.size, player.scale, path, stepCount);
    return clear;
  }

  abstract boolean pathClear(PVector position, PVector size, int scale, PImage path, int steps);
}

class CanGoUp extends Query {
  CanGoUp() {
  }

  boolean pathClear(PVector position, PVector size, int scale, PImage path, int steps) {
    println("path clear");
    for (int i=0; i<steps; i++) {
      if (path.get(floor(player.position.x), floor(player.position.y-i)) == black ||
      path.get(floor(player.position.x + player.size.x), floor(player.position.y-i)) == black) {
        return false;
      }
    }
    return true;
  }
}

abstract class HowFar {
  int execute(Player player, PImage path) {
    return steps(player.copy(), path, 0);
  }

  abstract int steps(Player player, PImage path, int step);
}

class HowFarUp extends HowFar {
  int steps(Player player, PImage path, int step) {
    if (path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y)) == black || step >= 100) {
      return step;
    }
    player.position.y--;
    return steps(player, path, step+1);
  }
}

class HowFarRight extends HowFar {
  int steps(Player player, PImage path, int step) {
    if (path.get(floor(player.position.x + player.size.x), floor(player.position.y + (player.size.y/2))) == black || step >= 100) {
      return step;
    }
    player.position.x++;
    return steps(player, path, step+1);
  }
}

class HowFarLeft extends HowFar {
  int steps(Player player, PImage path, int step) {
    if (path.get(floor(player.position.x), floor(player.position.y + (player.size.y/2))) == black || step >= 100) {
      return step;
    }
    player.position.x--;
    return steps(player, path, step+1);
  }
}

class HowFarDown extends HowFar {
  int steps(Player player, PImage path, int step) {
    if (path.get(floor(player.position.x + (player.size.x/2)), floor(player.position.y + player.size.y)) == black || step >= 100) {
      return step;
    }
    player.position.y++;
    return steps(player, path, step+1);
  }
}
