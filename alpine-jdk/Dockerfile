FROM alpine:latest

ENV JAVA_HOME /usr/lib/jvm/java-1.8-jdk
ENV PATH $PATH:$JAVA_HOME/bin

RUN apk -U add bash wget \
 && rm -rf /var/cache/apk/* \
 && cd /tmp \
 && wget -c -O- --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz | tar -xz \
 && mkdir -p /usr/lib/jvm/java-1.8-jdk \
 && mv jdk1.8.0_181/* /usr/lib/jvm/java-1.8-jdk/ \
 && rm -rf /tmp/*

CMD ["/bin/sh"]
