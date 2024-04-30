FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

RUN addgroup --gid 1000 jimvid
RUN adduser --gecos jimvid --uid 1000 --gid 1000 --disabled-password jimvid
RUN echo "jimvid ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo 'jimvid:123' | chpasswd

USER jimvid 
WORKDIR /home/jimvid

COPY --chown=jimvid:jimvid . ./ansible
CMD ["bash"]
