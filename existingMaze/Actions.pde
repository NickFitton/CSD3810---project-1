class Actions {
  Block[] blocks;
  Pointer pointer;

  PVector printScale;

  Actions() {
    pointer = new Pointer();
    blocks = new Block[0];

    printScale = new PVector(10, 15);
  }

  void addBlock(Block block) {
    blocks = (Block[]) append(blocks, block);
  }

  void printActions(int x, int y) {
    translate(x, y);
    fill(0);
    stroke(0);
    pushMatrix();
    printBlocks(blocks, 0);
    popMatrix();
  }

  void printBlocks(Block[] givenBlocks, int indentation) {
    for (Block block : givenBlocks) {
      //printIndent(indentation);
      //println(block.action);
      text(block.action, 20, 20);
      translate(0, printScale.y);
      if (block instanceof Iterable) {
        Iterable iterable = (Iterable) block;
        translate(printScale.x, 0);
        printBlocks(iterable.getSubBlocks(), indentation+1);
        translate(-printScale.x, 0);
      }
    }
  }

  void printIndent(int indentation) {
    if (indentation > 0) {
      print(" ");
      printIndent(indentation - 1);
    }
  }

  void execute() throws IOException {
    try {
      Block currentBlock = pointer.point(blocks);
      boolean state = currentBlock.execute();
      if (currentBlock instanceof Iterable) {
        if (!state) {
          pointer.indent();
        } else {
          pointer.increment();
        }
      } else if (state) {
        pointer.increment();
      }
    } 
    catch (ArrayIndexOutOfBoundsException e) {
      if (pointer.pointer.length > 1) {
        pointer.outdent();
      } else {
        println("Reached end of action list");
        noLoop();
      }
    }
  }
}
