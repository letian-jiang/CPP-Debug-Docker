FROM ubuntu:22.04

LABEL maintainer="Lei Mao <dukeleimao@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# Install necessary dependencies
RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        automake \
        libtool \
        libssl-dev \
        pkg-config \
        apt-transport-https \
        ca-certificates \
        software-properties-common \
        wget \
        git \
        curl \
        gnupg \
        zlib1g-dev \
        swig \
        vim \
        gdb \
        valgrind \
        locales \
        locales-all &&\
    apt-get clean

# Install CMake
WORKDIR /root
RUN mkdir temp
WORKDIR /root/temp
RUN curl -OL https://github.com/Kitware/CMake/releases/download/v3.27.4/cmake-3.27.4.tar.gz
RUN tar -xzvf cmake-3.27.4.tar.gz

WORKDIR /root/temp/cmake-3.27.4
RUN ./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release
RUN make -j4
RUN make install

WORKDIR /root
RUN rm -rf temp

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
