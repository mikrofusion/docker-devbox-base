FROM ubuntu:latest
MAINTAINER Mike Groseclose <mike.groseclose@gmail.com>

ENV USER mikrofusion

RUN apt-get update

RUN apt-get install -y \
      sudo \
      openssh-client \
      git \
      ctags \
      man \
      curl \
      software-properties-common \
      fish \
      tmux \
      ruby

# https://github.com/chrishunt/github-auth
RUN gem install github-auth --no-rdoc --no-ri

# neovim
RUN add-apt-repository ppa:neovim-ppa/unstable &&\
    apt-get update &&\
    apt-get install neovim

# sshd & ssh forwarding
RUN apt-get install -y openssh-server &&\
    mkdir /var/run/sshd &&\
    sed -i 's/AllowAgentForwarding no/AllowAgentForwarding yes/' /etc/ssh/sshd_config
    #echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config

# set up user
RUN adduser --disabled-password $USER
RUN adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# run as user
USER $USER

# ssh
RUN mkdir /home/$USER/.ssh
RUN touch /home/$USER/.ssh/authorized_keys
RUN gh-auth add --users=$USER

# neovim
RUN mkdir ~/.config
RUN mkdir ~/.config/nvim
RUN ln -s ~/.vim ~/.config/nvim
RUN ln -s ~/.vimrc ~/.config/nvim/init.vim

# expose ports
EXPOSE 22 80 3000 4000

CMD sudo /usr/sbin/sshd -D
