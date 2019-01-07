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
    return new OutDent(obj);
  case 2:
    return new Up(obj);
  case 3:
    return new Down(obj);
  case 4:
    return new Left(obj);
  case 5:
    return new Right(obj);
  case 6:
    return new ForLoop(obj, 5);
  case 7:
    return new InfiniteLoop(obj);
  case 8:
    return new If(obj);
  case 9:
    return new CanGoUp(obj);
  case 10:
    return new CanGoDown(obj);
  default:
    return new Up(obj);
  }
}
