class Actions {
  List<Block> blocks;
  Pointer pointer;
  Block previousBlock;

  PVector printScale;

  Actions() {
    pointer = new Pointer();
    blocks = new LinkedList<Block>();

    printScale = new PVector(10, 15);
  }

  void clear() {
    pointer = new Pointer();
    blocks = new LinkedList<Block>();
  }

  void reloadActions(List<Block> codeTrain) {
    pointer = new Pointer();
    blocks = codeTrain;
  }

  void update(List<Block> codeTrain) {
    List<Block> trainActions = convertToActions(codeTrain);
    if (trainActions.size() == 0) {
      blocks = trainActions;
    } else {
      int min = Math.min(blocks.size(), trainActions.size());
      int max = Math.max(blocks.size(), trainActions.size());
      for (int i=0; i<min; i++) {
        if (blocks.get(i).action != trainActions.get(i).action) {
          reloadActions(trainActions);
        }
      }
      if (blocks.size() < trainActions.size()) {
        for (int i=min; i< max; i++) {
          Block nextBlock = trainActions.get(i);
          blocks.add(nextBlock);
        }
      } else if (blocks.size() > trainActions.size()) {
        while (blocks.size() > trainActions.size()) {
          blocks.remove(blocks.size() - 1);
        }
      }
    }
  }

  List<Block> convertToActions(List<Block> codeTrain) {
    return getSegment(new LinkedList(codeTrain), new LinkedList());
  }

  List<Block> getSegment(List<Block> queue, List<Block> segment) {
    if (queue.size() == 0) { // If queue is empty return segment
      return segment;
    }
    Block first = queue.get(0);
    if (first instanceof Query) {
      queue.remove(first);
      return getSegment(queue, segment);
    } else if (first instanceof Iterable) { // If the first element of the queue is an iterable
      queue.remove(first);
      Iterable iterableFirst = ((Iterable) first);
      List<Block> innerBlocks = getSegment(queue, new LinkedList());
      iterableFirst.setBlocks(innerBlocks);
      segment.add(iterableFirst);
      if (queue.size() != 0) {
        segment.add(queue.get(0));
        queue.remove(queue.get(0));
      }
      return getSegment(queue, segment);
    } else if (first instanceof OutDent) {
      return segment;
    } else {
      queue.remove(first);
      segment.add(first);
      return getSegment(queue, segment);
    }
  }

  void addBlock(Block block) {
    blocks.add(block);
  }

  void addBlocks(Block... blocks) {
    for (Block block : blocks) {
      this.addBlock(block);
    }
  }

  void printActions(int x, int y) {
    textAlign(LEFT);
    pushMatrix();
    translate(x, y);
    fill(0);
    stroke(0);
    pushMatrix();
    int[] fauxPointer = new int[1];
    fauxPointer[0] = 0;
    printBlocks(blocks, 0, fauxPointer);
    popMatrix();
    popMatrix();
    textAlign(CENTER, CENTER);
  }

  void printBlocks(List<Block> givenBlocks, int indentation, int[] fPointer) {
    for (Block block : givenBlocks) {
      if (pointer.equals(fPointer)) {
        fill(0, 255, 0);
        stroke(0, 255, 0);
      } else {
        fill(0);
        stroke(0);
      }
      if (block instanceof Conditional) {
        Conditional cond = (Conditional) block;
        
        text(cond.getStatement(), 20, 20);
      } else {
        text(block.action, 20, 20);
      }
      translate(0, printScale.y);
      if (block instanceof Iterable) {
        Iterable iterable = (Iterable) block;
        translate(printScale.x, 0);
        printBlocks(iterable.getSubBlocks(), indentation+1, append(fPointer, 0));
        translate(-printScale.x, 0);
        //}
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
    catch (IndexOutOfBoundsException e) {
      if (pointer.pointer.length > 1) {
        pointer.outdent();
      } else {
        pointer.reset();
        playPauseButton.setPlaying(false);
        println("Reached end of action list");
      }
    }
  }
}
