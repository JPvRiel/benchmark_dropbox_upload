#!/usr/bin/env bash
if [ -z "$1" ]; then
  mb=10
elif [[ "$1" =~ ^[0-9]{1,3}$ ]]; then
  mb="$1"
else
  echo "ERROR: '$1' not understood" >&2
  echo "Usage $0 [number of MB as an integer less than 999]"
  exit 1
fi
echo "Generating $mb MB file with random data"
randfile="rand${mb}m.bin"
dd bs=1M count="$mb" if=/dev/urandom of="$randfile" &> /dev/null
echo "Moving file to Dropbox folder and waiting for upload to complete"
mv "$randfile" ~/Dropbox
elapsed=$(
  TIMEFORMAT='%3R'
  ( time {
      while ! dropbox filestatus ~/"Dropbox/$randfile" | grep 'up to date' > /dev/null; do
        sleep 0.01;
      done
    }
  ) 2>&1
)
speed=$(bc <<< "scale=3; $mb / $elapsed")
echo "$mb MB took $elapsed seconds = $speed MB/s"
rm ~/"Dropbox/$randfile"
