class Element {
  PVector position;
  PVector previousPosition;
  PVector velocity;
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
      rectMode(CENTER);
      pushMatrix();
      translate(position.x * scale.x, position.y * scale.y);
      rotate(rotation);
      fill(elementColor);
      rect(0, 0, size, size);
      popMatrix();
    }
  }

  void show() {
    visible = true;
  }

  void hide() {
    visible = false;
  }

  PVector getVelocity() {
    return position.sub(previousPosition);
  }
}
