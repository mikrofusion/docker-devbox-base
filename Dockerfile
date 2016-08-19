FROM ubuntu:latest
MAINTAINER Mike Groseclose <mike.groseclose@gmail.com>

ARG user

RUN apt-get update

RUN apt-get install -y \
      sudo \
      openssh-client \
      git \
      ctags \
      man \
      curl \
      software-properties-common \
      tmux \
      tig \
      vim-gtk \
      silversearcher-ag \
      xclip

RUN apt-add-repository ppa:fish-shell/release-2 &&\
    apt-get update &&\
    apt-get install -y fish

# sshd & ssh forwarding
RUN apt-get install -y openssh-server &&\
    mkdir /var/run/sshd &&\
    sed -i 's/AllowAgentForwarding no/AllowAgentForwarding yes/' /etc/ssh/sshd_config

# set up user
RUN adduser --disabled-password $user
RUN adduser $user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# change default shell to fish
RUN usermod -s /usr/bin/fish $user

# update local (fix fish: Tried to print invalid wide character string)
RUN locale-gen en_US.UTF-8
RUN /usr/sbin/update-locale LANG=en_US.UTF-8

# run as user
USER $user

# vim
ADD vimrc /home/$user/.vimrc
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

# fish
RUN mkdir ~/.config
RUN mkdir ~/.config/fish
ADD config.fish /home/$user/.config/fish/config.fish
RUN curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
RUN fish -c 'fisher oh-my-fish/theme-bobthefish'

# tmux
ADD tmux.conf /home/$user/.tmux.conf
ADD tmux.conf.local /home/$user/.tmux.conf.local
RUN git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank

# git
ADD gitconfig /home/$user/.gitconfig

# expose ports
EXPOSE 22

CMD sudo /usr/sbin/sshd -D
