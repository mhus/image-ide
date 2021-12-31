FROM edgelevel/alpine-xfce-vnc

LABEL AUTHOR Mike Hummel <mh@mhus.de>

RUN set -x \
&& apk update \
&& apk upgrade \
&& apk add bash bash-completion mksh lxterminal libc6-compat

RUN set -x \
&& cd / \
&& wget -O openjdk.tar.gz https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_alpine-linux_hotspot_11.0.13_8.tar.gz \
&& cd /usr/local \
&& tar xzvf /openjdk.tar.gz \
&& ln -s /usr/local/jdk-11.0.13+8 /usr/local/java \
&& echo "export PATH=/usr/local/java/bin:\$PATH" > /etc/profile.d/java.sh \
&& echo "export JAVA_HOME=/usr/local/java" >> /etc/profile.d/java.sh

RUN set -x \
&& cd / \
&& wget -O eclipse.tar.gz https://archive.eclipse.org/technology/epp/downloads/release/2021-12/RC1/eclipse-committers-2021-12-RC1-linux-gtk-x86_64.tar.gz \
&& cd /usr/local \
&& tar xzvf /eclipse.tar.gz 
