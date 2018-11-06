class Pointer {
  int[] pointer;
  Pointer() {
    pointer = new int[0];
    pointer = append(pointer, 0);
  }

  void increment() {
    int updatedPointer = pointer[pointer.length - 1];
    pointer[pointer.length - 1] = updatedPointer + 1;
  }

  void decrement() {
    int updatedPointer = pointer[pointer.length - 1];
    pointer[pointer.length - 1] = updatedPointer - 1;
  }

  void indent() {
    pointer = append(pointer, 0);
  }

  void outdent() {
    pointer = shorten(pointer);
  }

  Block point(Block[] blocks) throws IOException {
    return getBlock(blocks, pointer);
  }

  Block getBlock(Block[] blocks, int[] pointers) throws IOException, ArrayIndexOutOfBoundsException {
    int point = (pointers[0]);
    Block foundBlock = blocks[point];
    if (pointers.length > 1) {
      int[] newPointers = reverse(shorten(reverse(pointers)));
      return getBlock(foundBlock.getSubBlocks(), newPointers);
    } else {
      return foundBlock;
    }
  }
}
