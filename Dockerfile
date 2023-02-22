# Download base image ubuntu 22.04
FROM ubuntu:22.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl apt-transport-https gnupg

RUN curl https://deb.releases.teleport.dev/teleport-pubkey.asc -o /usr/share/keyrings/teleport-archive-keyring.asc
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg -o /usr/share/keyrings/kubernetes.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/teleport-archive-keyring.asc] https://deb.releases.teleport.dev/ stable main" | tee /etc/apt/sources.list.d/teleport.list > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes.gpg] http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list > /dev/null

# Update Ubuntu Software repository
RUN apt update

# Install teleport and kubectl
RUN apt install -y teleport kubectl netcat openssh-client
RUN rm -rf /var/lib/apt/lists/*
RUN apt clean
