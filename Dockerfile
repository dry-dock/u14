FROM ubuntu:14.04

ADD . /tmp

RUN /tmp/install.sh && rm -rf /tmp