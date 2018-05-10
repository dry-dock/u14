FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

ADD . /u14

RUN /u14/install.sh && rm -rf /tmp && mkdir /tmp

ENV BASH_ENV "/etc/drydock/.env"
