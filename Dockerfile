FROM maven:3.8.7-amazoncorretto-19 AS builder
WORKDIR build
COPY pom.xml pom.xml
RUN mvn -fn clean verify
COPY src src
RUN mvn package

FROM openjdk:19-alpine
WORKDIR build
COPY --from=builder build/target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
