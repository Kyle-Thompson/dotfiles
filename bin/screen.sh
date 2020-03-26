#!/bin/sh

if test -z $1; then
  echo must provide argument of either day or night
  exit 1
fi

case "$1" in
  day)
    redshift -x
    xbacklight -set 80
    ;;
  night)
    redshift -P -O 1500
    xbacklight -set 1
    ;;
  *)
    echo must provide argument of either day or night
esac
