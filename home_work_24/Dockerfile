FROM openjdk:11.0.11

# Install Bash
RUN apt-get install -y bash

# Copy resources
WORKDIR /
COPY /scripts/wait-for-it.sh wait-for-it.sh
COPY target/cassandra-api-1.0-SNAPSHOT-jar-with-dependencies.jar cassandra-api.jar

# Wait for Cassandra and Kafka to be available and run application
CMD ./wait-for-it.sh -s -t 360 $EXAMPLE_CASSANDRA_HOST:$EXAMPLE_CASSANDRA_PORT -- java -Xmx512m -jar cassandra-api.jar