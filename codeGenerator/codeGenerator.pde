import TUIO.*; //<>//
import java.util.Collection;
import java.util.List;
import java.util.LinkedList;
import java.util.Optional;

TuioProcessing tuioClient;
HashMap<Integer, Element> objects = new HashMap<Integer, Element>();

List<Element> codeTrain = new LinkedList<Element>();

boolean tuioUpdated = false;

PVector scale;

void setup() {
  size(900, 900, P2D);
  background(50);

  scale = new PVector(1.32, 1);
  tuioClient = new TuioProcessing(this);
}

void draw() {
  background(50);
  pushMatrix();
  scale(scale.x, scale.y);
  List<Element> elements = new LinkedList<Element>(objects.values());
  synchronized (objects) {
    if (tuioUpdated) {
      println("Update train");
      updateCodeTrain(elements);
      tuioUpdated = false;
    }
  }
  for (Element e : elements) {
    e.drawElement();
  }
  drawCodeTrain(codeTrain);
  popMatrix();
}

void updateCodeTrain(List<Element> elements) {
  Optional<Element> firstElement = getStartingElement(elements);

  if (firstElement.isPresent()) {
    codeTrain = generateTrain(firstElement.get(), new LinkedList(elements));
  } else {
    println("Start block not found");
    codeTrain = new LinkedList();
  }
}

List<Element> generateTrain(Element firstElement, List<Element> elements) {
  List<Element> train = new LinkedList<Element>();
  train.add(firstElement);
  elements.remove(firstElement);
  return train(elements, train);
}

List<Element> train(List<Element> elements, List<Element> train) {
  Element end = train.get(train.size() - 1);
  for (Element e : elements) {
    float dist = dist(end.position.x * scale.x, end.position.y * scale.y, e.position.x * scale.x, e.position.y * scale.y);
    if (dist < end.size + e.size) {
      float angle = atan2(e.position.y - end.position.y, e.position.x - end.position.x) + (PI*1.5);
      println(angle, end.rotation);
      if (anglesClose(angle, end.rotation, 0.5)) {
        train.add(e);
        elements.remove(e);
        return train(elements, train);
      }
    }
  }
  return train;
}

boolean anglesClose(float a, float b, float give) {
  float diffA = abs(a-b);
  float diffB = abs((a-TWO_PI)-b);
  return (give > diffA || give > diffB);
}

Optional<Element> getStartingElement(Collection<Element> elements) {
  for (Element e : elements) {
    if (e.fedId == 0) {
      return Optional.of(e);
    }
  }
  return Optional.empty();
}

void drawCodeTrain(List<Element> train) {
  strokeWeight(3);
  stroke(0);
  for (int i=0; i<train.size() - 1; i++) {
    Element a = train.get(i);
    Element b = train.get(i + 1);
    line(a.position.x, a.position.y, b.position.x, b.position.y);
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
