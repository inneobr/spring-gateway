FROM maven:3.8.4-openjdk-17-slim AS build  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean install -DskipTests

FROM openjdk:17
RUN mkdir api
COPY --from=build /usr/src/app/target/*.jar api/gateway-cloud.jar
EXPOSE 7100
ENTRYPOINT ["java", "-jar", "/api/gateway-cloud.jar"]