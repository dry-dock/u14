FROM ubuntu:14.04

ADD . /home/dry-dock/u14/

RUN /home/dry-dock/u14/script.sh && rm -rf /home/dry-dock

CMD ["/bin/bash"]
