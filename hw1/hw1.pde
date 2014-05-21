/*
  Game Design Homework 1 - Quiz
  Art: Michael Schwartz
  Programming: Drew Guarnera
  Music from http://freemusicarchive.org/genre/Pop/
    Artist Josh: Woodward
    Song: Good to Go (Instrumental) 
*/

import ddf.minim.*;

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
// Images
PImage background;
PShape sun_happy;
PShape sun_question;
PShape sun_surprised;
PShape winner;

// Audio
AudioPlayer player;
Minim minim;

// Data and state
FileImporter importer; // holds questions
Question question;
ArrayList<Integer> choicePos;
int answer;
int state;
boolean loadQuestion;

void setup() {
  size(800, 600);
  importer = new FileImporter();
  background = loadImage("bgf.jpg");
  state = START;
  sun_happy = loadShape("sun_happy.svg");
  sun_question = loadShape("sun_question.svg");
  sun_surprised = loadShape("sun_surprised.svg");
  winner = loadShape("winner.svg");
  loadQuestion = false;
  answer = -1;
  
  minim = new Minim(this);
  player = minim.loadFile("bg.mp3", 2048);
  player.loop();
}

void draw() {
  background(background);
  if (state == START) {
    //title screen
    textFont(TITLE_FONT);       
    textAlign(CENTER);
    fill(255);
    text("Epic Happy Funtime Quiz!",width/2,100);
    shape(sun_happy, width/2-310, height/2-325);
    text("PRESS ENTER", width/2, height - 20);
  }
  else if (state == QUESTION) {
    // write question
    textFont(QUESTION_FONT);       
    textAlign(LEFT);
    fill(255);
    text(question.questionText, 60, 60);
    
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
    shape(sun_question, width/2-150, height/2-385);
  }
  else if (state == INCORRECT) {
    // Discourage
    println("INCORRECT");
    textFont(QUESTION_FONT);       
    textAlign(LEFT);
    fill(255,64,64);
    text(question.questionText, 60, 60);
    
    int yPos = 90;
    char select = 'A';
    for (int i = 0; i < question.choices.size(); ++i) {
      yPos += 62;
      textAlign(LEFT);
      if (i == answer) {
        fill(255,64,64);
        textFont(CHOICES_BOLD_FONT);
      }
      else {
        fill(255);
        textFont(CHOICES_FONT);
      }
      text(select++ + ".)" + "   " + question.choices.get(i), 60, yPos);
    }
    
    textFont(TITLE_FONT);       
    textAlign(CENTER);
    fill(255,64,64);
    text("Oops, Try Again!", width/2, height - 80);
    text("Press Enter", width/2, height - 20);
    shape(sun_surprised, width/2-150, height/2-385);
  }
  else if (state == CORRECT) {
    // Encourage
    println("CORRECT");
    textFont(QUESTION_FONT);       
    textAlign(LEFT);
    fill(192,255,62);
    text(question.questionText, 60, 60);
    
    int yPos = 90;
    char select = 'A';
    for (int i = 0; i < question.choices.size(); ++i) {
      yPos += 62;
      textAlign(LEFT);
      if (i == answer) {
        fill(192,255,62);
        textFont(CHOICES_BOLD_FONT);
      }
      else {
        fill(255);
        textFont(CHOICES_FONT);
      }
      text(select++ + ".)" + "   " + question.choices.get(i), 60, yPos);
    }
    textFont(TITLE_FONT);       
    textAlign(CENTER);
    fill(192,255,62);
    text("Good Job!", width/2, height - 80);
    text("Press Enter", width/2, height - 20);
    shape(sun_happy, width/2-150, height/2-385);
  }
  else if (state == END) {
    println("DONE");
    fill(255);   
    shape(winner, width/2-600, height/2-500, 1200, 1000);
    text("PRESS ENTER", width/2, height - 20);
  }
  else {
    player.close();
    minim.stop();
    super.stop();
    println("QUIT");
    exit();
  }
}

void mousePressed() {
  if (state == QUESTION) {
    for (int i = 0; i < choicePos.size(); ++i) {
      if (mouseY <= choicePos.get(i) + 22 && mouseY >= choicePos.get(i) - 22) {
        answer = i;
        println(question.checkAnswer(i));
        if(question.checkAnswer(i)) {
          state = CORRECT;
        }
        else {
          state = INCORRECT;
        }
        println(state);
        break;
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
      answer = -1;
    }
    else if (key == ENTER && state == INCORRECT) {
      state = QUESTION;
    }
    else if (key == ENTER && state == CORRECT) {
      state = QUESTION;
      question = importer.nextQuestion();
      checkDone();
      loadQuestion = true;
      answer = -1;
    }
    else if (key == ENTER && state == END) {
      state = -1;  
    }
  }
}

void checkDone() {
  if (question == null)
    state = END;
} 
