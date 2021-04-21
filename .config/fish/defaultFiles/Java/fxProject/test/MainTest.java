import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.Test;
import org.junit.platform.commons.annotation.Testable;

@Testable
public class MainTest {
    
    private Main main = new Main();

    @Test
    public void testIfTrue() {

        System.out.println("Testing " + main.getClass().getName());
        assertTrue(true);

    }

}
