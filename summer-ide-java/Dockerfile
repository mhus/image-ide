FROM summer-eclipse

LABEL AUTHOR Mike Hummel <mh@mhus.de>

# install maven and gradel
RUN apt-get install -y --no-install-recommends \
    maven \
    gradle

# install conductor
RUN wget -qO- https://repo1.maven.org/maven2/de/mhus/conductor/conductor-launcher/1.1.0/conductor-launcher-1.1.0-install.sh | bash
