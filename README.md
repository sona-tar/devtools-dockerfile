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


## setup proxy
```
source proxy.sh DOMAIN=yourhost
```

## developer tools

### editor
emacs
vim

### Language
python
ruby
golang

### github
[ghq](https://github.com/motemen/ghq)   Manage remote repository clones
[ghs](https://github.com/sona-tar/ghs)  search repository in github

### utils
[peco](https://github.com/peco/peco)  Simplistic interactive filtering tool
[gtags and pygments](http://qiita.com/sona-tar/items/672df1259a76f082ce42) gtags support golang, ruby, python


### alias
[gpi](http://qiita.com/sona-tar/items/c11063cd3671c07b6e0a) ghs | peco | ghq


### Global alias
```
git add S
git rebase H
git checkout H
```
