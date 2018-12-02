abstract class Block {
  String action;

  abstract Block[] getSubBlocks() throws IOException;

  /**
   returns true if the block is complete
   **/
  abstract boolean execute();
}

abstract class Movement extends Block {
  int movementPointer;
  int steps;

  Movement(int steps) {
    this.steps = steps;
    this.movementPointer = 0;
  }

  Block[] getSubBlocks() throws IOException {
    throw new IOException("Movements do not have subblocks");
  }

  abstract void move();

  boolean execute() {
    move();    
    movementPointer++;
    if (movementPointer-1 < steps) {
      return false;
    } else {
      movementPointer = 0;
      return true;
    }
    //return true;
  }
}

class Up extends Movement {
  Up() {
    super(stepCount);
    action = "up";
  }

  void move() {
    player.moveUp();
  }
}

class Down extends Movement {
  Down() {
    super(stepCount);
    action = "down";
  }

  void move() {
    player.moveDown();
  }
}

class Right extends Movement {
  Right() {
    super(stepCount);
    action = "right";
  }

  void move() {
    player.moveRight();
  }
}

class Left extends Movement {
  Left() {
    super(stepCount);
    action = "left";
  }

  void move() {
    player.moveLeft();
  }
}

abstract class Iterable extends Block {
  Block[] subBlocks;

  Iterable(Block[] subBlocks) {
    this.subBlocks = subBlocks;
  }

  Block[] getSubBlocks() {
    return subBlocks;
  }

  void addBlock(Block block) {
    subBlocks = (Block[]) append(subBlocks, block);
  }

  void addBlocks(Block... blocks) {
    for (Block block : blocks) {
      addBlock(block);
    }
  }
}

class ForLoop extends Iterable {
  int iterations;
  int pointer;

  ForLoop(int iterations) {
    super(new Block[0]);
    action = "for";
    this.iterations = iterations;
    pointer = 0;
  }

  boolean execute() {
    pointer++;
    if (pointer > iterations) {
      pointer = 0;
      return true;
    } else {
      return false;
    }
  }
}

class InfiniteLoop extends Iterable {
  InfiniteLoop() {
    super(new Block[0]);
    action = "infinite";
  }

  boolean execute() {
    return false;
  }
}

abstract class Conditional extends Iterable {
  Query query;

  Conditional() {
    super(new Block[0]);
  }

  void setQuery(Query query) {
    this.query = query;
  }

  boolean execute() {
    return !query.execute(player, path);
  }
}

class If extends Conditional {
  If() {
    super();
    this.action = "if";
  }
}

class IfElse extends Conditional {
  boolean success;

  Block[] elseBlocks;

  IfElse() {
    elseBlocks = new Block[0];
    action = "if else";
  }

  void addElseBlock(Block block) {
    elseBlocks = (Block[]) append(elseBlocks, block);
  }

  void addElseBlocks(Block... blocks) {
    for (Block block : blocks) {
      addElseBlock(block);
    }
  }
  
  Block[] getSubBlocks() {
    execute();
    if (!success) {
      return subBlocks;
    } else {
      return elseBlocks;
    }
  }
  
  boolean execute() {
    success = !query.execute(player, path);
    return false;
  }
}
