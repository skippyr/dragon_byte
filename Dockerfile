FROM archlinux
RUN pacman -Syu --noconfirm --needed zip nodejs imagemagick xorg-xcursorgen
WORKDIR /root/development/dragon_byte
COPY . .

