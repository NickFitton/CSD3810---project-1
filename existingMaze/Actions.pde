class Actions {
  Block[] blocks;
  Pointer pointer;
  Block previousBlock;

  PVector printScale;

  Actions() {
    pointer = new Pointer();
    blocks = new Block[0];

    printScale = new PVector(10, 15);
  }

  void addBlock(Block block) {
    blocks = (Block[]) append(blocks, block);
  }

  void addBlocks(Block... blocks) {
    for (Block block : blocks) {
      this.addBlock(block);
    }
  }

  void printActions(int x, int y) {
    translate(x, y);
    fill(0);
    stroke(0);
    pushMatrix();
    int[] fauxPointer = new int[1];
    fauxPointer[0] = 0;
    printBlocks(blocks, 0, fauxPointer);
    popMatrix();
  }

  void printBlocks(Block[] givenBlocks, int indentation, int[] fPointer) {
    for (Block block : givenBlocks) {
      if (pointer.equals(fPointer)) {
        fill(0, 255, 0);
        stroke(0, 255, 0);
      } else {
        fill(0);
        stroke(0);
      }
      text(block.action, 20, 20);
      translate(0, printScale.y);
      if (block instanceof Iterable) {
        Iterable iterable = (Iterable) block;
        translate(printScale.x, 0);
        if (block instanceof IfElse) {
          printBlocks(iterable.subBlocks, indentation+1, append(fPointer, 0));
          translate(-printScale.x, 0);
          text("else", 20, 20);
          translate(printScale.x, printScale.y);
          printBlocks(((IfElse) iterable).elseBlocks, indentation+1, append(fPointer,0));
          translate(-printScale.x, printScale.y);
        } else {
          printBlocks(iterable.getSubBlocks(), indentation+1, append(fPointer, 0));
          translate(-printScale.x, 0);
        }
      }
      fPointer[fPointer.length-1]++;
    }
  }

  void execute() throws IOException {
    try {
      // Grab the block currently pointed at
      Block currentBlock = pointer.point(blocks);
      if (currentBlock instanceof Iterable) {
        println("fucking why?");
      } else {
        println(currentBlock.action);
      }
      // Execute the block (if it's a movement move the user, if it's a loop, take the next step)
      boolean state = currentBlock.execute();
      if (state) {
        previousBlock = currentBlock;
        pointer.increment();
      } else {
        if (currentBlock instanceof Iterable) {
          pointer.indent();
        }
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
