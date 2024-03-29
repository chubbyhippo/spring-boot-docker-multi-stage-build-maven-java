FROM maven:3.9.5-amazoncorretto-21 AS builder
WORKDIR build
COPY pom.xml pom.xml
RUN mvn -fn clean verify
COPY src src
RUN mvn package

FROM bellsoft/liberica-openjre-alpine:21
WORKDIR build
COPY --from=builder build/target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
