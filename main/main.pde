import TUIO.*; //<>// //<>//

TuioProcessing tuioClient;
HashMap<Integer, Element> objects = new HashMap<Integer, Element>();

void setup() {
  size(900, 900);
  background(50);
  tuioClient = new TuioProcessing(this);
}

void draw() {
  background(50);
  for (Element e : objects.values()) {
    e.drawElement();
  }
}

void addTuioObject(TuioObject object) {
  if (elementExists(object.getSymbolID())) {
    getElement(object.getSymbolID()).show();
  } else {
    objects.put(object.getSymbolID(), new Element(object));
  }
}

void updateTuioObject(TuioObject object) {
  if (elementExists(object.getSymbolID())) {
    Element e = getElement(object.getSymbolID());
    e.moveElement(object);
    e.position = tuioObjectPosition(object);
    e.rotation = object.getAngle();
  } else {
    println("Updating nonexistent object: [" + object.getSymbolID() + "]");
  }
}

void removeTuioObject(TuioObject object) {
  if (elementExists(object.getSymbolID())) {
    objects.get(object.getSymbolID()).hide();
  } else {
    println("Removing nonexistent object: [" + object.getSymbolID() + "]");
  }
}

void refresh(TuioTime bundleTime) {}
void addTuioCursor(TuioCursor tcur) {}
void removeTuioCursor(TuioCursor tcur) {}
void updateTuioCursor(TuioCursor tcur) {}
void addTuioBlob(TuioBlob tblb) {}
void removeTuioBlob(TuioBlob tblb) {}
void updateTuioBlob(TuioBlob tblb) {}


PVector tuioObjectPosition(TuioObject object) {
  return new PVector(object.getScreenX(width), object.getScreenY(height));
}

Element getElement(int id) {
  return objects.get(id);
}

boolean elementExists(int id) {
  return objects.get(id) != null;
}
