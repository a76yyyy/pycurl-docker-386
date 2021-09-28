# 基础镜像
FROM python:3.8-alpine

# 维护者信息
LABEL maintainer "a76yyyy <q981331502@163.com>"

# Envirenment for pycurl
ENV PYCURL_SSL_LIBRARY=openssl
ENV CURL_VERSION 7.79.1

# 换源 & For nghttp2-dev, we need testing respository.
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >>/etc/apk/repositories 

# Install packages
RUN apk update && \
    apk add --update --no-cache openssl openssl-dev openrc redis bash git autoconf g++ tzdata nano openssh-client automake \
    nghttp2-dev ca-certificates zlib zlib-dev brotli brotli-dev zstd zstd-dev linux-headers libtool

RUN apk add --update --no-cache --virtual curldeps make perl && \
    wget https://curl.se/download/curl-$CURL_VERSION.tar.bz2 && \
    tar xjvf curl-$CURL_VERSION.tar.bz2 && \
    rm curl-$CURL_VERSION.tar.bz2 && \
    cd curl-$CURL_VERSION && \
    ./configure \
        --with-nghttp2=/usr \
        --prefix=/usr \
        --with-ssl \
        --enable-ipv6 \
        --enable-unix-sockets \
        --without-libidn \
        --disable-static \
        --disable-ldap \
        --with-pic && \
    make && \
    make install && \
    cd .. && \
    rm -r curl-$CURL_VERSION && \
    apk del curldeps
    
# Pip install modules
RUN pip install --upgrade setuptools \
    && pip install --upgrade wheel \
    && pip install pycurl \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/share/man/* 

