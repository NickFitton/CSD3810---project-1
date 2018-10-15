class Ball extends Element {
  Ball() {
    super();
  }

  void collideWith(Element e) {
    float distance = dist(this.position.x, this.position.y, e.position.x, e.position.y);
    float friction = (this.size/2)+(e.size/2)- distance;
    float angle = PVector.angleBetween(this.position, e.position);
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(angle));
    line(0, 100, 0, -100);
    popMatrix();
    this.velocity = PVector.fromAngle(angle);
  }

  @Override
    void drawElement() {
    if (visible) {
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotation);
      fill(elementColor);
      ellipse(0, 0, size, size);
      popMatrix();
    }
  }

  void containElement() {
    if (position.x <= size/2) {
      position = new PVector((size/2)-position.x+size/2, position.y);
      velocity = new PVector(velocity.x * -1, velocity.y);
    } else if (position.x >= width-(size/2)) {
      position = new PVector((width-(size/2))-position.x + width-(size/2), position.y);
      velocity = new PVector(velocity.x * -1, velocity.y);
    }

    if (position.y <= size/2) {
      position = new PVector(position.x, (size/2)-position.y+size/2);
      velocity = new PVector(velocity.x, velocity.y * -1);
    } else if (position.y >= height-(size/2)) {
      position = new PVector(position.x, position.y + (height-(size/2))-height-(size/2));
      velocity = new PVector(velocity.x, velocity.y * -1);
    }
  }
  
  void moveElement() {
    this.velocity = this.velocity.mult(0.95);
    this.position = this.position.add(this.velocity);
    containElement();
  }
}
