#!/usr/bin/env bash

DB=$1
USER=$2
PASSWORD=$3

mysql -e 'show databases;' -B | grep $DB
if [[ $? == 0 ]]
then
  echo "db exists, ok"
else
  mysql -e "create database ${DB} DEFAULT CHARACTER SET UTF8 COLLATE utf8_general_ci;"
fi

usergrants=`mysql -e 'show grants' -B | grep ${USER} | wc -l`
if [[ $usergrants == 0 ]]
then
  mysql -e "grant all privileges on ${DB}.* to ${USER}@localhost identified by '${PASSWORD}'"
else
  echo "got somethin'"
fi
