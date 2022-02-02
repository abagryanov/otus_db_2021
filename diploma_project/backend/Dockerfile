FROM azul/zulu-openjdk-alpine:11.0.5

ENV SPRING_APP_PROFILE=dev

RUN apk --no-cache add curl
ADD ./target/backend-0.0.1-SNAPSHOT.jar /app/

CMD java $JAVA_OPTIONS -jar -Dspring.profiles.active=$SPRING_APP_PROFILE /app/backend-0.0.1-SNAPSHOT.jar

EXPOSE 8090