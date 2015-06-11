# devtools-dockerfile
sona-tar development tools on Ubuntu


## SETUP

### docker and docker-compose installation

- CentOS

```
yum -y install docker python-pip
pip install docker-compose
```

- Ubuntu

```
apt-get install docker python-pip
pip install docker-compose
```


### get docker settings

```
git clone https://github.com/sona-tar/devtools-dockerfile.git
cd devtools-dockerfile
```


## CONTAINER

### docker-compose lifecycle
```
$ docker-compose up -d
Pulling dev (sonatar/devtools-dockerfile:latest)...
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

$ docker-compose start
Starting devtoolsdockerfile_dev_1...

$ docker-compose ps
          Name                  Command        State           Ports
----------------------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp

$ docker-compose stop
$ docker-compose rm
Are you sure? [yN] y
Removing devtoolsdockerfile_dev_1...
$ docker-compose ps
Name   Command   State   Ports
------------------------------
```

[more detail](http://qiita.com/iron-breaker/items/6b74fe9b0620b74d4281)


### ssh login

```
$ docker-compose ps
          Name                  Command        State           Ports
----------------------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp

$ ssh -p 10022 develop@localhost
```


### proxy setting

```
source proxy.sh DOMAIN=yourhost
```

## DEVELOPER TOOLS

### editor

* emacs
* vim

### language

* python
* ruby
* golang

### github

* [ghq](https://github.com/motemen/ghq) -  Manage remote repository clones
* [ghs](https://github.com/sona-tar/ghs) -  search repository in github

### utils

* [peco](https://github.com/peco/peco) - Simplistic interactive filtering tool
* [gtags and pygments](http://qiita.com/sona-tar/items/672df1259a76f082ce42) - gtags support golang, ruby, python


### alias

* [gpi](http://qiita.com/sona-tar/items/c11063cd3671c07b6e0a) - ghs | peco | ghq import


### global alias

* [general git filters](http://qiita.com/sona-tar/items/fe401c597e8e51d4e243)
```
git add F
git rebase H
git checkout H
```


## CONTANER BUILD YOURSELF

Modify Dockerfile and then exec following command.

```
docker-compose -f build.yml build
```
