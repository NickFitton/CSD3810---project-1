abstract class Block {
  String action;
  boolean visible;
  PVector position;
  float rotation;
  long fedId;
  float size = 90;

  Block(TuioObject obj) {
    this.fedId = obj.getSymbolID();
    this.visible = true;
    this.moveBlock(obj);
  }

  abstract List<Block> getSubBlocks() throws IOException;

  /**
   returns true if the block is complete
   **/
  abstract boolean execute();

  abstract void drawBlock();

  void moveBlock(TuioObject obj) {
    this.position = new PVector(obj.getScreenX(width), obj.getScreenY(height));
    this.rotation = obj.getAngle();
  }

  void runnableDraw(Runnable drawing) {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    noStroke();
    drawing.run();
    popMatrix();
  }

  void show() {
    visible = true;
  }

  void hide() {
    visible = false;
  }
}

class Start extends Block {

  Start(TuioObject obj) {
    super(obj);
    action = "start";
  }

  List<Block> getSubBlocks() throws IOException {
    throw new IOException("Start does not have subblocks");
  }

  boolean execute() {
    return true;
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        fill(255);
        rectMode(CENTER);
        rect(0, 0, size, size);
      }
    }
    );
  }
}

class OutDent extends Block {

  OutDent(TuioObject obj) {
    super(obj);
    action = "}";
  }

  List<Block> getSubBlocks() throws IOException {
    throw new IOException("Start does not have subblocks");
  }

  boolean execute() {
    return true;
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        fill(255);
        rectMode(CENTER);
        rect(0, 0, size, size);
        fill(0);
        text("}", 0, 0);
      }
    }
    );
  }
}

abstract class Movement extends Block {
  int movementPointer;
  int steps;

  Movement(TuioObject obj, int steps) {
    super(obj);
    this.steps = steps;
    this.movementPointer = 0;
  }

  List<Block> getSubBlocks() throws IOException {
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
  Up(TuioObject obj) {
    super(obj, stepCount);
    action = "up";
  }

  void move() {
    player.moveUp();
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        rectMode(CENTER);
        fill(125, 125, 0);
        rect(0, 0, size, size);
        fill(0);
        text("^", 0, 0);
      }
    }
    );
  }
}

class Down extends Movement {
  Down(TuioObject obj) {
    super(obj, stepCount);
    action = "down";
  }

  void move() {
    player.moveDown();
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        rectMode(CENTER);
        fill(125, 0, 125);
        rect(0, 0, size, size);
        fill(0);
        text("V", 0, 0);
      }
    }
    );
  }
}

class Right extends Movement {
  Right(TuioObject obj) {
    super(obj, stepCount);
    action = "right";
  }

  void move() {
    player.moveRight();
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        rectMode(CENTER);
        fill(0, 125, 125);
        rect(0, 0, size, size);
        fill(0);
        text(">", 0, 0);
      }
    }
    );
  }
}

class Left extends Movement {
  Left(TuioObject obj) {
    super(obj, stepCount);
    action = "left";
  }

  void move() {
    player.moveLeft();
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size);
        fill(0);
        text("<", 0, 0);
      }
    }
    );
  }
}

abstract class Iterable extends Block {
  List<Block> subBlocks;

  Iterable(TuioObject obj) {
    super(obj);
    this.subBlocks = new LinkedList<Block>();
  }

  List<Block> getSubBlocks() {
    return subBlocks;
  }

  void addBlock(Block block) {
    subBlocks.add(block);
  }

  void setBlocks(List<Block> blocks) {
    subBlocks = blocks;
  }

  void addBlocks(List<Block> blocks) {
    for (Block block : blocks) {
      addBlock(block);
    }
  }
}

class ForLoop extends Iterable {
  int iterations;
  int pointer;

  ForLoop(TuioObject obj, int iterations) {
    super(obj);
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

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        String label = "for (0:" + iterations + ") {";
        float textWidth = textWidth(label);
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size);
        fill(0);
        text(label, -textWidth/2, 0);
      }
    }
    );
  }
}

class InfiniteLoop extends Iterable {
  InfiniteLoop(TuioObject obj) {
    super(obj);
    action = "infinite";
  }

  boolean execute() {
    return false;
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        String label = "8";
        float textWidth = textWidth(label);
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size);
        fill(0);
        rotate(PI/2);
        text(label, -textWidth/2, 0);
      }
    }
    );
  }
}

abstract class Conditional extends Iterable {
  Query query;

  Conditional(TuioObject obj) {
    super(obj);
  }

  void setQuery(Query query) {
    this.query = query;
  }

  boolean hasQuery() {
    return query != null;
  }

  boolean execute() {
    return !query.execute();
  }

  String getStatement() {
    if (hasQuery()) {
      return action + " (" + query.statement + ") {";
    } else {
      return action + " () {";
    }
  }

  void clearQuery() {
    query = null;
  }
}

class If extends Conditional {
  If(TuioObject obj) {
    super(obj);
    this.action = "if";
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        String label = getStatement();
        float textWidth = textWidth(label);
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size);
        fill(0);
        text(label, -textWidth/2, 0);
      }
    }
    );
  }
}

//class IfElse extends Conditional {
//  boolean success;

//  List<Block> elseBlocks;

//  IfElse(TuioObject obj) {
//    super(obj);
//    elseBlocks = new LinkedList();
//    action = "if else";
//  }

//  void addElseBlock(Block block) {
//    elseBlocks = (List<Block>) append(elseBlocks, block);
//  }

//  void addElseBlocks(Block... blocks) {
//    for (Block block : blocks) {
//      addElseBlock(block);
//    }
//  }

//  void drawBlock() {
//    runnableDraw(new Runnable() {
//      @Override
//        public void run() {
//        String label = "} else {";
//        float textWidth = textWidth(label);
//        rectMode(CENTER);
//        fill(175, 0, 125);
//        rect(0, 0, size, size);
//        fill(0);
//        text(label, -textWidth/2, 0);
//      }
//    }
//    );
//  }

//  List<Block> getSubBlocks() {
//    execute();
//    if (!success) {
//      return subBlocks;
//    } else {
//      return elseBlocks;
//    }
//  }

//  boolean execute() {
//    success = !query.execute(player, path);
//    return false;
//  }
//}
