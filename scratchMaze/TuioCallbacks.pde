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
  return new PVector(object.getScreenX(width), object.getScreenY(height));
}

void refresh(TuioTime bundleTime) {
}
void addTuioCursor(TuioCursor tcur) {
}
void removeTuioCursor(TuioCursor tcur) {
}
void updateTuioCursor(TuioCursor tcur) {
}
void addTuioBlob(TuioBlob tblb) {
}
void removeTuioBlob(TuioBlob tblb) {
}
void updateTuioBlob(TuioBlob tblb) {
}
