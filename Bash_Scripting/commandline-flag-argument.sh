#!/bin/bash

while getopts 'ti:' OPTION; do
  case "$OPTION" in
    t)
      echo "Memory Test -t"
      ;;
    t)
      echo "IO test -i"
      ;;
    a)
      avalue="$OPTARG"
      echo "The value provided is $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-t] [-i] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
