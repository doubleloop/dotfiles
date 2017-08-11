FROM debian:buster
LABEL application=dotfiles_tests

# prevent dpkg errors
ENV TERM=xterm-256color

RUN apt-get update && \
    apt-get install -y \
    -o APT:Install-Recommend=false -o APT::Install-Suggests=false \
    build-essential \
    python \
    python-virtualenv \
    virtualenvwrapper \
    zsh \
    neovim \
    curl \
    tmux \
    git

RUN useradd -m -s /bin/zsh testuser
USER testuser

ENV PIP_NO_INPUT=1
ENV WORKON_HOME=/home/testuser/.virtualenvs

COPY . /home/testuser/dotfiles
USER root
RUN chown -R testuser:testuser /home/testuser
USER testuser
WORKDIR /home/testuser/dotfiles
RUN ./install.sh
CMD ["zsh"]
