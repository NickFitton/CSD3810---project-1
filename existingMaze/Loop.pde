class Loop {
  int loops;
  int currentLoop;

  Loop(int numLoops) {
    loops = numLoops;
    currentLoop = 0;
  }

  boolean nextLoop() {
    currentLoop++;
    if (currentLoop >= loops) {
      currentLoop = 0;
      return false;
    } else {
      return false;
    }
  }
}
