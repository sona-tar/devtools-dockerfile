FROM ubuntu
MAINTAINER sona-tar

# EVN
ENV USER_NAME      develop
ENV USER_PASS      develop
ENV ROOT_PASS      root

RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get install -y openssh-server language-pack-ja zsh tmux git mercurial subversion gcc
RUN apt-get install -y wget unzip curl p7zip-full xterm tree grep
RUN apt-get install -y emacs24 texinfo vim rlwrap python-pip
RUN pip install diff-highlight



RUN mkdir /var/run/sshd
RUN echo "root:${ROOT_PASS}" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


# Add User
RUN adduser --disabled-password --gecos "" ${USER_NAME} \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "${USER_NAME}:${USER_PASS}" | chpasswd

RUN chsh -s /bin/zsh ${USER_NAME}


USER ${USER_NAME}

RUN mkdir /home/${USER_NAME}/.ssh
RUN chmod 700 /home/${USER_NAME}/.ssh
# ADD id_rsa /home/${USER_NAME}/.ssh/id_rsa
# ADD config /home/${USER_NAME}/.ssh/config
# ADD authorized_keys /home/${USER_NAME}/.ssh/authorized_keys

USER root
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
