abstract class Shape {
  abstract void draw(color shapeColor, PVector position);
}

class Pause extends Shape {

  void draw(color shapeColor, PVector position) {
    pushMatrix();
    translate(position.x, position.y);
    beginShape();
    fill(shapeColor);
    noStroke();
    vertex(0, 0);
    vertex(20, 12.5);
    vertex(0, 25);
    endShape(CLOSE);
    popMatrix();
  }
}

class Arrow extends Shape {
  void draw(color shapeColor, PVector position) {
    pushMatrix();
    translate(position.x, position.y);
    beginShape();
    fill(shapeColor);
    noStroke();
    vertex(0, 7);
    vertex(8, 7);
    vertex(8, 0);
    vertex(20, 10);
    vertex(8, 20);
    vertex(8, 13);
    vertex(0, 13);
    endShape(CLOSE);
    popMatrix();
  }
}

class InfinitySymbol extends Shape {
  void draw(color shapeColor, PVector position) {
    pushMatrix();
    translate(position.x, position.y);
    beginShape();
    fill(shapeColor);
    noStroke();
    vertex(10, 8);
    bezierVertex(15, 4, 20, 10, 15, 16);
    vertex(10, 12);
    bezierVertex(5, 16, 0, 10, 5, 4);    
    endShape(CLOSE);
    popMatrix();
  }
}

class IndentEnd extends Shape {
  void draw(color shapeColor, PVector position) {
    pushMatrix();
    translate(position.x, position.y);
    beginShape();
    fill(shapeColor);
    noStroke();
    vertex(14, 0);
    vertex(14, 12);
    vertex(5, 12);
    vertex(5, 10);
    vertex(0, 15);
    vertex(5, 20);
    vertex(5, 17);
    vertex(19, 17);
    vertex(19, 0);
    endShape(CLOSE);
    popMatrix();
  }
}

class LoopShape extends Shape {
  void draw(color shapeColor, PVector position) {
    pushMatrix();
    ellipseMode(CORNER);
    translate(position.x, position.y);
    beginShape();
    fill(shapeColor);
    noStroke();
    ellipse(0, 0, 20, 20);
    popMatrix();
  }
}
