List<Block> codeTrain = new LinkedList<Block>();

/**
 * Tries to get the starting element from the list of elements, if it exists, start the train, otherwise return an empty list.
 */
void updateCodeTrain(List<Block> elements) {
  Optional<Block> firstElement = getStartingElement(elements);

  if (firstElement.isPresent()) {
    List<Block> train = new LinkedList<Block>();
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
List<Block> generateTrain(Block firstElement, List<Block> elements) {
  List<Block> train = new LinkedList<Block>();
  train.add(firstElement);
  elements.remove(firstElement);
  return train(elements, train);
}

/**
 * Recursive function, recieves a list of elements and a train of elements if an element is close to the end of the train, it is added to the train and the function is run again, otherwise the existing train is returned.
 */
List<Block> train(List<Block> elements, List<Block> train) {
  Block end = train.get(train.size() - 1);
  for (Block e : elements) {
    if (!(e instanceof TriggerBlock)) {
      float dist = dist(end.position.x, end.position.y, e.position.x, e.position.y);
      float angle = atan2(e.position.y - end.position.y, e.position.x - end.position.x) + (PI*1.5);
      if (e instanceof Query && end instanceof If && anglesClose(angle - (TWO_PI * 0.75), end.rotation, e.rotation, 0.5) && dist < end.size + e.size) {
        If ifEnd = (If) end;
        ifEnd.setQuery((Query) e);
        elements.remove(e);
        return train(elements, train);
      } else if (end instanceof Iterable && dist < end.size + e.size) {
        if (anglesClose(angle - (TWO_PI * 0.875), end.rotation, e.rotation, 0.5)) {
          train.add(e);
          elements.remove(e);
          return train(elements, train);
        }
      } else if (e instanceof OutDent && dist < end.size + e.size) {
        if (anglesClose((angle + (TWO_PI * 0.875)) % TWO_PI, end.rotation, e.rotation, 0.5)) {
          train.add(e);
          elements.remove(e);
          return train(elements, train);
        }
      } else if (dist < end.size + e.size) {
        if (anglesClose(angle, end.rotation, e.rotation, 0.5)) {
          train.add(e);
          elements.remove(e);
          return train(elements, train);
        }
      }
    }
  }
  return train;
}

boolean incrementAngleClose(float angle, float objA, float objB, float give) {
  return angleClose(objA, objB, give) && angleClose(angle, objA, give);
}

boolean anglesClose(float angle, float objA, float objB, float give) {
  return angleClose(angle, objA, give) && angleClose(objA, objB, give);
}

/**
 * Recieves 2 angles and an amount of give and tests if the difference between them is less than the given give, ensuring the calculation wraps over.
 */
boolean angleClose(float angleA, float angleB, float give) {
  return abs(angleA-angleB) < give || abs((angleA-TWO_PI)-angleB) < give || abs(angleA-(angleB-TWO_PI)) < give;
}

/**
 * Draws lines between the blocks in the train
 */
void drawCodeTrain() {
  strokeWeight(3);
  stroke(0);
  for (int i=0; i<codeTrain.size() - 1; i++) {
    Block a = codeTrain.get(i);
    Block b = codeTrain.get(i + 1);
    line(a.position.x, a.position.y, b.position.x, b.position.y);
  }
}
