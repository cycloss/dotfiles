import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;

public class TestAppController {

    @FXML
    private Button incrementButton;

    @FXML
    private Label pressCounter;

    private int count = 0;

    public void initialize() {

    }

    private void incrementCounter() {
        count++;
        pressCounter.setText(String.valueOf(count));
    }

}
