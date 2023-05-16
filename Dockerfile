FROM archlinux
RUN pacman -Syu --noconfirm --needed nodejs imagemagick xorg-xcursorgen
WORKDIR /root/development/dragon_byte
COPY . .

