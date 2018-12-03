void addTuioObject(TuioObject object) {
  tuioUpdated = true;
  long sessionID = object.getSessionID();

  if (elementExists(sessionID)) {
    getElement(sessionID).show();
  } else {
    Element newElement;
    newElement = new Element(object);
    saveElement(sessionID, newElement);
  }
}

void updateTuioObject(TuioObject object) {
  tuioUpdated = true;
  final long sessionID = object.getSessionID();
  if (elementExists(sessionID)) {
    Element e = getElement(sessionID);
    e.moveElement(object);
    e.position = tuioObjectPosition(object);
    e.rotation = object.getAngle();
  } else {
    println("Updating nonexistent object: [" + object.getSessionID() + "]");
  }
}

void removeTuioObject(TuioObject object) {
  tuioUpdated = true;
  long sessionID = object.getSessionID();

  if (elementExists(sessionID)) {
    Element removedObj = getElement(sessionID);
    if (codeTrain.contains(removedObj)) {
      codeTrain.remove(removedObj);
    }
    removedObj.hide();
  } else {
    println("Removing nonexistent object: [" + object.getSessionID() + "]");
  }
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
