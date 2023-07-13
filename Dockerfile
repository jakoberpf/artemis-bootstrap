FROM ubuntu:22.04

LABEL maintainer="github@jakoberpf.de"

RUN apt-get update && apt-get install sshpass python3 python3-pip -y

COPY ansible/requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY ansible/collections/requirements.yml requirements.yml
RUN ansible-galaxy install -r requirements.yml

WORKDIR /bootstrap
