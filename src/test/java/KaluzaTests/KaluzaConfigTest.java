package KaluzaTests;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class KaluzaConfigTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:KaluzaTests")
                .outputCucumberJson(true)
                .karateEnv("features")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
