#!/bin/bash

IFS="
"
mkdir -p output
x=0
while [ $x -lt 500000 ]
do
  url="http://nycma.lunaimaging.com/luna/servlet/view/all?pgs=250&os=$x"
  echo $url
  for line in $(curl -s --compressed --cookie 'JSESSIONID=762E4631B42A71B1ED76FA226CEEDE3E' \
    $url | \
    grep -Po 'alt="dof_[^"]+" src="http://nycma.lunaimaging.com/MediaManager/srvr\?mediafile=[^&]+')
  do
    name=$(echo $line | grep -Po 'dof_[^"]+')
    url=$(echo $line | grep -Po 'http://.*' | sed -e 's/Size1/Size3/')
    if [ ! -e output/$name.jpg ]
    then
      echo $name
      curl -s "$url" > output/$name.jpg
      sleep 0.1
    fi
  done
  x=$(( x + 250 ))
  echo "x: $x"
done
