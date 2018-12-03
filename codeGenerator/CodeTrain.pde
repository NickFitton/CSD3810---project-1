List<Element> codeTrain = new LinkedList<Element>();

/**
 * Tries to get the starting element from the list of elements, if it exists, start the train, otherwise return an empty list.
 */
void updateCodeTrain(List<Element> elements) {
  Optional<Element> firstElement = getStartingElement(elements);

  if (firstElement.isPresent()) {
    List<Element> train = new LinkedList<Element>();
    train.add(firstElement.get());
    elements.remove(firstElement.get());
    codeTrain = train(elements, train);
  } else {
    codeTrain = new LinkedList();
  }
}

/**
 * Starts a train for the train function, takes the '0' element from the list of elements and returns the completed train.
 */
List<Element> generateTrain(Element firstElement, List<Element> elements) {
  List<Element> train = new LinkedList<Element>();
  train.add(firstElement);
  elements.remove(firstElement);
  return train(elements, train);
}

/**
 * Recursive function, recieves a list of elements and a train of elements if an element is close to the end of the train, it is added to the train and the function is run again, otherwise the existing train is returned.
 */
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
  return (angleClose(angle, objA, give) && angleClose(objA, objB, give));
}

/**
 * Recieves 2 angles and an amount of give and tests if the difference between them is less than the given give, ensuring the calculation wraps over.
 */
boolean angleClose(float angleA, float angleB, float give) {
  return abs(angleA-angleB) < give || abs((angleA-TWO_PI)-angleB) < give || abs(angleA-(angleB-TWO_PI)) < give;
}

/**
 * Receives a collection of elements, if the collection contains an element with the fedId '0' then it is returned as an observable, otherwise an empty observable is returned.
 */
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
