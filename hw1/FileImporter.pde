import java.util.Collections;
import java.util.ArrayList;
import java.util.Arrays; 

public class FileImporter {
  private final String filename = "data/questions.json";
  private ArrayList<Question> textData;
  private int numCorrect;
  private int currentQuestion;
  
  public FileImporter() {
    // Setup Question List
    textData = new ArrayList<Question>();
    
    // Load JSON File
    JSONObject json = loadJSONObject(filename);
    
    // Get the array of questions
    JSONArray questions = json.getJSONArray("questions");
    for (int i = 0; i < questions.size(); i++) {     
      JSONObject question = questions.getJSONObject(i); 
      Question q = new Question(question.getString("question"),
                                question.getString("correct"));
      
      JSONArray choices = question.getJSONArray("choices");
      // Get the array of choices
      for (int j = 0; j < choices.size(); j++) { 
        JSONObject choice = choices.getJSONObject(j); 
        q.addChoice(choice.getString("choice"));
      }   
      q.shuffleChoices();
    }
    
    Collections.shuffle(textData);
    numCorrect = 0;
    currentQuestion = 0;
  }
  
  public Question nextQuestion() {
    if (textData.size() >= currentQuestion)
      return null;
    
    ++currentQuestion;
    return textData.get(currentQuestion - 1); 
  } 
} 
