FROM centos

RUN yum -y install java-1.7.0-openjdk-devel.x86_64 

ADD target/dropwizard-helloworld-1.0-SNAPSHOT.jar /
ADD example.yml /
ADD example.keystore /

CMD ["java", "-jar", "dropwizard-helloworld-1.0-SNAPSHOT.jar", "server", "example.yml"]

EXPOSE 8080
