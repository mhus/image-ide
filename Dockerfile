FROM alpine:3.13

LABEL AUTHOR Mike Hummel <mh@mhus.de>
# Credits https://github.com/edgelevel/alpine-xfce-vnc 

#--------------------------------
# alpine-xfce-vnc/base
#--------------------------------

ENV DISPLAY :1
ENV RESOLUTION 1024x768x16
# ENV RESOLUTION 1920x1080x24

# setup desktop environment (xfce4), display server (xvfb), vnc server (x11vnc)
RUN apk add --no-cache \
  xfce4 \
  faenza-icon-theme \
  xvfb \
  x11vnc

# setup novnc (requires bash)
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  bash \
  novnc && \
  ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# setup supervisor
COPY supervisor /tmp
SHELL ["/bin/bash", "-c"]
RUN apk add --no-cache supervisor && \
  echo_supervisord_conf > /etc/supervisord.conf && \
  sed -i -r -f /tmp/supervisor.sed /etc/supervisord.conf && \
  mkdir -pv /etc/supervisor/conf.d /var/log/{novnc,x11vnc,xfce4,xvfb} && \
  mv /tmp/supervisor-*.ini /etc/supervisor/conf.d/ && \
  rm -fr /tmp/supervisor*

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

#--------------------------------
# alpine-xfce-vnc/web
#--------------------------------

# timezone
# https://gitlab.alpinelinux.org/alpine/aports/-/issues/5543
# /usr/share/zoneinfo/Europe/Dublin
ARG TZ='Europe/Dublin'
ENV DEFAULT_TZ ${TZ}
RUN apk upgrade --update && \
  apk add --no-cache tzdata && \
  cp /usr/share/zoneinfo/${DEFAULT_TZ} /etc/localtime && \
  date

# commons
RUN apk add --no-cache \
  git \
  vim \
  zip

# python and pip
# http://github.com/Docker-Hub-frolvlad/docker-alpine-python3
ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache \
  python3 && \
  ln -sf python3 /usr/bin/python && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --no-cache --upgrade pip setuptools wheel && \
  ln -sf pip3 /usr/bin/pip

# gcc
RUN apk add --no-cache \
  musl-dev \
  gcc \
  make

# java
RUN apk add --no-cache \
  openjdk11-jdk

# golang
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
  go

# rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# filesystem
RUN apk add --no-cache \
  exa \
  fd \
  ripgrep

# networking
RUN apk add --no-cache \
  bind-tools \
  curl \
  httpie \
  jq

# monitoring
RUN apk add --no-cache \
  ncdu \
  htop

# browsers
RUN apk add --no-cache \
  firefox-esr \
  lynx

# terminals
RUN apk add --no-cache \
  xfce4-terminal \
  tmux \
  neofetch

# image viewer
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  nomacs

# update configs
COPY .bashrc .vimrc /root/

WORKDIR /root

#--------------------------------
# mhus
#--------------------------------

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
