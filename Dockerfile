FROM ubuntu:jammy AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential sudo && \
    #apt-add-repository -y ppa:neovim-ppa/unstable && apt update && apt install -y neovim && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS prime
ARG TAGS
RUN sed -i 's/\%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL) NOPASSWD:ALL/g'  /etc/sudoers
RUN addgroup --gid 1000 zellione
RUN adduser --gecos zellione --uid 1000 --gid 1000 --disabled-password zellione
RUN usermod -g sudo zellione
RUN passwd -d zellione
USER zellione
WORKDIR /home/zellione

FROM prime
WORKDIR /opt/test
COPY --chown=zellione . .
#CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
CMD ["sh", "-c", "./ansible-run"]

