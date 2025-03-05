#Build Stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

#Run stage
FROM maven:3.9.6-eclipse-temurin-21
WORKDIR /app
COPY --from=build /app/target/LabApplication-*.jar /app/LabApplication.jar
EXPOSE 5000
ENTRYPOINT ["java", "-jar", "LabApplication.jar"]