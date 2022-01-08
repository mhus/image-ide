# Builds a base Docker image for Ubuntu with X Windows and VNC support.
#
# The built image can be found at:
#
#   https://hub.docker.com/r/x11vnc/docker-desktop
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:master
LABEL maintainer Xiangmin Jiao <xmjiao@gmail.com>

WORKDIR /tmp
ADD image/etc /etc

ARG DEBIAN_FRONTEND=noninteractive 

# Install some required system tools and packages for X Windows
RUN add-apt-repository ppa:webupd8team/atom && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        automake \
        autoconf \
        gettext \
        libtool-bin \
        libltdl-dev \
        ruby \
        ruby-dev \
        atom \
        meld \
        docker.io && \
    apt-get -y autoremove && \
    gem install travis && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


########################################################
# Customize atom
########################################################
RUN pip install -U \
        autopep8 flake8 &&\
    apm install \
        language-docker \
        autocomplete-python \
        git-plus \
        merge-conflicts \
        split-diff \
        platformio-ide-terminal \
        intentions \
        busy-signal \
        linter-ui-default \
        linter \
        linter-flake8 \
        python-autopep8 \
        clang-format && \
    rm -rf /tmp/* && \
    echo '@atom .' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \
    \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

# Install vscode and system packages
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    \
    apt-get update && \
    apt-get install  -y --no-install-recommends \
        vim \
        build-essential \
        pkg-config \
        gfortran \
        cmake \
        bison \
        flex \
        git \
        bash-completion \
        rsync \
        wget \
        ccache \
        \
        clang \
        clang-format \
        libboost-all-dev \
        code \
        enchant && \
    apt-get install -y --no-install-recommends \
        pandoc \
        ttf-dejavu && \
    apt-get clean && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install -U \
        setuptools \
	ipython && \
    pip3 install -U \
        autopep8 \
        flake8 \
        yapf \
        black \
        pyenchant \
        pylint \
        pytest \
        Cython \
        Sphinx \
        sphinx_rtd_theme && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME