int stepCount = 15; // Dictates the stride of the entity, the smaller the number, the less it moves per action
boolean collision = true; // If true, player can collide with walls
boolean displayImage = true;

boolean debugMode = false;

PVector playerSize = new PVector(5, 5);

color black = color(0, 0, 0);
int rectBorder = 8;

PVector imagePosition = new PVector(100, 339);
//PVector imagePosition = new PVector(0, 0);

PVector screenScale = new PVector(1, 1);
