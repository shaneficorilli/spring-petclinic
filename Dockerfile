FROM eclipse-temurin:17-jdk-alpine 
RUN mkdir /petclinic
COPY spring-petclinic-3.3.0-SNAPSHOT.jar.original /petclinic/spring-petclinic-3.3.0-SNAPSHOT.jar
ENV SERVER_PORT=8080
WORKDIR /petclinic
EXPOSE 8080
ENTRYPOINT ["java","-jar","/spring-petclinic-3.3.0-SNAPSHOT.jar"]
