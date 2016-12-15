#!/bin/bash
#ln -s ~/.virtualenvs/${PWD##*/}/bin .
hg clone ssh://hg@bitbucket.org/zikzakmedia/trytontasks tasks
hg clone ssh://hg@bitbucket.org/zikzakmedia/tryton-config config -b 4.2
pip install -r tasks/requirements.txt
pip install -r config/requeriments.txt
invoke modules.clone -c base.cfg
invoke modules.clone
