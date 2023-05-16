FROM archlinux
RUN pacman -Syu --noconfirm --needed nodejs imagemagick xorg-xcursorgen
