#!/usr/bin/env bash

max_num=7
min_num=4

echo "hello, I am going to stop running once I get to a number greater than" "${max_num}"
echo "for numbers less than" "${min_num}" "I will exit just that iteration of the loop, but not abort the rest of the loop, or exit the script."


for i in {1..10}
do
  echo "this is" "${i}"
  if [ $i -gt "${max_num}" ]; then
    echo "hey, $i is greater than ${max_num} -- stopping the loop"
    break
  fi

  if [ $i -lt "${min_num}" ]; then
    echo "$i is less than" "${min_num}"", skipping to next loop iteration..."
    continue
  fi

  echo "this is the statement at the end of the loop!"

done

echo "but hey, here is the rest of the script"

exit
