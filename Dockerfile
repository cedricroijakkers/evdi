# Copyright (c) 2022 DisplayLink (UK) Ltd.
FROM debian:bullseye
MAINTAINER Synaptics Technical Support <technical-enquiries@synaptics.com>

# Install basic tools
RUN apt-get update && apt-get install -y \
	curl \
	coreutils \
	fakeroot \
	file \
	git \
	lintian \
	make \
	shellcheck \
	pkg-config \
	qemu-system-x86 \
	wget

# Install java for Synopsys detect
RUN apt-get update && apt-get install -y default-jre default-jdk
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/

RUN dpkg --add-architecture i386
RUN dpkg --add-architecture armhf
RUN dpkg --add-architecture arm64

# Install linux kernel build dependencies
RUN apt-get update && apt-get install -y bc bison flex libelf-dev libssl-dev

# Install libevdi dependencies
RUN apt-get update && apt-get install -y libdrm-dev libc6-dev

# C++ gcc and gcc crossompilers
RUN apt-get update && apt-get install -y gcc g++
RUN apt-get update \
 && apt-get install -y build-essential gcc-multilib g++-multilib
RUN apt-get update && apt-get install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
RUN apt-get update && apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Dependencies for pybind
RUN apt-get update && apt-get install -y python3 libpython3-dev python3-pip
RUN pip3 install pybind11

# needed to generate the compile_commands.json
run apt-get update && apt-get install -y bear

# Install SonarQube utils
RUN cd /tmp && curl -ksSLo sonar-scanner-cli.zip https://artifactory:443/artifactory/third-party-tools/SonarQube/sonar-scanner-cli-linux.zip
RUN unzip -o /tmp/sonar-scanner-cli.zip -d /tmp && cp -r /tmp/sonar-scanner-*-linux/* /usr/local/ && chmod a+x /usr/local/bin/sonar-scanner
