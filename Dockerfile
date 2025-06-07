###########################################################
# Haxe/JS Dev Container
###########################################################
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Define versions
ARG HAXE_VERSION=4.3.7
ARG NEKO_VERSION=2.4.1
ARG NODE_VERSION=20
ARG YARN_VERSION=1
ARG PNPM_VERSION=10

# Use Japanese mirror sever for Ubuntu packages
RUN sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list.d/ubuntu.sources

# Update packages and install dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y locales \
    && locale-gen ja_JP.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set Japanese locale
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# Install Neko VM & Haxe
RUN NEKO_VERSION_TAG=$(echo ${NEKO_VERSION} | tr '.' '-') \
    && curl -L https://github.com/HaxeFoundation/neko/releases/download/v${NEKO_VERSION_TAG}/neko-${NEKO_VERSION}-linux64.tar.gz -o /tmp/neko.tar.gz \
    && tar -xzf /tmp/neko.tar.gz -C /tmp \
    && mv /tmp/neko-* /usr/local/neko \
    && rm /tmp/neko.tar.gz
RUN curl -L https://github.com/HaxeFoundation/haxe/releases/download/${HAXE_VERSION}/haxe-${HAXE_VERSION}-linux64.tar.gz -o /tmp/haxe.tar.gz \
    && tar -xzf /tmp/haxe.tar.gz -C /tmp \
    && mv /tmp/haxe_* /usr/local/haxe \
    && rm /tmp/haxe.tar.gz
RUN ln -s /usr/local/neko/neko /usr/local/bin/neko \
    && ln -s /usr/local/neko/nekoc /usr/local/bin/nekoc \
    && ln -s /usr/local/neko/nekoml /usr/local/bin/nekoml \
    && ln -s /usr/local/haxe/haxe /usr/local/bin/haxe \
    && ln -s /usr/local/haxe/haxelib /usr/local/bin/haxelib
ENV NEKOPATH=/usr/local/neko
ENV LD_LIBRARY_PATH=${NEKOPATH}
ENV HAXEPATH=/usr/local/haxe
ENV HAXE_STD_PATH=${HAXEPATH}/std

# [setup vscode user]
USER vscode

# Setup haxelib
RUN mkdir -p ~/.local/haxelib \
    && haxelib setup ~/.local/haxelib

# Install Volta
RUN curl https://get.volta.sh | bash

# Install Node.js and Yarn
RUN ~/.volta/bin/volta install node@${NODE_VERSION} yarn@${YARN_VERSION} pnpm@${PNPM_VERSION}
