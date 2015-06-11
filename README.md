# devtools-dockerfile
sona-tar development tools on Ubuntu


## SETUP

```
git clone https://github.com/sona-tar/devtools-dockerfile.git
cd devtools-dockerfile
```

## docker-compose LIFECYCLE
```
$ docker-compose up -d
Creating devtoolsdockerfile_dev_1...

$ docker-compose ps
Name                  Command        State           Ports
----------------------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp

$ docker-compose stop
Stopping devtoolsdockerfile_dev_1...

$ docker-compose ps
          Name                  Command        State    Ports
-------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Exit 0

$ docker-compose rm
Are you sure? [yN] y
Removing devtoolsdockerfile_dev_1...
$ docker-compose ps
Name   Command   State   Ports
------------------------------
```

## SSH LOGIN

```
HOSTIP=192.168.1.2
ssh -p 10022 develop@${HOSTIP}
```


## PROXY

```
source proxy.sh DOMAIN=yourhost
```

## DEVELOPER TOOLS

### EDITOR

* emacs
* vim

### LANGUAGE

* python
* ruby
* golang

### GITHUB

* [ghq](https://github.com/motemen/ghq) -  Manage remote repository clones
* [ghs](https://github.com/sona-tar/ghs) -  search repository in github

### UTILS

* [peco](https://github.com/peco/peco) - Simplistic interactive filtering tool
* [gtags and pygments](http://qiita.com/sona-tar/items/672df1259a76f082ce42) - gtags support golang, ruby, python


### ALIAS

* [gpi](http://qiita.com/sona-tar/items/c11063cd3671c07b6e0a) - ghs | peco | ghq


### GLOBAL ALIAS
```
git add S
git rebase H
git checkout H
```
