package ru.otus.cassandra.main;

import ru.otus.cassandra.runner.RunDatastax;
import ru.otus.cassandra.runner.RunKundera;

public class Main {
    public static void main(String[] args) throws InterruptedException {
        RunDatastax runDatastax = new RunDatastax();
        runDatastax.run();

//        RunKundera runKundera = new RunKundera();
//        runKundera.run();
    }
}
