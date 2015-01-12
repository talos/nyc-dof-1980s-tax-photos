#!/bin/bash

IFS="
"
mkdir -p output

BRONX='http://nycma.lunaimaging.com/luna/servlet/RECORDSPHOTOUNITBRO~4~4'
BROOKLYN='http://nycma.lunaimaging.com/luna/servlet/RECORDSPHOTOUNITBRK~1~1'
MANHATTAN='http://nycma.lunaimaging.com/luna/servlet/RECORDSPHOTOUNITMAN~2~2'
QUEENS='http://nycma.lunaimaging.com/luna/servlet/RECORDSPHOTOUNITQUE~1~1'
STATEN_ISLAND='http://nycma.lunaimaging.com/luna/servlet/RECORDSPHOTOUNITSTA~1~1'

COOKIEJAR=cookiejar

for borough in $BRONX $BROOKLYN $MANHATTAN $QUEENS $STATEN_ISLAND
do
  # Browsing a specific collection isn't stored in URL, but in session cookie
  # (!). To look at a collection, go to its landing page and store the cookie.
  curl -s --compressed --cookie-jar $COOKIEJAR $borough > /dev/null
  x=0
  cat $COOKIEJAR
  while [ $x -lt 500000 ]
  do
    url="http://nycma.lunaimaging.com/luna/servlet/view/all?pgs=250&os=$x"
    echo $url
    for line in $(curl --cookie $COOKIEJAR -s --compressed $url | \
      grep -Po 'alt="dof_[^"]+" src="http://nycma.lunaimaging.com/MediaManager/srvr\?mediafile=[^&]+')
    do
      name=$(echo $line | grep -Po 'dof_[^"]+')
      url=$(echo $line | grep -Po 'http://.*' | sed -e 's/Size1/Size3/')
      if [ ! -e "output/$name.jpg" ]
      then
        echo $name
        curl -s "$url" > output/$name.jpg
        sleep 0.1
      else
        echo skipped $name
      fi
    done
    x=$(( x + 250 ))
    echo "x: $x"
  done
done
