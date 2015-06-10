# devtools-dockerfile
sona-tar development tools on Ubuntu


## start container
```
docker-compose up -d
docker-compose ps
          Name                  Command        State           Ports        
          ----------------------------------------------------------------------------
          devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp

```

## ssh login
```
HOSTIP=192.168.1.2
ssh -p 10022 develop@${HOSTIP}
```


## setup dotfiles
```
DOTFILESREPO=https://github.com/sona-tar/dotfiles
source init.sh
cd src/github.com
git clone ${DOTFILESREPO}
cd dotfiles
./setup.sh
./app_install.sh
zsh
```

## developer tools
```
emacs -nw
go
ghq
ghs
peco
```
