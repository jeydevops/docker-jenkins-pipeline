FROM java:8-jdk

MAINTAINER ayache khettar <ayache.khettar@infinityworks.com>

ADD target/dropwizard-example-1.0.0-SNAPSHOT.jar /
ADD example.yml /data/example.yml
ADD example.keystore /data/example.keystore

CMD ["java", "-jar", "dropwizard-example-1.0.0-SNAPSHOT.jar", "server", "data/example.yml"]

EXPOSE 8080
