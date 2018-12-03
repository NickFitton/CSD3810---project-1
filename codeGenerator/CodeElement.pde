class StartElement extends Element {
  PShape shape;

  StartElement(TuioObject obj) {
    super(obj);
    shape = createShape();
    shape.beginShape();
    shape.fill(elementColor);
    shape.stroke(0);
    shape.strokeWeight(5);
    shape.vertex(-45, 45);
    shape.bezierVertex(-45, -45, 0, 0, 45, -45);
    shape.endShape(CLOSE);
  }

  @Override()
    void drawElement() {
    if (visible) {
      rectMode(CENTER);
      pushMatrix();
      //translate(position.x * scale.x, position.y * scale.y);
      translate(position.x, position.y);
      rotate(rotation);
      shape(shape, 0, 0);
      popMatrix();
    }
  }
}
