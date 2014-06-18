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

kill -9 $(cat /var/run/apps/$appname.pid)

cd $REPOS_DIR
if [[ -d $appname ]]; then
  rm -rf $appname
fi

rm /var/run/apps/$appname.{pid,port}
