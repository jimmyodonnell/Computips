#!/usr/bin/env bash

time1=$(date -u +"%s")

time2=$(date -u +"%s")
diff=$(($time2-$time1))
echo "operation took $(($diff / 3600)) hours, $((($diff / 60) % 60)) minutes and $(($diff % 60)) seconds."
