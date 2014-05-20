// GAME STATES
final int START = 0;
final int QUESTION = 1;
final int INCORRECT = 2;
final int CORRECT = 3;
final int END = 4;

// TITLE FONT
final PFont TITLE_FONT = createFont("OpenSans-ExtraBold", 52, true);
final PFont QUESTION_FONT = createFont("OpenSans-Bold", 42, true);
final PFont CHOICES_FONT = createFont("OpenSans-Regular", 32, true);
final PFont CHOICES_BOLD_FONT = createFont("OpenSans-Bold", 42, true);

// GLOBAL VARIABLES
PImage background;
PFont font;
int state;
PShape sun;
FileImporter importer; // holds questions
Question question;
ArrayList<Integer> choicePos;
boolean loadQuestion;

void setup() {
  size(800, 600);
  importer = new FileImporter();
  background = loadImage("bgf.jpg");
  state = START;
  sun = loadShape("sun.svg");
  loadQuestion = false;
}

void draw() {
  background(background);
  if (state == START) {
    //title screen
    textFont(TITLE_FONT);       
    textAlign(CENTER);
    text("Epic Happy Funtime Quiz!",width/2,100);
    fill(255);
    shape(sun, width/2-310, height/2-325);
    text("PRESS ENTER", width/2, height - 20);
  }
  else if (state == QUESTION) {
    // write question
    textFont(QUESTION_FONT);       
    textAlign(LEFT);
    text(question.questionText, 60, 60);
    fill(255);
    
    // write choices       
    if (loadQuestion)
      choicePos = new ArrayList<Integer>();
      
    int yPos = 90;
    char select = 'A';
    for (int i = 0; i < question.choices.size(); ++i) {
      yPos += 62;
      if (mouseY >= yPos + 22 || mouseY <= yPos - 22) {
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
      
      if (loadQuestion)
        choicePos.add(yPos);
    }
    loadQuestion = false;
  }
  else if (state == INCORRECT) {
    // Discourage
  }
  else if (state == CORRECT) {
    // Encourage
  }
  else if (state == END) {
    // Results screen
  }
  else {
    exit();
  }
}

void mousePressed() {
  if (state == QUESTION) {
    println(choicePos.size());
    for (int i = 0; i < choicePos.size(); ++i) {
      if (mouseY <= choicePos.get(i) + 22 && mouseY >= choicePos.get(i) - 22) {
        println(question.checkAnswer(i));
      }
    }
  }
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
      loadQuestion = true;
    }
    else if (key == ENTER && state == END) {  
    }
  }
}

void checkDone() {
  if (question == null)
    state = END;
} 
