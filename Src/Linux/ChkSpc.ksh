#! /usr/bin/ksh

# Check space in all filesystems

for i in $(df -k | grep -e "/u0" | awk '{print $4}' )
do
  # convert the file size to a numeric value
  filesize=$(expr i)

  # if any filesystem has less than 100k, issue an alert
  if [ $filesize -lt 100 ]
  then
    echo "Oracle filesystem $i has less than 100k free space."
  fi

done
