#!/usr/bin/env bash


echo hello

for i in {1..10}
do
  echo "this is $i"
  echo "stopping at 7"
  if [ $i -gt 7 ]; then
    echo "hey, that was greater than 7 -- stopping the loop"
    break
  fi

done

echo "but hey, here is the rest of the script"

exit
