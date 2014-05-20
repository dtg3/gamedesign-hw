// GAME STATES
final int START = 0;
final int QUESTION = 1;
final int ANSWER = 2;
final int INCORRECT = 3;
final int CORRECT = 4;
final int END = 5;

// TITLE FONT
final PFont TITLE_FONT = createFont("OpenSans-ExtraBold", 52, true);
final PFont QUESTION_FONT = createFont("OpenSans-Bold", 42, true);
final PFont CHOICES_FONT = createFont("OpenSans-Regular", 32, true);
final PFont CHOICES_BOLD_FONT = createFont("OpenSans-Bold", 42, true);

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
    textAlign(CENTER);
    text("Epic Happy Funtime Quiz!",width/2,60);
    fill(255);
  }
  else if (state == QUESTION) {
    // write question
    textFont(QUESTION_FONT);       
    textAlign(LEFT);
    text(question.questionText, 60, 60);
    fill(255);
    
    // write choices       
    int yPos = 90;
    char select = 'A';
    for (int i = 0; i < question.choices.size(); ++i) {
      yPos += 62;
      if (mouseY >= yPos + 15 || mouseY <= yPos - 15) {
        textFont(CHOICES_FONT);
        textAlign(LEFT);
        fill(255);    
      }
      else {
        textFont(CHOICES_BOLD_FONT);
        textAlign(LEFT);
        fill(255);    
      }
      text(select++ + ".)" + "   " + question.choices.get(i), 60, yPos);
          
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
      checkDone();
    }
  }
}

void checkDone() {
  if (question == null)
    state = END;
} 
