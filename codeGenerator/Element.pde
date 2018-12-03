class Element {
  PVector position;
  PVector previousPosition;
  PVector velocity;
  long fedId;
  float rotation;
  float size;
  color elementColor;
  boolean visible;

  Element() {
    this.position = new PVector(width/2, height/2);
    this.rotation = 0;
    velocity = new PVector(0, 0);
    elementColor = color(255);
    previousPosition = position;
    size = 90;
    visible = true;
  }

  Element(TuioObject object) {
    this.position = new PVector(object.getScreenX(width), object.getScreenY(height));
    this.rotation = object.getAngle();
    velocity = new PVector(0, 0);
    elementColor = color(random(50, 205), random(50, 205), random(50, 205));
    previousPosition = position;
    fedId = object.getSymbolID();
    size = 90;
    visible = true;
  }

  void moveElement(TuioObject object) {
    previousPosition = this.position;
    this.position = new PVector(object.getScreenX(width), object.getScreenY(height));
    this.rotation = object.getAngle();
  }

  void drawElement() {
    if (visible) {
      noStroke();
      rectMode(CENTER);
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation);
      fill(elementColor);
      rect(0, 0, size, size);
      line(0, 0, 0, -(size/2));
      fill(0);
      ellipse(0, 0, 5, 5);
      popMatrix();
    }
  }

  void show() {
    visible = true;
  }

  void hide() {
    visible = false;
  }
}
