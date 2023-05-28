FROM archlinux
RUN pacman -Syu --noconfirm --needed ruby imagemagick xorg-xcursorgen zip
WORKDIR /root/development/dragon_byte
COPY . .

