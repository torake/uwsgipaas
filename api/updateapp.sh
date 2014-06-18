#!/bin/bash -x

STARTFILE="main.py"
REPOS_DIR="/repos"

appname=$1
pid=$(cat /var/run/apps/$appname.pid)
port=$(cat /var/run/apps/$appname.port)

cd $REPOS_DIR/$appname
git pull
touch /var/run/apps/$appname.reload
