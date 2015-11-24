FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/default-java
ENV PKG_NAME demo-spring-tomcat-1.0-SNAPSHOT.jar
ENV BASE_DIR /home/spring
ENV VOL_DIR ${BASE_DIR}/data

# run with /bin/sh
 
RUN apt-get update
RUN apt-get install -y \
	default-jre \
	default-jdk \
	tomcat7 \
	curl \
	apt-file
RUN apt-get clean

RUN mkdir -p ${BASE_DIR}
RUN mkdir -p ${VOL_DIR}

WORKDIR ${BASE_DIR}
VOLUME ${VOL_DIR}

ADD target/${PKG_NAME} .

RUN echo "#!/bin/bash" >> run.sh
#RUN echo "export JAVA_HOME=${JAVA_HOME}" >> run.sh
RUN echo "echo starting daemon using JAVA_HOME: \$JAVA_HOME" >> run.sh
RUN echo "echo hello world > ${VOL_DIR}/data.log" >> run.sh
RUN echo "echo created log file: ${VOL_DIR}/data.log" >> run.sh
RUN echo "java -jar ${PKG_NAME}">> run.sh
RUN chmod 755 run.sh

EXPOSE 8080

#CMD java -jar ${PKG_NAME}
CMD ./run.sh

# run forground (only /Users directory is allowed for share on Mac)
# $ docker run --rm -i -t -p 8080:8080 -v $HOME/tmp:/home/spring/data zoonoo/spring-tomcat

# run background 
# $ docker run --rm -d -p ...

# check env
# $ docker run --rm -i -t zoonoo/spring-tomcat env

