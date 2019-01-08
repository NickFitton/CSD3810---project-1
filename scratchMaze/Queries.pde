abstract class Query extends Block {
  String statement;

  Query(TuioObject obj, String statement) {
    super(obj);
    this.statement = statement;
  }

  List<Block> getSubBlocks() throws IOException {
    throw new IOException("Queries don't have sub blocks");
  }

  boolean execute() {
    boolean clear = pathClear(player.position.copy(), player.size, player.scale, path);
    return clear;
  }

  abstract boolean pathClear(PVector position, PVector size, int scale, PImage path);

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        fill(0, 200, 0);
        rectMode(CENTER);
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text(statement, 0, 0);
      }
    }
    );
  }
}

class CanGoUp extends Query {
  CanGoUp(TuioObject obj) {
    super(obj, "Can go up");
  }

  boolean pathClear(PVector position, PVector size, int scale, PImage path) {
    return player.canGoUp();
  }
}

class CanGoDown extends Query {
  CanGoDown(TuioObject obj) {
    super(obj, "Can go down");
  }

  boolean pathClear(PVector position, PVector size, int scale, PImage path) {
    return player.canGoDown();
  }
}

class CanGoRight extends Query {
  CanGoRight(TuioObject obj) {
    super(obj, "Can go right");
  }

  boolean pathClear(PVector position, PVector size, int scale, PImage path) {
    return player.canGoRight();
  }
}

class CanGoLeft extends Query {
  CanGoLeft(TuioObject obj) {
    super(obj, "Can go left");
  }

  boolean pathClear(PVector position, PVector size, int scale, PImage path) {
    return player.canGoLeft();
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
