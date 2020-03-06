#pull base image
FROM openjdk:8-jdk-alpine

#expose port 8080
EXPOSE 8080
#copy jar file 
COPY ./target/spring-boot-web-0.0.1-SNAPSHOT.jar ./

#default command
CMD java -jar ./spring-boot-web-0.0.1-SNAPSHOT.jar

#copy test hello world to docker image
#ADD ./data/spring-boot-web-0.0.1-SNAPSHOT.jar /data/spring-boot-web-0.0.1-SNAPSHOT.jar
