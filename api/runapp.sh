#!/bin/bash -x

STARTFILE="main.py"
REPOS_DIR="/repos"

#def find_unused_port():
#  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
#  s.bind(('0.0.0.0', 0))
#  addr, port = s.getsockname()
#  s.close()
#  return port


appname=$1
repo=$2
port=$3

reponame=${repo##*/}
reponame=${reponame%.git}

cd $REPOS_DIR
if [[ -d $appname ]]; then
  exit 1
fi

mkdir $appname
cd $appname
git clone $repo .

uwsgi --http :$port --wsgi-file $STARTFILE --touch-reload /var/run/apps/$appname.port &

echo $! > /var/run/apps/$appname.pid
echo $port > /var/run/apps/$appname.port
