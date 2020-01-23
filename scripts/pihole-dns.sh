#!/bin/bash

# if pihole is not running
# to see if Pihole is running and redirects the request to http://localhost/admin
if [[ $(curl -s -I localhost/admin | grep 301 | wc -l) -eq 0 ]]; then
  # if localhost dns is exist
  if [[ $(networksetup -getdnsservers Wi-Fi | grep '127.0.0.1' | wc -l) -gt 0 ]]; then
    echo '127.0.0.1 is deleted from DNS as pihole is not running.'
    networksetup -setdnsservers Wi-Fi Empty
  fi
fi

