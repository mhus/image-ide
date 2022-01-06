FROM debian:bullseye

LABEL AUTHOR Mike Hummel <mh@mhus.de>

RUN set -x \
&& apt-get update \
&& apt-get -y --no-install-recommends install \
less \
nano \
vim-tiny \
gnupg \
gnupg2 \
netcat-openbsd \
socat \
openssl \
ssh \
telnet \
net-tools \
wget \
curl \
zip \
unzip \
git \
ca-certificates

#RUN set -x \
#&& cd / \
#&& wget -O openjdk.tar.gz https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_alpine-linux_hotspot_11.0.13_8.tar.gz \
#&& cd /usr/local \
#&& tar xzvf /openjdk.tar.gz \
#&& ln -s /usr/local/jdk-11.0.13+8 /usr/local/java \
#&& echo "export PATH=/usr/local/java/bin:\$PATH" > /etc/profile.d/java.sh \
#&& echo "export JAVA_HOME=/usr/local/java" >> /etc/profile.d/java.sh

RUN set -x \
&& cd / \
&& wget -O eclipse.tar.gz https://archive.eclipse.org/technology/epp/downloads/release/2021-12/RC1/eclipse-committers-2021-12-RC1-linux-gtk-x86_64.tar.gz \
&& cd /usr/local \
&& tar xzvf /eclipse.tar.gz 

RUN set -x \
&& apt-get -y --no-install-recommends install \
maven

RUN set -x \
&& apt-get -y --no-install-recommends install \
tightvncserver \
xfonts-base \
lwm \
xterm \
xdotool \
tigervnc-viewer

ENV DISPLAY :1
ENV RESOLUTION 1024x768x16

RUN set -x \
&& apt-get -y --no-install-recommends install \
  xfce4 \
  faenza-icon-theme \
  xvfb \
  x11vnc \
  supervisor \
  novnc \
  dbus-x11

RUN set -x \
cd /etc \
openssl \
req -x509 \
-nodes \
-newkey rsa:3072 \
-keyout \
novnc.pem \
-out novnc.pem \
-days 3650 \
-subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

RUN set -x \
&& apt-get -y --no-install-recommends install \
 firefox-esr 

RUN set -x \
&& wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
&& install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
&& sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
&& rm -f packages.microsoft.gpg \
&& apt -y --no-install-recommends install apt-transport-https \
&& apt update \
&& apt -y --no-install-recommends install code 

COPY supervisor /tmp
COPY novnc_server /usr/bin/
SHELL ["/bin/bash", "-c"]

RUN set -x \
&& echo_supervisord_conf > /etc/supervisord.conf \
&&  sed -i -r -f /tmp/supervisor.sed /etc/supervisord.conf \
&&  mkdir -pv /etc/supervisor/conf.d /var/log/{novnc,x11vnc,xfce4,xvfb} \
&&  mv /tmp/supervisor-*.ini /etc/supervisor/conf.d/ \
&&  chmod +x /usr/bin/novnc_server \
&&  rm -fr /tmp/supervisor*

RUN set -x \
&& adduser --disabled-password -uid 1000  user \
&& su - user -c "mkdir /home/user/.vnc" \
&& su - user -c "touch /home/user/.vnc/passwd" \
&& su - user -c "x11vnc -storepasswd test /home/user/.vnc/passwd"
