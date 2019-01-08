import TUIO.*;

void addTuioObject(TuioObject object) {
  synchronized (blocks) {
    tuioUpdated = true;
    long sessionID = object.getSessionID();

    Optional<Block> possibleBlock = getBlock((int) sessionID);

    if (possibleBlock.isPresent()) {
      possibleBlock.get().show();
    } else {
      Block newBlock = createBlock(object);
      saveBlock((int) sessionID, newBlock);
    }
  }
}

void updateTuioObject(TuioObject object) {
  synchronized (blocks) {
    tuioUpdated = true;
    final long sessionID = object.getSessionID();

    Optional<Block> possibleBlock = getBlock((int) sessionID);

    if (possibleBlock.isPresent()) {
      Block e = possibleBlock.get();
      e.moveBlock(object);
      e.position = tuioObjectPosition(object);
      e.rotation = object.getAngle();
    } else {
      println("Updating nonexistent object: [" + object.getSessionID() + "]");
    }
  }
}

void removeTuioObject(TuioObject object) {
  synchronized (blocks) {

    tuioUpdated = true;
    long sessionID = object.getSessionID();

    Optional<Block> possibleBlock = getBlock((int) sessionID);

    if (possibleBlock.isPresent()) {
      Block removedObj = possibleBlock.get();
      removeBlock((int) sessionID);
      if (codeTrain.contains(removedObj)) {
        codeTrain.remove(removedObj);
      }
    } else {
      println("Removing nonexistent object: [" + object.getSessionID() + "]");
    }
  }
}

PVector tuioObjectPosition(TuioObject object) {
  //return new PVector(object.getScreenX(width), object.getScreenY(height));
 
  return new PVector(object.getScreenX(width) * screenScale.x, object.getScreenY(height) * screenScale.y);
}

void refresh(TuioTime bundleTime) {
}

class Cursor {
  PVector position;

  Cursor(PVector position) {
    update(position);
  }

  void update(PVector position) {
    this.position = position;
  }

  void draw() {
    strokeWeight(3);
    stroke(120, 120, 255);
    fill(100, 100, 255);
    ellipse(position.x, position.y, 25, 25);
  }
}

HashMap<Integer, Cursor> cursors = new HashMap<Integer, Cursor>();

PVector tuioCursorPosition(TuioCursor cursor) {
  return new PVector(cursor.getScreenX(width), cursor.getScreenY(height));
}

void addTuioCursor(TuioCursor tcur) {
  cursors.put((int) tcur.getSessionID(), new Cursor(tuioCursorPosition(tcur)));
}
void removeTuioCursor(TuioCursor tcur) {
  cursors.remove((int) tcur.getSessionID());

  PVector position = tuioCursorPosition(tcur);
  if (playPauseButton.inButton(position)) {
    playPauseButton.pressed();
  }
  if (resetButton.inButton(position)) {
    resetButton.pressed();
  }
}
void updateTuioCursor(TuioCursor tcur) {
  Cursor c = cursors.get((int) tcur.getSessionID());
  if (c != null) {
    c.update(tuioCursorPosition(tcur));
  }
}


void addTuioBlob(TuioBlob tblb) {
}
void removeTuioBlob(TuioBlob tblb) {
}
void updateTuioBlob(TuioBlob tblb) {
}
