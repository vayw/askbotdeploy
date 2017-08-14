#!/usr/bin/env bash

DB=$1
USER=$2
PASSWORD=$3
APPDIR=$5
DBENGINE=3
ENV=$4

DEPLOYFlAG="${APPDIR}/deploy.jenkins"

cd ~/

if [[ -f $DEPLOYFlAG ]]
then
  exit 0
fi

if [[ -d $APPDIR ]]
then
  tar cjf oldapp.tbz2 $APPDIR
  rm -Rf $APPDIR
fi

#enter virtenv
source ${ENV}/bin/activate 
askbot-setup -n ${APPDIR} -d ${DB} -u ${USER} -p ${PASSWORD} -e ${DBENGINE}
cd ${APPDIR}
yes yes | python manage.py collectstatic
yes no | python manage.py syncdb

ln -s static m
cp django.wsgi wsgi.py

touch $DEPLOYFlAG
