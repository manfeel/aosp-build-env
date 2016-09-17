# Android & Openwrt build environment Dockerfile
# docker pull hub.c.163.com/library/ubuntu:14.04
FROM hub.c.163.com/library/ubuntu:14.04

MAINTAINER Manfeel "manfeel@foxmail.com"

# Sets language to UTF8
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# set root password
RUN echo "root:root" | chpasswd

# Set sources to aliyun
COPY sources.list /etc/apt/

# install full vim editor
# RUN apt-get remove -y vim-common && apt-get install -y vim

RUN apt-get update && apt-get install -y \
	bison build-essential \
	curl ccache \
	dos2unix \
	flex \
	gettext gperf git-core gnupg gcc-multilib g++-multilib gawk \
	libc6-dev-i386 lib32ncurses5-dev libx11-dev lib32z-dev libgl1-mesa-dev libssl-dev libxml2-utils \
	openjdk-7-jdk \
	python \
	quilt \
	subversion \
	unzip \
	vim \
	wget \
	xsltproc x11proto-core-dev \
	zip zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

# Add build user account, values are set to default below
ENV RUN_USER manfeel
ENV RUN_UID 2318

RUN id $RUN_USER || adduser --uid "$RUN_UID" \
    --gecos 'Build User' \
    --shell '/bin/sh' \
    --disabled-login "$RUN_USER" && usermod -a -G sudo "$RUN_USER" \
    && echo "$RUN_USER:password" | chpasswd

# Creating project directories prepared for build when running
# `docker run`
ENV WORKS /works
RUN mkdir $WORKS
RUN chown -R $RUN_USER:$RUN_USER $WORKS
WORKDIR $WORKS

USER $RUN_USER
