abstract class Button {
  PVector position;
  float size;
  boolean ellipse;
  color buttonColor;
  String name;

  Button(PVector position, float size, boolean ellipse, color buttonColor, String name) {
    this.position = position;
    this.size = size;
    this.ellipse = ellipse;
    this.buttonColor = buttonColor;
    this.name = name;
  }

  void draw() {
    noStroke();
    fill(buttonColor);
    if (ellipse) {
      ellipseMode(CENTER);
      ellipse(position.x, position.y, size, size);
    } else {
      rectMode(CENTER);
      rect(position.x, position.y, size, size, rectBorder);
    }
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, position.x, position.y);
  }

  abstract void pressed();

  boolean inButton(PVector input) {
    return dist(input.x, input.y, position.x, position.y) < size;
  }
}

class PlayPauseButton extends Button {

  private boolean playing = false;

  PlayPauseButton(PVector position, float size) {
    super(position, size, true, color(240, 100, 100), "play/pause");
  }

  void toggle() {
    setPlaying(!playing);
    if (playing == true) {
      buttonColor = color(100, 240, 100);
    } else {
      buttonColor = color(240, 100, 100);
    }
  }

  void setPlaying(boolean state) {
    if (state) {
      println("playing");
    } else {
      println("pausing"); //<>//
    }
    playing = state;
    setColor(state);
  }

  boolean getPlaying() {
    return playing;
  }

  void pressed() {
    toggle();
  }

  void setColor(boolean state) {
    if (state == true) {
      buttonColor = color(100, 240, 100);
    } else {
      buttonColor = color(240, 100, 100);
    }
  }
}

class ResetButton extends Button {
  ResetButton(PVector position, float size) {
    super(position, size, true, color(218, 112, 214), "reset");
  }

  void pressed() {
    println("reset");
    playPauseButton.setPlaying(false);
    player = new Player(new PVector(5 + imagePosition.x, 5 + imagePosition.y));
    actions.pointer.reset();
  }
}
