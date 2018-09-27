#!/bin/bash
#ln -s ~/.virtualenvs/${PWD##*/}/bin .

if [ -z "$1" ]; then
    echo "$0 branch (project)"
    exit 0
fi

pip install --upgrade pip
pip install simpleeval

hg clone ssh://hg@bitbucket.org/zikzakmedia-erp/trytontasks tasks
hg clone ssh://hg@bitbucket.org/zikzakmedia-erp/tryton-config config -b $1
touch local.cfg

pip install -r tasks/requirements.txt
pip install -r config/requirements.txt

invoke modules.clone -c base.cfg

if [ ! -z "$2" ]; then
    hg clone ssh://zikzak@hg.zzsaas.com//home/tryton/master/clients/$2/ modules/$2 -b $1
    rm local.cfg
    ln -s modules/$1/local.cfg .
    ln -s modules/$1/requirements.txt .
    pip install -r requirements.txt
fi
invoke modules.clone
quilt push -a

# master
# invoke modules.clone -c base.cfg -m
# invoke modules.clone -c core.cfg -m

# sao
invoke sao.install
invoke sao.grunt
