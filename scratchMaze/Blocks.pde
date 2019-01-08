abstract class Block {
  String action;
  boolean visible;
  PVector position;
  float rotation;
  long fedId;
  float size = 120;

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
    this.position = tuioObjectPosition(obj);
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
        fill(125, 125, 125);
        rectMode(CENTER);
        rect(0, 0, size, size, rectBorder);
        fill(255);
        textAlign(CENTER, CENTER);
        text("start", 0, 0);
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
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text("}", 0, 0);
      }
    }
    );
  }
}

abstract class Movement extends Block {
  private int movementPointer;
  int steps;

  Movement(TuioObject obj) {
    super(obj);
    this.steps = stepCount;
    this.movementPointer = 0;
  }

  float getProgress() {
    return movementPointer / float(steps);
  }

  List<Block> getSubBlocks() throws IOException {
    throw new IOException("Movements do not have subblocks");
  }

  abstract void move();

  boolean execute() {
    move();    
    movementPointer++;
    if (movementPointer <= steps) {
      return false;
    } else {
      movementPointer = 0;
      return true;
    }
  }
}

class Up extends Movement {
  Up(TuioObject obj) {
    super(obj);
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
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text("^", 0, 0);
      }
    }
    );
  }
}

class Down extends Movement {
  Down(TuioObject obj) {
    super(obj);
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
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text("V", 0, 0);
      }
    }
    );
  }
}

class Right extends Movement {
  Right(TuioObject obj) {
    super(obj);
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
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text(">", 0, 0);
      }
    }
    );
  }
}

class Left extends Movement {
  Left(TuioObject obj) {
    super(obj);
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
        rect(0, 0, size, size, rectBorder);
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
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text(label, 0, 0);
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
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size, rectBorder);
        fill(0);
        rotate(PI/2);
        text(label, 0, 0);
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

  boolean beenExecuted = false;

  @Override()
    boolean execute() {
    if (beenExecuted) {
      beenExecuted = false;
      return true;
    } else {
      beenExecuted = true;
      return !query.execute();
    }
  }

  If(TuioObject obj) {
    super(obj);
    this.action = "if";
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        String label = getStatement();
        rectMode(CENTER);
        fill(175, 0, 125);
        rect(0, 0, size, size, rectBorder);
        fill(0);
        text(label, 0, 0);
      }
    }
    );
  }
}

class TriggerBlock extends Block {
  TriggerBlock(TuioObject obj) {
    super(obj);
    this.action = "trigger";
  }

  void drawBlock() {
    runnableDraw(new Runnable() {
      @Override
        public void run() {
        ellipseMode(CENTER);
        fill(0);
        ellipse(0, 0, size, size);
        fill(255);
        text(action, 0, 0);
      }
    }
    );
  }

  boolean execute() {
    return false;
  }

  List<Block> getSubBlocks() {
    return new LinkedList();
  }
}
