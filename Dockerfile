FROM ubuntu
MAINTAINER sona-tar

# EVN
ENV USER_NAME      develop
ENV USER_PASS      develop
ENV USER_HOME      "/home/${USER_NAME}"
ENV ROOT_PASS      root

# root user
## app install
RUN apt-get -yq update && apt-get -yq upgrade \
     build-essential libncurses5-dev openssh-server language-pack-ja \
     zsh tmux \
     git mercurial subversion gcc \
     python-pip ruby \
     wget zip unzip curl p7zip-full xterm tree \
     grep silversearcher-ag \
     emacs24 texinfo vim rlwrap \
     && \
     pip install diff-highlight pygments

## ssh settings
RUN mkdir /var/run/sshd && \
     echo "root:${ROOT_PASS}" | chpasswd && \
     sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
     sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Add User
RUN adduser --disabled-password --gecos "" ${USER_NAME} \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "${USER_NAME}:${USER_PASS}" | chpasswd

RUN chsh -s /bin/zsh ${USER_NAME}

# develop user
## ssh
USER ${USER_NAME}
RUN mkdir /home/${USER_NAME}/.ssh && \
     chmod 700 /home/${USER_NAME}/.ssh
# ADD id_rsa /home/${USER_NAME}/.ssh/id_rsa
# ADD config /home/${USER_NAME}/.ssh/config
# ADD authorized_keys /home/${USER_NAME}/.ssh/authorized_keys

## app
RUN cd $HOME && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
RUN ${HOME}/.linuxbrew/bin/brew install \
           go peco/peco/peco motemen/ghq/ghq sona-tar/tools/ghs global \
	   tcnksm/ghr/ghr
ENV GOPATH "${USER_HOME}"
ENV PATH   "$PATH:$GOPATH/bin:/usr/local/go/bin:${USER_HOME}/.linuxbrew/bin"
RUN go get github.com/mitchellh/gox
RUN gox -build-toolchain
RUN mkdir -p /home/${USER_NAME}/src/github.com /home/${USER_NAME}/bin /home/${USER_NAME}/.zshrc.d
ADD proxy.sh /home/${USER_NAME}/
ADD zshrc /home/${USER_NAME}/.zshrc
ADD zshrc.d /home/${USER_NAME}/zshrc.d/

# root user
USER root
EXPOSE 22
RUN mkdir /host
CMD ["/usr/sbin/sshd", "-D"]
