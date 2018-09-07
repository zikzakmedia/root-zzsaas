#!/bin/bash
#ln -s ~/.virtualenvs/${PWD##*/}/bin .
#pip install psycopg2cffi
pip install --upgrade pip
pip install simpleeval

hg clone ssh://hg@bitbucket.org/zikzakmedia-erp/trytontasks tasks
hg clone ssh://hg@bitbucket.org/zikzakmedia-erp/tryton-config config -b 4.8
touch local.cfg

pip install -r tasks/requirements.txt
pip install -r config/requirements.txt
pip install -r requirements.txt

invoke modules.clone -c base.cfg
invoke modules.clone
quilt push -a

# master
# invoke modules.clone -c base.cfg -m
# invoke modules.clone -c core.cfg -m

# sao
invoke sao.install
invoke sao.grunt
