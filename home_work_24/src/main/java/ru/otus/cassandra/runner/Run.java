package ru.otus.cassandra.runner;

import org.apache.commons.lang3.time.StopWatch;
import org.apache.logging.log4j.Logger;
import ru.otus.cassandra.common.Common;

import java.util.ArrayList;
import java.util.List;
import java.util.LongSummaryStatistics;
import java.util.concurrent.TimeUnit;

public abstract class Run {
    private final Logger logger;

    public Run(final Logger logger) {
        this.logger = logger;
    }

    public void run() throws InterruptedException {
        for (int i = 0; i < Common.CYCLES; i++) {
            Common.uuids = Common.generateUUIDs();
            clean();

            LongSummaryStatistics statsWrite = runWrites();
            Common.logStatistics(logger, "WRITE", statsWrite);

            LongSummaryStatistics statsRead = runReads();
            Common.logStatistics(logger, "READ", statsRead);

            LongSummaryStatistics statsUpdate = runUpdates();
            Common.logStatistics(logger, "UPDATE", statsUpdate);

            LongSummaryStatistics statsDelete = runDeletes();
            Common.logStatistics(logger, "DELETE", statsDelete);

            logger.info("");
        }
    }

    public LongSummaryStatistics runWrites() throws InterruptedException {
        open();

        List<StopWatch> stopwatches = new ArrayList<>();
        for (int i = 0; i < Common.REPETITIONS; i++) {
            stopwatches.add(write(i));
        }

        LongSummaryStatistics stats = stopwatches.stream()
                .mapToLong((x) -> x.getTime(TimeUnit.MILLISECONDS))
                .summaryStatistics();
        close();
        return stats;
    }

    public LongSummaryStatistics runReads() throws InterruptedException {
        open();

        List<StopWatch> stopwatches = new ArrayList<>();
        for (int i = 0; i < Common.REPETITIONS; i++) {
            stopwatches.add(read(i));
        }

        LongSummaryStatistics stats = stopwatches.stream()
                .mapToLong((x) -> x.getTime(TimeUnit.MILLISECONDS))
                .summaryStatistics();
        close();
        return stats;
    }

    public LongSummaryStatistics runUpdates() throws InterruptedException {
        open();

        List<StopWatch> stopwatches = new ArrayList<>();
        for (int i = 0; i < Common.REPETITIONS; i++) {
            stopwatches.add(update(i));
        }

        LongSummaryStatistics stats = stopwatches.stream()
                .mapToLong((x) -> x.getTime(TimeUnit.MILLISECONDS))
                .summaryStatistics();
        close();
        return stats;
    }

    public LongSummaryStatistics runDeletes() throws InterruptedException {
        open();

        List<StopWatch> stopwatches = new ArrayList<>();
        for (int i = 0; i < Common.REPETITIONS; i++) {
            stopwatches.add(delete(i));
        }

        LongSummaryStatistics stats = stopwatches.stream()
                .mapToLong((x) -> x.getTime(TimeUnit.MILLISECONDS))
                .summaryStatistics();
        close();
        return stats;
    }

    abstract public void open();
    abstract public void close();
    abstract public void clean();

    abstract StopWatch write(int repetition) throws InterruptedException;
    abstract StopWatch read(int repetition) throws InterruptedException;
    abstract StopWatch update(int repetition) throws InterruptedException;
    abstract StopWatch delete(int repetition) throws InterruptedException;
}
