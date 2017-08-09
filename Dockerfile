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
SHELL ["/bin/bash", "-c"]

ENV PIP_NO_INPUT=1
ENV WORKON_HOME=/home/testuser/.virtualenvs

RUN source /usr/share/virtualenvwrapper/virtualenvwrapper.sh && \
    mkvirtualenv dotfiles && \
    pip install pip --upgrade && \
    pip install --upgrade mackup

WORKDIR /home/testuser
COPY . /home/testuser/dotfiles
USER root
RUN chown -R testuser:testuser /home/testuser/dotfiles
USER testuser
RUN mv /home/testuser/dotfiles/mackup.cfg /home/testuser/.mackup.cfg && \
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh && \
    workon dotfiles && \
    mackup -f restore
CMD ["zsh"]
