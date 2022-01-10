
# Builds a base Docker image for Ubuntu with X Windows and VNC support.
#
# The built image can be found at:
#
#   https://hub.docker.com/r/x11vnc/docker-desktop
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM vscode-desktop:22.04.00

LABEL AUTHOR Mike Hummel <mh@mhus.de>

USER $DOCKER_USER
ADD image/home $DOCKER_HOME
USER root

ADD image/etc /etc

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    sudo

RUN rm /etc/my_init.d/init-sshd.sh

#ENTRYPOINT ["/sbin/my_init", "--", "/sbin/setuser", "ubuntu"]

WORKDIR $DOCKER_HOME
