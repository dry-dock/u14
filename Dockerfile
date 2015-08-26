FROM ubuntu:14.04

ADD . /tmp

RUN /tmp/script.sh && rm /tmp/script.sh
