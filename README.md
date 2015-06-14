# devtools-dockerfile
sona-tar development tools on Ubuntu


## SETUP

### docker and docker-compose installation

- CentOS

```
# yum -y install docker python-pip
# pip install docker-compose
```

- Ubuntu

```
# apt-get install docker python-pip
# pip install docker-compose
```


### get docker settings

```
# git clone https://github.com/sona-tar/devtools-dockerfile.git
# cd devtools-dockerfile
```


## CONTAINER

### docker-compose lifecycle
```
# docker-compose up -d
Pulling dev (sonatar/devtools-dockerfile:latest)...
Creating devtoolsdockerfile_dev_1...

# docker-compose ps
Name                  Command        State           Ports
----------------------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp

# docker-compose stop
Stopping devtoolsdockerfile_dev_1...

# docker-compose ps
          Name                  Command        State    Ports
-------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Exit 0

# docker-compose start
Starting devtoolsdockerfile_dev_1...

# docker-compose ps
          Name                  Command        State           Ports
----------------------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp

# docker-compose stop
# docker-compose rm
Are you sure? [yN] y
Removing devtoolsdockerfile_dev_1...
# docker-compose ps
Name   Command   State   Ports
------------------------------
```

[Dockerライフサイクルをハンズオンで学ぶ](http://qiita.com/iron-breaker/items/6b74fe9b0620b74d4281)


### ssh login

```
# docker-compose ps
          Name                  Command        State           Ports
----------------------------------------------------------------------------
devtoolsdockerfile_dev_1   /usr/sbin/sshd -D   Up      0.0.0.0:10022->22/tcp
```

if you use RSA authentication.

```
# CONTAINERHOST=localhost
# ssh-key -t rsa
# ls ~/.ssh/id_rsa.pub
# ssh-copy-id -p 10022 develop@${CONTAINERHOST}
# scp -P 10022 ~/.ssh/id_rsa develop@${CONTAINERHOST}:~/.ssh/
```

```
# ssh -p 10022 develop@${CONTAINERHOST}
```

### git settings
```
export GITHUB_USER=YOU
$ git config --global user.name    ${GITHUB_USER}
$ git config --global user.email   username@gmail.com
$ git config --global github.user  ${GITHUB_USER}
$ git config --global github.token ....
```

Get [Github token](https://github.com/settings/tokens)


### tree

host root direcotory mount to /host
```
$ ls /host
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

```

home directory
```
$ tree $HOME -L 1 # omitted
/home/develop
|-- proxy.sh
|-- bin/
|-- pkg/
|-- src/
|-- .zshrc
|-- .linuxbrew/
|-- .ssh/
`-- .zshrc.d/
```

### proxy setting

- on container
```
$ source proxy.sh DOMAIN=yourhost
```

[SOTA Proxy環境下でDockerを動かす](http://deeeet.com/writing/2014/07/01/docker-behind-proxy/)


## DEVELOP by GOLANG
### Create Reapository

```
$ mkdir -p ~/src/github.com/${GITHUB_USER}/go-sample
$ cd ~/src/github.com/${GITHUB_USER}/go-sample
$ git init
$ hub create
```

### Write README and First commit

```
$ echo "go-sample" > README.md
$ git add README.md
$ git commit -m "Add README.md"
$ git log
$ git push origin master
$ hub browse
```

### Write Golang Code
```
cat << '_EOF_' > sample-main.go
package main

func main() {
     SamplePrint("test 1")
     SamplePrint("test 2")
}
_EOF_

cat << '_EOF_' > sample-print.go
package main

import  "fmt"

func SamplePrint(msg string) {
     fmt.Printf("go-sample %s\n", msg)
}
_EOF_

$ gtags -v --gtagslabel=pygments
$ ls G*
GPATH  GRTAGS  GTAGS
$ go build
$ ./go-sample
go-sample test 1
go-sample test 2
```

### Commit and Push

```
$ git add sample-main.go sample-print.go
$ git commit -m "Add sample-main.go sample-print.go"
$ git tag -a 0.0.1 -m "Release 0.0.1"
$ git push --tag origin master
```

### Release binary

build for Multi platoforms by gox.


```
$ create_pkg.sh 0.0.1
```

release all binary by ghr.

```
$ release_pkg.sh 0.0.1
$ hub release
 (0.0.1)
$ hub browse
```

## DEVELOPER TOOLS

### editor

* emacs
* vim

### language

* C/C++
* Perl
* Python
* Ruby
* Golang

### github

* [ghq](https://github.com/motemen/ghq) -  Manage remote repository clones
* [ghr](https://github.com/tcnksm/ghr) - Easily ship your project to your user using Github Releases.
* [ghs](https://github.com/sona-tar/ghs) -  search repository in github

### utils

* [brew](https://github.com/Homebrew/linuxbrew) - Linuxbrew is a fork of Homebrew, the Mac OS package manager, for Linux.
* [peco](https://github.com/peco/peco) - Simplistic interactive filtering tool
* [gtags and pygments](http://qiita.com/sona-tar/items/672df1259a76f082ce42) - gtags support golang, ruby, python


### alias

* [gpi](http://qiita.com/sona-tar/items/c11063cd3671c07b6e0a) - ghs | peco | ghq import


### global alias

* [General git filters](http://qiita.com/sona-tar/items/fe401c597e8e51d4e243)
```
$ git add F
$ git rebase H
$ git checkout H
```


## BUILD YOURSELF CONTAINER

Modify Dockerfile and then exec following command.

```
docker-compose -f build.yml build
```
