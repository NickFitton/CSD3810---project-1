abstract class Block {
  String actionName;
}

class DevBlock extends Block {
  DevBlock(String actionName) {
    this.actionName = actionName;
  }
}

class Movement extends Block {
  Movement(String direction) throws IOException {
    if (!validMovement(direction)) {
      throw new IOException("Given direction is not valid, can only be 'up', 'down', 'left' or 'right'");
    }
    actionName = direction;
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

abstract class Indentable extends Block {
  Block[] subBlocks;

  abstract Block[] resolveIndent();
}

class If extends Indentable {
  Query query;
  Block[] blocks;

  If(Block[] blocks, Query query) {
    this.blocks = blocks;
    this.query = query;
  }

  Block[] resolveIndent() {
    if (query.execute()) {
      return blocks;
    } else {
      return new Block[0];
    }
  }
}
