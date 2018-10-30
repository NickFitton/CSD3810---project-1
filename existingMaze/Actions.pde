class Actions {
  String[] actions;
  int currentAction;
  int actionSteps;

  Actions() {
    actions = new String[0];
    currentAction = 0;
    actionSteps = 0;
  }

  void executeAction() {
    switch (speed) {
    case 2:
      if (actions.length > currentAction) {
        for (int i=0; i<actionStepLength; i++) {
          move(actions[currentAction]);
        }
        currentAction++;
      }
      break;
    case 3:
      for (String action : actions) {
        for (int i=0; i<actionStepLength; i++) {
          move(action);
        }
      }
      currentAction = actions.length;
      break;
    default:
    case 1:
      if (actions.length <= currentAction && loopActions) {
        currentAction = 0;
      } else if (actions.length > currentAction) {
        move(actions[currentAction]);
        actionSteps++;
        if (actionSteps >= actionStepLength) {
          actionSteps = 0;
          currentAction++;
        }
      }
      break;
    }
  }

  void move(String direction) {
    switch (direction) {
    case "up":
      player.moveUp();
      break;
    case "down":
      player.moveDown();
      break;
    case "left":
      player.moveLeft();
      break;
    case "right":
      player.moveRight();
      break;
    }
  }

  void addMovement(String direction) throws IOException {
    if (validMovement(direction)) {
      actions = append(actions, direction);
    } else {
      throw new IOException("Given movement '" + direction + "' is not valid");
    }
  }

  void addMovements(String... directions) throws IOException {
    for (String direction : directions) {
      addMovement(direction);
    }
  }

  void printActions() {
    for (String action : actions) {
      print("\"" + action + "\", ");
    }
    println();
  }

  boolean validMovement(String direction) {
    String[] validDirections = {"up", "down", "left", "right"};
    for (String valid : validDirections) {
      if (valid.equals(direction)) {
        return true;
      }
    }
    return false;
  }
}  
