FROM archlinux:latest AS base
WORKDIR /usr/local/bin
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm sudo ansible

FROM base AS zellione
ARG TAGS
# %wheel ALL=\(ALL:ALL\) NOPASSWD: ALL
RUN sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g'  /etc/sudoers
RUN useradd -m -G wheel -s /bin/bash zellione
RUN passwd -d zellione
USER zellione
WORKDIR /home/zellione

FROM zellione
WORKDIR /opt/test
COPY --chown=zellione ./arch .
COPY --chown=zellione ./.ssh ./.ssh
# #CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
CMD ["sh", "-c", "./ansible-arch"]
