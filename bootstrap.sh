#!/bin/bash
#ln -s ~/.virtualenvs/${PWD##*/}/bin .

if [ -z "$1" ]; then
    echo "$0 branch (project)"
    exit 0
fi

pip install --upgrade pip
pip install simpleeval

git clone git@github.com:zikzakmedia/trytontasks.git tasks
git clone git@github.com:zikzakmedia/tryton-config.git config -b $1
touch local.cfg

pip install -r tasks/requirements.txt
pip install -r config/requirements.txt

invoke modules.clone -c base.cfg

if [ ! -z "$2" ]; then
    git clone ssh://zikzak@hg.zikzakmedia.com:2299//home/tryton/master/clients/$2/ modules/$2 -b $1
    rm local.cfg requirements.txt
    ln -s modules/$2/local.cfg .
    ln -s modules/$2/requirements.txt .
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
