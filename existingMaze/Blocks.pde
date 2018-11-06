abstract class Block {
  String action;

  abstract Block[] getSubBlocks() throws IOException;
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
}

class ForLoop extends Iterable {
  int iterations;
  int pointer;

  ForLoop(Block[] blocks, int iterations) {
    super(blocks);
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
  InfiniteLoop(Block[] blocks) {
    super(blocks);
    action = "infinite";
  }

  boolean execute() {
    return false;
  }
}
