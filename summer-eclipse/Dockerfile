FROM summer-ide

RUN     apt-get install  -y --no-install-recommends \
    java-11-sdk

USER $DOCKER_USER

RUN set -x \
&& cd /home/ubuntu \
&& mkdir bin \
&& cd bin \
&& wget -O eclipse.tar.gz https://archive.eclipse.org/technology/epp/downloads/release/2021-12/RC1/eclipse-committers-2021-12-RC1-linux-gtk-x86_64.tar.gz \
&& tar xzvf eclipse.tar.gz \
&& rm eclipse.tar.gz

ADD image/home $DOCKER_HOME

USER root