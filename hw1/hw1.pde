FileImporter importer;

PFont font;
boolean answered;

void setup() {
  size(800, 600);
  importer = new FileImporter();
  answered = true;
  font = createFont("Arial", 16, true);
}

void draw() {
  background(255);
  
  if (answered) {
      
  }
}

void mousePressed() {
  println("Mouse at: " + mouseX + ", " + mouseY);
}

void keyPressed() {
  // Check for special keys (UP, DOWN, etc.)
  if (key == CODED) {
    if (keyCode == SPACE) {
      
    }
  }
  // Regular keys
  else {
  }
}

void keyReleased() {
  // Check for special keys (UP, DOWN, etc.)
  if (key == CODED) {
  }
  // Regular keys
  else {
  }
}

