#!/bin/sh

if test -z $1; then
  echo must provide argument of either day or night
  exit 1
fi

case "$1" in
  day)
    redshift -x > /dev/null
    xbacklight -set 80 > /dev/null
    ;;
  night)
    redshift -P -O 1500 > /dev/null
    xbacklight -set 1 > /dev/null
    ;;
  *)
    echo must provide argument of either day or night
esac
