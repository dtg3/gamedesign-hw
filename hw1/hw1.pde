// GAME STATES
final int START = 0;
final int QUESTION = 1;
final int ANSWER = 2;
final int INCORRECT = 3;
final int CORRECT = 4;
final int END = 5;

// TITLE FONT
final PFont TITLE_FONT = createFont("Arial", 32, true);
final PFont QUESTION_FONT = createFont("Arial", 20, true);
final PFont CHOICES_FONT = createFont("Arial", 16, true);


// GLOBAL VARIABLES
PImage background;
PFont font;
int state;
FileImporter importer; // holds questions
Question question;

void setup() {
  size(800, 600);
  importer = new FileImporter();
  background = loadImage("bg.jpg");
  state = START;
}

void draw() {
  background(background);
  if (state == START) {
    //title screen
    textFont(TITLE_FONT);       
    fill(0);
    textAlign(CENTER);
    text("Epic Happy Funtime Quiz!",width/2,60);
  }
  else if (state == QUESTION) {
    // write question
    textFont(QUESTION_FONT);       
    fill(0);
    textAlign(CENTER);
    text(question.questionText,width/2,60);
    
    // write choices
    textFont(QUESTION_FONT);       
    fill(0);
    textAlign(CENTER);
    int yPos = 60;
    for (int i = 0; i < question.choices.size(); ++i) {
      yPos += 40;
      text(question.choices.get(i),width/2,yPos);    
    }
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
    if (key == ESC)
      state = END;
      
    if (key == ENTER && state == START) {
      state = QUESTION;
      question = importer.nextQuestion();
    }
  }
}

