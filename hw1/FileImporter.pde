import java.util.Collections;
import java.util.ArrayList;
import java.util.Arrays; 

public class FileImporter {
  private final String filename = "question.dat";
  private ArrayList<String> textData;
  private int numCorrect;
  private int currentQuestion;
  
  public FileImporter() {
    textData = new ArrayList<String>(Arrays.asList(loadStrings(filename)));
    Collections.shuffle(textData);
    numCorrect = 0;
    currentQuestion = 0;
  }
  
} 
