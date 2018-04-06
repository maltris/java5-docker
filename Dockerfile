FROM debian:stretch-slim
MAINTAINER Lewis

ENV DEBIAN_FRONTEND noninteractive
# this is the checksum of jdk-1_5_0_22-linux-amd64.bin from oracle
ENV JDK_CSUM_SHA512 c181929619866470efa0cf8223d7349e2b703db41f8b16f25a8567ca44ee9a9817365cad0ea21ad9520cc08d2114234e1d9a2d23d777b9c532f830c0e1041e77
ENV JAVA_HOME /jdk1.5.0_22
ENV PATH /jdk1.5.0_22/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN \
    apt-get update \
    && apt-get -y install curl \
    && curl http://monalisa.cern.ch/MONALISA/download/java/jdk-1_5_0_22-linux-amd64.bin > /tmp/jdk-1_5_0_22-linux-amd64.bin \
    && echo "${JDK_CSUM_SHA512} /tmp/jdk-1_5_0_22-linux-amd64.bin" | sha512sum -c - \
    && echo yes|sh /tmp/jdk-1_5_0_22-linux-amd64.bin \
    && rm /tmp/jdk-1_5_0_22-linux-amd64.bin \
    && apt-get -y purge curl \
    && apt-get -y autoremove --purge \
    && apt-get clean

# alternate  java method disabled: download local jdk
#ADD jdk-1_5_0_22-linux-amd64.bin /tmp/
