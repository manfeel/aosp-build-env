# Android build environment Dockerfile

FROM ubuntu:14.04

MAINTAINER Manfeel "manfeel@foxmail.com"

# Sets language to UTF8
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# ENV DOCKER_ANDROID_LANG en_US
# ENV DOCKER_ANDROID_DISPLAY_NAME manfeel-docker

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# Update apt-get
# RUN rm -rf /var/lib/apt/lists/*

# Set sources to aliyun
RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty universe \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty universe \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates universe \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates universe \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security universe \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security universe \n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security multiverse \n\
deb http://extras.ubuntu.com/ubuntu trusty main \n\
deb-src http://extras.ubuntu.com/ubuntu trusty main' > /etc/apt/sources.list
 

RUN apt-get update && apt-get install -y \
	openjdk-7-jdk git-core gnupg flex bison gperf build-essential \
	zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
	lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
	libgl1-mesa-dev libxml2-utils xsltproc unzip \
 && rm -rf /var/lib/apt/lists/*

# Add build user account, values are set to default below
ENV RUN_USER manfeel
ENV RUN_UID 3188

RUN id $RUN_USER || adduser --uid "$RUN_UID" \
    --gecos 'Build User' \
    --shell '/bin/sh' \
    --disabled-login \
    --disabled-password "$RUN_USER"

# Creating project directories prepared for build when running
# `docker run`
ENV ANDROID /android
RUN mkdir $ANDROID
RUN chown -R $RUN_USER:$RUN_USER $ANDROID
WORKDIR $ANDROID

USER $RUN_USER
