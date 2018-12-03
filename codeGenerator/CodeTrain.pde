List<Element> codeTrain = new LinkedList<Element>();

void updateCodeTrain(List<Element> elements) {
  Optional<Element> firstElement = getStartingElement(elements);

  if (firstElement.isPresent()) {
    codeTrain = generateTrain(firstElement.get(), new LinkedList(elements));
  } else {
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
      if (anglesClose(angle, end.rotation, e.rotation, 0.5)) {
        train.add(e);
        elements.remove(e);
        return train(elements, train);
      }
    }
  }
  return train;
}

boolean anglesClose(float angle, float objA, float objB, float give) {
  float diffA = abs(angle-objA);
  float diffB = abs((angle-TWO_PI)-objA);
  float diffC = abs(angle-(objA-TWO_PI));
  float diffObjA = abs(objA-objB);
  float diffObjB = abs((objA-TWO_PI)-objB);
  float diffObjC = abs(objA-(objB-TWO_PI));
  return ((give > diffA || give > diffB || give > diffC) && (diffObjA < give || diffObjB < give || diffObjC < give));
}

Optional<Element> getStartingElement(Collection<Element> elements) {
  for (Element e : elements) {
    if (e.fedId == 0 && e.visible) {
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
