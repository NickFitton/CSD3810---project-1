import TUIO.*; //<>//
import java.util.Collection;
import java.util.List;
import java.util.LinkedList;
import java.util.Optional;

TuioProcessing tuioClient;
HashMap<Integer, Element> objects = new HashMap<Integer, Element>();

boolean tuioUpdated = false;

PVector scale;

void setup() {
  size(900, 900, P2D);
  background(50);

  scale = new PVector(1.32, 1);
  scale(scale.x, scale.y);
  tuioClient = new TuioProcessing(this);
}

void draw() {
  synchronized (objects) {
    List<Element> elements = new LinkedList<Element>(objects.values());
    if (tuioUpdated) {
      background(50);
      updateCodeTrain(new LinkedList(elements));
      tuioUpdated = false;
      for (Element e : elements) {
        e.drawElement();
      }
      drawCodeTrain(codeTrain);
    }
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
