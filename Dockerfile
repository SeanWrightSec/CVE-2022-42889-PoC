FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update \
    && apt install -y openjdk-11-jdk-headless maven \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir poc
WORKDIR poc

COPY pom.xml .
COPY src/ src/

RUN mvn clean install  \
    && mvn dependency:get -Dartifact=org.codehaus.mojo:exec-maven-plugin:3.1.0

CMD mvn -q exec:java -Dexec.mainClass='com.seanwrightsec.poc.PoC'