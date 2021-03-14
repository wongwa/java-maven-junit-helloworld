FROM openjdk
WORKDIR /app
COPY ./target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar .
CMD ["java", "-jar", "java-maven-junit-helloworld-2.0-SNAPSHOT.jar"]
