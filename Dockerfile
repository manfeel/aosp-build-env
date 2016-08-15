# Android build environment Dockerfile

FROM ubuntu:14.04

MAINTAINER Manfeel "manfeel@foxmail.com"

# Sets language to UTF8
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# Set sources to aliyun
COPY sources.list /etc/apt/
 
RUN apt-get update && apt-get remove vim-common && apt-get install -y \
	vim openjdk-7-jdk git-core gnupg flex bison gperf build-essential \
	zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
	lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
	libgl1-mesa-dev libxml2-utils xsltproc unzip \
 && rm -rf /var/lib/apt/lists/*

# Add build user account, values are set to default below
ENV RUN_USER manfeel
ENV RUN_UID 2318

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
