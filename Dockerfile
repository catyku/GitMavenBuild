FROM openjdk:8-jdk

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN  apt-get update && apt-get install -y curl git \
  && apt-get install -y --no-install-recommends apt-utils \
  && mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn 

#if you project is private ,you need blow 
# add credentials on build
RUN  mkdir /root/.ssh && chmod 0700 /root/.ssh \
&& ssh-keyscan -t rsa bitbucket.org >> /root/.ssh/known_hosts \
&& ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts 

#COPY private_key /root 
#RUN cat /root/private_key > /root/.ssh/id_rsa && rm /root/private_key 

#RUN chmod 600 /root/.ssh/id_rsa



ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
RUN chmod u+x /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/
COPY run.sh /root/run.sh
RUN chmod u+x /root/run.sh && mkdir  /root/target/

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]
