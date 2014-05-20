// GAME STATES
final int START = 0;
final int QUESTION = 1;
final int ANSWER = 2;
final int INCORRECT = 3;
final int CORRECT = 4;
final int END = 5;

// TITLE FONT
final PFont TITLE = createFont("Arial", 32, true);

// GLOBAL VARIABLES
PFont font;
int state;
FileImporter importer; // holds questions

void setup() {
  size(800, 600);
  importer = new FileImporter();
  state = START;
}

void draw() {
  background(255);
  if (state == START) {
    //title screen
    textFont(TITLE);       
    fill(0);
    textAlign(CENTER);
    text("Epic Happy Funtime Quiz!",width/2,60);
  }
  else if (state == QUESTION) {
  }
  else if (state == ANSWER) {
  }
  else if (state == INCORRECT) {
  }
  else if (state == CORRECT) {
  }
  else {
    exit();
  }
}

void mousePressed() {
  println("Mouse at: " + mouseX + ", " + mouseY);
}

void keyReleased() {
  println("RELEASED");
  // Check for special keys (UP, DOWN, etc.)
  if (key == CODED) {
    println("CODED KEY");
  }
  // Regular keys
  else {
    println("ASCII KEY");
    if (key == ESC) {
      state = END;
    }
  }
}

