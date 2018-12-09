int defineElement(TuioObject obj) {
  switch (obj.getSymbolID()) {
  default: 
  case 0: // Start
  case 5: // If else
  case 6: // Up
  case 7: // Down
  case 8: // Left
  case 9: // Right
    return 0;
  case 2: // If
  case 3: // ForLoop start
  case 4: // InfLoop start
    return 1;
  case 1: // End indent
    return -1;
  }
}
