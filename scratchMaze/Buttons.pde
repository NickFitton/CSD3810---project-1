abstract class Button {
  PVector position;
  PVector size;
  boolean ellipse;
  color buttonColor;
  String name;
  
  void draw() {
    fill(buttonColor);
    if (ellipse) {
      ellipseMode(CENTER);
      ellipse(position.x, position.y, size.x, size.y);
    } else {
      rectMode(CENTER);
      rect(position.x, position.y, size.x, size.y);
    }
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, 0, 0);
  }
}
