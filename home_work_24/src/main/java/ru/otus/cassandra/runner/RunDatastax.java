package ru.otus.cassandra.runner;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;
import com.datastax.driver.mapping.Mapper;
import com.datastax.driver.mapping.MappingManager;
import org.apache.commons.lang3.time.StopWatch;
import org.apache.logging.log4j.LogManager;
import ru.otus.cassandra.common.Common;
import ru.otus.cassandra.model.DatastaxUser;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class RunDatastax extends Run {
    private Cluster cluster;
    private Session session;
    private Mapper<DatastaxUser> mapper;
    private Map<UUID, DatastaxUser> users;


    public RunDatastax() {
        super(LogManager.getLogger(RunDatastax.class));
        this.users = new HashMap<>();
    }

    @Override
    public void open() {
        cluster = Cluster.builder()
                .addContactPoint(Common.EXAMPLE_CASSANDRA_HOST)
                .build();

        session = cluster.connect();

        session.execute("CREATE KEYSPACE IF NOT EXISTS example" +
                "  WITH REPLICATION = { " +
                "   'class' : 'SimpleStrategy', " +
                "   'replication_factor' : 1 " +
                "  };");

        session.execute("CREATE TABLE IF NOT EXISTS example.user " +
                "( id UUID PRIMARY KEY, first_name text, last_name text, city text);");

        MappingManager manager = new MappingManager(session);
        mapper = manager.mapper(DatastaxUser.class);
    }

    @Override
    public void close() {
        session.close();
        cluster.close();
    }

    @Override
    public void clean() {
        open();
        session.execute("TRUNCATE example.user");
        close();
    }

    @Override
    public StopWatch write(int repetition) throws InterruptedException {
        StopWatch stopwatch = new StopWatch();

        for (int i = 0; i < Common.OPERATIONS; i++) {
            UUID uuid = Common.uuids.get(repetition * Common.OPERATIONS + i);

            DatastaxUser user = new DatastaxUser(
                    uuid,
                    "John" + i,
                    "Smith" + i,
                    "London" + i
            );
            users.put(uuid, user);

            Common.resumeOrStartStopWatch(stopwatch);
            mapper.save(user);
            stopwatch.suspend();
        }

        stopwatch.stop();
        return stopwatch;
    }

    @Override
    public StopWatch read(int repetition) throws InterruptedException {
        StopWatch stopwatch = new StopWatch();

        for (int i = 0; i < Common.OPERATIONS; i++) {
            UUID uuid = Common.uuids.get(repetition * Common.OPERATIONS + i);

            Common.resumeOrStartStopWatch(stopwatch);
            DatastaxUser user = (DatastaxUser) mapper.get(uuid);
            stopwatch.suspend();
        }

        stopwatch.stop();
        return stopwatch;
    }

    @Override
    public StopWatch update(int repetition) throws InterruptedException {
        StopWatch stopwatch = new StopWatch();

        for (int i = 0; i < Common.OPERATIONS; i++) {
            UUID uuid = Common.uuids.get(repetition * Common.OPERATIONS + i);
            DatastaxUser user = users.get(uuid);
            user.setFirstName(user.getFirstName() + "___u");
            user.setLastName(user.getLastName() + "___u");
            user.setCity(user.getCity() + "___u");

            Common.resumeOrStartStopWatch(stopwatch);
            mapper.save(user);
            stopwatch.suspend();
        }

        stopwatch.stop();
        return stopwatch;
    }

    @Override
    public StopWatch delete(int repetition) throws InterruptedException {
        StopWatch stopwatch = new StopWatch();

        for (int i = 0; i < Common.OPERATIONS; i++) {
            UUID uuid = Common.uuids.get(repetition * Common.OPERATIONS + i);
            DatastaxUser user = users.get(uuid);

            Common.resumeOrStartStopWatch(stopwatch);
            mapper.delete(user);
            stopwatch.suspend();
        }

        stopwatch.stop();
        return stopwatch;
    }
}
