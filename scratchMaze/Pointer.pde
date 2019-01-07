class Pointer {
  int[] pointer;
  Pointer() {
    pointer = new int[0];
    pointer = append(pointer, 0);
  }

  void increment() {
    pointer[pointer.length - 1]++;
  }

  void decrement() {
    pointer[pointer.length - 1]--;
  }

  void indent() {
    pointer = append(pointer, 0);
  }

  void outdent() {
    pointer = shorten(pointer);
  }
  
  int[] removeFirst(int[] list) {
    return reverse(shorten(reverse(list)));
  }
  
  boolean equals(int[] otherPointer) {
    return pointerEquals(pointer, otherPointer);
  }
  
  boolean pointerEquals(int[] pointer1, int[] pointer2) {
    if (pointer1.length == 0 && pointer2.length == 0) {
      return true;
    } else if (pointer1.length == 0 || pointer2.length == 0) {
      return false;
    } else if (pointer1[0] == pointer2[0]) {
      return pointerEquals(removeFirst(pointer1), removeFirst(pointer2));
    } else {
      return false;
    }
  }
  
  void printPointer(int[] pointer) {
    if (pointer.length == 0) {
      println();
    } else {
      print(pointer[0] + ", ");
      printPointer(shorten(pointer));
    }
  }

  Block point(List<Block> blocks) throws IOException {
    return getBlock(blocks, pointer);
  }

  Block getBlock(List<Block> blocks, int[] pointers) throws IOException, ArrayIndexOutOfBoundsException {
    Block foundBlock = blocks.get(pointers[0]);
    if (pointers.length > 1) {
      int[] newPointers = reverse(shorten(reverse(pointers)));
      return getBlock(foundBlock.getSubBlocks(), newPointers);
    } else {
      return foundBlock;
    }
  }
}
