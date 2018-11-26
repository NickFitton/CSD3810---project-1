void addTuioObject(TuioObject object) {
  long sessionID = object.getSessionID();

  if (elementExists(sessionID)) {
    getElement(sessionID).show();
  } else {
    Element newElement;
    switch (object.getSymbolID()) {
    case 0:
      newElement = new StartElement(object);
      break;
    default:
      newElement = new Element(object);
    }
    saveElement(sessionID, newElement);
  }
}

void updateTuioObject(TuioObject object) {
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
  long sessionID = object.getSessionID();

  if (elementExists(sessionID)) {
    Element removedObj = getElement(sessionID);
    println("Removing: " + removedObj);
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
