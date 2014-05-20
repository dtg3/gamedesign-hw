import java.util.ArrayList;
import java.util.Collections;

public class Question {
  
  public String questionText;
  public ArrayList<String> choices;
  public String correctAnswer;
  
  public Question() {
    questionText = "";
    correctAnswer = "";
    choices = new ArrayList<String>();
  }
  
  public Question(String q, String a) {
    questionText = q;
    correctAnswer = a;
    choices = new ArrayList<String>();
  }
  
  public void addChoice(String choice) {
    choices.add(choice);
  }
  
  public void shuffleChoices() {
    Collections.shuffle(choices);
  }
  
  public boolean checkAnswer(int index) {
    return correctAnswer.equalsIgnoreCase(choices.get(index));
  }
}
