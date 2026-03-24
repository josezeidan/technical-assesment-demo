package com.example.api.runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ApiTestRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:com/example/api/features")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}



