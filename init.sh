#!/bin/sh

_ask() { echo -n "${1} [y/N]? "; read A; [ "${A}" = "Y" -o "${A}" = "y" ]; }

## proxy
if _ask "Use Proxy ?"; then
    [ $# -ne 1 ] && echo "usage: source init.sh <proxy_domain>" && return 1

    DOMAIN=$1
    PROXY="http://proxy.${DOMAIN}.co.jp:10080"
    NOPROXY="localhost,.proxy.${DOMAIN}.co.jp,/var/run/docker.sock"

    export ALL_PROXY="${PROXY}"
    export http_proxy="${ALL_PROXY}"
    export https_proxy="${ALL_PROXY}"
    export ftp_proxy="${ALL_PROXY}"
    export HTTP_PROXY="${ALL_PROXY}"
    export HTTPS_PROXY="${ALL_PROXY}"
    export FTP_PROXY="${ALL_PROXY}"

    export no_proxy="${NOPROXY}"
    export NO_PROXY="${NOPROXY}"
else
    [ $# -ne 0 ] && echo "usage: source init.sh" && return 1
    unset ALL_PROXY
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY

    unset no_proxy
    unset NO_PROXY
fi

## linuxbrew PATH
export BREWHOME=~/.linuxbrew
export LD_LIBRARY_PATH=${BREWHOME}/lib64:${BREWHOME}/lib:${LD_LIBRARY_PATH}
export PATH=${BREWHOME}/bin:${PATH}
