import java.util.*;

Player player;
PImage path;
boolean tuioUpdated = false;
boolean triggerOnPlay = false;

HashMap<Integer, Block> blocks = new HashMap<Integer, Block>();
Actions actions;
TuioProcessing tuioClient;

PlayPauseButton playPauseButton;
ResetButton resetButton;

void setup() {
  textAlign(CENTER, CENTER);
  size(1560, 1000);
  smooth();
  frameRate(60);

  // Only need to load the image if it is going to display it
  if (displayImage) {
    path = loadImage("newPath.png");
  }

  player = new Player(new PVector(5 + imagePosition.x, 5 + imagePosition.y));
  actions = new Actions();
  tuioClient = new TuioProcessing(this);
  playPauseButton = new PlayPauseButton(new PVector(width-100, 100), 100);
  resetButton = new ResetButton(new PVector(width-100, height-100), 100);
  background(50);
}

void draw() {
  ///////////////////////
  //// FUNCTIONALITY ////
  ///////////////////////
  
  // Retrieve the current list of blocks provided by TUIO
  List<Block> currentBlocks = new LinkedList<Block>(blocks.values());
  // If a the list of elements has changed since the last frame
  if (tuioUpdated) {
    // Update the code train to reflect new positions
    updateCodeTrain(new LinkedList(currentBlocks));
    tuioUpdated = false;
    // Update the actions to match the new code train
    actions.update();
  }

  // If the code is being played try to execute the next action
  if (playPauseButton.getPlaying()) {
    try {
      actions.execute();
    } 
    catch (IOException e) {
      /*
       * If an IOException occurs, it is due to the pointer not being in the right position.
       * Th draw loop is stopped from looping as we don't want these to occur.
       */
      noLoop();
      println("[ERROR] Pointed at an invalid block");
      println("[ERROR] Pointer at: ", actions.pointer.pointer);
    }
    // If the code is not playing and there are previous positions of the player, remove one of the positions per frame
  } else if (player.previousPositions.size() > 0) {
    player.previousPositions.remove(0);
  }

  Optional<TriggerBlock> triggerBlock = getTriggerBlock();
  if (triggerBlock.isPresent()) {
    TriggerBlock trigger = triggerBlock.get();

    if (playPauseButton.inButton(trigger.position)) {
      if (!triggerOnPlay) {
        playPauseButton.setPlaying(true);
      }
      triggerOnPlay = true;
    } else {
      playPauseButton.setPlaying(false);
      triggerOnPlay = false;
    }
    if (resetButton.inButton(trigger.position)) {
      resetButton.pressed();
    }
  }
  
  ///////////////////////
  /////// DRAWING ///////
  ///////////////////////
  drawBackground();
  
  // Draws the shading around the blocks in the train first so that everything else is drawn over them
  actions.annotateTrain();
  
  // Draw all of the blocks supplied by TUIO, event if they're not part of the train, the user may want to see them
  for (Block b : currentBlocks) {
    b.drawBlock();
  }
  player.draw();
  drawButtons();

  // For development of the actions, draws where the connections are between blocks
  if (debugMode) {
    drawCodeTrain();
    actions.printActions(50, 50);
  }
}

/*
 * Finds and returns the trigger in the current blocks if it exists
 */
Optional<TriggerBlock> getTriggerBlock() {
  for (Block b : blocks.values()) {
    if (b instanceof TriggerBlock) {
      return Optional.of((TriggerBlock) b);
    }
  }
  return Optional.empty();
}

void drawButtons() {
  playPauseButton.draw();
  resetButton.draw();
}

void drawBackground() {
  background(255);
  if (displayImage) {
    image(path, imagePosition.x, imagePosition.y);
  }
}

/**
 * Receives a collection of elements, if the collection contains an element with the fedId '0' then it is returned as an observable, otherwise an empty observable is returned.
 */
Optional<Block> getStartingElement(Collection<Block> elements) {
  for (Block e : elements) {
    if (e.fedId == 0 && e.visible) {
      return Optional.of(e);
    }
  }
  return Optional.empty();
}


void keyPressed() {
  if (key == ' ') {
    playPauseButton.pressed();
  }
}

/*
 * For if the user is having difficulty getting the trigger feducial over the play/pause & reset buttons, the mouse can also be used to trigger the buttons.
 */
void mousePressed() {
  PVector mousePos = new PVector(mouseX, mouseY);
  if (playPauseButton.inButton(mousePos)) {
    playPauseButton.pressed();
  }
  if (resetButton.inButton(mousePos)) {
    resetButton.pressed();
  }
}
