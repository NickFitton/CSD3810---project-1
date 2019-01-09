Optional<Block> getBlock(int id) {
  return Optional.ofNullable(blocks.get(id));
}

void saveBlock(int id, Block block) {
  blocks.put(id, block);
}

void removeBlock(int id) {
  blocks.remove(id);
}

Block createBlock(TuioObject obj) {
  switch (obj.getSymbolID()) {
  case 0:
    return new Start(obj);
  case 1:
  case 14:
    return new OutDent(obj);
  case 2:
  case 15:
    return new Up(obj);
  case 3:
    return new Down(obj);
  case 4:
    return new Left(obj);
  case 16:
    return new Right(obj);
  case 5:
    return new ForLoop(obj, 5);
  case 17:
    return new InfiniteLoop(obj);
  case 6:
    return new If(obj);
  case 18:
    return new CanGoUp(obj);
  case 7:
    return new CanGoDown(obj);
  case 19:
    return new CanGoLeft(obj);
  case 12:
    return new CanGoRight(obj);
  case 13:
    return new TriggerBlock(obj);
  default:
    return new Up(obj);
  }
}
