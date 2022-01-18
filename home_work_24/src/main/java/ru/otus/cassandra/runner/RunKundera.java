package ru.otus.cassandra.runner;

import com.impetus.client.cassandra.common.CassandraConstants;
import org.apache.commons.lang3.time.StopWatch;
import org.apache.logging.log4j.LogManager;
import ru.otus.cassandra.common.Common;
import ru.otus.cassandra.model.KunderaUser;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class RunKundera extends Run {
    private EntityManagerFactory emf;
    private EntityManager em;
    private Map<UUID, KunderaUser> users;

    public RunKundera() {
        super(LogManager.getLogger(RunKundera.class));
        this.users = new HashMap<>();
    }

    @Override
    public void open() {
        Map<String, String> props = new HashMap<>();
        props.put(CassandraConstants.CQL_VERSION, CassandraConstants.CQL_VERSION_3_0);

        emf = Persistence.createEntityManagerFactory("cassandra_pu", props);
        em = emf.createEntityManager();
    }

    @Override
    public void close() {
        em.close();
        emf.close();
    }

    @Override
    public void clean() {
        open();
        em.createNativeQuery("TRUNCATE user").executeUpdate();
        close();
    }

    @Override
    public StopWatch write(int repetition) throws InterruptedException {
        StopWatch stopwatch = new StopWatch();

        for (int i = 0; i < Common.OPERATIONS; i++) {
            UUID uuid = Common.uuids.get(repetition * Common.OPERATIONS + i);

            KunderaUser user = new KunderaUser(
                    uuid,
                    "John" + i,
                    "Smith" + i,
                    "London" + i
            );
            users.put(uuid, user);

            Common.resumeOrStartStopWatch(stopwatch);
            em.persist(user);
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
            KunderaUser user = em.find(KunderaUser.class, uuid);
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
            KunderaUser user = users.get(uuid);
            user.setFirstName(user.getFirstName() + "___u");
            user.setLastName(user.getLastName() + "___u");
            user.setCity(user.getCity() + "___u");

            Common.resumeOrStartStopWatch(stopwatch);
            em.merge(user);
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
            KunderaUser user = users.get(uuid);

            Common.resumeOrStartStopWatch(stopwatch);
            em.remove(user);
            stopwatch.suspend();
        }

        stopwatch.stop();
        return stopwatch;
    }
}
