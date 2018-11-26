import TUIO.*; //<>//

TuioProcessing tuioClient;
HashMap<Integer, Element> objects = new HashMap<Integer, Element>();

PVector scale;

void setup() {
  size(900, 900, P2D);
  background(50);

  scale = new PVector(1.32, 1);
  tuioClient = new TuioProcessing(this);
}

void draw() {
  background(50);
  for (Element e : objects.values()) {
    e.drawElement();
  }
}

PVector tuioObjectPosition(TuioObject object) {
  return new PVector(object.getScreenX(width), object.getScreenY(height));
}

Element getElement(long id) {
  return objects.get((int) id);
}

boolean elementExists(long id) {
  return objects.get((int) id) != null;
}

void saveElement(long id, Element element) {
  objects.put((int) id, element);
}
