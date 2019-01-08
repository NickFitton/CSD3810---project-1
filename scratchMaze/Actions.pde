class Actions {
  // List of actionable code blocks
  List<Block> blocks;
  // Position of current execution in the blocks
  Pointer pointer;

  PVector printScale;

  Actions() {
    pointer = new Pointer();
    blocks = new LinkedList<Block>();

    printScale = new PVector(10, 15);
  }

  /*
   * If the actions blocks has fallen out of sync with the code train, the action blocks are rewritten
   */
  private void reloadActions(List<Block> codeTrain) {
    pointer = new Pointer();
    blocks = codeTrain;
  }

  public void update() {
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

  private List<Block> convertToActions(List<Block> codeTrain) {
    return getSegment(new LinkedList(codeTrain), new LinkedList());
  }

  /*
   * Returns the next segment in the given queue.
   * The function is recursive, so if there is a segment in a segment e.g. a for loop in an if statement, this is accounted for.
   * The function also side affects, so when a queue is given, this should be taken into account (see 'convertToActions').
   */
  private List<Block> getSegment(LinkedList<Block> queue, List<Block> segment) {
    if (queue.size() == 0) { // If queue is empty return segment
      return segment;
    }
    Block first = queue.get(0); // Get the first element in the queue
    queue.remove(first);
    if (first instanceof Query) {
      return getSegment(queue, segment);
    } else if (first instanceof Iterable) { // If the first element of the queue is an iterable
      Iterable iterableFirst = ((Iterable) first);
      // Get the elements of the iterable and add the created segment to the current segment
      List<Block> innerBlocks = getSegment(queue, new LinkedList());
      iterableFirst.setBlocks(innerBlocks);
      segment.add(iterableFirst);
      return getSegment(queue, segment);
    } else if (first instanceof OutDent) {
      // Finish reading if an outdent is reached
      segment.add(first);
      return segment;
    } else {
      segment.add(first);
      return getSegment(queue, segment);
    }
  }

  void printActions(int x, int y) {
    textAlign(LEFT);
    pushMatrix();
    translate(x, y);
    fill(0);
    stroke(0);
    pushMatrix();
    // The faux pointer is used to text which block is active to highlight it
    int[] fauxPointer = new int[1];
    fauxPointer[0] = 0;
    printBlocks(blocks, fauxPointer);
    popMatrix();
    popMatrix();
    textAlign(CENTER, CENTER);
  }

  public void annotateTrain() {
    rectMode(CENTER);
    // The faux pointer is used to text which block is active to highlight it
    int[] fauxPointer = new int[1];
    fauxPointer[0] = 0;
    annotateTrain(blocks, fauxPointer);
  }

  private void annotateTrain(List<Block> givenBlocks, int[] fPointer) {
    for (Block block : givenBlocks) {
      pushMatrix();
      translate(block.position.x, block.position.y);
      rotate(block.rotation);
      float blockSize = block.size + 15;
      // If the current 'block' in the loop is the running one, highlight it
      if (pointer.equals(fPointer)) {
        fill(0, 255, 0, 100);
        // If the running block is a movement block, change the size of the block depending on the current progress of that movement
        if (block instanceof Movement) {
          Movement m = (Movement) block;
          blockSize += sin(m.getProgress() * PI) * 10;
        }
      } else {
        // If the current 'block' in the loop is not running, give it a different highlight
        fill(0, 0, 255, 100);
      }
      // Print the blocks highlight
      rect(0, 0, blockSize, blockSize, rectBorder);
      popMatrix();
      if (block instanceof Iterable) {
        Iterable iterable = (Iterable) block;
        // Recurse into the sub blocks, appending to the pointer to factor
        annotateTrain(iterable.getSubBlocks(), append(fPointer, 0));
      }
      // Step the pointer to the next point
      fPointer[fPointer.length-1]++;
    }
  }

  void printBlocks(List<Block> givenBlocks, int[] fPointer) {
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
        printBlocks(iterable.getSubBlocks(), append(fPointer, 0));
        translate(-printScale.x, 0);
      }
      fPointer[fPointer.length-1]++;
    }
  }

  void execute() throws IOException {
    try {
      // Grab the block currently pointed at
      Block currentBlock = pointer.point(blocks);
      // Execute the block (if it's a movement move the user, if it's a loop, take the next step)
      boolean state = currentBlock.execute();
      if (state) {
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
      }
    }
  }
}
